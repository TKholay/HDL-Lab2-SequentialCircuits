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


module BCDCounter_tb;  
    reg ENABLE, LOAD, UP, CLR, CLK;
    reg [3:0] D;
    wire CO;
    wire [3:0] Q;
    
    top uut(
        .ENABLE(ENABLE),
        .LOAD(LOAD),
        .UP(UP),
        .CLR(CLR),
        .D(D),
        .CLK(CLK),
        .CO(CO),
        .Q(Q)
    );
    
    always begin
        #5 CLK = ~CLK;
    end
    
    initial begin
        CLK <= 0;
        CLR <= 1;
        
        #2.5;
        
        LOAD <= 1;
        ENABLE <= 1;
        D <= 4'b0110;
        #10;
        
        LOAD <= 0;
        ENABLE <= 1;
        UP <= 1;
        
        #10; //increment once
        
        #10; //increment twice
        
        #10; //increment three times
        
        #10; //increment four times
        
        LOAD <= 0;
        ENABLE <= 1;
        UP <= 0;
        #10; //decrement once
        
        CLR <= 0;
        #10000;
        $finish;
    end
   
endmodule
