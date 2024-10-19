module lfsr #(parameter seed = 1)(
  input logic clk, rst,
  output logic [31:0] q
);
  logic feedback;
  logic [31:0] q_reg, q_next;

  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      q_reg <= seed;
    end
    else begin
      q_reg <= q_next;
    end
  end

  assign feedback = q_reg[0] ^ q_reg[1] ^ q_reg[21] ^ q_reg[31];
  assign q_next = {feedback, q_reg[31:1]};
  assign q = q_reg;
endmodule
