// SPDX-License-Identifier: Apache-2.0
// Author: Example Company (https://example.com)
// Description: 16-bit countdown timer IP block (template)

/*
Summary of Template features

| Section        | Purpose                                     |
| -------------- | ------------------------------------------- |
| `clk`, `rst_n` | Standard clock/reset ports                  |
| APB interface  | Default control interface (could change)    |
| Parameters     | `WIDTH`, `ONE_SHOT` for reuse/customization |
| Timer logic    | Fully synchronous counter w/ reload         |
| `irq` output   | Simple interrupt generation on timeout      |
| `pready`       | Always ready for simplicity                 |
| `prdata`       | Simple address-mapped readback              |

*/


`timescale 1ns/1ps

module your_ip_block #(
    // Parameters
    parameter int WIDTH = 16,       // Width of countdown timer
    parameter bit ONE_SHOT = 0      // 0 = periodic, 1 = one-shot mode
)(
    // Clock & Reset
    input  logic clk,
    input  logic rst_n,

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

    // --------------------------------------------------------------------
    // Internal Registers
    // --------------------------------------------------------------------
    logic [WIDTH-1:0] counter;
    logic [WIDTH-1:0] reload_value;
    logic             enable;
    logic             timeout;

    // --------------------------------------------------------------------
    // APB Register Write Logic (simple placeholder)
    // --------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reload_value <= '0;
            enable       <= 0;
        end else if (psel && penable && pwrite) begin
            case (paddr)
                16'h00: reload_value <= pwdata[WIDTH-1:0];
                16'h04: enable       <= pwdata[0];
                default: /* do nothing */;
            endcase
        end
    end

    // --------------------------------------------------------------------
    // Timer Counter
    // --------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= '0;
        end else if (enable) begin
            if (counter == 0) begin
                counter <= ONE_SHOT ? 0 : reload_value;
            end else begin
                counter <= counter - 1;
            end
        end
    end

    assign timeout = (counter == 0 && enable);

    // --------------------------------------------------------------------
    // IRQ Logic
    // --------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            irq <= 0;
        end else begin
            irq <= timeout;
        end
    end

    // --------------------------------------------------------------------
    // APB Read Logic
    // --------------------------------------------------------------------
    always_comb begin
        prdata = '0;
        case (paddr)
            16'h00: prdata = { {(32-WIDTH){1'b0}}, reload_value };
            16'h04: prdata = { 31'b0, enable };
            16'h08: prdata = { {(32-WIDTH){1'b0}}, counter };
            default: prdata = '0;
        endcase
    end

    assign pready = 1'b1;

endmodule
