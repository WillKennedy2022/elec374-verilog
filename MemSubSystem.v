module MemSubSystem(
	input Clock, Clear, MARin, MDRin, W_sig,
	input[31:0] BusMuxOut,
	inout[31:0] BusMuxInMDR); //This signal represents the output of MDR onto bus

	wire[31:0] Data, MdataIn, MDMuxOut; // Data represents output of MDR to RAM
	wire[8:0] Address;

	RAM RAM_MS(
		.address(Address),
		.clock(Clock),
		.data(BusMuxInMDR),
		.wren(W_sig),
		.q(MdataIn));
	
	MDR_unit MDR_MS(
		.q(BusMuxInMDR),
		.busMuxOut(BusMuxOut), .mDataIn(MdataIn), 
		.clk(Clock), .clr(Clear), .MDRin(MDRin), .MDRread(1)); // with megafunction RAM is technically always asserting a read to output value
  
	MAR_unit MAR_MS(
		.Q(Address),
		.enable(MARin), .clk(Clock), .clr(Clear),
		.D(BusMuxOut));
endmodule