//==============================================================================
// Example SystemVerilog Testbench
//==============================================================================
// Description: Example testbench demonstrating VCD waveform generation
// Author:      Vyges Team
// Date:        2025-01-20
// Version:     1.0.0
//==============================================================================

`timescale 1ns/1ps

module tb_example;
    // Clock and reset signals
    reg clk;
    reg rst_n;
    
    // Testbench parameters
    parameter CLK_PERIOD = 10; // 10ns = 100MHz
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Reset generation
    initial begin
        rst_n = 0;
        #(CLK_PERIOD * 10);
        rst_n = 1;
    end
    
    // Test stimulus
    initial begin
        // Initialize waveform dump
        $dumpfile("waveforms/tb_example.vcd");
        $dumpvars(0, tb_example);
        
        // Wait for reset to complete
        wait(rst_n);
        
        // Basic test sequence
        $display("Starting basic test sequence...");
        
        // Test 1: Basic functionality
        #(CLK_PERIOD * 5);
        $display("Test 1 completed at time %0t", $time);
        
        // Test 2: Edge cases
        #(CLK_PERIOD * 10);
        $display("Test 2 completed at time %0t", $time);
        
        // Test 3: Random stimulus
        #(CLK_PERIOD * 15);
        $display("Test 3 completed at time %0t", $time);
        
        // End simulation
        $display("All tests completed successfully!");
        $finish;
    end
    
    // Monitor signals
    always @(posedge clk) begin
        if (rst_n) begin
            $display("Time %0t: Clock tick", $time);
        end
    end
    
    // Timeout
    initial begin
        #(CLK_PERIOD * 1000); // 1000 clock cycles timeout
        $display("Simulation timeout!");
        $finish;
    end

endmodule 