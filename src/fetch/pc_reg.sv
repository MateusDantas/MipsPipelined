`include "CPU_def.sv"

module pc_reg(input clk, input stall_f, input [PC_BITS - 1 : 0] pc, output reg [PC_BITS - 1 : 0] pc_f);

	always @(posedge clk) begin
		if (~stall_f) begin
			pc_f <= pc;
		end
	end

endmodule
