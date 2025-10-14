//==============================================================================
// Example Core Testbench
//==============================================================================
// Description: Generic testbench for example_core
// Author:      Vyges Team
// Date:        2025-08-12
// Version:     1.0.0
//==============================================================================

`timescale 1ns/1ps

module tb_example;
    // Clock and reset signals
    logic clk_i;
    logic reset_n_i;
    
    // Testbench parameters
    parameter CLK_PERIOD = 10; // 10ns = 100MHz
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 8;
    parameter BUFFER_DEPTH = 16;
    
    // Control Interface signals
    logic enable_i;
    logic start_i;
    logic clear_i;
    logic busy_o;
    logic done_o;
    logic error_o;
    
    // Data Interface signals
    logic [DATA_WIDTH-1:0] data_in_i;
    logic valid_in_i;
    logic ready_in_o;
    logic [DATA_WIDTH-1:0] data_out_o;
    logic valid_out_o;
    logic ready_out_i;
    
    // Configuration Interface signals
    logic [ADDR_WIDTH-1:0] config_addr_i;
    logic [DATA_WIDTH-1:0] config_data_i;
    logic config_valid_i;
    logic config_ready_o;
    logic [DATA_WIDTH-1:0] status_o;
    
    // Test control
    logic test_done;
    int test_count;
    int pass_count;
    int fail_count;
    
    //==============================================================================
    // Clock Generation
    //==============================================================================
    
    initial begin
        clk_i = 0;
        forever #(CLK_PERIOD/2) clk_i = ~clk_i;
    end
    
    //==============================================================================
    // Reset Generation
    //==============================================================================
    
    initial begin
        reset_n_i = 0;
        #(CLK_PERIOD * 10);
        reset_n_i = 1;
    end
    
    //==============================================================================
    // DUT Instantiation
    //==============================================================================
    
    example_core #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .BUFFER_DEPTH(BUFFER_DEPTH)
    ) dut (
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
    
    //==============================================================================
    // Test Stimulus
    //==============================================================================
    
    initial begin
        // Initialize waveform dump
        $dumpfile("waveforms/tb_example.vcd");
        $dumpvars(0, tb_example);
        
        // Initialize signals
        initialize_signals();
        
        // Wait for reset to complete
        wait(reset_n_i);
        #(CLK_PERIOD * 5);
        
        // Run tests
        run_tests();
        
        // End simulation
        $display("All tests completed!");
        $display("Passed: %0d, Failed: %0d", pass_count, fail_count);
        $finish;
    end
    
    //==============================================================================
    // Test Tasks
    //==============================================================================
    
    task initialize_signals();
        // Control signals
        enable_i = 0;
        start_i = 0;
        clear_i = 0;
        
        // Data signals
        data_in_i = '0;
        valid_in_i = 0;
        ready_out_i = 1;
        
        // Configuration signals
        config_addr_i = '0;
        config_data_i = '0;
        config_valid_i = 0;
        
        // Test control
        test_done = 0;
        test_count = 0;
        pass_count = 0;
        fail_count = 0;
    endtask
    
    task run_tests();
        // Test 1: Reset Behavior
        test_reset_behavior();
        
        // Test 2: Configuration
        test_configuration();
        
        // Test 3: Data Processing
        test_data_processing();
        
        // Test 4: Buffer Operations
        test_buffer_operations();
        
        // Test 5: Error Handling
        test_error_handling();
        
        // Test 6: Integration
        test_integration();
    endtask
    
    task test_reset_behavior();
        test_count++;
        $display("Test %0d: Reset Behavior", test_count);
        
        // Verify reset state
        if (busy_o == 1'b0 && done_o == 1'b0 && error_o == 1'b0) begin
            $display("  PASS: Reset state correct");
            pass_count++;
        end else begin
            $display("  FAIL: Reset state incorrect");
            fail_count++;
        end
        
        #(CLK_PERIOD * 5);
    endtask
    
    task test_configuration();
        test_count++;
        $display("Test %0d: Configuration", test_count);
        
        // Enable module
        @(posedge clk_i);
        enable_i = 1;
        start_i = 1;
        
        // Wait for ready
        wait(config_ready_o);
        
        // Configure module
        @(posedge clk_i);
        config_addr_i = 8'h00;
        config_data_i = 32'hA5A5A5A5;
        config_valid_i = 1;
        
        @(posedge clk_i);
        config_valid_i = 0;
        
        // Verify configuration
        if (status_o == 32'hA5A5A5A5) begin
            $display("  PASS: Configuration successful");
            pass_count++;
        end else begin
            $display("  FAIL: Configuration failed");
            fail_count++;
        end
        
        #(CLK_PERIOD * 5);
    endtask
    
    task test_data_processing();
        test_count++;
        $display("Test %0d: Data Processing", test_count);
        
        // Send data
        @(posedge clk_i);
        data_in_i = 32'h12345678;
        valid_in_i = 1;
        
        // Wait for ready
        wait(ready_in_o);
        
        @(posedge clk_i);
        valid_in_i = 0;
        
        // Verify busy state
        if (busy_o == 1'b1) begin
            $display("  PASS: Data processing started");
            pass_count++;
        end else begin
            $display("  FAIL: Data processing not started");
            fail_count++;
        end
        
        #(CLK_PERIOD * 5);
    endtask
    
    task test_buffer_operations();
        test_count++;
        $display("Test %0d: Buffer Operations", test_count);
        
        // Fill buffer partially
        for (int i = 0; i < 4; i++) begin
            @(posedge clk_i);
            data_in_i = 32'h1000 + i;
            valid_in_i = 1;
            wait(ready_in_o);
            @(posedge clk_i);
            valid_in_i = 0;
        end
        
        // Verify buffer not full
        if (ready_in_o == 1'b1) begin
            $display("  PASS: Buffer operations working");
            pass_count++;
        end else begin
            $display("  FAIL: Buffer operations failed");
            fail_count++;
        end
        
        #(CLK_PERIOD * 5);
    endtask
    
    task test_error_handling();
        test_count++;
        $display("Test %0d: Error Handling", test_count);
        
        // Trigger error condition (clear during processing)
        @(posedge clk_i);
        clear_i = 1;
        
        @(posedge clk_i);
        clear_i = 0;
        
        // Verify error state
        if (error_o == 1'b1) begin
            $display("  PASS: Error handling working");
            pass_count++;
        end else begin
            $display("  FAIL: Error handling failed");
            fail_count++;
        end
        
        #(CLK_PERIOD * 5);
    endtask
    
    task test_integration();
        test_count++;
        $display("Test %0d: Integration", test_count);
        
        // Test complete flow
        @(posedge clk_i);
        enable_i = 1;
        start_i = 1;
        
        // Wait for configuration ready
        wait(config_ready_o);
        
        // Configure and process
        @(posedge clk_i);
        config_addr_i = 8'h01;
        config_data_i = 32'hDEADBEEF;
        config_valid_i = 1;
        
        @(posedge clk_i);
        config_valid_i = 0;
        
        // Send data
        @(posedge clk_i);
        data_in_i = 32'hCAFEBABE;
        valid_in_i = 1;
        wait(ready_in_o);
        @(posedge clk_i);
        valid_in_i = 0;
        
        // Wait for output
        wait(valid_out_o);
        
        if (valid_out_o == 1'b1) begin
            $display("  PASS: Integration test successful");
            pass_count++;
        end else begin
            $display("  FAIL: Integration test failed");
            fail_count++;
        end
        
        #(CLK_PERIOD * 5);
    endtask
    
    //==============================================================================
    // Timeout
    //==============================================================================
    
    initial begin
        #(CLK_PERIOD * 10000); // 10,000 clock cycles timeout
        $display("Simulation timeout!");
        $finish;
    end

endmodule : tb_example
