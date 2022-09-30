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
	reg [3:0] qq;

		T_FF tff0 (q[0], 1'b1, clk, reset);
		T_FF tff1 (q[1], q[0], clk, reset);

	assign qq = 4'b0000 + q;

		BCD_to_7_segment bcds (a,b,c,d,e,f,g,qq);	
			
endmodule

module BCD_to_7_segment (a,b,c,d,e,f,g,q);
	output a,b,c,d,e,f,g;
	input [3:0] q;
	
	assign a = (q == 1 || q == 4) ? 1'b1 : 1'b0;
	assign b = (q == 5 || q == 6) ? 1'b1 : 1'b0;
	assign c = (q == 2) ? 1'b1 : 1'b0;
	assign d = (q == 1 || q == 4 || q == 7) ? 1'b1 : 1'b0;
	assign e = (q == 1 || q == 3 || q == 4 || q == 5 || q == 7 || q == 9) ? 1'b1 : 1'b0;
	assign f = (q == 1 || q == 2 || q == 3 || q == 7) ? 1'b1 : 1'b0;
	assign g = (q == 0 || q == 1 || q == 7) ? 1'b1 : 1'b0;

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
