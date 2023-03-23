// 
// 
// 
// 
//
// Created by Alexander Maso PSU ECE-Winter 2023
///////////////////////////////////////////////////////////////

module player(
    input wire                 clk, rst,
    input wire    [11:0]       pixel_row, pixel_column, 
    input wire    [11:0]       btn_col, 
    input wire    [7:0]        btn_missle_en,
    output wire                missle1_active,
    output wire                missle2_active,
    output wire                missle3_active,
    output wire                missle4_active,
    output wire                missle5_active,
    output wire                missle6_active,
    output wire                missle7_active,
    output wire                missle8_active,
    output wire                player_active,
    output wire    [3:0]	   missle_output, 
    output wire    [3:0]	   player_output
    );

// Internals for the Player's Sprite
logic   [3:0]               player_pix;
logic   [11:0]              player_row;
logic   [11:0]              player_column;
logic                       player_active_reg;

// Internals for the missle sprites
logic   [11:0]              missle1_column_reg;
logic   [11:0]              missle1_column_next;
logic   [11:0]              missle1_row_reg;
logic   [11:0]              missle1_row_next;
logic                       missle1_active_reg;

logic   [11:0]              missle2_column_reg;
logic   [11:0]              missle2_column_next;
logic   [11:0]              missle2_row_reg;
logic   [11:0]              missle2_row_next;
logic                       missle2_active_reg;

logic   [11:0]              missle3_column_reg;
logic   [11:0]              missle3_column_next;
logic   [11:0]              missle3_row_reg;
logic   [11:0]              missle3_row_next;
logic                       missle3_active_reg;

logic   [11:0]              missle4_column_reg;
logic   [11:0]              missle4_column_next;
logic   [11:0]              missle4_row_reg;
logic   [11:0]              missle4_row_next;
logic                       missle4_active_reg;

logic   [11:0]              missle5_column_reg;
logic   [11:0]              missle5_column_next;
logic   [11:0]              missle5_row_reg;
logic   [11:0]              missle5_row_next;
logic                       missle5_active_reg;

logic   [11:0]              missle6_column_reg;
logic   [11:0]              missle6_column_next;
logic   [11:0]              missle6_row_reg;
logic   [11:0]              missle6_row_next;
logic                       missle6_active_reg;

logic   [11:0]              missle7_column_reg;
logic   [11:0]              missle7_column_next;
logic   [11:0]              missle7_row_reg;
logic   [11:0]              missle7_row_next;
logic                       missle7_active_reg;

logic   [11:0]              missle8_column_reg;
logic   [11:0]              missle8_column_next;
logic   [11:0]              missle8_row_reg;
logic   [11:0]              missle8_row_next;
logic                       missle8_active_reg;

logic   [23:0]              motion_counter;
logic   [7:0]               missle_en;
logic   [7:0]               missle_en_next;
logic   [7:0]	            missle_en_xor;
logic   [3:0]               missle_pix;
    
initial begin
    // Initializing Player 20 rows from the bottom of the screen. Rows 451 <-> 460
    // and close to centered as possible. Columns: 313 <-> 328
    player_pix = 0;
    player_row = 440;
    player_column = 305;
    missle_pix = 0;
    missle1_row_reg = 440;
    missle1_column_reg = 305;
    missle2_row_reg = 440;
    missle2_column_reg = 305;
    missle3_row_reg = 440;
    missle3_column_reg = 305;
    missle4_row_reg = 440;
    missle4_column_reg = 305;
    missle5_row_reg = 440;
    missle5_column_reg = 305;
    missle6_row_reg = 440;
    missle6_column_reg = 305;
    missle7_row_reg = 440;
    missle7_column_reg = 305;
    missle8_row_reg = 440;
    missle8_column_reg = 305;
    motion_counter = 0; 
    missle_en_xor = 0;
    missle_en = 0;
end

