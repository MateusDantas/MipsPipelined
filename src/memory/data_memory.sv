`include "CPU_def.sv"

module data_memory(
	input wire clk,
	input wire rst,

	input reg [PC_BITS - 1 : 0] alu_out_m,
	input [PC_BITS - 1 : 0] write_data_m,
	input reg mem_write_m,

	output [PC_BITS - 1 : 0] read_data_m
);

	reg [PC_BITS - 1 : 0] main_memory [0 : SIZE_MEMORY - 1];
	always_comb begin
		read_data_m <= main_memory[alu_out_m];
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			main_memory <= {32'b0};
		end
		else if (mem_write_m) begin
			main_memory[alu_out_m] <= write_data_m;
	end

endmodule
