`include "CPU_def.sv"

module reg_exec_mem(

	input clk,
	input clr,
	
	input reg reg_write_e,
	input reg mem_to_reg_e,
	input reg mem_write_e,

	input reg [PC_BITS - 1 : 0] alu_out_e,

	input reg [PC_BITS - 1 : 0] write_data_e,

	input pc_plus_4e,

	input write_reg_e,

	output reg reg_write_m,
	output reg mem_to_reg_m,
	output reg mem_write_m,

	output pc_plus_4m,

	output reg [PC_BITS - 1 : 0] alu_out_m,
	output reg [PC_BITS - 1 : 0] write_data_m,

	output write_reg_m
);

	always @(posedge clk, posedge clr) begin
		if (clr) begin
			mem_to_reg_m <= 2'b00;
			reg_write_m <= 1'b0;
			mem_write_m <= 1'b0;
			alu_out_m <= 32'b0;
			write_data_m <= 32'b0;
			write_reg_m <= 5'b0;
			pc_plus_4m <= 0;
		else begin
			mem_to_reg_m <= mem_to_reg_e;
			reg_write_m <= reg_write_e;
			mem_write_m <= mem_write_e;
			alu_out_m <= alu_out_e;
			write_data_m <= write_data_e;
			write_reg_m <= write_reg_e;
			pc_plus_4m <= pc_plus_4e;
		end
	end

endmodule
	
