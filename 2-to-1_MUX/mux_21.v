 //-----------------------------------------------------
 // Design Name : 2-to-1 mux
 // File Name   : mux_21.v
 // Function    : 2:1 Mux using Logic Gates
 // Coder       : Paskorn Champrasert
 // Date 		: July 23, 2012
 //-----------------------------------------------------
 module  mux_2to1(
 mux_out    , // Mux output
 din_0      , // Mux first input
 din_1      , // Mux Second input
 sel         // Select input
 );
 //-----------Input Ports---------------
 input din_0, din_1, sel ;
 //-----------Output Ports---------------
 output mux_out;
 //------------Internal Variables--------
 wire  w_not1, w_and1, w_and2;
 
 //-------------Code Start-----------------
 not not1(w_not1,sel);
 and and1(w_and1,w_not1,din_0);
 and and2(w_and2,sel,din_1);
 or or1(mux_out,w_and1,w_and2);
 
 endmodule //End Of Module mux
 
 