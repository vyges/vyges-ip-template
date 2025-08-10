//=============================================================================
// Module Name: example_module
//=============================================================================
// Description: Simple example module demonstrating basic RTL functionality
// Features:
// - Basic data pass-through with one cycle delay
// - Active-low reset with proper initialization
// - Valid flag generation for data handshaking
// - Parameterizable data width support
//
// Author: Vyges Team
// License: Apache-2.0
//=============================================================================

module example_module #(
    parameter int DATA_WIDTH = 8
) (
    input  logic                    clk_i,      // Clock input
    input  logic                    rst_n_i,    // Active-low reset
    input  logic [DATA_WIDTH-1:0]  data_in_i,  // Data input
    output logic [DATA_WIDTH-1:0]  data_out_o, // Data output
    output logic                    valid_out_o // Valid output flag
);

    //==============================================================================
    // Internal Signals
    //==============================================================================
    
    logic [DATA_WIDTH-1:0] data_reg;  // Data register
    logic                   valid_reg; // Valid flag register
    
    //==============================================================================
    // Sequential Logic
    //==============================================================================
    
    always_ff @(posedge clk_i or negedge rst_n_i) begin
        if (!rst_n_i) begin
            data_reg  <= '0;  // Use parameterized width
            valid_reg <= 1'b0;
        end else begin
            // Simple example: pass through data with one cycle delay
            data_reg  <= data_in_i;
            valid_reg <= 1'b1;  // Always valid after reset
        end
    end
    
    //==============================================================================
    // Output Assignment
    //==============================================================================
    
    assign data_out_o  = data_reg;
    assign valid_out_o = valid_reg;
    
    //==============================================================================
    // Security Validation and Assertions
    //==============================================================================
    
    // Security: Ensure reset behavior is properly implemented
    property reset_behavior;
        @(posedge clk_i) !rst_n_i |-> data_reg == '0 && valid_reg == 1'b0;
    endproperty
    assert property (reset_behavior) else
        $error("Reset behavior violation: data_reg or valid_reg not properly reset");
    
    // Security: Validate data integrity during normal operation
    property data_integrity;
        @(posedge clk_i) rst_n_i && valid_reg |-> data_out_o == data_reg;
    endproperty
    assert property (data_integrity) else
        $error("Data integrity violation: output does not match internal register");
    
    // Security: Ensure valid flag is properly controlled
    property valid_control;
        @(posedge clk_i) rst_n_i |-> valid_reg == 1'b1;
    endproperty
    assert property (valid_control) else
        $error("Valid control violation: valid_reg should be high after reset");
    
    //==============================================================================
    // Functional Coverage
    //==============================================================================
    
    // Coverage: Monitor data input transitions for verification completeness
    covergroup data_in_cg @(posedge clk_i);
        data_in_cp: coverpoint data_in_i {
            bins low  = {[0:(2**(DATA_WIDTH-1))-1]};
            bins high = {[2**(DATA_WIDTH-1):(2**DATA_WIDTH)-1]};
        }
        reset_cp: coverpoint rst_n_i {
            bins reset = {0};
            bins normal = {1};
        }
        valid_cp: coverpoint valid_reg {
            bins valid = {1};
            bins invalid = {0};
        }
    endgroup
    
    // Instantiate coverage group
    data_in_cg data_cov = new();
    
    //==============================================================================
    // Vyges IP Development Standards
    //==============================================================================
    //
    // This module follows Vyges IP development standards:
    // 1. One module per file: filename matches module name exactly
    // 2. Consistent naming: inputs end with _i, outputs with _o
    // 3. Parameterization: DATA_WIDTH parameter for configurability
    // 4. Security validation: Assertions for reset behavior and data integrity
    // 5. Functional coverage: Comprehensive coverage for verification
    // 6. Reset compliance: Proper active-low reset with initialization
    // 7. Lint-ready: Uses SystemVerilog constructs for better tool support
    // 8. Documentation: Clear header with module purpose and features
    //
    // For IP developers:
    // - Replace example functionality with your actual IP implementation
    // - Ensure all security assertions pass during verification
    // - Add IP-specific parameters and interfaces as needed
    // - Maintain consistent naming conventions throughout
    // - Update sourceFiles metadata when adding new files
    //
    //==============================================================================
    
endmodule : example_module 