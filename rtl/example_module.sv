//==============================================================================
// Example Module
//==============================================================================
// Description: Simple example module demonstrating basic RTL functionality
// Author:      Vyges Team
// Date:        2025-01-20
// Version:     1.0.0
// License:     Apache-2.0
//
// This is a template module. Replace with actual RTL for your IP.
//==============================================================================

module example_module (
    input  logic        clk,      // Clock input
    input  logic        rst_n,    // Active-low reset
    input  logic [7:0]  data_in,  // Data input (example)
    output logic [7:0]  data_out, // Data output (example)
    output logic        valid_out // Valid output flag (example)
);

    //==============================================================================
    // Internal Signals
    //==============================================================================
    
    logic [7:0] data_reg;  // Data register
    logic       valid_reg; // Valid flag register
    
    //==============================================================================
    // Sequential Logic
    //==============================================================================
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_reg  <= 8'h00;
            valid_reg <= 1'b0;
        end else begin
            // Simple example: pass through data with one cycle delay
            data_reg  <= data_in;
            valid_reg <= 1'b1;  // Always valid after reset
        end
    end
    
    //==============================================================================
    // Output Assignment
    //==============================================================================
    
    assign data_out  = data_reg;
    assign valid_out = valid_reg;
    
    //==============================================================================
    // Assertions (optional - for formal verification)
    //==============================================================================
    
    // Example assertion: data_out should be valid when valid_out is high
    // property data_valid_check;
    //     @(posedge clk) valid_out |-> data_out == data_reg;
    // endproperty
    // assert property (data_valid_check);
    
    //==============================================================================
    // Coverage (optional - for functional coverage)
    //==============================================================================
    
    // Example coverage: cover data_in transitions
    // covergroup data_in_cg @(posedge clk);
    //     data_in_cp: coverpoint data_in {
    //         bins low  = {[0:127]};
    //         bins high = {[128:255]};
    //     }
    // endgroup
    
    //==============================================================================
    // Notes for IP Developers
    //==============================================================================
    //
    // 1. Replace this example module with your actual IP implementation
    // 2. Add proper interface signals based on your IP requirements
    // 3. Implement the core functionality of your IP
    // 4. Add appropriate assertions for formal verification
    // 5. Add functional coverage for verification completeness
    // 6. Document any IP-specific requirements or constraints
    // 7. Ensure proper reset behavior and timing compliance
    // 8. Add parameterization if needed for configurability
    //
    //==============================================================================
    
endmodule : example_module 