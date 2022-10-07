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
