/*
	If jump is enabled, then move PC to JumpD adress, otherwise choose PCF if Branch is not enabled.
*/
module PC_Mux(input [31:0] PCF, input [31:0] BranchD, input [31:0] JumpD, input JumpControl, input PCScrD, output [31:0] NextPCF);
	always_comb NextPCF <= JumpControl ? JumpD : (PCScrD ? BranchD : PCF);
endmodule
