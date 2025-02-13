// Blink

module top(
    input logic     clk, 
    output logic    RGB_R,
    output logic    RGB_G,
    output logic    RGB_B
);

    // CLK frequency is 12MHz, so 6,000,000 cycles is 0.5s
    parameter BLINK_INTERVAL = 2000000;
    logic [20:0] count = 0;
    logic [2:0] stateCurrent = stateRed;

    parameter stateRed = 3'b011; // R ON, G OFF, B OFF
    parameter stateYellow = 3'b001; // R ON, G ON, B OFF
    parameter stateGreen = 3'b101; // R OFF, G ON, B OFF
    parameter stateCyan = 3'b100; // R OFF, G ON, B ON
    parameter stateBlue = 3'b110; // R OFF, G OFF, B ON
    parameter stateMagenta = 3'b010; // R ON, G OFF, B ON
    
    

    always_ff @(posedge clk) begin
        if (count == BLINK_INTERVAL - 1) begin
            case (stateCurrent)
                stateRed: stateCurrent <= stateYellow;
                stateYellow: stateCurrent <= stateGreen;
                stateGreen: stateCurrent <= stateCyan;
                stateCyan: stateCurrent <= stateBlue;
                stateBlue: stateCurrent <= stateMagenta;
                stateMagenta: stateCurrent <= stateRed;
                default: stateCurrent <= stateRed;
            endcase
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

    assign {RGB_R, RGB_G, RGB_B} = stateCurrent;

endmodule
