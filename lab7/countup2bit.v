//-----------------------------------------------------
 // Design Name : 2-Bit Synchronous Count Up 
 // File Name   : Count2BitSync.v
 // Function    : Using Synchronous Sequential Circuit Design to create 2 bit count up on CPLD
 // Coder       : Paskorn Champrasert
 // Date 		: Sept 27, 2022
 //-----------------------------------------------------
 
module countup2bit (a,b,c,d,e,f,g, q, clk, reset);
	output a,b,c,d,e,f,g;
	output [1:0] q; // MSB [...] LSB
	input clk, reset;
	wire q0;

			T_FF tff0 (q[0], 1'b1, clk, reset);
			T_FF tff1 (q[1], q[0], clk, reset);
			segment s (a,b,c,d,e,f,g,q);			
			
endmodule

module segment(a,b,c,d,e,f,g,q);
	output a,b,c,d,e,f,g;
	input [1:0] q;
	
	decoder_4x16 bcd (dout,q);
	
	or aor (a,dout[1],dout[0]);
	or bor (b,dout[5],dout[6]);
	wire d1;
	or dor1 (d1,dout[1],dout[4]);
	or dor2 (d,dout[7],d1);

endmodule

module decoder_4x16 (d_out, d_in);

   output [15:0] d_out;
   input [3:0]   d_in;
   parameter tmp = 16'b0000_0000_0000_0001;

assign d_out = (d_in == 4'b0000) ? tmp   :
               (d_in == 4'b0001) ? tmp<<1:
               (d_in == 4'b0010) ? tmp<<2:
               (d_in == 4'b0011) ? tmp<<3:
               (d_in == 4'b0100) ? tmp<<4:
               (d_in == 4'b0101) ? tmp<<5:
               (d_in == 4'b0110) ? tmp<<6:
               (d_in == 4'b0111) ? tmp<<7:
               (d_in == 4'b1000) ? tmp<<8:
               (d_in == 4'b1001) ? tmp<<9:
               (d_in == 4'b1010) ? tmp<<10:
               (d_in == 4'b1011) ? tmp<<11:
               (d_in == 4'b1100) ? tmp<<12:
               (d_in == 4'b1101) ? tmp<<13:
               (d_in == 4'b1110) ? tmp<<14:
               (d_in == 4'b1111) ? tmp<<15: 16'bxxxx_xxxx_xxxx_xxxx;

endmodule

module T_FF (q, t, clk, reset);
	output q;
	input t,clk,reset;
	wire d;
		xor xor01(d,q,t);
		D_FF  d01(q,d,clk,reset);
endmodule

module D_FF (q, d, clk, reset);
	output q;
	input d,clk,reset;
	reg q;
	
	always @(posedge reset or negedge clk)
		if (reset)
  			q= 1'b0;
		else
  			q=d;
endmodule
