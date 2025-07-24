`timescale 1ps/1ps
module testbench;
    reg clk;
    reg [1:0] speed_sel;
    wire [1:0] led;

    adi_tala_generator uut (
        .clk(clk),
        .speed_sel(speed_sel),
        .led(led)
    );

    
    always #0.5 clk = ~clk;

    initial begin
        clk = 0;
        speed_sel = 2'b00; 
        #400;              
        $finish;
      $monitor("%b", led);
    end

    initial begin
        $dumpfile("adi_tala.vcd");
        $dumpvars(0, testbench);
    end
endmodule