always_comb begin   
    // Are we in the active region for the player's sprite???
    player_active_reg = ((player_row < pixel_row) && (pixel_row < player_row + 21) && (player_column < pixel_column) && (pixel_column < player_column + 31));
    missle1_active_reg = ((missle1_row_reg < pixel_row) && (pixel_row < missle1_row_reg + 5) && (missle1_column_reg + 14 < pixel_column) && (pixel_column < missle1_column_reg + 17));
    missle2_active_reg = ((missle2_row_reg < pixel_row) && (pixel_row < missle2_row_reg + 5) && (missle2_column_reg + 14 < pixel_column) && (pixel_column < missle2_column_reg + 17));
    missle3_active_reg = ((missle3_row_reg < pixel_row) && (pixel_row < missle3_row_reg + 5) && (missle3_column_reg + 14 < pixel_column) && (pixel_column < missle3_column_reg + 17));    
    missle4_active_reg = ((missle4_row_reg < pixel_row) && (pixel_row < missle4_row_reg + 5) && (missle4_column_reg + 14 < pixel_column) && (pixel_column < missle4_column_reg + 17));
    missle5_active_reg = ((missle5_row_reg < pixel_row) && (pixel_row < missle5_row_reg + 5) && (missle5_column_reg + 14 < pixel_column) && (pixel_column < missle5_column_reg + 17));
    missle6_active_reg = ((missle6_row_reg < pixel_row) && (pixel_row < missle6_row_reg + 5) && (missle6_column_reg + 14 < pixel_column) && (pixel_column < missle6_column_reg + 17));   
    missle7_active_reg = ((missle7_row_reg < pixel_row) && (pixel_row < missle7_row_reg + 5) && (missle7_column_reg + 14 < pixel_column) && (pixel_column < missle7_column_reg + 17));
    missle8_active_reg = ((missle8_row_reg < pixel_row) && (pixel_row < missle8_row_reg + 5) && (missle8_column_reg + 14 < pixel_column) && (pixel_column < missle8_column_reg + 17));
    
    
    // Sprite data for Player....  I can make this logic much simpler, if needed
    // Rows 1 - 4 of the player's sprite            
    if ((player_row < pixel_row) && (pixel_row < player_row  + 5) && (player_column + 14 < pixel_column) && (pixel_column < player_column + 17))
        begin
            player_pix = 4'b1111;
        end    
    // Rows 5 & 6 of the player's sprite
    else if ((player_row + 4 < pixel_row) && (pixel_row < player_row  + 7) && (player_column + 4 < pixel_column) && (pixel_column < player_column + 27))
        begin
            player_pix = 4'b1111;
        end
    // Rows 7 & 8
    else if ((player_row + 6 < pixel_row) && (pixel_row < player_row  + 9) && (player_column + 2 < pixel_column) && (pixel_column < player_column + 29))
        begin
            player_pix = 4'b1111;
        end
    // Rows 9 - 20
    else if ((player_row + 8 < pixel_row) && (pixel_row < player_row  + 21) && (player_column < pixel_column) && (pixel_column < player_column + 31))
        begin
            player_pix = 4'b1111;
        end
    else
        begin
            player_pix = 4'b0000;
        end
          
    if ((missle_en_xor[0] && missle1_active) || (missle_en_xor[1] && missle2_active) || (missle_en_xor[2] && missle3_active) || (missle_en_xor[3] && missle4_active) || (missle_en_xor[4] && missle5_active) || (missle_en_xor[5] && missle6_active) || (missle_en_xor[6] && missle7_active) || (missle_en_xor[7] && missle8_active))
        begin
            missle_pix = 4'b1111;
        end
    else
        begin
            missle_pix = 4'b0000;
        end      
end


