module test01;
  reg clk, rst;
  always #10 clk = ~clk;
  
  initial begin
    clk = 1;
    rst = 1;
    
    #1 rst = 0;
    
    #40 $stop;
  end
  
  cpu uut(
    .clk(clk), .rst(rst)
  );
endmodule