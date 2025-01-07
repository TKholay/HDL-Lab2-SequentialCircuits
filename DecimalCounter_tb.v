`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 01:56:15 PM
// Design Name: 
// Module Name: BCDCounter_tb
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


module DecimalCounter_tb;
    reg ENABLE, LOAD, UP, CLR, CLK;
    reg [3:0] D1, D2;
    wire CO;
    wire [3:0] Q1, Q2;
    
    DecimalCounter uut(
        .ENABLE(ENABLE),
        .LOAD(LOAD),
        .UP(UP),
        .CLR(CLR),
        .D1(D1),
        .D2(D2),
        .CLK(CLK),
        .CO(CO),
        .Q1(Q1),
        .Q2(Q2)
    );
    
    always begin
        #5 CLK = ~CLK;
    end
    
    initial begin
        CLK <= 0;
        CLR <= 0;
        #30;
        
        CLR <= 1;
        #2.5;
        
        LOAD <= 1;
        ENABLE <= 1;
        D1 <= 4'd7;
        D2 <= 4'd9;
        #10;
        
        LOAD <= 0;
        ENABLE <= 1;
        UP <= 1;
        
        #10; //increment once
        #10; //increment twice
        #10; //increment three times
        #10; //increment four times
        #10; //increment five times
        
        ENABLE <= 0;
        
        #10; //wait two clock cycles
        #10;
        
        ENABLE <= 1;
        UP <= 0;
        
        #10; //decrement counter four times
        #10;
        #10;
        #10;
        
        CLR <= 0;
        #10;
        $finish;
    end
   
endmodule
