`include "CPU_def.sv"

module reg_decode_exec(
	input clk,
	input flush_e,
	
	input reg reg_write_d,
	input reg mem_to_reg_d,
	input reg mem_write_d,
	input reg alu_control_d,
	input reg alu_src_d,
	input reg reg_dst_d,

	input logic [PC_BITS - 1 : 0] read_data_1_d,
	input logic [PC_BITS - 1 : 0] read_data_2_d,

	output logic [PC_BITS - 1 : 0] read_data_1_e,
	output logic [PC_BITS - 1 : 0] read_data_2_e, 

	input [PC_BITS - 1 : 0] pc_plus_4d,
	
	output [PC_BITS - 1 : 0] pc_plus_4e, 

	input [PC_BITS - 1 : 0] sign_imm_d,

	output [PC_BITS - 1 : 0] sign_imm_e,

	input rs_d,
	input rt_d,
	input rd_d,
	
	output rs_e,
	output rt_e,
	output rd_e,

	output reg reg_write_e,
	output reg mem_to_reg_e,
	output reg mem_write_e,
	output reg alu_control_e,
	output reg alu_src_e,
	output reg reg_dst_e
);
	
	always @(posedge clk, posedge clr) begin
		if (flush_e) begin
			reg_dst_e <= 2'b00;
			alu_src_e <= 1'b0;
			mem_to_reg_e <= 2'b00;
			reg_write_e <= 1'b0;
			mem_write_e <= 1'b0;
			branch_e <= 1'b0;
			alu_control_e <= 2'b00;
			jump_e <= 1'b0;
			rs_e <= 5'b0;
			rt_e <= 5'b0;
			rd_e <= 5'b0;
			pc_plus_4e <= 32'b0;
			sign_imm_e <= 32'b0;
			read_data_1_e <= 0;
			read_data_2_e <= 0;	
		end
		else begin
			reg_dst_e <= reg_dst_d;
			alu_src_e <= alu_src_d;
			mem_to_reg_e <= mem_to_reg_d;
			reg_write_e <= reg_write_d;
			mem_write_e <= mem_write_d;
			branch_e <= branch_d;
			alu_control_e <= alu_control_d;
			jump_e <= jump_d;
			rs_e <= rs_d;
			rt_e <= rt_d;
			rd_e <= rd_d;
			pc_plus_4e <= pc_plus_4d;
			sign_imm_e <= sign_imm_d;
			read_data_1_e <= read_data_1_d;
			read_data_2_e <= read_data_2_d;
		end
	end

endmodule
