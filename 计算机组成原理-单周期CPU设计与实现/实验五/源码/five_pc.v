module five_pc(
  input wire clk,//时钟信号
  input wire rst,//复位信号
  input wire wr,//有条件转移信号
  input wire wr_none,//无条件转移信号
  input wire stop,//停机信号
  input reg[11:0] data_in,//输入的12位跳转所加的数
  output reg[11:0] data_out//12位指令地址
);
  initial begin 
    data_out = 0; //初始化data_out
  end
  always@(negedge clk) begin //下降沿
    if(stop == 1) //停机信号生效
      data_out = data_out; //即pc的值不变
    else if (rst == 1) //复位信号生效
      data_out = 0; //即pc的值变为0
    else
      data_out = data_out + 1; //pc=pc+1
  end
  always@(posedge clk) begin//上升沿
    if(wr == 1) //有条件跳转信号生效
      data_out = data_out + data_in;
    else if(wr_none == 1)//无条件跳转信号生效
      data_out = 12'b000000000011;//跳转至3指令
  end
endmodule


