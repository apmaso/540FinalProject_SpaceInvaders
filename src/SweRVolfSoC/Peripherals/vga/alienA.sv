// SV Module to display one copy of alien_A through the VGA port
// Module includes two 12 bit registers to store row and column
// addresses.  Future improvements will utilize the registers
// to implement automated motion for the SPACE INVADERS!
//
// Created by Alexander Maso PSU ECE-Winter 2023
//
// Alien2 does not move on its own yet.  Will in future 
// implementation
//
///////////////////////////////////////////////////////////////

module alienA(
    input  wire                clk, rst,
    input  wire    [11:0]      pixel_row, pixel_column,  
    output wire                loserA,
	output wire    [3:0]	   alienA_output,
    output wire                alienA1_active,
    output wire                alienA2_active,
    output wire                alienA3_active,
    output wire                alienA4_active,
    output wire                alienA5_active
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

logic                       loser_reg;
logic                       winner_reg;
    
initial begin
    active1 = 1'b0;
    active2 = 1'b0;
    active3 = 1'b0;
    active4 = 1'b0;
    active5 = 1'b0;
    alien_pix = 4'b0000;
    // Initializing Alien2 20 rows from the top of the screen. Rows 21 <-> 36
    // and close to centered as possible. Columns: 313 <-> 328
    sprite_column_ff = 312;
    sprite_row_ff = 20;
    sprite_column = 312;
    sprite_row = 20;
    motion_counter = 0;
    move_left = 1'b0;
    loser_reg = 1'b0;
end

always_comb begin
    // AlienA Sprite's are 16 rows by 16 columns of pixels 
    // There are 4 pixels between each alien sprite --> Offsets are multiples of 20 
    // First sprite --> Offset of 0
    active1 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column < pixel_column) && (pixel_column < sprite_column + 17));
    // Second sprite --> Offset of 20
    active2 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 37));    
    // Third sprite --> Offset of 40
    active3 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 57));
    // Third sprite --> Offset of 40
    active4 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 77));
    // Third sprite --> Offset of 40
    active5 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 97));
   
    if (sprite_row > 460)
        begin
            loser_reg = 1;
        end
    else
        begin
            loser_reg = 0;
        end
            
    // Row one & two of AlienA1's Sprite    
    if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 6 < pixel_column) && (pixel_column < sprite_column + 11))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 4 < pixel_column) && (pixel_column < sprite_column + 13))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 2 < pixel_column) && (pixel_column < sprite_column + 15))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row + 9) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 5)) || ((sprite_column + 6 < pixel_column) && (pixel_column < sprite_column + 11)) || ((sprite_column + 12 < pixel_column) && (pixel_column < sprite_column + 17))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column < pixel_column) && (pixel_column < sprite_column + 17))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 5 == pixel_column) || (sprite_column + 6 == pixel_column) || (pixel_column == sprite_column + 11) || (pixel_column == sprite_column + 12)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 3 == pixel_column) || (sprite_column + 4 == pixel_column) || ((sprite_column + 6 < pixel_column) && (pixel_column < sprite_column + 11)) || (pixel_column == sprite_column + 13) || (pixel_column == sprite_column + 14)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 1 == pixel_column) || (sprite_column + 2 == pixel_column) || (sprite_column + 5 == pixel_column) || (pixel_column == sprite_column + 6) || (pixel_column == sprite_column + 11) || (pixel_column == sprite_column + 12) || (pixel_column == sprite_column + 15) || (pixel_column == sprite_column + 16)))
        begin
            alien_pix = 4'b1111;
        end 
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 26 < pixel_column) && (pixel_column < sprite_column + 31))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 24 < pixel_column) && (pixel_column < sprite_column + 33))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 22 < pixel_column) && (pixel_column < sprite_column + 35))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  +  9) && (((sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 25)) || ((sprite_column + 26 < pixel_column) && (pixel_column < sprite_column + 31)) || ((sprite_column + 32 < pixel_column) && (pixel_column < sprite_column + 37))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 37))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 25 == pixel_column) || (sprite_column + 26 == pixel_column) || (pixel_column == sprite_column + 31) || (pixel_column == sprite_column + 32)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 23 == pixel_column) || (sprite_column + 24 == pixel_column) || ((sprite_column + 26 < pixel_column) && (pixel_column < sprite_column + 31)) || (pixel_column == sprite_column + 33) || (pixel_column == sprite_column + 34)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 21 == pixel_column) || (sprite_column + 22 == pixel_column) || (sprite_column + 25 == pixel_column) || (pixel_column == sprite_column + 26) || (pixel_column == sprite_column + 31) || (pixel_column == sprite_column + 32) || (pixel_column == sprite_column + 35) || (pixel_column == sprite_column + 36)))
        begin
            alien_pix = 4'b1111;
        end        
    // Sprite data for AlienA3....  I can make this logic much simpler, if needed
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 46 < pixel_column) && (pixel_column < sprite_column + 51))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 44 < pixel_column) && (pixel_column < sprite_column + 53))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 42 < pixel_column) && (pixel_column < sprite_column + 55))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  +  9) && (((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 45)) || ((sprite_column + 46 < pixel_column) && (pixel_column < sprite_column + 51)) || ((sprite_column + 52 < pixel_column) && (pixel_column < sprite_column + 57))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 57))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 45 == pixel_column) || (sprite_column + 46 == pixel_column) || (pixel_column == sprite_column + 51) || (pixel_column == sprite_column + 52)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 43 == pixel_column) || (sprite_column + 44 == pixel_column) || ((sprite_column + 46 < pixel_column) && (pixel_column < sprite_column + 51)) || (pixel_column == sprite_column + 53) || (pixel_column == sprite_column + 54)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 41 == pixel_column) || (sprite_column + 42 == pixel_column) || (sprite_column + 45 == pixel_column) || (pixel_column == sprite_column + 46) || (pixel_column == sprite_column + 51) || (pixel_column == sprite_column + 52) || (pixel_column == sprite_column + 55) || (pixel_column == sprite_column + 56)))
        begin
            alien_pix = 4'b1111;
        end 
    // Sprite data for AlienA4....  I can make this logic much simpler, if needed
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 66 < pixel_column) && (pixel_column < sprite_column + 71))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 64 < pixel_column) && (pixel_column < sprite_column + 73))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 62 < pixel_column) && (pixel_column < sprite_column + 75))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  +  9) && (((sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 65)) || ((sprite_column + 66 < pixel_column) && (pixel_column < sprite_column + 71)) || ((sprite_column + 72 < pixel_column) && (pixel_column < sprite_column + 77))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 77))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 65 == pixel_column) || (sprite_column + 66 == pixel_column) || (pixel_column == sprite_column + 71) || (pixel_column == sprite_column + 72)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 63 == pixel_column) || (sprite_column + 64 == pixel_column) || ((sprite_column + 66 < pixel_column) && (pixel_column < sprite_column + 71)) || (pixel_column == sprite_column + 73) || (pixel_column == sprite_column + 74)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 61 == pixel_column) || (sprite_column + 62 == pixel_column) || (sprite_column + 65 == pixel_column) || (pixel_column == sprite_column + 66) || (pixel_column == sprite_column + 71) || (pixel_column == sprite_column + 72) || (pixel_column == sprite_column + 75) || (pixel_column == sprite_column + 76)))
        begin
            alien_pix = 4'b1111;
        end        


    // Sprite data for AlienA5....  I can make this logic much simpler, if needed
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 86 < pixel_column) && (pixel_column < sprite_column + 91))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 84 < pixel_column) && (pixel_column < sprite_column + 93))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 82 < pixel_column) && (pixel_column < sprite_column + 95))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  + 9) && (((sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 85)) || ((sprite_column + 86 < pixel_column) && (pixel_column < sprite_column + 91)) || ((sprite_column + 92 < pixel_column) && (pixel_column < sprite_column + 97))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 97))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 85 == pixel_column) || (sprite_column + 86 == pixel_column) || (pixel_column == sprite_column + 91) || (pixel_column == sprite_column + 92)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 83 == pixel_column) || (sprite_column + 84 == pixel_column) || ((sprite_column + 86 < pixel_column) && (pixel_column < sprite_column + 91)) || (pixel_column == sprite_column + 93) || (pixel_column == sprite_column + 94)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 81 == pixel_column) || (sprite_column + 82 == pixel_column) || (sprite_column + 85 == pixel_column) || (pixel_column == sprite_column + 86) || (pixel_column == sprite_column + 91) || (pixel_column == sprite_column + 92) || (pixel_column == sprite_column + 95) || (pixel_column == sprite_column + 96)))
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
// Block of three alienA sprite's is 16 x 56 pixels (essentially 16 x 60)
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
        if (sprite_column > 560) 
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

assign loserA = loser_reg;
assign move_left = move_left_ff;
assign sprite_row = sprite_row_ff;
assign sprite_column = sprite_column_ff;
assign alienA_output = alien_pix;
assign alienA1_active = active1; 
assign alienA2_active = active2; 
assign alienA3_active = active3; 
assign alienA4_active = active4; 
assign alienA5_active = active5; 


endmodule
