module five_dmemory(
  input wire wr_dmemory,//数据寄存器写信号
  input wire clk,//时钟信号
  input wire [11:0] Addr,//12为指令地址
  input wire [15:0] in_dmemory,//16位输入数据
  output wire [15:0] out_dmemory//16位输出数据
);
  reg[15:0] regfile[12'b111111111111:0]; //定义为一个数组
  assign out_dmemory = regfile[Addr];
  initial begin 
      regfile[0] = 16'h0002; 
      regfile[1] = 16'h4df8;
      regfile[2] = 16'h0003;
  end
 always@(posedge clk) begin
   if(wr_dmemory)
     regfile[Addr] = in_dmemory;
 end
endmodule
