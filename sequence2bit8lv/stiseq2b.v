module stimulus;
	reg on,reset,setzero,start,clk;
    reg [3:0] b;
	wire [3:0] l;
    wire win,lose;

    seq2b8lv seq (win,lose,l,b,on,setzero,reset,start,clk);
	
	initial
		begin
			$dumpfile("seq2bTD.vcd");
			$dumpvars(0,stimulus);
            start = 1'b0;
            setzero = 1'b1;
            reset = 1'b0;
			clk = 1'b1;     
		end		
	always 
		#1 clk = ~clk;
	initial
        begin
            #1 setzero = 1'b0;
            #1 reset = 1'b1;
            #1 reset = 1'b0;
            #1 start = 1'b1;
            #50 $finish;
        end
endmodule