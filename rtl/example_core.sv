`ifndef EXAMPLE_CORE_SV
`define EXAMPLE_CORE_SV

//=============================================================================
// Example Core Module
//=============================================================================
// Description: Generic template module demonstrating Vyges IP development standards
//              and best practices. Replace with your actual IP functionality.
// Author:      Vyges IP Development Team
// Date:        2025-08-12
// License:     Apache-2.0
//=============================================================================

module example_core #(
    parameter int DATA_WIDTH = 32,         // Data width parameter
    parameter int ADDR_WIDTH = 8,          // Address width parameter
    parameter int BUFFER_DEPTH = 16        // Buffer depth parameter
) (
    // Clock and Reset
    input  logic                    clk_i,      // System clock
    input  logic                    reset_n_i,  // Active-low reset
    
    // Control Interface
    input  logic                    enable_i,   // Module enable
    input  logic                    start_i,    // Start operation
    input  logic                    clear_i,    // Clear/reset operation
    output logic                    busy_o,     // Module busy flag
    output logic                    done_o,     // Operation complete flag
    output logic                    error_o,    // Error flag
    
    // Data Interface
    input  logic [DATA_WIDTH-1:0]  data_in_i,  // Input data
    input  logic                    valid_in_i, // Input data valid
    output logic                    ready_in_o, // Ready for input data
    output logic [DATA_WIDTH-1:0]  data_out_o, // Output data
    output logic                    valid_out_o, // Output data valid
    input  logic                    ready_out_i, // Downstream ready
    
    // Configuration Interface
    input  logic [ADDR_WIDTH-1:0]  config_addr_i,  // Configuration address
    input  logic [DATA_WIDTH-1:0]  config_data_i,  // Configuration data
    input  logic                    config_valid_i, // Configuration valid
    output logic                    config_ready_o, // Configuration ready
    output logic [DATA_WIDTH-1:0]  status_o        // Status information
);

    //==============================================================================
    // Internal Signals and Registers
    //==============================================================================
    
    // State machine
    typedef enum logic [2:0] {
        ST_IDLE     = 3'b000,
        ST_CONFIG   = 3'b001,
        ST_PROCESS  = 3'b010,
        ST_OUTPUT   = 3'b011,
        ST_ERROR    = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    
    // Configuration registers
    logic [DATA_WIDTH-1:0] config_reg [0:(1<<ADDR_WIDTH)-1];
    logic [DATA_WIDTH-1:0] status_reg;
    
    // Data processing registers
    logic [DATA_WIDTH-1:0] data_buffer [0:BUFFER_DEPTH-1];
    logic [ADDR_WIDTH-1:0] buffer_wr_ptr;
    logic [ADDR_WIDTH-1:0] buffer_rd_ptr;
    logic [ADDR_WIDTH:0]   buffer_count;
    
    // Control signals
    logic buffer_full;
    logic buffer_empty;
    logic processing_active;
    
    //==============================================================================
    // State Machine Logic
    //==============================================================================
    
    always_ff @(posedge clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            current_state <= ST_IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    always_comb begin
        next_state = current_state;
        
        case (current_state)
            ST_IDLE: begin
                if (start_i && enable_i) begin
                    next_state = ST_CONFIG;
                end
            end
            
            ST_CONFIG: begin
                if (config_valid_i) begin
                    next_state = ST_PROCESS;
                end else if (clear_i) begin
                    next_state = ST_IDLE;
                end
            end
            
            ST_PROCESS: begin
                if (valid_in_i && !buffer_full) begin
                    next_state = ST_PROCESS;
                end else if (buffer_count > 0) begin
                    next_state = ST_OUTPUT;
                end else if (done_o) begin
                    next_state = ST_IDLE;
                end
            end
            
            ST_OUTPUT: begin
                if (ready_out_i && valid_out_o) begin
                    if (buffer_count > 1) begin
                        next_state = ST_OUTPUT;
                    end else begin
                        next_state = ST_PROCESS;
                    end
                end
            end
            
            ST_ERROR: begin
                if (clear_i) begin
                    next_state = ST_IDLE;
                end
            end
            
            default: next_state = ST_IDLE;
        endcase
    end
    
    //==============================================================================
    // Configuration Logic
    //==============================================================================
    
    always_ff @(posedge clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            for (int i = 0; i < (1 << ADDR_WIDTH); i++) begin
                config_reg[i] <= '0;
            end
            status_reg <= '0;
        end else if (config_valid_i && current_state == ST_CONFIG) begin
            config_reg[config_addr_i] <= config_data_i;
            status_reg <= config_data_i;
        end
    end
    
    //==============================================================================
    // Data Buffer Logic
    //==============================================================================
    
    always_ff @(posedge clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            buffer_wr_ptr <= '0;
            buffer_rd_ptr <= '0;
            buffer_count <= '0;
            for (int i = 0; i < BUFFER_DEPTH; i++) begin
                data_buffer[i] <= '0;
            end
        end else begin
            // Write to buffer
            if (valid_in_i && ready_in_o && !buffer_full) begin
                data_buffer[buffer_wr_ptr] <= data_in_i;
                buffer_wr_ptr <= (buffer_wr_ptr == BUFFER_DEPTH-1) ? '0 : buffer_wr_ptr + 1;
                buffer_count <= buffer_count + 1;
            end
            
            // Read from buffer
            if (ready_out_i && valid_out_o && !buffer_empty) begin
                buffer_rd_ptr <= (buffer_rd_ptr == BUFFER_DEPTH-1) ? '0 : buffer_rd_ptr + 1;
                buffer_count <= buffer_count - 1;
            end
        end
    end
    
    //==============================================================================
    // Buffer Status Logic
    //==============================================================================
    
    assign buffer_full = (buffer_count == BUFFER_DEPTH);
    assign buffer_empty = (buffer_count == 0);
    
    //==============================================================================
    // Output Logic
    //==============================================================================
    
    always_ff @(posedge clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            data_out_o <= '0;
            valid_out_o <= 1'b0;
        end else if (current_state == ST_OUTPUT && !buffer_empty) begin
            data_out_o <= data_buffer[buffer_rd_ptr];
            valid_out_o <= 1'b1;
        end else begin
            valid_out_o <= 1'b0;
        end
    end
    
    //==============================================================================
    // Control Output Logic
    //==============================================================================
    
    always_ff @(posedge clk_i or negedge reset_n_i) begin
        if (!reset_n_i) begin
            busy_o <= 1'b0;
            done_o <= 1'b0;
            error_o <= 1'b0;
            processing_active <= 1'b0;
        end else begin
            case (current_state)
                ST_IDLE: begin
                    busy_o <= 1'b0;
                    done_o <= 1'b0;
                    error_o <= 1'b0;
                    processing_active <= 1'b0;
                end
                
                ST_CONFIG: begin
                    busy_o <= 1'b1;
                    done_o <= 1'b0;
                    error_o <= 1'b0;
                    processing_active <= 1'b0;
                end
                
                ST_PROCESS: begin
                    busy_o <= 1'b1;
                    done_o <= 1'b0;
                    error_o <= 1'b0;
                    processing_active <= 1'b1;
                end
                
                ST_OUTPUT: begin
                    busy_o <= 1'b1;
                    done_o <= 1'b0;
                    error_o <= 1'b0;
                    processing_active <= 1'b1;
                end
                
                ST_ERROR: begin
                    busy_o <= 1'b0;
                    done_o <= 1'b0;
                    error_o <= 1'b1;
                    processing_active <= 1'b0;
                end
                
                default: begin
                    busy_o <= 1'b0;
                    done_o <= 1'b0;
                    error_o <= 1'b0;
                    processing_active <= 1'b0;
                end
            endcase
        end
    end
    
    //==============================================================================
    // Ready Signal Logic
    //==============================================================================
    
    assign ready_in_o = (current_state == ST_PROCESS) && !buffer_full;
    assign config_ready_o = (current_state == ST_CONFIG);
    assign status_o = status_reg;
    
    //==============================================================================
    // Security Validation and Assertions
    //==============================================================================
    
    // Use Yosys-compatible assertions
    `ifdef YOSYS
        // Security: Ensure reset behavior is properly implemented
        property reset_behavior;
            @(posedge clk_i) !reset_n_i |-> busy_o == 1'b0 && done_o == 1'b0 && error_o == 1'b0;
        endproperty
        assert property (reset_behavior) else
            $error("Reset behavior violation: control signals not properly reset");
        
        // Security: Validate buffer pointer bounds
        property buffer_bounds;
            @(posedge clk_i) reset_n_i |-> buffer_wr_ptr < BUFFER_DEPTH && buffer_rd_ptr < BUFFER_DEPTH;
        endproperty
        assert property (buffer_bounds) else
            $error("Buffer bounds violation: pointer out of range");
        
        // Security: Validate buffer count consistency
        property buffer_count_consistency;
            @(posedge clk_i) reset_n_i |-> buffer_count <= BUFFER_DEPTH;
        endproperty
        assert property (buffer_count_consistency) else
            $error("Buffer count violation: count exceeds buffer depth");
    `endif
    
    //==============================================================================
    // Functional Coverage
    //==============================================================================
    
    // Coverage: Monitor state transitions
    covergroup state_cg @(posedge clk_i);
        state_cp: coverpoint current_state {
            bins idle = {ST_IDLE};
            bins config = {ST_CONFIG};
            bins process = {ST_PROCESS};
            bins output = {ST_OUTPUT};
            bins error = {ST_ERROR};
        }
        
        state_transition_cp: coverpoint {current_state, next_state} {
            bins idle_to_config = {ST_IDLE, ST_CONFIG};
            bins config_to_process = {ST_CONFIG, ST_PROCESS};
            bins process_to_output = {ST_PROCESS, ST_OUTPUT};
            bins output_to_process = {ST_OUTPUT, ST_PROCESS};
            bins process_to_idle = {ST_PROCESS, ST_IDLE};
            bins any_to_error = {ST_IDLE, ST_ERROR}, {ST_CONFIG, ST_ERROR}, {ST_PROCESS, ST_ERROR};
        }
    endgroup
    
    // Coverage: Monitor data flow
    covergroup data_flow_cg @(posedge clk_i);
        input_valid_cp: coverpoint valid_in_i {
            bins valid = {1};
            bins invalid = {0};
        }
        
        output_ready_cp: coverpoint ready_out_i {
            bins ready = {1};
            bins not_ready = {0};
        }
        
        buffer_status_cp: coverpoint {buffer_full, buffer_empty} {
            bins empty = {2'b01};
            bins partial = {2'b00};
            bins full = {2'b10};
        }
    endgroup
    
    // Instantiate coverage groups
    state_cg state_cov = new();
    data_flow_cg data_flow_cov = new();
    
    //==============================================================================
    // Vyges IP Development Standards
    //==============================================================================
    //
    // This module follows Vyges IP development standards:
    // 1. File naming: block-name_module-name.sv (e.g., fft_memory.sv)
    // 2. Consistent naming: inputs end with _i, outputs with _o
    // 3. Parameterization: Configurable data width, address width, and buffer depth
    // 4. Security validation: Yosys-compatible assertions for reset and bounds checking
    // 5. Functional coverage: Comprehensive coverage for verification
    // 6. Reset compliance: Proper active-low reset with initialization
    // 7. Lint-ready: Uses SystemVerilog constructs for better tool support
    // 8. Documentation: Clear header with module purpose and features
    // 9. State machine: Well-defined states with clear transitions
    // 10. Buffer management: Proper FIFO implementation with bounds checking
    //
    // For IP developers:
    // - Repository name: Descriptive (e.g., fast-fourier-transform-ip)
    // - Block name: Short identifier (e.g., fft)
    // - Module name: Functionality (e.g., memory, controller, processor)
    // - RTL filename: block-name_module-name.sv (e.g., fft_memory.sv)
    // - Replace template functionality with your actual IP implementation
    // - Ensure all security assertions pass during verification
    // - Add IP-specific parameters and interfaces as needed
    // - Maintain consistent naming conventions throughout
    // - Update sourceFiles metadata when adding new files
    // - Customize state machine for your specific requirements
    // - Adapt buffer logic for your data processing needs
    //
    //==============================================================================
    
endmodule : example_core
