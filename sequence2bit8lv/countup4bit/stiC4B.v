module stimulus;
	reg en,reset,clk;
	wire [3:0] q;

    C4B a (q,en,reset,clk);
	
	initial
		begin
			$dumpfile("C4BTD.vcd");
			$dumpvars(0,stimulus);
            en = 1'b0;
            reset = 1'b1;
			clk = 1'b1;     
		end
	always
		#5 clk = ~clk;
	initial
        begin
            #10 reset = 1'b0;
            #10 en = 1'b1;
            #200 en = 1'b0;
            #50 $finish;
        end
endmodule