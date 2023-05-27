module InsMemory(
    input [7:0] Addr,
    output [15:0] Ins,
    reg Ins;//定义输出为寄存器
);
    reg [15:0] men[0:255];//256个8位的寄存器型数据
    integer i,j;
    initial begin
        for(i=0;i<256;i=i+1)
        begin
        //初始化分配地址空间
            j = i % 6;
            men[i][2:0] = j;
            men[i][5:3] = j + 1;
            men[i][8:6] = j + 2;
            men[i][15:9] = 0;
        end
    end

    always@* begin // 任何时钟改变均会进入
        Ins = men[Addr];
    end
  
endmodule
