`include "CPU_def.sv"

module control_unit(
	input [5 : 0] funct,
	input [PC_BITS - 1 : 0] op_code,

	output reg reg_write_d,
	output reg mem_to_reg_d,
	output reg mem_write_d,
	output reg alu_control_d,
	output reg alu_src_d,
	output reg reg_dst_d,
	
	output reg ext_op,
	output reg jump_d,
	output reg branch_d
);

	always_comb begin
		
		case (op_code)
			ROP: begin
				if (funct == ADD)
					reg_dst_d <= 1'b1;
				else
					reg_dst_d <= 1'b0;

				alu_src_d <= 1'b0;
				mem_to_reg_d <= 2'b00;
				reg_write_d <= 1'b1;
				mem_write_d <= 1'b0;
				branch_d <= 1'b0;
				alu_control_d <= 2'b10;
				jump_d <= 1'b0;
			end
			LW: begin
				reg_dst_d <= 2'b00;
				alu_src_d <= 1'b1;
				mem_to_reg_d <= 2'b01;
				reg_write_d <= 1'b1;
				mem_write_d <= 1'b0;
				branch_d <= 1'b0;
				alu_control_d <= 2'b00;
				jump_d <= 1'b0;
			end
			SW: begin
				alu_src_d <= 1'b1;
				reg_write_d <= 1'b0;
				mem_write_d <= 1'b1;
				branch_d <= 1'b0;
				alu_control_d <= 2'b00;
				jump_d <= 1'b0;
			end
			BEQ: begin
				alu_src_d <= 1'b0;
				reg_write_d <= 1'b0;
				mem_write_d <= 1'b0;
				branch_d <= 1'b1;
				alu_control_d <= 2'b01;
				jump_d <= 1'b0;
			end
			ADDI: begin
				reg_dst_d <= 2'b00;
				alu_src_d <= 1'b1;
				mem_to_reg_d <= 2'b00;
				reg_write_d <= 1'b1;
				mem_write_d <= 1'b0;
				branch_d <= 1'b0;
				alu_control_d <= 2'b00;
				jump_d <= 1'b0;
			NOP: begin
				reg_dst_d <= 2'b00;
				alu_src_d <= 1'b0;
				mem_to_reg_d <= 2'b00;
				reg_write_d <= 1'b0;
				mem_write_d <= 1'b0;
				branch_d <= 1'b0;
				alu_control_d <= 2'b00;
				jump_d <= 1'b0;
			end
			J: begin
				reg_write_d <= 1'b0;
				mem_write <= 1'b0;
				jump_d <= 1'b1;
			end
			JAL: begin
				reg_dst_d <= 2'b10;
				mem_to_reg_d <= 2'b10;
				reg_write_d <= 1'b1;
				mem_write_d <= 1'b0;
				jump_d <= 1'b1;
			end
			LWR: begin
				reg_dst_d <= 2'b01;
				alu_src_d <= 1'b0;
				mem_to_reg_d <= 2'b01;
				reg_write_d <= 1'b1;
				mem_write_d <= 1'b0;
				branch_d <= 1'b0;
				alu_control_d <= 2'b00;
				jump_d <= 1'b0;
			end
			default: begin
				$display("Unknown instruction");
	end

endmodule
