module PC(

    input clk,
    input rst,
    output reg [7:0] pc
);
    always@(posedge clk) beign
        if (rst == 1)
            pc = 0;
        else
            pc = pc + 1;
    end

endmoudle