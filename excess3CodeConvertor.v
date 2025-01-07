`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2024 01:45:27 PM
// Design Name: 
// Module Name: excess3CodeConvertor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module behavioralExcess3CodeConvertor(X, CLK, S, V);
input X, CLK;
output reg S, V;

reg [2:0] State;
reg [2:0] NextState;

initial
begin
    State <= 0;
    NextState <= 0;
end

always @(State, X)
begin

case(State)

    0 : begin
       if(X == 1'b0) begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 1;
       end
       else begin
           S <= 1'b0;
           V <= 1'b0;
           NextState <= 2;
       end
    end
    
    1 : begin
       if(X == 1'b0) begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 3;
       end
       else begin
           S <= 1'b0;
           V <= 1'b0;
           NextState <= 4;
       end
    end
    
    2 : begin
       if(X == 1'b0) begin
           S <= 1'b0;
           V <= 1'b0;
           NextState <= 4;
       end
       else begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 4;
       end
    end
    
    3 : begin
       if(X == 1'b0) begin
           S <= 1'b0;
           V <= 1'b0;
           NextState <= 5;
       end
       else begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 5;
       end
    end
    
    4 : begin
       if(X == 1'b0) begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 5;
       end
       else begin
           S <= 1'b0;
           V <= 1'b0;
           NextState <= 6;
       end
    end
    
    5 : begin
       if(X == 1'b0) begin
           S <= 1'b0;
           V <= 1'b0;
           NextState <= 0;
       end
       else begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 0;
       end
    end
    
    6 : begin
       if(X == 1'b0) begin
           S <= 1'b1;
           V <= 1'b0;
           NextState <= 0;
       end
       else begin
           S <= 1'b0;
           V <= 1'b1;
           NextState <= 0;
       end
    end
    
    default : begin
        S <= 1'b0;
        V <= 1'b0;
        State <= 0;
        NextState <= 0;
    end
    
endcase

end

always @(posedge CLK)
begin
    State <= NextState;
    $display("%d %d %d %d", State, X, S, V);
    $display("%t", $time);
end
    
endmodule

module dataflowExcess3CodeConvertor(X, CLK, S, V);
input X, CLK;
output S, V;

reg Q1;
reg Q2;
reg Q3;

initial begin
    Q1 <= 0;
    Q2 <= 0;
    Q3 <= 0;
end

always @(posedge CLK)
begin
    Q1 <= (~Q3 & ~X & & Q2)|(Q3 & ~Q1 & Q2)|(Q3 & Q1 & ~Q2);
    Q2 <= (~X & ~Q1 & ~Q2)|(Q3 & X & ~Q1)|(~Q3 & X & Q2);
    Q3 <= (~Q3 & Q2)|(X & ~Q1)|(Q3 & ~Q1 & ~Q2);
    $display("%d %d %d - %d %d", Q1, Q2, Q3, S, V);
end

assign S = (~Q3 & ~X & ~Q1)|(~X & Q2)|(~Q3 & X & Q1)|(Q3 & X & ~Q2);
assign V = (X & Q1 & Q2);

endmodule
