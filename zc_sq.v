`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2026 06:44:17
// Design Name: 
// Module Name: zc_sq
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


module zc_sq(
    //output reg signed [15:0] zc_real [0:63], //64 16 bit registers
    //output reg signed [15:0] zc_img [0:63]  //requires system verilog
    output reg signed [1023:0] zc_real,
    output reg signed [1023:0] zc_img
    );
    
    parameter ZC_LEN           = 43; //43 values in the ZC LUT
    parameter SUBCARRIER_COUNT = 64; 
    parameter GUARD_COUNT      = 10; //as ZC LUT contains values for only 43 subcarriers, rest including guard count and dc must have 0 value
    parameter DC               = 32; //dc in middle 
    
    integer i;

    ///ZC LUT
    reg signed [15:0] ZC_LUT_real [0:ZC_LEN-1];
    reg signed [15:0] ZC_LUT_img  [0:ZC_LEN-1];
    
    initial
    begin
			ZC_LUT_real[0]  = 16'h7FFF;
			ZC_LUT_real[1]  = 16'h9060;
			ZC_LUT_real[2]  = 16'hFB53;
			ZC_LUT_real[3]  = 16'h8057;
			ZC_LUT_real[4]  = 16'h320F;
			ZC_LUT_real[5]  = 16'hE8C0;
			ZC_LUT_real[6]  = 16'h2060;
			ZC_LUT_real[7]  = 16'hE8C0;
			ZC_LUT_real[8]  = 16'h73E5;
			ZC_LUT_real[9]  = 16'h42AE;
			ZC_LUT_real[10] = 16'h7EA2;
			ZC_LUT_real[11] = 16'hA728;
			ZC_LUT_real[12] = 16'hB585;
			ZC_LUT_real[13] = 16'h6AC0;
			ZC_LUT_real[14] = 16'h7A92;
			ZC_LUT_real[15] = 16'h0DFF;
			ZC_LUT_real[16] = 16'h73E5;
			ZC_LUT_real[17] = 16'h7A92;
			ZC_LUT_real[18] = 16'h9060;
			ZC_LUT_real[19] = 16'h830F;
			ZC_LUT_real[20] = 16'h6AC0;
			ZC_LUT_real[21] = 16'hD6AB;
			ZC_LUT_real[22] = 16'h6AC0;
			ZC_LUT_real[23] = 16'h830F;
			ZC_LUT_real[24] = 16'h9060;
			ZC_LUT_real[25] = 16'h7A92;
			ZC_LUT_real[26] = 16'h73E5;
			ZC_LUT_real[27] = 16'h0DFF;
			ZC_LUT_real[28] = 16'h7A92;
			ZC_LUT_real[29] = 16'h6AC0;
			ZC_LUT_real[30] = 16'hB585;
			ZC_LUT_real[31] = 16'hA728;
			ZC_LUT_real[32] = 16'h7EA2;
			ZC_LUT_real[33] = 16'h42AE;
			ZC_LUT_real[34] = 16'h73E5;
			ZC_LUT_real[35] = 16'hE8C0;
			ZC_LUT_real[36] = 16'h2060;
			ZC_LUT_real[37] = 16'hE8C0;
			ZC_LUT_real[38] = 16'h320F;
			ZC_LUT_real[39] = 16'h8057;
			ZC_LUT_real[40] = 16'hFB53;
			ZC_LUT_real[41] = 16'h9060;
			ZC_LUT_real[42] = 16'h7FFF;
           
            ZC_LUT_img[0]  = 16'h0000;
			ZC_LUT_img[1]  =  16'h3EA5;
			ZC_LUT_img[2]  = 16'h7FEA;
			ZC_LUT_img[3]  = 16'hF6A8;
			ZC_LUT_img[4]  = 16'h75CD;
			ZC_LUT_img[5]  = 16'h7DDE;
			ZC_LUT_img[6]  = 16'h8429;
			ZC_LUT_img[7]  = 16'h8221;
			ZC_LUT_img[8]  = 16'h3654;
			ZC_LUT_img[9]  = 16'h92BD;
			ZC_LUT_img[10] = 16'h12A3;
			ZC_LUT_img[11] = 16'hA3DA;
			ZC_LUT_img[12] = 16'h97E6;
			ZC_LUT_img[13] = 16'h46A0;
			ZC_LUT_img[14] = 16'hDB1F;
			ZC_LUT_img[15] = 16'h7F3B;
			ZC_LUT_img[16] = 16'hC9AB;
			ZC_LUT_img[17] = 16'h24E0;
			ZC_LUT_img[18] = 16'hC15A;
			ZC_LUT_img[19] = 16'hE42B;
			ZC_LUT_img[20] = 16'hB95F;
			ZC_LUT_img[21] = 16'h86DB;
			ZC_LUT_img[22] = 16'hB95F;
			ZC_LUT_img[23] = 16'hE42B;
			ZC_LUT_img[24] = 16'hC15A;
			ZC_LUT_img[25] = 16'h24E0;
			ZC_LUT_img[26] = 16'hC9AB;
			ZC_LUT_img[27] = 16'h7F3B;
			ZC_LUT_img[28] = 16'hDB1F;
			ZC_LUT_img[29] = 16'h46A0;
			ZC_LUT_img[30] = 16'h97E6;
			ZC_LUT_img[31] = 16'hA3DA;
			ZC_LUT_img[32] = 16'h12A3;
			ZC_LUT_img[33] = 16'h92BD;
			ZC_LUT_img[34] = 16'h3654;
			ZC_LUT_img[35] = 16'h8221;
			ZC_LUT_img[36] = 16'h8429;
			ZC_LUT_img[37] = 16'h7DDE;
			ZC_LUT_img[38] = 16'h75CD;
			ZC_LUT_img[39] = 16'hF6A8;
			ZC_LUT_img[40] = 16'h7FEA;
			ZC_LUT_img[41] = 16'h3EA5;
			ZC_LUT_img[42] = 16'h0000;
	end
			
   always @(*)
   begin
   for ( i=0; i< SUBCARRIER_COUNT ;i=i+1 )
        begin 
        if ((i == DC)||(i< GUARD_COUNT)||(i>= SUBCARRIER_COUNT - GUARD_COUNT))
           begin
           zc_real[i*16 +:16] = 16'h0000; //using indexed part select
           zc_img[i*16+:16]= 16'h0000;
           end
        
        else 
           begin
           //index = i - GUARD_COUNT - (i> DC);
           zc_real[i*16+:16]= ZC_LUT_real[i - GUARD_COUNT - (i> DC)];
           zc_img[i*16+:16]= ZC_LUT_img[i - GUARD_COUNT - (i> DC)];
           end
        end    
  end 			            
        
    
    
    
endmodule
