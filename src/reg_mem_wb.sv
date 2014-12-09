`include "CPU_def.sv"

module reg_mem_wb(
	input clk,
	input rst,
	input stall_w,

	input reg reg_write_m,
	input reg mem_to_reg_m,

	input [PC_BITS - 1 : 0] read_data_m,
	
	input reg [PC_BITS - 1 : 0] alu_out_m,
	
	input write_reg_m,

	input pc_plus_4m,

	output reg_write_wb,
	output mem_to_reg_wb,

	output [PC_BITS - 1 : 0] read_data_wb,

	output reg [PC_BITS - 1 : 0] alu_out_wb,

	output pc_plus_4wb,

	output write_reg_wb
);

	always @(posedge clk, posedge rst) begin
		if (rst) begin
			mem_to_reg_wb <= 2'b00;
			reg_write_wb <= 1'b0;
			alu_out_wb <= 32'b0;
			read_data_wb <= 32'b0;
			write_reg_wb <= 5'b0;
			pc_plus_4wb <= 0;
		end
		else if (stall_w) begin
			reg_write_wb <= reg_write_m;
			mem_to_reg_wb <= mem_to_reg_m;
			read_data_wb <= read_data_m;
			alu_out_wb <= alu_out_m;
			write_reg_wb <= write_reg_m;
			pc_plus_4wb <= pc_plus_4e;
		end
	end

endmodule
