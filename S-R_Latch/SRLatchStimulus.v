module stimulus;
	reg s,r;
	wire q,qn;
	// instantiate the design block
	sr_latch sr(q,qn,r,s);
	
	// control the signals that drives the design block
	initial
		begin
			$dumpfile("SRLatchTimeDiagram.vcd");
			$dumpvars(0,stimulus);
			s = 1'b0;
			r = 1'b0;
		end		
	initial
	begin
		#5 begin
			s = 1'b1;
			r = 1'b0;
			end
		#5 begin
			s = 1'b0;
			r = 1'b0;
			end
        #5 begin
			s = 1'b0;
			r = 1'b1;
			end
        #5 begin
			s = 1'b0;
			r = 1'b0;
			end
        #5 begin
			s = 1'b1;
			r = 1'b0;
			end
        #5 begin
			s = 1'b0;
			r = 1'b1;
			end
        #5 begin
			s = 1'b1;
			r = 1'b1;
			end
        #5 begin
			s = 1'b0;
			r = 1'b0;
			end
		#45 $finish;
	end
	initial 
		$monitor ($time, " Output S=%d R=%d Q=%d QN=%d",s,r,q,qn);
 endmodule
  