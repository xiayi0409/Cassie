module five_CPU_tb();
  reg clk,rst;
  initial begin
      clk=1;
      rst=1;
      #1 rst=0;
      #20 $stop;
  end
  always #1 clk=~clk;

  five_CPU uut(
      .clk(clk),
      .rst(rst)
  );

  endmodule