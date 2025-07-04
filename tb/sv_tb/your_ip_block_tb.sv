// File: tb/sv_tb/your_ip_block_tb.sv
// Testbench skeleton for your_ip_block with APB interface

/*
Description:
  - Clock runs at 100 MHz.
  - Reset is active low, held for a few cycles.
  - Simple APB master tasks apb_write and apb_read that follow APB timing.
  - Basic example write/read transaction in the initial test sequence.
  - You can extend the testbench with checks, scoreboard, or random stimulus.
*/


`timescale 1ns / 1ps

module your_ip_block_tb;

  // Parameters (match the DUT)
  parameter int WIDTH = 16;
  parameter bit ONE_SHOT = 0;

  // Clock & reset
  logic clk;
  logic rst_n;

  // APB signals
  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [15:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic        pready;

  // Interrupt output
  logic irq;

  // Instantiate the DUT
  your_ip_block #(
    .WIDTH(WIDTH),
    .ONE_SHOT(ONE_SHOT)
  ) dut (
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

  // Clock generation: 10ns period (100 MHz)
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst_n = 0;
    psel = 0;
    penable = 0;
    pwrite = 0;
    paddr = 0;
    pwdata = 0;
    @(posedge clk);
    @(posedge clk);
    rst_n = 1;  // Release reset
  end

  // APB Master stimulus (simplified)
  task apb_write(input logic [15:0] addr, input logic [31:0] data);
    begin
      @(posedge clk);
      psel    = 1;
      penable = 0;
      pwrite  = 1;
      paddr   = addr;
      pwdata  = data;

      @(posedge clk);
      penable = 1;

      wait (pready == 1);

      @(posedge clk);
      psel    = 0;
      penable = 0;
      pwrite  = 0;
    end
  endtask

  task apb_read(input logic [15:0] addr, output logic [31:0] data);
    begin
      @(posedge clk);
      psel    = 1;
      penable = 0;
      pwrite  = 0;
      paddr   = addr;

      @(posedge clk);
      penable = 1;

      wait (pready == 1);

      data = prdata;

      @(posedge clk);
      psel    = 0;
      penable = 0;
    end
  endtask

  // Test sequence
  initial begin
    logic [31:0] read_data;

    // Wait for reset release
    @(negedge rst_n);
    @(posedge rst_n);

    // Example APB write and read sequence
    apb_write(16'h0000, 32'h0000_FFFF);
    apb_read(16'h0000, read_data);
    $display("Read data from addr 0x0000: 0x%08h", read_data);

    // Add your test stimulus here

    // Finish simulation after some delay
    #1000;
    $finish;
  end

endmodule
