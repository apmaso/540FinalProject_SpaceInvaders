

module btn_top(
    input wire          btn_clk_i,
    input wire          btn_rst_i,
    input wire          btn_m2s_cyc_i,
    input wire [7:0]    btn_m2s_adr_i,
    input wire [31:0]   btn_m2s_dat_i,
    input wire          btn_sel_i,
    input wire          btn_m2s_we_i,
    input wire          btn_m2s_stb_i,
    output wire [31:0]  btn_s2m_dat_o,
    output wire         btn_s2m_ack_o,
    output wire         btn_s2m_err_o,    
    output wire         btn_inta_o,  
    // {BTNC,BTNU,BTNL,BTNR,BTND}
    input wire   [4:0]  btn_data,
    output wire  [11:0] btn_col_o,           
    output wire  [7:0]  btn_missle_en
    );
    
// Internals for button peripheral    
logic        btn_ack_ff;
logic [4:0]  btn_data_reg;
logic [11:0] btn_col_reg;
logic [7:0]  btn_missle_reg;

// Orientation matches that of the Sprite as well as VGA
// (Row x Column) with origin in the upper left corner
// The only difference is that Pixel Array begins at (1,1), not (0,0)
initial begin
btn_col_reg = 312;
btn_data_reg = 0;
btn_missle_reg = 0;
end

always_ff @(posedge btn_clk_i, posedge btn_rst_i) begin
	if (btn_rst_i) begin
	    btn_ack_ff <= 0;
	    btn_data_reg <= 0;
/*   Removing rst for these registers...  
Debugging starting position of the Player Sprite
        btn_col_reg <= 0;
	    btn_row_reg <= 0;
	    */
	end
	else begin
	            btn_data_reg <= btn_ack_ff ? btn_data : btn_data_reg;
        case(btn_m2s_adr_i[5:2])
            1:  btn_col_reg <= btn_ack_ff && btn_m2s_we_i ? btn_m2s_dat_i : btn_col_reg;
            2:  btn_missle_reg <= btn_ack_ff && btn_m2s_we_i ? btn_m2s_dat_i : btn_missle_reg;     
        endcase
	       // Ensure 1 wait state even for back to back host requests
           btn_ack_ff = ! btn_ack_ff & btn_m2s_stb_i & btn_m2s_cyc_i;
    	end
end


assign btn_s2m_dat_o = (btn_m2s_adr_i[5:2] > 0) ? (btn_m2s_adr_i[5:2] > 1) ? btn_missle_reg : btn_col_reg : btn_data_reg;
assign btn_col_o = btn_col_reg;
assign btn_missle_en = btn_missle_reg;
assign btn_s2m_ack_o = btn_ack_ff;

// Holding irq low for now....
assign btn_inta_o = 1'b0;

endmodule