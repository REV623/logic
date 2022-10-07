module stimulus;
	wire a,b,c,d,e,f,g;
    reg [3:0] q;

    BCD_to_7_segment bcd7 (a,b,c,d,e,f,g,q);
	
	initial
		begin
			$dumpfile("BCD7TimeDiagram.vcd");
			$dumpvars(0,stimulus);
            q = 4'b0000;
		end

	initial
        begin
            #5 q = 1;
            #5 q = 2;
            #5 q = 3;
            #5 q = 4;
            #5 q = 5;
            #5 q = 6;
            #5 q = 7;
            #5 q = 8;
            #5 q = 9;
            #5 $finish;
        end
	initial 
		$monitor ($time, " a=%d b=%d c=%d d=%d e=%d f=%d g=%d q3=%b q2=%b q1=%b q0=%b",a,b,c,d,e,f,g,q[3],q[2],q[1],q[0]);
endmodule
