module toggle (
  input  logic clk,
  input  logic rst_n,
  output logic out
);

  logic [1:0] q;

  always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      q <= 2'b0;
    end else begin
      q <= q + 1'b1;
    end
  end

  assign out = q[1];

endmodule
