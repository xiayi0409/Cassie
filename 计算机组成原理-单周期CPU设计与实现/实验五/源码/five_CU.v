module five_CU(
  input wire[3:0] opcode,
  input wire rst,
  output reg wr_pc,wr_ACC,wr_dmemory,stop,wr_none_pc,cu_rst,
  output reg[3:0] alu_op
);
  initial begin
    wr_pc = 0;
    wr_ACC = 0;
    wr_dmemory = 0;
    stop = 0;
    wr_none_pc = 0;
    alu_op = 4'b0000;
    cu_rst = rst;
  end
  always@* begin
    //0000为CLA pc=0 acc=1 mdr=0
    if(opcode == 4'b0000) begin
      wr_pc = 0;
      cu_rst = 1;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0000;
    end
    //0001为LDA pc=0 acc=1 mdr=0
    else if(opcode == 4'b0001)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0001;
    end
    //0010为ADD pc=0 acc=1 mdr=0
    else if(opcode == 4'b0010)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0010;
    end
    //0011为COM pc=0 acc=1 mdr=0
    else if(opcode == 4'b0011)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0011;
    end
    //0100为SHR pc=0 acc=1 mdr=0
    else if(opcode == 4'b0100)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0100;
    end
    //0101为CSL pc=0 acc=0 mdr=0 
    else if(opcode == 4'b0101)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0101;
    end
    //0110为STA pc=0 acc=0 mdr=1
    else if(opcode == 4'b0110)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 0;
      wr_dmemory = 1;
      stop = 0;
      alu_op = 4'b0110;
    end
    //0111为BAN pc=1 acc=0 mdr=0
    else if(opcode == 4'b0111)begin
      wr_pc = 1;
      cu_rst = 0;
      wr_ACC = 1;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b0111;
    end
    //1000为JMP pc=1 acc=0 mdr=0
    else if(opcode == 4'b1000)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_none_pc=1;
      wr_ACC = 0;
      wr_dmemory = 0;
      stop = 0;
      alu_op = 4'b1000;
    end
    //1001为STOP pc=1 acc=0 mdr=0 stop=1
    else if(opcode == 4'b1001)begin
      wr_pc = 0;
      cu_rst = 0;
      wr_ACC = 0;
      wr_dmemory = 0;
      stop = 1;
      //alu_op = 4'b1001;
    end
  end
endmodule
    
