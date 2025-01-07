`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2024 02:01:31 PM
// Design Name: 
// Module Name: e3cc_tb
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


module e3cc_tb;
    reg X;
    reg CLK;
    wire S;
    wire V;
    
    dataflowExcess3CodeConvertor uut(
        .X(X),
        .CLK(CLK),
        .S(S),
        .V(V)
    );
    
    always begin
        #5 CLK = ~CLK;
    end
    
    initial begin
        CLK = 0;
        
        X = 1;
        #7.5;
        X = 0;
        #10; 
        X = 1;
        #10; 
        X = 1;
        #10; 
        
        X = 0;
        #10; 
        X = 0;
        #10; 
        X = 1;
        #10;
        X = 1;
        #10; 
        
        X = 1;
        #10; 
        X = 1;
        #10; 
        X = 0;
        #10; 
        X = 1;
        #10;

        $finish;
    end
   
endmodule
