// SV Module to display 5 copies of alienC through the VGA port
// and to implement automated motion for these SPACE INVADERS!
//
// Created by Alexander Maso PSU ECE-Winter 2023
///////////////////////////////////////////////////////////////

module alienC(
    input  wire                clk, rst,
    input  wire    [11:0]      pixel_row, pixel_column, 
	output wire    [3:0]	   alienC_output,
    output wire                alienC1_active,
    output wire                alienC2_active,
    output wire                alienC3_active,
    output wire                alienC4_active,
    output wire                alienC5_active,
    output wire                loserC
    );

// Internals
logic   [11:0]              sprite_row;
logic   [11:0]              sprite_column;
logic   [11:0]              sprite_row_ff;
logic   [11:0]              sprite_column_ff;
logic   [3:0]               alien_pix;
logic   [11:0]              sprite_row_next;
logic   [11:0]              sprite_column_next;
logic                       active1; 
logic                       active2;
logic                       active3; 
logic                       active4;
logic                       active5; 
logic   [23:0]              motion_counter;
logic                       move_left;
logic                       move_left_ff;
logic                       move_left_next;
    
initial begin
    active1 = 1'b0;
    active2 = 1'b0;
    active3 = 1'b0;
    active4 = 1'b0;
    active5 = 1'b0;
    alien_pix = 4'b0000;
    // Initialized AlienA 20 rows from the top of the screen
    // ==> Initializing AlienB 10 rows below AlienA sprite, at row 46
    // ====> Initializing AlienC 10 rows below Alien B sprite, at row 72

    sprite_column_ff = 245;
    sprite_row_ff = 72;
    sprite_column = 245;
    sprite_row = 72;
    motion_counter = 0;
    move_left = 1'b0;
end

always_comb begin

    // AlienC's Sprite is 16 rows by 24 columns of pixels
    // There are 6 pixels between each alien sprite --> Offsets are multiples of 30
    // First sprite --> Offset of 0, Second --> Offset of 30, Third --> Offset of 60 
    active1 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column < pixel_column) && (pixel_column < sprite_column + 25));
    active2 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 55));    
    active3 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 85));
    active4 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 90 < pixel_column) && (pixel_column < sprite_column + 115));
    active5 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 120 < pixel_column) && (pixel_column < sprite_column + 145));
   
   
    // Row one & two of AlienC1's Sprite    
    if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 8 < pixel_column) && (pixel_column < sprite_column + 17))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 2 < pixel_column) && (pixel_column < sprite_column + 23))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column < pixel_column) && (pixel_column < sprite_column + 25))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row + 9) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 7)) || ((sprite_column + 10 < pixel_column) && (pixel_column < sprite_column + 15)) || ((sprite_column + 18 < pixel_column) && (pixel_column < sprite_column + 25))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column < pixel_column) && (pixel_column < sprite_column + 25))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row + 13) && (((sprite_column + 6 < pixel_column) && (pixel_column < sprite_column + 11)) || ((sprite_column + 14 < pixel_column) && (pixel_column < sprite_column + 19))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row + 15) && (((sprite_column + 4 < pixel_column) && (pixel_column < sprite_column + 9)) || ((sprite_column + 10 < pixel_column) && (pixel_column < sprite_column + 15)) || ((sprite_column + 16 < pixel_column) && (pixel_column < sprite_column + 21))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row + 17) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 5)) || ((sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 25))))
        begin
            alien_pix = 4'b1111;
        end
 
    
    // Row one & two of AlienC2's Sprite    
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 38 < pixel_column) && (pixel_column < sprite_column + 47))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 32 < pixel_column) && (pixel_column < sprite_column + 53))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 55))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row + 9) && (((sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 37)) || ((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 45)) || ((sprite_column + 48 < pixel_column) && (pixel_column < sprite_column + 55))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 55))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row + 13) && (((sprite_column + 36 < pixel_column) && (pixel_column < sprite_column + 41)) || ((sprite_column + 44 < pixel_column) && (pixel_column < sprite_column + 49))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row + 15) && (((sprite_column + 34 < pixel_column) && (pixel_column < sprite_column + 39)) || ((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 45)) || ((sprite_column + 46 < pixel_column) && (pixel_column < sprite_column + 51))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row + 17) && (((sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 35)) || ((sprite_column + 50 < pixel_column) && (pixel_column < sprite_column + 55))))
        begin
            alien_pix = 4'b1111;
        end
 

    // Row one & two of AlienC3's Sprite    
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 68 < pixel_column) && (pixel_column < sprite_column + 77))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 62 < pixel_column) && (pixel_column < sprite_column + 83))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 85))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row + 9) && (((sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 67)) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 75)) || ((sprite_column + 78 < pixel_column) && (pixel_column < sprite_column + 85))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 85))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row + 13) && (((sprite_column + 66 < pixel_column) && (pixel_column < sprite_column + 71)) || ((sprite_column + 74 < pixel_column) && (pixel_column < sprite_column + 79))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row + 15) && (((sprite_column + 64 < pixel_column) && (pixel_column < sprite_column + 69)) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 75)) || ((sprite_column + 76 < pixel_column) && (pixel_column < sprite_column + 81))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row + 17) && (((sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 65)) || ((sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 85))))
        begin
            alien_pix = 4'b1111;
        end


    // Row one & two of AlienC4's Sprite    
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 98 < pixel_column) && (pixel_column < sprite_column + 107))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 92 < pixel_column) && (pixel_column < sprite_column + 113))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 90 < pixel_column) && (pixel_column < sprite_column + 115))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row + 9) && (((sprite_column + 90 < pixel_column) && (pixel_column < sprite_column + 97)) || ((sprite_column + 100 < pixel_column) && (pixel_column < sprite_column + 105)) || ((sprite_column + 108 < pixel_column) && (pixel_column < sprite_column + 115))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 90 < pixel_column) && (pixel_column < sprite_column + 115))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row + 13) && (((sprite_column + 96 < pixel_column) && (pixel_column < sprite_column + 101)) || ((sprite_column + 104 < pixel_column) && (pixel_column < sprite_column + 109))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row + 15) && (((sprite_column + 94 < pixel_column) && (pixel_column < sprite_column + 99)) || ((sprite_column + 100 < pixel_column) && (pixel_column < sprite_column + 105)) || ((sprite_column + 106 < pixel_column) && (pixel_column < sprite_column + 111))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row + 17) && (((sprite_column + 90 < pixel_column) && (pixel_column < sprite_column + 95)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 115))))
        begin
            alien_pix = 4'b1111;
        end


    // Row one & two of AlienC5's Sprite    
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 128 < pixel_column) && (pixel_column < sprite_column + 137))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 122 < pixel_column) && (pixel_column < sprite_column + 143))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 120 < pixel_column) && (pixel_column < sprite_column + 145))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row + 9) && (((sprite_column + 120 < pixel_column) && (pixel_column < sprite_column + 127)) || ((sprite_column + 130 < pixel_column) && (pixel_column < sprite_column + 135)) || ((sprite_column + 138 < pixel_column) && (pixel_column < sprite_column + 145))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 120 < pixel_column) && (pixel_column < sprite_column + 145))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row + 13) && (((sprite_column + 126 < pixel_column) && (pixel_column < sprite_column + 131)) || ((sprite_column + 134 < pixel_column) && (pixel_column < sprite_column + 139))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row + 15) && (((sprite_column + 124 < pixel_column) && (pixel_column < sprite_column + 129)) || ((sprite_column + 130 < pixel_column) && (pixel_column < sprite_column + 135)) || ((sprite_column + 136 < pixel_column) && (pixel_column < sprite_column + 141))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row + 17) && (((sprite_column + 120 < pixel_column) && (pixel_column < sprite_column + 125)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 145))))
        begin
            alien_pix = 4'b1111;
        end
    else
        begin  
            alien_pix = 4'b0000;
        end
