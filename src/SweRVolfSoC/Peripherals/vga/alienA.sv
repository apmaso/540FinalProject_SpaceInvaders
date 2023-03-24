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
	output wire    [3:0]	   alienA_output,
    output wire                alienA1_active,
    output wire                alienA2_active,
    output wire                alienA3_active,
    output wire                alienA4_active,
    output wire                alienA5_active,
    output wire                loserA
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
    sprite_column_ff = 244;
    sprite_row_ff = 20;
    sprite_column = 244;
    sprite_row = 20;
    motion_counter = 0;
    move_left = 1'b0;
end

always_comb begin
    // AlienA Sprite's are 16 rows by 16 columns of pixels 
    // There are 16 pixels between each alien sprite --> Offsets are multiples of 16 + 16 = 32 
    // First sprite --> Offset of 0
    active1 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column < pixel_column) && (pixel_column < sprite_column + 17));
    // Second sprite --> Offset of 32
    active2 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 32 < pixel_column) && (pixel_column < sprite_column + 49));    
    // Third sprite --> Offset of 64
    active3 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 64 < pixel_column) && (pixel_column < sprite_column + 81));
    // Third sprite --> Offset of 96
    active4 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 96 < pixel_column) && (pixel_column < sprite_column + 113));
    // Third sprite --> Offset of 128
    active5 = ((sprite_row < pixel_row) && (pixel_row < sprite_row + 17) && (sprite_column + 128 < pixel_column) && (pixel_column < sprite_column + 145));
   
   
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
        
        
    // Alien A2: Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 38 < pixel_column) && (pixel_column < sprite_column + 43))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 36 < pixel_column) && (pixel_column < sprite_column + 45))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 34 < pixel_column) && (pixel_column < sprite_column + 47))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  +  9) && (((sprite_column + 32 < pixel_column) && (pixel_column < sprite_column + 37)) || ((sprite_column + 38 < pixel_column) && (pixel_column < sprite_column + 43)) || ((sprite_column + 44 < pixel_column) && (pixel_column < sprite_column + 49))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 32 < pixel_column) && (pixel_column < sprite_column + 49))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 37 == pixel_column) || (sprite_column + 38 == pixel_column) || (pixel_column == sprite_column + 43) || (pixel_column == sprite_column + 44)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 35 == pixel_column) || (sprite_column + 36 == pixel_column) || ((sprite_column + 38 < pixel_column) && (pixel_column < sprite_column + 43)) || (pixel_column == sprite_column + 45) || (pixel_column == sprite_column + 46)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 33 == pixel_column) || (sprite_column + 34 == pixel_column) || (sprite_column + 37 == pixel_column) || (pixel_column == sprite_column + 38) || (pixel_column == sprite_column + 43) || (pixel_column == sprite_column + 44) || (pixel_column == sprite_column + 47) || (pixel_column == sprite_column + 48)))
        begin
            alien_pix = 4'b1111;
        end        
        
        
    // Sprite data for AlienA3....  I can make this logic much simpler, if needed
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 75))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 68 < pixel_column) && (pixel_column < sprite_column + 77))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 66 < pixel_column) && (pixel_column < sprite_column + 79))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  +  9) && (((sprite_column + 64 < pixel_column) && (pixel_column < sprite_column + 69)) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 75)) || ((sprite_column + 76 < pixel_column) && (pixel_column < sprite_column + 81))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 64 < pixel_column) && (pixel_column < sprite_column + 81))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 69 == pixel_column) || (sprite_column + 70 == pixel_column) || (pixel_column == sprite_column + 75) || (pixel_column == sprite_column + 76)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 67 == pixel_column) || (sprite_column + 68 == pixel_column) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 75)) || (pixel_column == sprite_column + 77) || (pixel_column == sprite_column + 78)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 65 == pixel_column) || (sprite_column + 66 == pixel_column) || (sprite_column + 69 == pixel_column) || (pixel_column == sprite_column + 70) || (pixel_column == sprite_column + 75) || (pixel_column == sprite_column + 76) || (pixel_column == sprite_column + 79) || (pixel_column == sprite_column + 80)))
        begin
            alien_pix = 4'b1111;
        end 
        
        
    // Sprite data for AlienA4....  I can make this logic much simpler, if needed
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 102 < pixel_column) && (pixel_column < sprite_column + 107))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 100 < pixel_column) && (pixel_column < sprite_column + 109))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 98 < pixel_column) && (pixel_column < sprite_column + 111))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  +  9) && (((sprite_column + 96 < pixel_column) && (pixel_column < sprite_column + 101)) || ((sprite_column + 102 < pixel_column) && (pixel_column < sprite_column + 107)) || ((sprite_column + 108 < pixel_column) && (pixel_column < sprite_column + 113))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 96 < pixel_column) && (pixel_column < sprite_column + 113))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 101 == pixel_column) || (sprite_column + 102 == pixel_column) || (pixel_column == sprite_column + 107) || (pixel_column == sprite_column + 108)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 99 == pixel_column) || (sprite_column + 100 == pixel_column) || ((sprite_column + 102 < pixel_column) && (pixel_column < sprite_column + 107)) || (pixel_column == sprite_column + 109) || (pixel_column == sprite_column + 110)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 97 == pixel_column) || (sprite_column + 98 == pixel_column) || (sprite_column + 101 == pixel_column) || (pixel_column == sprite_column + 102) || (pixel_column == sprite_column + 107) || (pixel_column == sprite_column + 108) || (pixel_column == sprite_column + 111) || (pixel_column == sprite_column + 112)))
        begin
            alien_pix = 4'b1111;
        end        


    // Sprite data for AlienA5....  I can make this logic much simpler, if needed
    // Row one & two   
    else if ((sprite_row < pixel_row) && (pixel_row < sprite_row  + 3) && (sprite_column + 134 < pixel_column) && (pixel_column < sprite_column + 139))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 3 & 4 
    else if ((sprite_row + 2 < pixel_row) && (pixel_row < sprite_row  + 5) && (sprite_column + 132 < pixel_column) && (pixel_column < sprite_column + 141))
        begin
            alien_pix = 4'b1111;
        end   
    // Row 5 & 6 
    else if ((sprite_row + 4 < pixel_row) && (pixel_row < sprite_row  + 7) && (sprite_column + 130 < pixel_column) && (pixel_column < sprite_column + 143))
        begin
            alien_pix = 4'b1111;
        end
    // Row 7 & 8 
    else if ((sprite_row + 6 < pixel_row) && (pixel_row < sprite_row  + 9) && (((sprite_column + 128 < pixel_column) && (pixel_column < sprite_column + 133)) || ((sprite_column + 134 < pixel_column) && (pixel_column < sprite_column + 139)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 145))))
        begin
            alien_pix = 4'b1111;
        end
    // Row 9 & 10 
    else if ((sprite_row + 8 < pixel_row) && (pixel_row < sprite_row + 11) && (sprite_column + 128 < pixel_column) && (pixel_column < sprite_column + 145))
        begin
            alien_pix = 4'b1111;
        end
    // Row 11 & 12 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row  + 13) && ((sprite_column + 133 == pixel_column) || (sprite_column + 134 == pixel_column) || (pixel_column == sprite_column + 139) || (pixel_column == sprite_column + 140)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 13 & 14 
    else if ((sprite_row + 12 < pixel_row) && (pixel_row < sprite_row  + 15) && ((sprite_column + 131 == pixel_column) || (sprite_column + 132 == pixel_column) || ((sprite_column + 134 < pixel_column) && (pixel_column < sprite_column + 139)) || (pixel_column == sprite_column + 141) || (pixel_column == sprite_column + 142)))
        begin
            alien_pix = 4'b1111;
        end
    // Row 15 & 16 
    else if ((sprite_row + 14 < pixel_row) && (pixel_row < sprite_row  + 17) && ((sprite_column + 129 == pixel_column) || (sprite_column + 130 == pixel_column) || (sprite_column + 133 == pixel_column) || (pixel_column == sprite_column + 134) || (pixel_column == sprite_column + 139) || (pixel_column == sprite_column + 140) || (pixel_column == sprite_column + 143) || (pixel_column == sprite_column + 144)))
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

assign loserA = (sprite_row > 360) ? 1'b1 : 1'b0;
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
