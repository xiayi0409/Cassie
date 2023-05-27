module five_ACC(
  input wire clk,//时钟信号
  input wire wr_ACC,//ACC写信号
  input wire[15:0] in_ACC,//ACC输入
  output wire[15:0] out_ACC//ACC输出
);
  reg[15:0] ACC; //定义数组
  assign out_ACC = ACC; //用assign对out_ACC赋值
  initial begin
    ACC = 0;
  end
  always@(posedge clk) begin
    if(wr_ACC)
      ACC = in_ACC;
  end
endmodule