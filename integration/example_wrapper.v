//=============================================================================
// Integration Wrapper for example_core
//=============================================================================
// Description: Generic wrapper module for integrating example_core into larger designs
// Author: Vyges Team
// License: Apache-2.0
//=============================================================================

module example_wrapper #(
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

    //=============================================================================
    // Instance of the example core module
    //=============================================================================
    
    example_core #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .BUFFER_DEPTH(BUFFER_DEPTH)
    ) u_example_core (
        .clk_i          (clk_i),
        .reset_n_i      (reset_n_i),
        .enable_i       (enable_i),
        .start_i        (start_i),
        .clear_i        (clear_i),
        .busy_o         (busy_o),
        .done_o         (done_o),
        .error_o        (error_o),
        .data_in_i      (data_in_i),
        .valid_in_i     (valid_in_i),
        .ready_in_o     (ready_in_o),
        .data_out_o     (data_out_o),
        .valid_out_o    (valid_out_o),
        .ready_out_i    (ready_out_i),
        .config_addr_i  (config_addr_i),
        .config_data_i  (config_data_i),
        .config_valid_i (config_valid_i),
        .config_ready_o (config_ready_o),
        .status_o       (status_o)
    );

    //=============================================================================
    // Integration Notes
    //=============================================================================
    //
    // This wrapper provides:
    // 1. Consistent interface naming (_i for inputs, _o for outputs)
    // 2. Parameter passing to the underlying module
    // 3. Easy integration into larger designs
    // 4. Consistent reset and clock handling
    // 5. Generic data processing interface
    // 6. Configuration and status interfaces
    // 7. Handshaking protocol support
    //
    // For IP developers:
    // - Repository name: Descriptive (e.g., fast-fourier-transform-ip)
    // - Block name: Short identifier (e.g., fft)
    // - Module name: Functionality (e.g., memory, controller, processor)
    // - Wrapper filename: block-name_module-name_wrapper.v (e.g., fft_memory_wrapper.v)
    // - Customize this wrapper for your specific integration needs
    // - Add any additional glue logic or interface adaptation
    // - Ensure proper parameter passing and signal mapping
    // - Update sourceFiles metadata when modifying this file
    // - Consider adding clock domain crossing if needed
    // - Adapt interfaces for your specific bus protocols
    //
    //=============================================================================

endmodule : example_wrapper
