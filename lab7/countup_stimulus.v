module stimulus;
	reg clk,reset;
	wire a,b,c,d,e,f,g;
    wire [1:0] q;

    countup2bit c2b (a,b,c,d,e,f,g, q, clk, reset);
	
	initial
		begin
			$dumpfile("CountUpTimeDiagram.vcd");
			$dumpvars(0,stimulus);
			clk   = 1'b0;
		end		
	always 
		#5 clk = ~clk;
	initial
        begin
            reset = 1'b1;
			#50 reset = 1'b0;
			#50 reset = 1'b1;
			#5 reset = 1'b0;
            #50 $finish;
        end
	initial 
		$monitor ($time, " CLK=%d reset=%d q=%b a=%d b=%d c=%d d=%d e=%d f=%d g=%d",clk,reset,q,a,b,c,d,e,f,g);
endmodule
