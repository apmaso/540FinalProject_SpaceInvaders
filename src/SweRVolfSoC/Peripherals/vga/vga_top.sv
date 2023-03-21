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


// Internals for Sprite
logic [11:0]        pixel_row;
logic [11:0]        pixel_column;


initial begin
video_on = 0;
vga_output = 0;
alienA1_active = 0;
alienA2_active = 0;
alienA3_active = 0;
alienA4_active = 0;
alienA5_active = 0;
player_active = 0;
missle1_active = 0;
missle2_active = 0;
missle3_active = 0;
missle4_active = 0;
missle5_active = 0;
missle6_active = 0;
missle7_active = 0;
missle8_active = 0;

alienA1_deactivate = 1'b1;
alienA2_deactivate = 1'b1;
alienA3_deactivate = 1'b1;
alienA4_deactivate = 1'b1;
alienA5_deactivate = 1'b1;
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

alienA five(
	.clk    	       (vga_clk_i),
	.rst	  	       (vga_rst_i),
    .pixel_row         (pixel_row),
	.pixel_column      (pixel_column),
	.alienA_output     (alienA_output),
	.alienA1_active    (alienA1_active),
	.alienA2_active    (alienA2_active),
	.alienA3_active    (alienA3_active),
	.alienA4_active    (alienA4_active),
	.alienA5_active    (alienA5_active)	
);

player allmiss(
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
 
    // Check active signals and output appropriate data
    if ((alienA1_active && alienA1_deactivate) || (alienA2_active && alienA2_deactivate) || (alienA3_active && alienA3_deactivate) || (alienA4_active && alienA4_deactivate) || (alienA5_active && alienA5_deactivate)) 
        begin
            vga_output = alienA_output;
        end
    else if (missle1_active || missle2_active || missle3_active || missle4_active || missle5_active|| missle6_active || missle7_active || missle8_active)
        begin
            vga_output = missle_output;
        end
    else if (player_active)
        begin
            vga_output = player_output;
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
