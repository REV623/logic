module stimulus;
	reg up,on,setzero,reset,clk;
	wire [3:0] lv;

    lvMEM LM (lv,up,on,setzero,reset,clk);
	
	initial
		begin
			$dumpfile("LMTD.vcd");
			$dumpvars(0,stimulus);
            setzero = 1'b1;
            up = 1'b0;
            on = 1'b0;
            reset = 1'b0;
			clk = 1'b1;     
		end
	always
		#5 clk = ~clk;
	initial
        begin
            #10 setzero = 1'b0;
            #10 on = 1'b1;
            #10 on = 1'b0;
            #10 up = 1'b1;
            #100 up = 1'b0;
            #30 reset = 1'b1;
            #20 up = 1'b1;
            #20 reset = 1'b0;
            #300 $finish;
        end
	initial 
		$monitor ($time, " lv0=%b lv1=%b lv2=%b lv3=%b up=%d on=%d setzero=%d reset=%d CLK=%d",lv[0],lv[1],lv[2],lv[3],up,on,setzero,reset,clk);
endmodule