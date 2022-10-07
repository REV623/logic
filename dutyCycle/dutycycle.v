module dutycycle25 (newclk, clk);
    output newclk;
    input clk;
    reg newclk;

    initial newclk = 1'b0;

    always
        begin
            #75 newclk <= ~newclk;
            #25 newclk <= ~newclk;
        end

endmodule