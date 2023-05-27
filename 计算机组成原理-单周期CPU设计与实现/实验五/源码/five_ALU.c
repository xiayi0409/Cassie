module five_ALU(
  input wire [15:0] in1,
  input wire [15:0] in2,
  input wire [3:0] alu_op,
  output reg [15:0] Z,
  output reg [11:0] ban_len
);
  initial begin
    Z=0;
    ban_len = 0;
  end

  always @*begin
      case(alu_op)
      4'b0000:Z = 0;//CLA
      4'b0011:Z = ~in1;//COM
      4'b0100:Z = in1[15] == 1?{1'b1,in1[15:1]}:{1'b0,in1[15]};//SHR 
      4'b0101:Z = {in1[14:0],in1[15]};//CSL
      4'b0010:Z = in1+in2;//ADD
      4'b0110:Z = in1;//STA
      4'b0001:Z = in2;//LDA
      4'b0111:begin //BAN
        if(in1[15] == 1)
          ban_len = 12'b000000000010;
        else
          ban_len = 12'b000000000000;
      end
      4'b1001: ; //stop
      endcase
  end
 
endmodule
