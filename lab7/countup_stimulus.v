module stimulus;
	reg clk,reset;
	wire a,b,c,d,e,f,g;
    wire [1:0] q;

    countup2bit c2b (a,b,c,d,e,f,g, q, clk, reset);
	
	initial
		begin
			$dumpfile("CountUpTimeDiagram.vcd");
			$dumpvars(0,stimulus);
			reset = 1'b0;
			clk   = 1'b0;
		end		
	always 
		#10 clk = ~clk;
	initial
        begin
            #80 begin
                reset = 1'b1;
                end
            #100 $finish;
        end
	initial 
		$monitor ($time, "CLK=%d reset=%d q1=$d q0=%d a=%d b=%d c=%d d=%d e=%d f=%d g=%d",clk,reset,q[1],q[0],a,b,c,d,e,f,g);
endmodule