end

// Additional combinational block for FSM used in implemention of motion for Alien2
always_comb begin

// Every 16 M clocks (31.5 MHz clk -> ~0.5 sec) move alien left or right by 12 pixels.
// Sprite moves down 24 rows of pixels and changes direction at edge of display 
// Block of three alienC sprite's is 16 x 56 pixels (essentially 16 x 60)
// Each individual alien is 16 x 16 pix with 4 pix of spacing between aliens
    if (move_left) begin
        if (sprite_column < 21) 
            begin
                sprite_row_next = (sprite_row_ff + 24);
                sprite_column_next = sprite_column_ff;
                move_left_next = 1'b0;
            end
        else
            begin
                sprite_row_next = sprite_row_ff;
                sprite_column_next = (sprite_column_ff - 12);
                move_left_next = 1'b1; 
            end      
    end
    else begin
        if (sprite_column > 500) 
            begin
                sprite_row_next = (sprite_row_ff + 24);
                sprite_column_next = sprite_column_ff;
                move_left_next = 1'b1;
            end
        else
            begin
                sprite_row_next = sprite_row_ff;
                sprite_column_next = (sprite_column_ff + 12);
                move_left_next = 1'b0; 
            end  
    end
    
end

always_ff @ (posedge clk) begin
    if (motion_counter < 16000000) 
        begin
            sprite_row_ff <= sprite_row_ff;
            sprite_column_ff <= sprite_column_ff;
            motion_counter <= (motion_counter + 1);
            move_left_ff <= move_left_ff;
        end
   else 
        begin
            sprite_row_ff <= sprite_row_next;
            sprite_column_ff <= sprite_column_next;
            motion_counter <= 0;
            move_left_ff <= move_left_next;
        end

end

assign loserC = (sprite_row > 400) ? 1'b1 : 1'b0;
assign move_left = move_left_ff;
assign sprite_row = sprite_row_ff;
assign sprite_column = sprite_column_ff;
assign alienC_output = alien_pix;
assign alienC1_active = active1; 
assign alienC2_active = active2; 
assign alienC3_active = active3; 
assign alienC4_active = active4; 
assign alienC5_active = active5; 


endmodule
