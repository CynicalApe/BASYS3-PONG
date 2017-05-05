`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// // Engineer: Oguz Kaan Agac & Bora Ecer
// 
// Create Date: 14/12/2016
// Design Name: Controller
// Module Name: main_control
// Project Name: BASPONG
// Target Devices: BASYS3
// Description: 
// Controller for the BASPONG
// Dependencies: 
// clk_wiz
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_control(
    input logic clk,
    input logic start,   
    input logic reset,
    input logic bottom_button_l,
    input logic bottom_button_r,
    input logic top_button_l,
    input logic top_button_r,
    input logic start_ball,
    output logic[2:0] rgb, 
    output logic horizontal_sync,
    output logic vertical_sync,
    output a, b, c, d, e, f, g, dp,
                     output [3:0] an  ); 

reg score_checker1;
reg score_checker2;
reg [3:0] player1_score;
reg [3:0] player2_score;

initial 
                        begin : process_0
                        player1_score = 'b0000;   
                        player2_score = 'b0000;
                        score_checker1 = 0;
                        score_checker2 = 0;
                        end

//signal x,y:std_logic_vector(9 downto 0);
reg[9:0] x_control;
reg[9:0] y_control;

//signal video:std_logic;
reg video_on;

//signal clk_50 :std_logic;
reg clk_50;


//Vivado CLK wizzard to create 50MHz clock 
clk_wiz_0(clk_50, reset, clk);

//Module to create animations
anim_gen(clk_50, reset, x_control,start_ball, bottom_button_l, bottom_button_r,top_button_l,top_button_r, y_control, video_on, rgb, score_checker1, score_checker2);

//vga synchronization module to update changing pixels and refresh the display
sync_mod(clk_50, reset, start, y_control, x_control, horizontal_sync, vertical_sync, video_on);

//if score checker1 is enabled that means player 1(topbar) scored, so update  his score
always_ff @(posedge clk_50, posedge reset)
begin
    if (player1_score == 9 || reset == 1)
        player1_score <= 0;
    else if (score_checker1 == 1)
        player1_score++;
end

//if score checker2 is enabled that means player2 (bottom bar) scored, so update his score
always_ff @(posedge clk_50, posedge reset)
begin
    if (player2_score == 9 || reset == 1)
        player2_score <= 0;
    else if (score_checker2 == 1)
        player2_score++;
end

//Module to display the scores on the 7seg display of basys3
SevenSegment(clk_50,player1_score,'b0000,'b0000,player2_score,a, b, c, d, e, f, g, dp,an);

endmodule
