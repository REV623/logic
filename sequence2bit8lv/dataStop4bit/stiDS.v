module stimulus;
	reg en,reset,clk;
    reg [3:0] b;
	wire [15:0] d;

    DS dstop (d,b,en,reset,clk);
	
	initial
		begin
			$dumpfile("DSTD.vcd");
			$dumpvars(0,stimulus);
            b = 4'b0000;
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
            #10 b = 1;
            #10 b = 2;
            #10 b = 3;
            #10 b = 4;
            #10 b = 5;
            #10 b = 6;
            #10 b = 7;
            #10 b = 8;
            #10 b = 9;
            #10 b = 10;
            #10 en = 1'b0;
            #50 en = 1'b1;
            #10 b = 11;
            #10 b = 12;
            #10 b = 13;
            #10 b = 14;
            #10 b = 15;
            #10 reset = 1'b1;
            #50 reset = 1'b0;
            #10 en = 1'b1;
            #10 b = 10;
            #50 $finish;
        end
endmodule