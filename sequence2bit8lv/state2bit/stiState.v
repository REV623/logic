module stimulus;
	reg stop,show,reset,clk;
	wire [1:0] q;

    state s (q,stop,show,reset,clk);
	
	initial
		begin
			$dumpfile("stateTD.vcd");
			$dumpvars(0,stimulus);
            stop = 1'b0;
            show = 1'b0;
            reset = 1'b1;
			clk = 1'b1;     
		end		
	always 
		#5 clk = ~clk;
	initial
        begin
            #10 reset = 1'b0;
            #10 show = 1'b1;
            #100 stop = 1'b1;
            #50 $finish;
        end
	initial 
		$monitor ($time, " q1=%b q0=%b stop=%d show=%d reset=%d CLK=%d",q[1],q[0],stop,show,reset,clk);
endmodule