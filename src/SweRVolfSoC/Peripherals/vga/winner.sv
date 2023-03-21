module winner(
    input  wire                clk, rst,
    input  wire    [11:0]      pixel_row, pixel_column, 
	input  wire				   winner,
	output wire    [3:0]	   winner_output
    );

// Internals
logic   [11:0]              sprite_row;
logic   [11:0]              sprite_column;
logic   [11:0]              sprite_row_ff;
logic   [11:0]              sprite_column_ff;
logic   [11:0]              sprite_row_next;
logic   [11:0]              sprite_column_next;
logic   [3:0]               winner_pix;
logic   [23:0]              motion_counter;


    
initial begin
    winner_pix = 4'b0000;
    sprite_column_ff = 195;
    sprite_row_ff = 480;
    sprite_column = 195;
    sprite_row = 480;
	motion_counter = 0;
end



always_comb begin
	// Rows 1 - 10
	if ((sprite_row < pixel_row) && (pixel_row < sprite_row + 11) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 11)) || ((sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 91)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end   
    // Row 11 - 20 
    else if ((sprite_row + 10 < pixel_row) && (pixel_row < sprite_row + 21) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 11)) || ((sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 91)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 121)) || ((sprite_column + 170 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end   
    // Row 21 - 30 
	else if ((sprite_row + 20 < pixel_row) && (pixel_row < sprite_row + 31) && (((sprite_column + 10 < pixel_column) && (pixel_column < sprite_column + 21)) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 81)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 121)) || ((sprite_column + 170 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
    // Row 31 - 40
    else if ((sprite_row + 30 < pixel_row) && (pixel_row < sprite_row + 41) && (((sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 31)) || ((sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 71)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 121)) || ((sprite_column + 170 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Row 41 - 50
    else if ((sprite_row + 40 < pixel_row) && (pixel_row < sprite_row + 51) && (((sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 61)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 121)) || ((sprite_column + 170 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Row 51 - 90
    else if ((sprite_row + 50 < pixel_row) && (pixel_row < sprite_row + 91) && (((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 51)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 121)) || ((sprite_column + 170 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Row 91 - 100
    else if ((sprite_row + 90 < pixel_row) && (pixel_row < sprite_row + 101) && (((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 51)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 210 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Rows 151 - 160
	else if ((sprite_row + 150 < pixel_row) && (pixel_row < sprite_row + 161) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 11)) || ((sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 91)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 221)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Rows 161 - 180
	else if ((sprite_row + 160 < pixel_row) && (pixel_row < sprite_row + 181) && (((sprite_column < pixel_column) && (pixel_column < sprite_column + 11)) || ((sprite_column + 80 < pixel_column) && (pixel_column < sprite_column + 91)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 151)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) ||  ((sprite_column + 220 < pixel_column) && (pixel_column < sprite_column + 231)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Rows 181 - 200
	else if ((sprite_row + 180 < pixel_row) && (pixel_row < sprite_row + 201) && (((sprite_column + 10 < pixel_column) && (pixel_column < sprite_column + 21)) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 81)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 151)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) ||  ((sprite_column + 230 < pixel_column) && (pixel_column < sprite_column + 241)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
        end
	// Rows 201 - 210
	else if ((sprite_row + 200 < pixel_row) && (pixel_row < sprite_row + 211) && (((sprite_column + 10 < pixel_column) && (pixel_column < sprite_column + 21)) || ((sprite_column + 70 < pixel_column) && (pixel_column < sprite_column + 81)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 151)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) || ((sprite_column + 240 < pixel_column) && (pixel_column < sprite_column + 251)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
		end
	// Rows 211 - 220
	else if ((sprite_row + 210 < pixel_row) && (pixel_row < sprite_row + 221) && (((sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 31)) || ((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 51)) || ((sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 71)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 151)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) ||  ((sprite_column + 240 < pixel_column) && (pixel_column < sprite_column + 251)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
		end
	// Rows 221 - 230
	else if ((sprite_row + 220 < pixel_row) && (pixel_row < sprite_row + 231) && (((sprite_column + 20 < pixel_column) && (pixel_column < sprite_column + 31)) || ((sprite_column + 40 < pixel_column) && (pixel_column < sprite_column + 51)) || ((sprite_column + 60 < pixel_column) && (pixel_column < sprite_column + 71)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 151)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) ||  ((sprite_column + 250 < pixel_column) && (pixel_column < sprite_column + 261)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
		end
	// Rows 231 - 240
	else if ((sprite_row + 230 < pixel_row) && (pixel_row < sprite_row + 241) && (((sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 41)) || ((sprite_column + 50 < pixel_column) && (pixel_column < sprite_column + 61)) || ((sprite_column + 140 < pixel_column) && (pixel_column < sprite_column + 151)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) ||  ((sprite_column + 250 < pixel_column) && (pixel_column < sprite_column + 261)) || ((sprite_column + 270 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
		end
	// Rows 241 - 250
	else if ((sprite_row + 240 < pixel_row) && (pixel_row < sprite_row + 251) && (((sprite_column + 30 < pixel_column) && (pixel_column < sprite_column + 41)) || ((sprite_column + 50 < pixel_column) && (pixel_column < sprite_column + 61)) || ((sprite_column + 110 < pixel_column) && (pixel_column < sprite_column + 181)) || ((sprite_column + 200 < pixel_column) && (pixel_column < sprite_column + 211)) ||  ((sprite_column + 260 < pixel_column) && (pixel_column < sprite_column + 281))))
        begin
            winner_pix = 4'b1111;
		end
	else
		begin
			winner_pix = 4'b0000;
		end
		
end


// Additional combinational block for FSM used in implemention motion
always_comb begin
// Every 1 M clocks (31.5 MHz clk -> ~0.03 sec) move missle up 3 pixels
    if (winner) 
		begin
			if (sprite_row < 1) 
				begin
					sprite_row_next = 0;
					sprite_column_next = 100;
				end
			else
				begin
					sprite_row_next = (sprite_row_ff - 3);
					sprite_column_next = sprite_column_ff;
				end      
		end
	else 
		begin
			sprite_row_next = 480;
            sprite_column_next = 195;
        end
    
end

always_ff @ (posedge clk) begin
    if (motion_counter < 4000000) 
        begin
            sprite_row_ff <= sprite_row_ff;
            sprite_column_ff <= sprite_column_ff;
            motion_counter <= (motion_counter + 1);
        end
   else 
        begin
            sprite_row_ff <= sprite_row_next;
            sprite_column_ff <= sprite_column_next;
            motion_counter <= 0;
        end

end


assign sprite_row = sprite_row_ff;
assign sprite_column = sprite_column_ff;
assign winner_output = winner_pix;

endmodule

