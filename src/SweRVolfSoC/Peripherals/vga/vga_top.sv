module vga_top(
    input wire            vga_clk_i,
    input wire            vga_rst_i,
    output wire   [3:0]   vga_r,
	output wire   [3:0]   vga_g,
	output wire   [3:0]   vga_b,
	output wire		      vga_hs,
	output wire			  vga_vs,
	input  wire   [11:0]  btn_col,
	input  wire   [7:0]   btn_missle_en
    );
    

// Internals for Alien Model A Sprites
logic               alienA1_active;
logic               alienA2_active;
logic               alienA3_active;
logic               alienA4_active;
logic               alienA5_active;
logic   [3:0]       alienA_output;

logic               alienA1_deactivate;
logic               alienA2_deactivate;
logic               alienA3_deactivate;
logic               alienA4_deactivate;
logic               alienA5_deactivate;
logic               loserA;

// Internals for Alien Model B Sprites
logic               alienB1_active;
logic               alienB2_active;
logic               alienB3_active;
logic               alienB4_active;
logic               alienB5_active;
logic   [3:0]       alienB_output;

logic               alienB1_deactivate;
logic               alienB2_deactivate;
logic               alienB3_deactivate;
logic               alienB4_deactivate;
logic               alienB5_deactivate;
logic               loserB;

// Internals for Alien Model C Sprites
logic               alienC1_active;
logic               alienC2_active;
logic               alienC3_active;
logic               alienC4_active;
logic               alienC5_active;
logic   [3:0]       alienC_output;

logic               alienC1_deactivate;
logic               alienC2_deactivate;
logic               alienC3_deactivate;
logic               alienC4_deactivate;
logic               alienC5_deactivate;
logic               loserC;

// Internals for barriers
logic               barrier1_active;
logic               barrier2_active;
logic               barrier3_active;
logic               barrier4_active;
logic   [3:0]       barrier_output;

// Internals for player and missle sprites
logic               player_active;
logic   [3:0]       player_output;

logic   [7:0]       missle_en_xor;
logic               missle1_active;
logic               missle2_active;
logic               missle3_active;
logic               missle4_active;
logic               missle5_active;
logic               missle6_active;
logic               missle7_active;
logic               missle8_active;
logic   [3:0]       missle_output;

// Internals for VGA and ROM/RAM image
reg  [3:0]      vga_r_reg;
reg  [3:0]      vga_g_reg; 
reg  [3:0]      vga_b_reg;
wire [31:0]     pix_num;
wire [3:0]      doutb;
logic           video_on;
logic [3:0]     vga_output;

// Internals for Sprites
logic [11:0]        pixel_row;
logic [11:0]        pixel_column;

// Internals for Win Or Lose Screen
logic               winner;
logic [3:0]         winner_output;
logic               loser;
logic [3:0]         loser_output;

initial begin
video_on = 0;
vga_output = 0;

player_active = 0;
missle1_active = 0;
missle2_active = 0;
missle3_active = 0;
missle4_active = 0;
missle5_active = 0;
missle6_active = 0;
missle7_active = 0;
missle8_active = 0;

barrier1_active = 0;
barrier2_active = 0;
barrier3_active = 0;
barrier4_active = 0;

alienA1_active = 0;
alienA2_active = 0;
alienA3_active = 0;
alienA4_active = 0;
alienA5_active = 0;
alienA1_deactivate = 1'b1;
alienA2_deactivate = 1'b1;
alienA3_deactivate = 1'b1;
alienA4_deactivate = 1'b1;
alienA5_deactivate = 1'b1;

alienB1_active = 0;
alienB2_active = 0;
alienB3_active = 0;
alienB4_active = 0;
alienB5_active = 0;
alienB1_deactivate = 1'b1;
alienB2_deactivate = 1'b1;
alienB3_deactivate = 1'b1;
alienB4_deactivate = 1'b1;
alienB5_deactivate = 1'b1;

alienC1_active = 0;
alienC2_active = 0;
alienC3_active = 0;
alienC4_active = 0;
alienC5_active = 0;
alienC1_deactivate = 1'b1;
alienC2_deactivate = 1'b1;
alienC3_deactivate = 1'b1;
alienC4_deactivate = 1'b1;
alienC5_deactivate = 1'b1;

winner = 1'b0;
loser = 1'b0;
winner_output = 4'b0000;
loser_output = 4'b0000;
end

dtg dtg(
	.clock    	   (vga_clk_i),
	.rst	  	   (vga_rst_i),
	.video_on 	   (video_on),
	.horiz_sync	   (vga_hs),
	.vert_sync	   (vga_vs),
	.pixel_row     (pixel_row),
	.pixel_column  (pixel_column),
	.pix_num	   (pix_num)
);
	
