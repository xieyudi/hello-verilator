`ifndef VERILATOR
`timescale 1ns/100ps
`endif

`ifndef VERILATOR
module tb_top;
`else
module tb_top (
  input logic clk,
  input logic rst_n
);
`endif

`ifndef VERILATOR
  logic clk;
  logic rst_n;
`endif

  logic out;

`ifndef VERILATOR
  initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    #5;
    rst_n = 1'b1;
    #5;
    forever begin
      #5 clk = ~clk;
      //$display("%t", $time);
    end
  end
`endif

  toggle u_toggle (
    .clk,
    .rst_n,
    .out
  );
endmodule
