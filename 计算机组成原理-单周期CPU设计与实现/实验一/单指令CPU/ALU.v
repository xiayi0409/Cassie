module ALU(
    input [15:0] in1,in2,
    input [3:0] alu_op,
    output [15:0] Z
);
    always@(*) begin
        case(alu_op)
            //算术运算
            4'd0 : Z = ln1 + in2;
            4'd1 : Z = in1 - in2;
            4'd2 : Z = in1 * in2;
            4'd3 : Z = in1 / in2;
            4'd4 : Z = in1 % in2;
            //移位运算
            4'd5 : Z = in1 << in2;
            4'd6 : Z = in1 >> in2;
            4'd7 : Z = in1 >>> in1;
            4'd8 : Z = 0;
            //位运算
            4'd9 : Z = in1 & in2;
            4'd10 : Z = in1 | in2;
            4'd11 : Z = ~in1;
        endcase
    end
endmodule
