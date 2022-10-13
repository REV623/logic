module lvMEM (lv,up,on,setzero,reset,clk);
    output [3:0] lv;
    input up,on,setzero,reset,clk;
    wire t0,t1,t2,t3;

    // t0 in tff0
    wire t0_OtoO,t0_3AtoO,t0_AtoO,t0_NtoA,t0_Nto3A0,t0_Nto3A1,t0_4AtoN;
    or t0o0 (t0,t0_OtoO,on);
    or t0o1 (t0_OtoO,t0_3AtoO,t0_AtoO);
    and t0a0 (t0_AtoO,t0_NtoA,reset);
    not t0n0 (t0_NtoA,lv[0]);
    and3 t03A (t0_3AtoO,t0_Nto3A0,up,t0_Nto3A1);
    not t0n1 (t0_Nto3A0,t0_4AtoN);
    not t0n2 (t0_Nto3A1,reset);
    and4 t04A (t0_4AtoN,lv[0],lv[1],lv[2],lv[3]);

    // t1 in tff1
    wire t1_Nto3A,t1_3AtoN;
    and3 t13A0 (t1,lv[0],up,t1_Nto3A);
    not t1n (t1_Nto3A,t1_3AtoN);
    and3 t13A1 (t1_3AtoN,lv[1],lv[2],lv[3]);

    // t2 in tff2
    wire t2_Nto4A,t2_AtoN;
    and4 t24A (t2,up,lv[0],lv[1],t2_Nto4A);
    not t2n (t2_Nto4A,t2_AtoN);
    and t2a (t2_AtoN,lv[2],lv[3]);

    // t3 in tff3
    wire t3_4AtoA,t3_Nto4A;
    and t3a (t3,up,t3_4AtoA);
    and4 t34A (t3_4AtoA,lv[0],lv[1],lv[2],t3_Nto4A);
    not t3n (t3_Nto4A,lv[3]);

    wire reset1,reset2,reset3;
    or re1 (reset1,setzero,reset);
    or re2 (reset2,setzero,reset);
    or re3 (reset3,setzero,reset);
    T_FF tff0 (lv[0],t0,setzero,clk);
    T_FF tff1 (lv[1],t1,reset1,clk);
    T_FF tff2 (lv[2],t2,reset2,clk);
    T_FF tff3 (lv[3],t3,reset3,clk);
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

module and4 (out,a,b,c,d);
    output out;
    input a,b,c,d;
    wire an0,an1;

    and a0 (an0,a,b);
    and a1 (an1,c,d);
    and a2 (out,an0,an1);
endmodule

module and3 (out,a,b,c);
    output out;
    input a,b,c;
    wire an0;

    and a0 (an0,a,b);
    and a1 (out,an0,c);
endmodule
