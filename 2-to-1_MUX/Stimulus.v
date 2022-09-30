module stimulus;
	reg sel;
	reg din_0,din_1;
	wire mux_out;
	// instantiate the design block
	mux_2to1 mux1(mux_out, din_0,din_1,sel);
	
	// control the signals that drives the design block
	initial
		begin
			$dumpfile("MUXTimeDiagram.vcd");
			$dumpvars(0,stimulus);
			din_0 = 1'b0;  // set din_0 to 0
			din_1 = 1'b1;  // set din_1 to 1
			sel   = 1'b0;  // set sel to 0
		end		
	always 
		#5 sel = ~sel; // toggle sel every 5 time units
	
	
	initial
	begin
		#20 begin
			din_0 = 1'b1;  // set din_0 to 0
			din_1 = 1'b0;  // set din_1 to 1
			end
		#20 begin
			din_0 = 1'b0;  // set din_0 to 0
			din_1 = 1'b1;  // set din_1 to 1
			end
			
		#100 $finish;
	end
	initial 
		$monitor ($time, " Output d1=%d d2=%d sel=%d mux=%d",din_0,din_1, sel, mux_out);
 endmodule
  