module Indicators(	input  clk,
					input  left,
					input  right,
					input  reset,
					output [5:0] TailLights);

	reg [5:0] state;
 	reg [5:0] nextstate;

 	// Fully encoded states with 6 bits
 	parameter   S00 = 6'b000000,
 	            SLA = 6'b001000,
                SLB = 6'b011000,
 	            SLC = 6'b111000,
 	            SRA = 6'b000100,
 	            SRB = 6'b000110,
 	            SRC = 6'b000111;

	// state register
	always @ (posedge clk, posedge reset)
		if (reset) state <= S00;
		else state <= nextstate;

	// next state logic
	always @ (*)
		case (state)

			S00:	begin 
                        if (left & ~right) begin	// only the left signal is on
                           nextstate = SLA;
                        end
                        else if (~left & right) begin	// only the right signal is on
                           nextstate = SRA;
                        end
                        else begin						// either both or none of the signals are on
                           nextstate = S00;
                        end
				    end
			SLA:	nextstate = SLB;
			SLB:	nextstate = SLC;
			SLC:	nextstate = S00;
			SRA:	nextstate = SRB;
			SRB:	nextstate = SRC;
			SRC:	nextstate = S00;
			default: nextstate = S00;

		endcase

	// output logic
	assign TailLights = state;


endmodule