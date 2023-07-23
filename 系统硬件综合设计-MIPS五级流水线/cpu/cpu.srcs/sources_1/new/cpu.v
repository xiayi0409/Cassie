`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: cpu
// Author:lerogo
//////////////////////////////////////////////////////////////////////////////////

//include
`include "if_pc.v"
`include "if_im.v"
`include "reg_file.v"
`include "id_decode.v"
`include "id_control.v"
`include "exe_alu.v"
`include "mem_dm.v"
`include "reg_latches.v"

module cpu(clk,reset);
    input clk,reset;
    // number of instruction memory
    parameter MEM_NUM = 0;
    // number of datamem
    parameter MEM_DATA_NUM = 0;
    // fileName of instructions restore 
    parameter IM_DATA_FILENAME = "";

    // hold����1->2�ȴ�ִ���꣬flush����b��jָ��������
    reg hold,flush;

    // ��һ�׶�
    // ���ڶ�pc��ѡ��
    reg [1:0] pcsource_s1;
    // ��ת�ĵ�ַ pc��ַ
    reg [31:0] baddr_s1,jaddr_s1;
    wire [31:0] npc_s1;
    // ��һ�׶λ�ȡ����ָ��
    wire [31:0] im_data_s1;
    
    // �ڶ��׶�
    // ���ݵ��ڶ��׶ε�npc_s2�����ݵ��ڶ��׶ε�im_data_s2
    wire [31:0] npc_s2,im_data_s2;
    // �������
    wire [5:0] opcode_s2;
    wire [4:0] rs_s2,rt_s2,rd_s2;
    wire [15:0] imm_s2;
    wire [31:0] jaddr_s2;
    // b �ĵ�ַ
    wire [31:0] baddr_s2 = npc_s2 + { {14{imm_s2[15]}},imm_s2, 2'b0 };
    // ����������Ŀ����ź�
    wire is_imm_s2,is_branch_s2,is_jump_s2,mem_read_s2,mem_write_s2,write_back_s2;
    wire [4:0] rs_control_s2,rt_control_s2;
    // �Ĵ�����õ�ֵ
    wire [31:0] rs_data_s2,rt_data_s2;
    
    // �����׶�
    // ����
    wire [5:0] opcode_s3;
    wire [4:0] rs_control_s3,rt_control_s3,rd_s3;
    wire [15:0] imm_s3;
    wire [31:0] jaddr_s3,baddr_s3;
    wire is_imm_s3,is_branch_s3,is_jump_s3,mem_read_s3,mem_write_s3,write_back_s3;
    wire [31:0] rs_data_s3,rt_data_s3;
    // alu
    reg [31:0] alu_data1_s3,alu_data2_s3;
    wire [31:0] alu_out_s3;
    reg [1:0] rw_bits_s3;
    // ������һ�׶��õ�����
    
    // ���Ľ׶�
    // ����
    // д��Ŀ��
    wire [5:0] opcode_s4;
    wire [4:0] rd_s4;
    wire [31:0] jaddr_s4,baddr_s4;
    wire is_branch_s4,is_jump_s4,mem_read_s4,mem_write_s4,write_back_s4;
    // ���Ҫ��/д�ڴ� ��ôдmem�ĵ�ַΪalu_out_s4
    // ���Ҫ��д����ô��д����Ϊalu_out_s4
    wire [31:0] alu_out_s4;
    // ��/д�ڴ�ʱ����д����λ Ĭ��Ϊ00 32λ    
    wire [1:0] rw_bits_s4;
    // ���ڴ�Ľ��    // д�ڴ������
    wire [31:0] mem_read_data_s4,write_data_s4;
    // ��д����
    wire [31:0] wdata_s4;
    
    // ����׶�
    // ����
    wire write_back_s5,mem_read_s5;
    wire [4:0] rd_s5;
    wire [31:0] wdata_s5,alu_out_s5,mem_read_data_s5;

    // ���� ����4��5�׶��޸�reg���� ֱ�Ӷ������׶εļĴ���
    reg [1:0] forward_a,forward_b;
  

    always @(negedge reset) begin
        hold <= 1'b0;
        flush <= 1'b0;
        pcsource_s1 <= 2'b01;
        forward_a <= 1'b0;
        forward_b <= 1'b0;
    end
    // ��һ�׶�
    //����pc
    if_pc if_pc1(
        .clk(clk),.reset(reset),
        .pcsource_s1(pcsource_s1),.baddr_s1(baddr_s1),.jaddr_s1(jaddr_s1),
        .pc_s1(npc_s1),.npc_s1(npc_s1)
    );
    // ����ָ���ȡ
    if_im #(.MEM_NUM(MEM_NUM),.IM_DATA_FILENAME(IM_DATA_FILENAME)) if_im1(
        .clk(clk),.npc_s1(npc_s1),.im_data_s1(im_data_s1)
    );
    // �ѵ�һ�׶ε�ָ��ת���ڶ��׶� ��������ת�ƣ�
    reg_latches #(.N(32*2)) reg_latches_s1_1(
        .clk(clk),.clear(flush),.hold(hold),
        .in({npc_s1,im_data_s1}),.out({npc_s2,im_data_s2})
    );

    // �ڶ��׶�
    // ����ָ������
    id_decode id_decode1(
        .npc_s2(npc_s2),.im_data_s2(im_data_s2),
        .opcode_s2(opcode_s2),.rs_s2(rs_s2),.rt_s2(rt_s2),.rd_s2(rd_s2),
        .imm_s2(imm_s2),.jaddr_s2(jaddr_s2)
    );
    // ��������ָ��
    id_control id_control1(
        .opcode_s2(opcode_s2),.imm_s2(imm_s2),.rs_s2(rs_s2),.rt_s2(rt_s2),.rd_s2(rd_s2),
        .is_imm_s2(is_imm_s2),.is_branch_s2(is_branch_s2),.is_jump_s2(is_jump_s2),
        .mem_read_s2(mem_read_s2),.mem_write_s2(mem_write_s2),.write_back_s2(write_back_s2),
        .rs_control_s2(rs_control_s2),.rt_control_s2(rt_control_s2)
    );
    // �����Ĵ�����
    reg_file reg_file1(
       .clk(clk),.reset(reset),.write_back_s5(write_back_s5),
       .rs_s2(rs_control_s2),.rt_s2(rt_control_s2),.rd_s5(rd_s5),.wdata(wdata_s5),
       .rs_data_s2(rs_data_s2),.rt_data_s2(rt_data_s2)
    );
    // ת������
   // �����ź�һ���ᴫ��ȥ ����ͣһ��(lw sw����ʱ)
   reg_latches #(.N(6+6)) reg_latches_s2_1(
        .clk(clk),.clear(hold | flush),.hold(1'b0),
        .in({opcode_s2,is_imm_s2,is_branch_s2,is_jump_s2,mem_read_s2,mem_write_s2,write_back_s2}),
        .out({opcode_s3,is_imm_s3,is_branch_s3,is_jump_s3,mem_read_s3,mem_write_s3,write_back_s3})
    );
   // ���ݲ��� �������
   reg_latches #(.N(5*3+16+32*2+32*2)) reg_latches_s2_2(
        .clk(clk),.clear(flush),.hold(hold),
        .in({rs_control_s2,rt_control_s2,rd_s2,imm_s2,jaddr_s2,baddr_s2,rs_data_s2,rt_data_s2}),
        .out({rs_control_s3,rt_control_s3,rd_s3,imm_s3,jaddr_s3,baddr_s3,rs_data_s3,rt_data_s3})
    );
    
    // �����׶�
    // ���alu���ߵĲ�����
    always @(*) begin
        // ֻ���������д�����������������memֱ��ͣһ��
        case(forward_a)
            2'd1: alu_data1_s3 = alu_out_s4;
            2'd2: alu_data1_s3 = wdata_s5;
            default: alu_data1_s3 = rs_data_s3;
        endcase
        if(is_imm_s3) begin
            // ������Ū��һ��addiu ��֪����Ū���ָ����
            if(opcode_s3==6'd3) alu_data2_s3 = { {16{1'b0}},imm_s3};
            else alu_data2_s3 = { {16{imm_s3[15]}},imm_s3};
        end else begin 
            case(forward_b)
                2'd1: alu_data2_s3 = alu_out_s4;
                2'd2: alu_data2_s3 = wdata_s5;
                default: alu_data2_s3 = rt_data_s3;
            endcase
        end
    end
    // ����alu
    exe_alu exe_alu1(
        .alu_op_s3(opcode_s3),.alu_data1_s3(alu_data1_s3),.alu_data2_s3(alu_data2_s3),
        .alu_out_s3(alu_out_s3)
    );
    // ��������һ�·����ڴ�ʱ�ķ��ʶ���λ
    always @(*) begin
        if(mem_read_s3|mem_write_s3==1'b1) begin
            case(opcode_s3)
                // 8λ lb sb
                6'd24,6'd27: rw_bits_s3 <= 2'd1;
                // 16λ lh sh
                6'd25,6'd28: rw_bits_s3 <= 2'd2;
                // 32λ
                default:rw_bits_s3 <= 2'd0;
            endcase
        end
    end
    // ����
    reg_latches #(.N(5+32*2+6 + 5 + 32+2+32)) reg_latches_s3_1(
        .clk(clk),.clear(flush),.hold(1'b0),
        .in({   rd_s3,jaddr_s3,baddr_s3,opcode_s3,
                is_branch_s3,is_jump_s3,mem_read_s3,mem_write_s3,write_back_s3,
                alu_out_s3,rw_bits_s3,alu_data1_s3
         }),
        .out({  rd_s4,jaddr_s4,baddr_s4,opcode_s4,
                is_branch_s4,is_jump_s4,mem_read_s4,mem_write_s4,write_back_s4,
                alu_out_s4,rw_bits_s4,write_data_s4
         })
    );
    
    // ���Ľ׶� mem
    // ����datamem �ô�
    mem_dm #(.MEM_NUM(MEM_DATA_NUM)) mem_dm1(
        .clk(clk),.alu_out_s4(alu_out_s4),.mem_read_s4(mem_read_s4),.mem_write_s4(mem_write_s4),
        .write_data_s4(write_data_s4),.rw_bits_s4(rw_bits_s4),
        .mem_read_data_s4(mem_read_data_s4)
    );
    // jump branch����
    always @(*) begin
        // default
        pcsource_s1 <= 2'b01;
        flush <= 1'b0;
        baddr_s1 <= baddr_s4;
        jaddr_s1 <= jaddr_s4;
		case (1'b1)
			is_branch_s4: begin
			     if(alu_out_s4==32'b1)begin
			          pcsource_s1 <= 2'b10;
			          flush <= 1'b1;
			      end
			end
			is_jump_s4: begin
			     case(opcode_s4)
			         6'd23: jaddr_s1 <= alu_out_s4;
			     endcase
			     pcsource_s1 <= 2'b11;
			     flush <= 1'b1;
			end
		endcase
	end
	//����
	reg_latches #(.N(5+2+32*2)) reg_latches_s4_1(
        .clk(clk),.clear(1'b0),.hold(1'b0),
        .in({   rd_s4,write_back_s4,alu_out_s4,mem_read_s4,mem_read_data_s4 }),
        .out({  rd_s5,write_back_s5,alu_out_s5,mem_read_s5,mem_read_data_s5 })
    );
    
	// ����׶�
    // �����д����
    assign wdata_s5 = mem_read_s5 ? mem_read_data_s5:alu_out_s5;
    
    // �����ͻ
    // ��ǰ �̽�����һָ��
    always @(*) begin
		if ((write_back_s4 == 1'b1) && (rd_s4 == rs_control_s3)) begin
			forward_a <= 2'd1;
		end else if ((write_back_s5 == 1'b1) && (rd_s5 == rs_control_s3)) begin
			forward_a <= 2'd2;
		end else
			forward_a <= 2'd0;
		if ((write_back_s4 == 1'b1) & (rd_s4 == rt_control_s3)) begin
			forward_b <= 2'd1;
		end else if ((write_back_s5 == 1'b1) && (rd_s5 == rt_control_s3)) begin
			forward_b <= 2'd2;
		end else
			forward_b <= 2'd0;
	end
    // ���Ҫ���ڴ�
    always @(*) begin
		if (mem_read_s3 == 1'b1 && ((rs_control_s2 == rd_s3) || (rt_control_s2 == rd_s3)) ) begin
			hold <= 1'b1;
		end else
			hold <= 1'b0;
	   if(hold) pcsource_s1 <= 2'b00;
	end
endmodule


