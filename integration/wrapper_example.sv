// File: integration/wrapper_example.sv
// Example integration of top_wrapper into a system-level module
// Demonstrates instantiation with default parameters and APB connectivity 
// Integration-level reference showing how to instantiate the top_wrapper of your IP 
//  in a broader system context (e.g., SoC, test harness, or integration into a bus fabric).

`timescale 1ns / 1ps

module wrapper_example;

  // Clock & Reset
  logic clk;
  logic rst_n;

  // APB interface signals
  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [15:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic        pready;

  // IRQ line from IP
  logic irq;

  // Clock generation (100 MHz)
  initial clk = 0;
  always #5 clk = ~clk;

  // Simple reset sequence
  initial begin
    rst_n = 0;
    #100;
    rst_n = 1;
  end

  // Instantiate the IP wrapper
  top_wrapper #(
    .WIDTH(16),         // 16-bit countdown timer
    .ONE_SHOT(0)        // Periodic mode
  ) u_top_wrapper (
    .clk     (clk),
    .rst_n   (rst_n),
    .psel    (psel),
    .penable (penable),
    .pwrite  (pwrite),
    .paddr   (paddr),
    .pwdata  (pwdata),
    .prdata  (prdata),
    .pready  (pready),
    .irq     (irq)
  );

  // Example APB stimulus (could be replaced by APB master or testbench)
  initial begin
    // Wait for reset deassertion
    wait (rst_n == 1);
    #10;

    // Default APB idle
    psel    = 0;
    penable = 0;
    pwrite  = 0;
    paddr   = 0;
    pwdata  = 0;

    // Sample write to start timer (address and data are examples)
    #20;
    psel    = 1;
    penable = 0;
    pwrite  = 1;
    paddr   = 16'h0000;
    pwdata  = 32'h0000_00FF;  // Load countdown value

    #10;
    penable = 1;
    wait (pready == 1);
    #10;
    psel    = 0;
    penable = 0;
    pwrite  = 0;

    // Wait for IRQ
    wait (irq == 1);
    $display("[%0t] IRQ received from countdown timer!", $time);

    #100;
    $finish;
  end

endmodule
