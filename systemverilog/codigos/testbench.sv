module tb_lfsr;
  localparam seed = 1;
  logic clk, rst;
  logic [31:0] q;

  localparam N = 100;
  logic [31:0] testvectors [N-1:0];
  logic [31:0] expected_q;

  lfsr #(seed) dut(clk, rst, q);
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, clk, q);

    clk = 1; rst = 0;
    rst = 1; @(posedge clk); rst = 0;

    $readmemb("testvectors.txt", testvectors, 0, N-1);
    foreach(testvectors[i]) begin
      expected_q = testvectors[i];
      @(posedge clk);

      assert(q === expected_q);
        else $error(
          "Erro na linha %0d: q=%b, expected_q=%b",
          i+1, q, expected_q
        );
    end

    $finish;
  end
endmodule
