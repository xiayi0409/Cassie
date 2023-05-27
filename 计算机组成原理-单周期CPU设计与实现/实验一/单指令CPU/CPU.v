module cpu(
  input wire clk, rst
);
 
  wire wr;
  wire [2:0] op;
  wire [7:0] addr;
  wire [15:0] z, ins, r1, r2;
  
  pc pc(
    .clk(clk), .rst(rst), .pc(addr)
  );
  
  insmemory insmemory(
    .Addr(addr), .Ins(ins)
  );
  
  cu cu(
    .Ins_op(ins[15:9]),
    .wr_en(wr), .alu_op(op)
  );
  
  registers registers(
    .clk(clk), .wr_en(wr), 
    .read_reg1(ins[8:6]), .read_reg2(ins[5:3]), .write_reg(ins[2:0]),
    .write_data(z), .reg1(r1), .reg2(r2)
  );
  
  alu alu(
    .in1(r1), .in2(r2),
    .alu_op(op), .Z(z)
  );
  
endmodule