module graycode (q1,q0,clk,reset);
    output q1,q0;
    input clk,reset;
    wire t0b,t1b;

    xor x1 (t1b,q0,q1);
    xnor x0 (t0b,q0,q1);
    T_FF t0 (q0,t0b,clk,reset);
    T_FF t1 (q1,t1b,clk,reset);
endmodule

module T_FF (q, t, clk, reset);
	output q;
	input t,clk,reset;
	wire d;
		xor x1(d,q,t);
		D_FF d1(q,d,clk,reset);
endmodule

module D_FF (q, d, clk, reset);
	output q;
	input d,clk,reset;
	reg q;
	
	always @(posedge reset or posedge clk)
		if (reset)
  			q <= 1'b0;
		else
  			q <= d;
endmodule