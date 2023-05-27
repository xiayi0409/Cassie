module registers(
    input wire clk,
    input wire wr_en;
    input [2:0] read_reg1,read_reg2，write_reg,
    input [15:0] write_data,
    output [15:0] reg1,reg2
);
    reg[15,0] registers[7:0];
    integer i;
    initial begin
            for(i=0;i<8;i=i+1) begin
                registers[i] = i;
            end
        end

   
    always@(negedge clk) begin 
        if(wr_en == 1)
            registers[write_reg] = write_data;
    end

    assign reg1 = regfile[read_reg1];
    assign reg2 = regfile[read_reg2];
  
endmodule

