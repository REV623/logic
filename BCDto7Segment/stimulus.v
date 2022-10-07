module stimulus;
	wire a,b,c,d,e,f,g;
    reg [3:0] q;

    BCD_to_7_segment bcd (a,b,c,d,e,f,g,q);
	
	initial
		begin
			$dumpfile("BCDTimeDiagram.vcd");
			$dumpvars(0,stimulus);
            q = 4'b0000;
		end		
	initial
        begin
            #5 q = 4'b0001;
            #5 q = 4'b0010;
            #5 q = 4'b0011;
            #5 q = 4'b0100;
            #5 q = 4'b0101;
            #5 q = 4'b0110;
            #5 q = 4'b0111;
            #5 q = 4'b1000;
            #5 q = 4'b1001;
            #5 $finish;
        end
	initial 
		$monitor ($time, " a=%b b=%b c=%b d=%b e=%b f=%b g=%b q=%b",a,b,c,d,e,f,g,q);
endmodule