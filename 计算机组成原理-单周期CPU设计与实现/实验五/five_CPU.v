module five_CPU(
    input wire clk,//时钟信号
    input wire rst//复位信号
);

wire stop,pc_wr,ACC_wr,dmemory_wr,pc_wr_none;
wire [3:0] alu_op;
wire [11:0] Addr;
wire [11:0] pc_in;
wire [15:0] opcode,in1,in2,Z;

five_pc pc(
    .clk(clk),
    .rst(rst),
    .stop(stop),
    .wr(pc_wr),
    .data_in(pc_in),
    .data_out(Addr),
    .wr_none(pc_wr_none)
);

five_imemory imemory(
    .Addr(Addr),
    .Ins(opcode)
);

five_dmemory dmemory(
    .clk(clk),
    .wr_dmemory(dmemory_wr),
    .Addr(Addr),
    .in_dmemory(Z),
    .out_dmemory(in2)
);

five_ACC acc(
    .clk(clk),
    .wr_ACC(ACC_wr),
    .in_ACC(Z),
    .out_ACC(in1)
);

five_CU cu(
    .rst(rst),
    .opcode(opcode[15:12]),
    .stop(stop),
    .wr_pc(pc_wr),
    .wr_ACC(ACC_wr),
    .wr_dmemory(dmemory_wr),
    .alu_op(alu_op),
    .wr_none_pc(pc_wr_none),
    .cu_rst(rst)
);

five_ALU alu(
    .in1(in1),
    .in2(in2),
    .alu_op(alu_op),
    .Z(Z),
    .ban_len(pc_in)
);

endmodule

