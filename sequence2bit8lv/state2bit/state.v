module state (q,stop,show,reset,clk);
    output [1:0] q;
    input stop,show,reset,clk;
    wire [1:0] qin;
    wire stopToEn;

    not n1 (stopToEn,stop);
    countup2bit c1 (qin,stopToEn,reset,clk);
    and a1 (q[1],qin[1],show);
    and a2 (q[0],qin[0],show);
endmodule

module countup2bit (q, en, reset, clk);
	output [1:0] q;
	input en, clk, reset;
	wire t0,t1;

    and a1 (t0,1'b1,en);
    and a2 (t1,q[0],en);
	T_FF tff0 (q[0], t0, reset, clk);
	T_FF tff1 (q[1], t1, reset, clk);
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
