`timescale 1 ns/10 ps

module MemSubSystem_tb;
	reg Clocktb, Cleartb, MARintb, MDRintb, W_sigtb;
	reg[31:0] BusMuxOuttb;
	wire[31:0] BusMuxInMDRtb; //not sure what to do for this pipeline --> does BusMuxIn-MDR & Address need to be diff sig and inout?

	MemSubSystem MSblock(Clocktb, Cleartb, MARintb, MDRintb, W_sigtb, BusMuxOuttb, BusMuxInMDRtb);
/*
	always 		
		begin
		Clocktb = 1;
		#20;
		Clocktb = 0;
		#20;
	end

	always @(posedge Clocktb) 
		begin
*/
	initial
		begin
		Clocktb = 1;
		Cleartb = 0; 
		MARintb = 1; 
		MDRintb = 1;
		W_sigtb = 0; 
		BusMuxOuttb = 32'b1111_0000_1111_0000_1111_0000_1111_0000; 
		#50;
		Clocktb = 1;
		Cleartb = 0; 
		MARintb = 1; 
		MDRintb = 1;
		W_sigtb = 1; 
		BusMuxOuttb = 32'b0000_1111_0000_1111_0000_1111_0000_1111; 
	end
endmodule