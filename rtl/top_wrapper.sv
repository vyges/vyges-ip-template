// File: rtl/top_wrapper.sv
// Top-level wrapper for the countdown timer with APB interface

/*
 * countdown timer IP uses an APB slave interface with clock/reset and an IRQ output, 
 * this top_wrapper.sv wraps around that interface and expose it at the top level. 
 */

`timescale 1ns / 1ps

module top_wrapper #(
    parameter int WIDTH = 16,
    parameter bit ONE_SHOT = 0
)(
    input  logic        clk,
    input  logic        rst_n,

    // APB Interface (Slave)
    input  logic        psel,
    input  logic        penable,
    input  logic        pwrite,
    input  logic [15:0] paddr,
    input  logic [31:0] pwdata,
    output logic [31:0] prdata,
    output logic        pready,

    // Interrupt Output
    output logic irq
);

    // Instantiate your IP block
    your_ip_block #(
        .WIDTH(WIDTH),
        .ONE_SHOT(ONE_SHOT)
    ) u_your_ip_block (
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

endmodule
