module stimulus;
	reg clk,reset;
	wire q1,q0;

    graycode g (q1,q0,clk,reset);
	
	initial
		begin
			$dumpfile("CountUpTimeDiagram.vcd");
			$dumpvars(0,stimulus);
			clk = 1'b1;
		end		
	always 
		#5 clk = ~clk;
	initial
        begin
            reset = 1'b1;
            #10 reset = 1'b0;
            #100 $finish;
        end
	initial 
		$monitor ($time, " CLK=%d L1=%b L0=%b",clk,q1,q0);
endmodule