module seq2b8lv (win,l,b,on,setzero,reset,start,clk);
    output [3:0] l;
    output win;
    input [3:0] b;
    input on,reset,setzero,start,clk;
    wire clk_div;

    freq_div frdiv (clk_div,clk);

    wire sc;
    T_FF startcircuit (sc,start,reset,clk_div);

    decoder2bit DCdisplay (l,{B1,B0},displayEn);

    wire displayEn;
    xor xor0 (displayEn,stopout,do[0]);

    wire [15:0] di;
    decoder4bit DCIM (di,IM_q,stopin);

    wire stopin;
    T_FF tffin (stopin,out_M4_OM,reIM,clk_div);//re_tffin
    /*
    wire re_tffin,and123,NtoA123;
    or tffinOR (re_tffin,reIM,);
    and tffbeforeinAND (and123,NtoA123,press);
    not tffbeforeinNOT (NtoA123,correct);*/

    wire [15:0] do;
    decoder4bit DCOM (do,OM_q,stopout);

    wire Twin_NtoA,Twin_AtoN;
    not TwinNOT (Twin_NtoA,Twin_AtoN);
    and TwinAND (Twin_AtoN,out_M4_maxLV,out_M4_IM);

    T_FF tffwin (win,Twin_AtoN,reset,clk_div);

    wire stopout,re_tffout,T_tffout,tffout_OtoA;
    T_FF tffout (stopout,T_tffout,re_tffout,clk_div);
    or tffoutOR1 (re_tffout,reset,out_M4_OM);
    and tffoutAND (T_tffout,Twin_NtoA,tffout_OtoA);
    or tffoutOR2 (tffout_OtoA,out_M4_IM,reset);

    wire out_M4_OM;
    check4bit CHOM (out_M4_OM,OM_q,lv,sc);

    wire [3:0] OM_q;
    C4B OM (OM_q,stopout,reOM,clk_div);

    wire reOM;
    or ORreOM (reOM,out_M4_OM,reset);

    wire [15:0] stop;
    DS datastop (stop,lv,DSen,reset,clk_div);

    wire DSen;
    or orDS (DSen,reset,sc);

    wire out_M4_maxLV;
    check4bit CHwin (out_M4_maxLV,4'b1000,lv,sc);

    wire [3:0] lv;
    wire onM4,up,M4_NtoA;
    lvMEM M4 (lv,up,onM4,setzero,reset,clk_div);
    or orM4 (onM4,on,start);
    and andM4 (up,M4_NtoA,out_M4_IM);
    not notM4 (M4_NtoA,out_M4_maxLV);

    wire out_M4_IM;
    check4bit CHIM (out_M4_IM,IM_q,lv,sc);

    wire [3:0] IM_q;
    C4B IM (IM_q,correct,reIM,clk_div);
    wire reIM;
    or ORreIM (reIM,reset,out_M4_IM);

    wire press;
    or16 or4input (press,{b,12'b0000_0000_0000});

    wire correct;
    check2bit checkANS (correct,ans,{B1,B0},press);//p
    wire [1:0] ans;
    encoder2bit enc (ans,b);

    wire [1:0] sq1,sq2,sq3,sq4,sq5,sq6,sq7,sq8;
    wire B0,B1;
    or16 or16_b0 (B0,{sq1[0],sq2[0],sq3[0],sq4[0],sq5[0],sq6[0],sq7[0],sq8[0],8'b0000_0000});
    or16 or16_b1 (B1,{sq1[1],sq2[1],sq3[1],sq4[1],sq5[1],sq6[1],sq7[1],sq8[1],8'b0000_0000});

    wire [7:0] show;
    or ors1 (show[0],di[0],do[1]);
    or ors2 (show[1],di[1],do[2]);
    or ors3 (show[2],di[2],do[3]);
    or ors4 (show[3],di[3],do[4]);
    or ors5 (show[4],di[4],do[5]);
    or ors6 (show[5],di[5],do[6]);
    or ors7 (show[6],di[6],do[7]);
    or ors8 (show[7],di[7],do[8]);

    state s1 (sq1,stop[1],show[0],reset,clk_div);
    state s2 (sq2,stop[2],show[1],reset,clk_div);
    state s3 (sq3,stop[3],show[2],reset,clk_div);
    state s4 (sq4,stop[4],show[3],reset,clk_div);
    state s5 (sq5,stop[5],show[4],reset,clk_div);
    state s6 (sq6,stop[6],show[5],reset,clk_div);
    state s7 (sq7,stop[7],show[6],reset,clk_div);
    state s8 (sq8,stop[8],show[7],reset,clk_div);
    

endmodule

module freq_div (clk_out,clk);
	output clk_out;
	input clk;
	wire [16:0] c;
		T_FF tff01(c[0], 1'b1,  clk, 1'b0);
		T_FF tff02(c[1], 1'b1, c[0], 1'b0);
		T_FF tff03(c[2], 1'b1, c[1], 1'b0);
		T_FF tff04(c[3], 1'b1, c[2], 1'b0);
		T_FF tff05(c[4], 1'b1, c[3], 1'b0);
		T_FF tff06(c[5], 1'b1, c[4], 1'b0);
		T_FF tff07(c[6], 1'b1, c[5], 1'b0);
		T_FF tff08(c[7], 1'b1, c[6], 1'b0);
		T_FF tff09(c[8], 1'b1, c[7], 1'b0);
		T_FF tff10(c[9], 1'b1, c[8], 1'b0);
		T_FF tff11(c[10], 1'b1,	c[9], 1'b0);
		T_FF tff12(c[11], 1'b1, c[10], 1'b0);
		T_FF tff13(c[12], 1'b1,  c[11], 1'b0);
		T_FF tff14(c[13], 1'b1, c[12], 1'b0);
		T_FF tff15(c[14], 1'b1,  c[13], 1'b0);
		T_FF tff16(c[15], 1'b1, c[14], 1'b0);
		T_FF tff17(c[16], 1'b1, c[15], 1'b0);
		T_FF tff18(clk_out, 1'b1, c[16], 1'b0);
endmodule

module encoder2bit (b,d);
    output [1:0] b;
    input [3:0] d;

    or o0 (b[1],d[2],d[3]);
    or o1 (b[0],d[1],d[3]);
endmodule

module check4bit (out,a,b,en);
    output out;
    input [3:0] a;
    input [3:0] b;
    input en;
    wire d0,d1,d2,d3,A4toA;

    and a0 (out,A4toA,en);
    and4 a1 (A4toA,d0,d1,d2,d3);
    xnor x0 (d0,a[0],b[0]);
    xnor x1 (d1,a[1],b[1]);
    xnor x2 (d2,a[2],b[2]);
    xnor x3 (d3,a[3],b[3]);
endmodule

module check2bit (out,a,b,en);
    output out;
    input [1:0] a;
    input [1:0] b;
    input en;
    wire d0,d1,AtoA;

    and a0 (out,AtoA,en);
    and a1 (AtoA,d0,d1);
    xnor x0 (d0,a[0],b[0]);
    xnor x1 (d1,a[1],b[1]);
endmodule

module decoder4bit (d,b,en);
    output [15:0] d;
    input [3:0] b;
    input en;
    reg [15:0] d;
 
    always @(posedge en)
    begin
        if(en)
            begin
                case(b)
                    0 : d <= 16'b0000_0000_0000_0001;
                    1 : d <= 16'b0000_0000_0000_0010;
                    2 : d <= 16'b0000_0000_0000_0100;
                    3 : d <= 16'b0000_0000_0000_1000;
                    4 : d <= 16'b0000_0000_0001_0000;
                    5 : d <= 16'b0000_0000_0010_0000;
                    6 : d <= 16'b0000_0000_0100_0000;
                    7 : d <= 16'b0000_0000_1000_0000;
                    8 : d <= 16'b0000_0001_0000_0000;
                    9 : d <= 16'b0000_0010_0000_0000;
                    10 : d <= 16'b0000_0100_0000_0000;
                    11 : d <= 16'b0000_1000_0000_0000;
                    12 : d <= 16'b0001_0000_0000_0000;
                    13 : d <= 16'b0010_0000_0000_0000;
                    14 : d <= 16'b0100_0000_0000_0000;
                    15 : d <= 16'b1000_0000_0000_0000;
                    default : d <= 16'b0000_0000_0000_0000;
                endcase
            end
        else
            d <= 16'b0000_0000_0000_0000;
    end
endmodule

module decoder2bit (d,b,en);
    output [3:0] d;
    input [1:0] b;
    input en;
    reg [3:0] d;
 
    always @(posedge en)
    begin
        if(en)
            begin
                case(b)
                    0 : d <= 4'b0001;
                    1 : d <= 4'b0010;
                    2 : d <= 4'b0100;
                    3 : d <= 4'b1000;
                    default : d <= 4'b0000;
                endcase
            end
        else
            d <= 4'b0000;
    end
endmodule

module DS (d,b,en,reset,clk);
    output [15:0] d;
    input [3:0] b;
    input en,reset,clk;
    reg [15:0] d;

    always @(posedge en or posedge reset or posedge clk)
    begin 
        if(reset)
            d <= 0;
        else
        begin
            if(en)
            begin
                case(b)
                    0 : d <= 16'b0000_0000_0000_0001;
                    1 : d <= 16'b0000_0000_0000_0011;
                    2 : d <= 16'b0000_0000_0000_0111;
                    3 : d <= 16'b0000_0000_0000_1111;
                    4 : d <= 16'b0000_0000_0001_1111;
                    5 : d <= 16'b0000_0000_0011_1111;
                    6 : d <= 16'b0000_0000_0111_1111;
                    7 : d <= 16'b0000_0000_1111_1111;
                    8 : d <= 16'b0000_0001_1111_1111;
                    9 : d <= 16'b0000_0011_1111_1111;
                    10 : d <= 16'b0000_0111_1111_1111;
                    11 : d <= 16'b0000_1111_1111_1111;
                    12 : d <= 16'b0001_1111_1111_1111;
                    13 : d <= 16'b0011_1111_1111_1111;
                    14 : d <= 16'b0111_1111_1111_1111;
                    15 : d <= 16'b1111_1111_1111_1111;
                    default : d <= 16'b0000_0000_0000_0000;
                endcase
            end
            else
                d <= d;
        end
    end
endmodule

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

module countup2bit (q, en, reset, clk);
	output [1:0] q;
	input en,clk,reset;
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

module or16 (out0,in);
    output out0;
    input [15:0] in;
    reg out0;

    always @(in)
        if(in==0)
            out0 <= 1'b0;
        else
            out0 <= 1'b1;
endmodule

module and4 (out1,a,b,c,d);
    output out1;
    input a,b,c,d;
    wire an0,an1;

    and a0 (an0,a,b);
    and a1 (an1,c,d);
    and a2 (out1,an0,an1);
endmodule

module and3 (out2,a,b,c);
    output out2;
    input a,b,c;
    wire an0;

    and a0 (an0,a,b);
    and a1 (out2,an0,c);
endmodule
