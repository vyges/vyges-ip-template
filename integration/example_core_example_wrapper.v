//=============================================================================
// Integration Wrapper for example_module
//=============================================================================
// Description: Wrapper module for integrating example_module into larger designs
// Author: Vyges Team
// License: Apache-2.0
//=============================================================================

module example_wrapper #(
    parameter int DATA_WIDTH = 8
) (
    input  logic                    clk_i,      // Clock input
    input  logic                    rst_n_i,    // Active-low reset
    input  logic [DATA_WIDTH-1:0]  data_in_i,  // Data input
    output logic [DATA_WIDTH-1:0]  data_out_o, // Data output
    output logic                    valid_out_o // Valid output flag
);

    //=============================================================================
    // Instance of the example module
    //=============================================================================
    
    example_module #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_example_module (
        .clk_i      (clk_i),
        .rst_n_i    (rst_n_i),
        .data_in_i  (data_in_i),
        .data_out_o (data_out_o),
        .valid_out_o(valid_out_o)
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
    //
    // For IP developers:
    // - Customize this wrapper for your specific integration needs
    // - Add any additional glue logic or interface adaptation
    // - Ensure proper parameter passing and signal mapping
    // - Update sourceFiles metadata when modifying this file
    //
    //=============================================================================

endmodule : example_wrapper
