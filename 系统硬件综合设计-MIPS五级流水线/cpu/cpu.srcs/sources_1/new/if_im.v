//////////////////////////////////////////////////////////////////////////////////
// Module Name: if_im
// Author:lerogo
//////////////////////////////////////////////////////////////////////////////////

`ifndef _if_im
`define _if_im

module if_im(
    input clk,
    input  npc_s1,
    output im_data_s1
    );
    wire[31:0] npc_s1;
    reg[31:0] im_data_s1;
    
    // number of instruction
    parameter MEM_NUM = 0;
	parameter IM_DATA_FILENAME = "";
    // 32λ��ָ�� 32bits instructions
	reg [31:0] mem [0:MEM_NUM];
    
    // ��ȡ16���Ƶ�����
	initial begin
		$readmemh(IM_DATA_FILENAME, mem,0, MEM_NUM-1);
	end
	always @(*) begin
	   if(npc_s1[8:2] > MEM_NUM) im_data_s1 <= 32'b0;
	   // ��4 ��n��  pc <= pc+4 means npc_s1[8:2] not npc_s1[8:0]
	   else im_data_s1 <= mem[npc_s1[8:2]][31:0];   
	end
    
endmodule

`endif



