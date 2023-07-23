//////////////////////////////////////////////////////////////////////////////////
// Module Name: id_control
// Author:lerogo
//////////////////////////////////////////////////////////////////////////////////
`ifndef _id_control
`define _id_control

module id_control(
    input [5:0] opcode_s2,
    input [15:0] imm_s2,
    input [4:0] rd_s2,
    input [4:0] rs_s2,
    input [4:0] rt_s2,
    output reg is_imm_s2,
    output reg is_branch_s2,
    output reg is_jump_s2,
    output reg mem_read_s2,
    output reg mem_write_s2,
    output reg write_back_s2,
    output reg [4:0] rs_control_s2,
    output reg [4:0] rt_control_s2
    );
    always @(*) begin
        //default
        is_imm_s2 <= 1'b0;
        is_branch_s2 <= 1'b0;
        is_jump_s2 <= 1'b0;
        mem_read_s2 <= 1'b0;
        mem_write_s2 <= 1'b0;
        write_back_s2 <= 1'b0;
        // Ĭ�ϼĴ���
        rs_control_s2 <= rs_s2;
        rt_control_s2 <= rt_s2;
        
        case(opcode_s2)
            // ʹ��3���Ĵ�����
            // 'add', 'sub', 'and', 'or', 'nor', 'xor', 'sll', 'srl', 'sra', 'slt'
            6'd1,6'd4,6'd5,6'd7,6'd9,6'd11,6'd31,6'd33,6'd35,6'd36: begin
                 write_back_s2 <= 1'b1;
            end
            
            // ʹ��2���Ĵ��� ����imm�� ������
            // 'addi', 'addiu', 'andi', 'ori', 'nori', 'xori' 'slli', 'srli', 'srai', 'slti'
            6'd2,6'd3,6'd6,6'd8,6'd10,6'd12,6'd30,6'd32,6'd34,6'd37: begin
                write_back_s2 <= 1'b1;
                is_imm_s2 <= 1'b1;
                rt_control_s2 <= 5'b0; 
            end
            // ʹ��2���Ĵ��� ����imm�� �Ƚ����� ��ת
            // 'beq', 'beqz' ,'bne', 'bnez', 'bgt', 'bge', 'blt','ble'
            // ���� bnez beqz ָ������һ�� rtĬ��Ϊ0������ָ��ʱ��
            6'd13,6'd14, 6'd15,6'd16,6'd17,6'd18,6'd19,6'd20:begin
                is_branch_s2 <= 1'b1;
                rs_control_s2 <= rd_s2;
                rt_control_s2 <= rs_s2;
            end
            
            // ʹ��2���Ĵ�����
            // 'lb', 'lh', 'lw'
            6'd24,6'd25,6'd26: begin
                write_back_s2 <= 1'b1;
                mem_read_s2 <= 1'b1;
                rt_control_s2 <= 5'b0;
            end
            // 'sb', 'sh', 'sw'
            6'd27,6'd28,6'd29:begin
                mem_write_s2 <= 1'b1;
                rs_control_s2 <= rs_s2;
                rt_control_s2 <= rd_s2;
            end
            
            // ��һ��imm��
            // 'j'
            6'd21: begin
                is_jump_s2 <= 1'b1;
            end
            // ��һ���Ĵ�����
            // 'jr'
            6'd23: begin
                is_jump_s2 <= 1'b1;
                rs_control_s2 <= rd_s2;
                rt_control_s2 <= 5'b0;
            end
        endcase
    end
    
    
endmodule
`endif




















