module five_imemory (
    input wire [11:0] Addr,//12为指令地址
    output reg [15:0] Ins //16位指令码
);
    reg [15:0] RAM[255:0]; //设置数组
    initial begin
        RAM[0] = 16'h0000;//清除累加器指令CLA
        RAM[1] = 16'h1002;//取数指令LDA,直接寻址，取出地址为2的内存单元中的数
        RAM[2] = 16'h2003;//加法指令ADD,直接寻址，与地址为3的数相加放入ACC中
        RAM[3] = 16'h3000;//累加器取反指令COM
        RAM[4] = 16'h4000;//算数右移一位指令SHR：将累加器ACC中的数右移一位，结果放回ACC
        RAM[5] = 16'h5000;//循环左移一位指令CSL：对累加器中的数据进行操作
        RAM[6] = 16'h6004;//存数指令STA，直接寻址,放入地址为4的内存单元
        RAM[7] = 16'h7001;//有条件转移指令BAN
        RAM[8] = 16'h8000;//无条件转移指令JMP,转移至第三条指令
        RAM[9] = 16'h9000;//停机指令stop
    end
  always@* begin
    Ins = RAM[Addr];
  end
endmodule