always_comb begin
// Combinational logic for missles
// Every 1 M clocks (31.5 MHz clk -> ~0.03 sec) move missle up 2 pixels

    // MISSLE 1 LOGIC
    if (missle_en_xor[0]) begin
        if (missle1_row_reg < 2) 
            begin
                missle1_row_next = 0;
                missle1_column_next = 0;
                missle_en_next = (missle_en ^ (8'b00000001));
            end
        else
            begin
                missle1_row_next = (missle1_row_reg - 2);
                missle1_column_next = missle1_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin 
        missle1_row_next = player_row;
        missle1_column_next = player_column;
        missle_en_next = missle_en;
    end 
    
    // MISSLE 2 LOGIC
    if (missle_en_xor[1]) begin
        if (missle2_row_reg < 2) 
            begin
                missle2_row_next = 0;
                missle2_column_next = 0; 
                missle_en_next = (missle_en ^ (8'b00000010));
            end
        else
            begin
                missle2_row_next = (missle2_row_reg - 2);
                missle2_column_next = missle2_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle2_row_next = player_row;
        missle2_column_next = player_column;
        missle_en_next = missle_en;
    end
    
    // MISSLE 3 LOGIC
    if (missle_en_xor[2]) begin
        if (missle3_row_reg < 2) 
            begin
                missle3_row_next = 0;
                missle3_column_next = 0;
                missle_en_next = (missle_en ^ (8'b00000100));
            end
        else
            begin
                missle3_row_next = (missle3_row_reg - 2);
                missle3_column_next = missle3_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle3_row_next = player_row;
        missle3_column_next = player_column;
        missle_en_next = missle_en;
    end

    // MISSLE 4 LOGIC    
    if (missle_en_xor[3]) begin
        if (missle4_row_reg < 2) 
            begin
                missle4_row_next = 0;
                missle4_column_next = 0;
                missle_en_next = (missle_en ^ (8'b00001000));
            end
        else
            begin
                missle4_row_next = (missle4_row_reg - 2);
                missle4_column_next = missle4_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle4_row_next = player_row;
        missle4_column_next = player_column;
        missle_en_next = missle_en;
    end

    // MISSLE 5 LOGIC
    if (missle_en_xor[4]) begin
        if (missle5_row_reg < 2) 
            begin
                missle5_row_next = 0;
                missle5_column_next = 0;
                missle_en_next = (missle_en ^ (8'b00010000));
            end
        else
            begin
                missle5_row_next = (missle5_row_reg - 2);
                missle5_column_next = missle5_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle5_row_next = player_row;
        missle5_column_next = player_column;
        missle_en_next = missle_en;
    end

    // MISSLE 6 LOGIC
    if (missle_en_xor[5]) begin
        if (missle6_row_reg < 2) 
            begin
                missle6_row_next = 0;
                missle6_column_next = 0;
                missle_en_next = (missle_en ^ (8'b00100000));
            end
        else
            begin
                missle6_row_next = (missle6_row_reg - 2);
                missle6_column_next = missle6_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle6_row_next = player_row;
        missle6_column_next = player_column;
        missle_en_next = missle_en;
    end 
    
    // MISSLE 7 LOGIC
    if (missle_en_xor[6]) begin
        if (missle7_row_reg < 2) 
            begin
                missle7_row_next = 0;
                missle7_column_next = 0; 
                missle_en_next = (missle_en ^ (8'b01000000));
            end
        else
            begin
                missle7_row_next = (missle7_row_reg - 2);
                missle7_column_next = missle7_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle7_row_next = player_row;
        missle7_column_next = player_column;
        missle_en_next = missle_en;
    end
    
    // MISSLE 8 LOGIC
    if (missle_en_xor[7]) begin
        if (missle8_row_reg < 2) 
            begin
                missle8_row_next = 0;
                missle8_column_next = 0;
                missle_en_next = (missle_en ^ (8'b10000000));
            end
        else
            begin
                missle8_row_next = (missle8_row_reg - 2);
                missle8_column_next = missle8_column_reg;
                missle_en_next = missle_en;
            end      
    end
    else begin
        missle8_row_next = player_row;
        missle8_column_next = player_column;
        missle_en_next = missle_en;
    end

end


always_ff @ (posedge clk) begin
    if (motion_counter < 250000) 
        begin
            missle1_row_reg <= missle1_row_reg;
            missle1_column_reg <= missle1_column_reg;
            missle2_row_reg <= missle2_row_reg;
            missle2_column_reg <= missle2_column_reg;
            missle3_row_reg <= missle3_row_reg;
            missle3_column_reg <= missle3_column_reg;
            missle4_row_reg <= missle4_row_reg;
            missle4_column_reg <= missle4_column_reg;
            missle5_row_reg <= missle5_row_reg;
            missle5_column_reg <= missle5_column_reg;
            missle6_row_reg <= missle6_row_reg;
            missle6_column_reg <= missle6_column_reg;
            missle7_row_reg <= missle7_row_reg;
            missle7_column_reg <= missle7_column_reg;
            missle8_row_reg <= missle8_row_reg;
            missle8_column_reg <= missle8_column_reg;
            missle_en <= missle_en;
            motion_counter <= (motion_counter + 1);
        end
   else 
        begin
            missle1_row_reg <= missle1_row_next;
            missle1_column_reg <= missle1_column_next;
            missle2_row_reg <= missle2_row_next;
            missle2_column_reg <= missle2_column_next;
            missle3_row_reg <= missle3_row_next;
            missle3_column_reg <= missle3_column_next;
            missle4_row_reg <= missle4_row_next;
            missle4_column_reg <= missle4_column_next;
            missle5_row_reg <= missle5_row_next;
            missle5_column_reg <= missle5_column_next;
            missle6_row_reg <= missle6_row_next;
            missle6_column_reg <= missle6_column_next;
            missle7_row_reg <= missle7_row_next;
            missle7_column_reg <= missle7_column_next;
            missle8_row_reg <= missle8_row_next;
            missle8_column_reg <= missle8_column_next;
            missle_en <= missle_en_next;
            motion_counter <= 0;
        end

end



assign missle1_active = missle1_active_reg;
assign missle2_active = missle2_active_reg;
assign missle3_active = missle3_active_reg;
assign missle4_active = missle4_active_reg;
assign missle5_active = missle5_active_reg;
assign missle6_active = missle6_active_reg;
assign missle7_active = missle7_active_reg;
assign missle8_active = missle8_active_reg;
assign missle_output = missle_pix;
assign missle_en_xor = (btn_missle_en ^ missle_en);

assign player_active = player_active_reg;
assign player_column = btn_col;
assign player_output = player_pix;

endmodule

