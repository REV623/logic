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

module reg4bit (q,d,en,reset,clk);
    output [3:0] q;
    input [3:0] d;
    input en,reset,clk;

    reg1bit reg0 (q[0],d[0],en,reset,clk);
    reg1bit reg1 (q[1],d[1],en,reset,clk);
    reg1bit reg2 (q[2],d[2],en,reset,clk);
    reg1bit reg3 (q[3],d[3],en,reset,clk);
endmodule

module reg1bit (q,d,en,reset,clk);
    output q;
    input d,en,reset,clk;
    wire d0,AtoO0,AtoO1,NtoA0;

    or or0 (d0,AtoO0,AtoO1);
    and and1 (AtoO1,d,en);
    and and0 (AtoO0,q,NtoA0);
    not not0 (NtoA0,en);
    D_FF dff (q,d0,reset,clk);
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