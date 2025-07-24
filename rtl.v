module adi_tala_generator (
    input wire clk,
    input wire [1:0] speed_sel,
    output reg [1:0] led
);

reg [3:0] counter = 0;
reg [2:0] beat = 0;
reg [9:0] cycle_count = 0;

wire [3:0] speed_count;
assign speed_count = (speed_sel == 2'b01) ? 6 :
                     (speed_sel == 2'b10) ? 4 :
                     10;

wire [2:0] next_beat;
assign next_beat = (beat == 7) ? 0 : beat + 1;

always @(*) begin
    if (beat == 7) begin
        led = 2'b00;
    end else begin
        if (counter < (speed_count / 2)) begin
            if (beat <= 3)
                led = 2'b01;
            else
                led = 2'b10;
        end else begin
            led = 2'b00;
        end
    end
end

always @(posedge clk) begin
    if (counter < speed_count - 1) begin
        counter <= counter + 1;
    end else begin
        counter <= 0;
        beat <= next_beat;
        if (beat == 7) begin
            cycle_count <= cycle_count + 1;
        end
    end
end

endmodule
