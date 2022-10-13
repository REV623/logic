module C4B (q,en,reset,clk);
	output [3:0] q;
	input en,reset,clk;
	wire t1,t2,t3;

    and a1 (t1,q[0],en);
    and3 a2 (t2,q[0],q[1],en);
    and a3 (t3,q[2],t2);
	T_FF tff0 (q[0],en,reset,clk);
	T_FF tff1 (q[1],t1,reset,clk);
    T_FF tff2 (q[2],t2,reset,clk);
    T_FF tff3 (q[3],t3,reset,clk);
endmodule

module T_FF (q, t, reset, clk);
	output q;
	input t,reset,clk;
	wire d;

	xor x1(d,q,t);
	D_FF d1(q,d,reset,clk);
endmodule

module D_FF (q, d, reset, clk);
	output q;
	input d,reset,clk;
	reg q;
	
	always @(posedge reset or posedge clk)
		if (reset)
  			q <= 1'b0;
		else
  			q <= d;
endmodule

module and3 (out,a,b,c);
    output out;
    input a,b,c;
    wire an0;

    and a0 (an0,a,b);
    and a1 (out,an0,c);
endmodule