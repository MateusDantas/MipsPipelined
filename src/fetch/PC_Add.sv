// Return PC counter incremented by 4

module PC_Add(input [31:0] PC, output [31:0] PC_F);
	always_comb PC_F = PC + 4;
endmodule
