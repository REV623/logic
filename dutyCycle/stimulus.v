module stimulus;
    wire newclk;
    reg clk;

    dutycycle25 dc (newclk, clk);

    initial
		begin
			$dumpfile("DCTimeDiagram.vcd");
			$dumpvars(0,stimulus);
            clk = 1'b0;
		end

    always 
		#5 clk = ~clk;

	initial
        begin
            #100 $finish;
        end
	initial 
		$monitor ($time," clk=%d newclk=%d",clk,newclk);

endmodule
