`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 01:55:40 PM
// Design Name: 
// Module Name: BCDCounter
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


module BCDCounter(ENABLE, LOAD, UP, CLR, D, CO, Q, CLK);
input ENABLE, LOAD, UP, CLR, CLK;
input [3:0] D;
output CO;
output reg [3:0] Q;

assign CO = (Q==4'b1001 && ENABLE && UP) || (Q==4'b0000 && ENABLE && ~UP);

always @(posedge CLK, negedge CLR)
begin
    if(CLR == 0)begin
        Q <= 0;
    end
    else begin
        if(LOAD && ENABLE)begin
            Q <= D;
        end
        else if(LOAD == 0)begin
            if(ENABLE && UP)begin
                if(Q == 4'b1001)begin
                    Q <= 0;
                end
                else begin
                    Q = Q + 1;
                end
            end
            else if(ENABLE && ~UP)begin
                if(Q == 4'b0000)begin
                    Q <= 9;
                end
                else begin
                    Q <= Q - 1;
                end
            end
        end
    end
end

endmodule

module DecimalCounter(ENABLE, LOAD, UP, CLR, D1, D2, CO, Q1, Q2, CLK);
input ENABLE, LOAD, UP, CLR, CLK;
input [3:0] D1, D2;
output reg CO;
output [3:0] Q1, Q2;
wire tensCO;
wire tensUp;
wire onesCO;
reg tensEnable;

BCDCounter b1(.ENABLE(ENABLE), .LOAD(LOAD), .UP(UP), .CLR(CLR), .D(D1), .CO(onesCO), .Q(Q1), .CLK(CLK));
BCDCounter b10(.ENABLE(tensEnable), .LOAD(LOAD), .UP(tensUp), .CLR(CLR), .D(D2), .CO(tensCO), .Q(Q2), .CLK(CLK));

assign tensUp = (Q1 == 9);

always @(*)
begin
    if((LOAD == 1) && (ENABLE == 1))begin
        tensEnable <= 1;
    end
    else if(onesCO == 1)begin
        tensEnable <= 1;
    end
    else begin
        tensEnable <= 0;
    end
end

always @(posedge CLK, negedge CLR)
begin
    if(CLR != 1)begin
        if(LOAD != 1)begin
            if(ENABLE == 1)begin
                if(UP == 1)begin
                    if((D1 == 4'b1001)&&(D2 == 4'b1001))begin
                        CO <= 1;
                    end
                    else begin
                        CO <= 0;
                    end
                end
                if(UP == 0)begin
                    if((D1 == 4'b0000)&&(D2 == 4'b0000))begin
                        CO <= 1;
                    end
                    else begin
                        CO <= 0;
                    end
                end
            end
        end
    end
end

endmodule

module top(ENABLE, LOAD, UP, CLR, D, CO, Q, CLK);
input ENABLE, LOAD, UP, CLR, CLK;
input [3:0] D;
output CO;
output [3:0] Q;

wire slowCLK;

divider d1(.clk100Mhz(CLK), .slowClk(slowCLK));    
BCDCounter b1(.ENABLE(ENABLE), .LOAD(LOAD), .UP(UP), .CLR(CLR), .D(D), .CO(CO), .Q(Q), .CLK(slowCLK));

endmodule

module divider(clk100Mhz, slowClk);
  input clk100Mhz; //fast clock
  output reg slowClk; //slow clock

  reg[27:0] counter;

  initial begin
    counter = 0;
    slowClk = 0;
  end

  always @ (posedge clk100Mhz)
  begin
    if(counter == 27'd100000000) begin
      counter <= 1;
      slowClk <= ~slowClk;
    end
    else begin
      counter <= counter + 1;
    end
  end

endmodule
