//////////////////////////////////////////////////////////////////////////////////
// Author:lerogo
// Module Name: reg_latches
// �����䵱������ �������� ����exe��mem��ͻʱ
// this file is register that cached some data
//////////////////////////////////////////////////////////////////////////////////

`ifndef _reg_latches
`define _reg_latches
module reg_latches(
    input clk,
    input clear,
    input hold,
    input in,
    output out
    );
    // ����λ the number of bits
    parameter N = 1;
    
    wire [N-1:0] in;
    reg [N-1:0] out;
    
    always @(posedge clk) begin
        if(clear)
            out <= {N{1'b0}};
        else if (hold)
            out <= out;
        else
            out <= in;
    end
    
endmodule

`endif
