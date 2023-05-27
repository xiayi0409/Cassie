module CU(
    input [6:0] Ins_op,
    output wr_en,
    output [2:0] alu_op
);
    always@* begin//任何时钟信号都引起
        if(Ins_op == 0)
            wr_en = 1;
            alu_op = 4'd0;//设置alu的操作码 对应为+
    end
endmodule