image_ram img_ram(
  .clka            (vga_clk_i),     // input wire clka
  .wea             (1'b0),          // input wire [0 : 0] wea
  .addra           (1'b0),          // input wire [18 : 0] addra
  .dina            (1'b0),          // input wire [3 : 0] dina
  .clkb            (vga_clk_i),     // input wire clkb
  .addrb           (pix_num),       // input wire [18 : 0] addrb
  .doutb           (doutb)          // output wire [3 : 0] doutb
);

alienA battalion(
	.clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
	.alienA_output     (alienA_output),
	.alienA1_active    (alienA1_active),
	.alienA2_active    (alienA2_active),
	.alienA3_active    (alienA3_active),
	.alienA4_active    (alienA4_active),
	.alienA5_active    (alienA5_active),
	.loserA            (loserA)	
);

alienB horde(
	.clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
	.alienB_output     (alienB_output),
	.alienB1_active    (alienB1_active),
	.alienB2_active    (alienB2_active),
	.alienB3_active    (alienB3_active),
	.alienB4_active    (alienB4_active),
	.alienB5_active    (alienB5_active),
	.loserB            (loserB)	
);

alienC gang(
	.clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
	.alienC_output     (alienC_output),
	.alienC1_active    (alienC1_active),
	.alienC2_active    (alienC2_active),
	.alienC3_active    (alienC3_active),
	.alienC4_active    (alienC4_active),
	.alienC5_active    (alienC5_active),
	.loserC            (loserC)	
);

player eightmiss(
	.clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
	.btn_col           (btn_col),
	.btn_missle_en     (btn_missle_en),
	.missle1_active    (missle1_active),
	.missle2_active    (missle2_active),
    .missle3_active    (missle3_active),
    .missle4_active    (missle4_active),
	.missle5_active    (missle5_active),
    .missle6_active    (missle6_active),
    .missle7_active    (missle7_active),
	.missle8_active    (missle8_active),
	.player_active     (player_active),
	.missle_output     (missle_output),
	.player_output     (player_output)
);		


barriers defense(
	.clk    	        (vga_clk_i),
	.rst	  	        (vga_rst_i),
    .pixel_row          (pixel_row),
	.pixel_column       (pixel_column),
	.barrier_output     (barrier_output),
	.barrier1_active    (barrier1_active),
	.barrier2_active    (barrier2_active),
	.barrier3_active    (barrier3_active),
	.barrier4_active    (barrier4_active)	
);

winner win(
    .clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
    .winner            (winner),
    .winner_output	   (winner_output)
    );

loser lose(
    .clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
    .loser             (loser),
    .loser_output	   (loser_output)
    );

always_comb begin

    // Combinational logic to check for missle strikes and update accordingly
    if (alienA1_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienA1_deactivate = 0;
        end
    else if (alienA2_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienA2_deactivate = 0;
        end
    else if (alienA3_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienA3_deactivate = 0;
        end
    else if (alienA4_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienA4_deactivate = 0;
        end
    else if (alienA5_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienA5_deactivate = 0;
        end
    else if (alienB1_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienB1_deactivate = 0;
        end
    else if (alienB2_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienB2_deactivate = 0;
        end
    else if (alienB3_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienB3_deactivate = 0;
        end
    else if (alienB4_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienB4_deactivate = 0;
        end
    else if (alienB5_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienB5_deactivate = 0;
        end
    else if (alienC1_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienC1_deactivate = 0;
        end
    else if (alienC2_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienC2_deactivate = 0;
        end
    else if (alienC3_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienC3_deactivate = 0;
        end
    else if (alienC4_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienC4_deactivate = 0;
        end
    else if (alienC5_active && (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active || missle6_active || missle7_active || missle8_active))
        begin
            alienC5_deactivate = 0;
        end
 
    
     
     // Are all the aliens dead?
     if (!(alienA1_deactivate || alienA2_deactivate || alienA3_deactivate || alienA4_deactivate || alienA5_deactivate || alienB1_deactivate || alienB2_deactivate || alienB3_deactivate || alienB4_deactivate || alienB5_deactivate || alienC1_deactivate || alienC2_deactivate || alienC3_deactivate || alienC4_deactivate || alienC5_deactivate) && (!loser))
        begin
            winner = 1'b1;
            vga_output = winner_output;   
        end
    // If the alien's have reached the bottom and landed..... Player LOSES!
    else if (loserA || loserB || loserB)
        begin
            loser = 1'b1;
            vga_output = loser_output;   
        end
    // Check active signals and output appropriate data 
    else if ((alienA1_active && alienA1_deactivate) || (alienA2_active && alienA2_deactivate) || (alienA3_active && alienA3_deactivate) || (alienA4_active && alienA4_deactivate) || (alienA5_active && alienA5_deactivate)) 
        begin
            vga_output = alienA_output;
        end
    else if ((alienB1_active && alienB1_deactivate) || (alienB2_active && alienB2_deactivate) || (alienB3_active && alienB3_deactivate) || (alienB4_active && alienB4_deactivate) || (alienB5_active && alienB5_deactivate)) 
        begin
            vga_output = alienB_output;
        end
    else if ((alienC1_active && alienC1_deactivate) || (alienC2_active && alienC2_deactivate) || (alienC3_active && alienC3_deactivate) || (alienC4_active && alienC4_deactivate) || (alienC5_active && alienC5_deactivate)) 
        begin
            vga_output = alienC_output;
        end
    else if (player_active)
        begin
            vga_output = player_output;
        end
    else if (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active|| missle6_active || missle7_active || missle8_active)
        begin
            vga_output = missle_output;
        end
    else if (barrier1_active || barrier2_active || barrier3_active || barrier4_active) 
        begin
            vga_output = barrier_output;
        end
    else 
        begin
            vga_output = doutb;
        end
end


always_ff @ (posedge vga_clk_i)
begin
    if (video_on)
        begin
        vga_r_reg <= vga_output;
        vga_g_reg <= vga_output;
        vga_b_reg <= vga_output;
        end
    else   
        begin 
        vga_r_reg <= 4'b0000;
        vga_g_reg <= 4'b0000;
        vga_b_reg <= 4'b0000;
        end        
end        




assign vga_r = vga_r_reg;
assign vga_g = vga_g_reg;
assign vga_b = vga_b_reg;


endmodule
