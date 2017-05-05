# BASYS 3 Board - Pong Game

[![](https://img.youtube.com/vi/r8tnSQvCtVk/0.jpg)](https://youtu.be/r8tnSQvCtVk)

Our project is a two-player pong game created on BASYS-3 using the VGA output of the BASYS3. 
Project is coded in System Verilog and VHDL using VIVADO IDE. 

Top player controls are the up and down button on the boad and bottom player uses the left and right buttons and middle button is used to start the round. 

Current Scores are displayed on the seven segment display of the Basys board.

![](http://i.imgur.com/ewoNgx4.jpg)

References: 
* The clk_wiz_0 block is provided by Xilinx. Instead of using a clock counter to be more precise we used Vivado’s own clk API clk_wiz_0. https://www.xilinx.com/products/intellectual-property/clocking_wizard.html
* Sync_mod block is translated from another source, originally it was VHDL, it has translated into System Verilog. Original source code is from Jan Bukowski of http://mikrokontroler.pl/
