`include "CPU_def.sv"

module pc_reg(input clk, input [PC_BITS - 1 : 0] pc, input enable, output reg [PC_BITS - 1 : 0] pc_f);

	always @(posedge clk) begin
		if (enable) begin
			pc_f <= pc;
		end
	end

endmodule
