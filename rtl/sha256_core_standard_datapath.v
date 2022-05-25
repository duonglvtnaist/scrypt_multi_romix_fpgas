module sha256_core_standard_datapath #(
					parameter SHA256_H0_0 = 32'h6a09e667,
					parameter SHA256_H0_1 = 32'hbb67ae85,
					parameter SHA256_H0_2 = 32'h3c6ef372,
					parameter SHA256_H0_3 = 32'ha54ff53a,
					parameter SHA256_H0_4 = 32'h510e527f,
					parameter SHA256_H0_5 = 32'h9b05688c,
					parameter SHA256_H0_6 = 32'h1f83d9ab,
					parameter SHA256_H0_7 = 32'h5be0cd19,
					parameter SHA256_LOOP_LAST = 6'd63,
					parameter START_GET_W = 6'd16
)
(
					input	wire 				clk,
					input	wire	[511:0]		block_in,
					input	wire 				first_block,
					input 	wire	[255:0]		prev_digest,
					input	wire				t_ctr_init,
					input	wire				t_ctr_next,
					input	wire				digest_init,
					input	wire				loop_init,
					input	wire				loop_next,
					input	wire				w_init,
					input	wire				w_next,
					output	wire				t_ctr_last,
					output	wire 	[31:0]		digest_0,
					output	wire 	[31:0]		digest_1,
					output	wire 	[31:0]		digest_2,
					output	wire 	[31:0]		digest_3,
					output	wire 	[31:0]		digest_4,
					output	wire 	[31:0]		digest_5,					
					output	wire 	[31:0]		digest_6,
					output	wire 	[31:0]		digest_7					
);
	wire 	[31:0]	k_i;
	wire 	[31:0]	w_i_wire;
	wire 	[31:0]	w_i_choose_wire;
	wire 	[31:0]	w_mem_wire [0:15];
	
	wire 	[31:0]	a_wire;
	wire 	[31:0]	b_wire;
	wire 	[31:0]	c_wire;
	wire 	[31:0]	d_wire;
	wire 	[31:0]	e_wire;
	wire 	[31:0]	f_wire;
	wire 	[31:0]	g_wire;
	wire 	[31:0]	h_wire;
	wire 	[31:0]	t_1_wire;
	wire 	[31:0]	t_2_wire;
	
	wire	[31:0]	sum0_wire;
	wire	[31:0]	sum1_wire;
	wire	[31:0]	ch_wire;
	wire	[31:0]	maj_wire;

	
	wire 	[511:0] block;
	wire	[31:0] 	d0_wire;
	wire	[31:0]	d1_wire;

	wire	[31:0]	cal_a;
	wire	[31:0]	cal_e;
	
	wire	[5:0]	t_ctr_wire;
	
	wire	[31:0]	digest_0_wire	;
	wire	[31:0]	digest_1_wire	;
	wire	[31:0]	digest_2_wire	;
	wire	[31:0]	digest_3_wire	;
	wire	[31:0]	digest_4_wire	;
	wire	[31:0]	digest_5_wire	;
	wire	[31:0]	digest_6_wire	;
	wire	[31:0]	digest_7_wire	;
	
	
	// Defined regs and wires for main_loop
	reg 	[31:0]	digest_reg [0:7];
	reg	 	[31:0]	w_mem_reg [0:15];
	reg		[5:0]	t_ctr_reg;
	
	reg 	[31:0] 	a_reg;
	reg 	[31:0] 	b_reg;
	reg 	[31:0] 	c_reg;
	reg 	[31:0] 	d_reg;
	reg 	[31:0] 	e_reg;
	reg 	[31:0] 	f_reg;
	reg 	[31:0] 	g_reg;
	reg 	[31:0] 	h_reg;
	reg 	[31:0] 	t_1_reg;
	reg 	[31:0] 	t_2_reg;
			
	reg 	[31:0]	sum0_reg;
	reg 	[31:0]	sum1_reg;
	reg 	[31:0]	ch_reg;
	reg 	[31:0]	maj_reg;

	
	
	// Defined regs and wires for w_mem

	// Assign block from w_mem
	assign block = {w_mem_wire[00],
					w_mem_wire[01],
					w_mem_wire[02],
					w_mem_wire[03],
					w_mem_wire[04],
					w_mem_wire[05],
					w_mem_wire[06],
					w_mem_wire[07],
					w_mem_wire[08],
					w_mem_wire[09],
					w_mem_wire[10],
					w_mem_wire[11],
					w_mem_wire[12],
					w_mem_wire[13],
					w_mem_wire[14],
					w_mem_wire[15]};
					
	// Assign to get digest output
	assign	digest_0_wire 	= 	digest_reg[0];
	assign	digest_1_wire	=	digest_reg[1];
	assign	digest_2_wire	=	digest_reg[2];
	assign	digest_3_wire	=	digest_reg[3];
	assign	digest_4_wire	=	digest_reg[4];
	assign	digest_5_wire	=	digest_reg[5];
	assign	digest_6_wire	=	digest_reg[6];
	assign	digest_7_wire	=	digest_reg[7];
	
	
	assign digest_0	=  digest_reg[0] + a_wire;
	assign digest_1	=  digest_reg[1] + b_wire;
	assign digest_2	=  digest_reg[2] + c_wire;
	assign digest_3	=  digest_reg[3] + d_wire;
	assign digest_4	=  digest_reg[4] + e_wire;
	assign digest_5	=  digest_reg[5] + f_wire;
	assign digest_6	=  digest_reg[6] + g_wire;
	assign digest_7	=  digest_reg[7] + h_wire;
	
	assign	a_wire		=	a_reg;			
	assign	b_wire		=	b_reg;			
	assign	c_wire		=	c_reg;			
	assign	d_wire		=	d_reg;			
	assign	e_wire		=	e_reg;			
	assign	f_wire		=	f_reg;			
	assign	g_wire		=	g_reg;			
	assign	h_wire		=	h_reg;			

	
	
	assign cal_a = t_1_wire + t_2_wire	;
	assign cal_e = d_wire + t_1_wire	;
	assign w_i_choose_wire = (t_ctr_wire < 6'd16) ? w_mem_reg[t_ctr_wire] : w_i_wire;
	//assign wire	
	
	assign	t_ctr_wire 	= t_ctr_reg;
	
	assign	w_mem_wire[00]	=	w_mem_reg[00];
	assign	w_mem_wire[01]	=	w_mem_reg[01];
	assign	w_mem_wire[02]	=	w_mem_reg[02];
	assign	w_mem_wire[03]	=	w_mem_reg[03];
	assign	w_mem_wire[04]	=	w_mem_reg[04];
	assign	w_mem_wire[05]	=	w_mem_reg[05];
	assign	w_mem_wire[06]	=	w_mem_reg[06];
	assign	w_mem_wire[07]	=	w_mem_reg[07];
	assign	w_mem_wire[08]	=	w_mem_reg[08];
	assign	w_mem_wire[09]	=	w_mem_reg[09];
	assign	w_mem_wire[10]	=	w_mem_reg[10];
	assign	w_mem_wire[11]	=	w_mem_reg[11];
	assign	w_mem_wire[12]	=	w_mem_reg[12];
	assign	w_mem_wire[13]	=	w_mem_reg[13];
	assign	w_mem_wire[14]	=	w_mem_reg[14];
	assign	w_mem_wire[15]	=	w_mem_reg[15];
	
//instantions
	sha256_k_constants k_mem (
						.address(t_ctr_wire), 
						.k_data(k_i)
						);
	
	// Functions for main_loop
	
	assign	sum1_wire = {e_wire[5:0],e_wire[31:6]} ^ {e_wire[10:0], e_wire[31:11]} ^ {e_wire[24:0], e_wire[31:25]};
	assign	sum0_wire = {a_wire[1:0], a_wire[31:2]} ^ {a_wire[12:0], a_wire[31:13]} ^ {a_wire[21:0], a_wire[31:22]};
	assign	ch_wire	  = (e_wire & f_wire) ^ ((~e_wire) & g_wire); 
	assign	maj_wire  = (a_wire & b_wire) ^ (a_wire & c_wire) ^ (b_wire & c_wire);
	assign	t_1_wire	= 	sum1_wire + ch_wire + k_i + h_wire + w_i_choose_wire;
	assign	t_2_wire	= 	sum0_wire + maj_wire;
	
	// Functions for w_mem
	
	assign 	d0_wire = {block[454:448], block[479:455]} ^ {block[465:448], block[479:466]} ^ {3'b000,block[479:451]};
	assign	d1_wire = {block[48:32],block[63:49]}^{block[50:32],block[63:51]}^{10'b0000000000,block[63:42]};
	
	// t_ctr_last wire assignment
	
	assign t_ctr_last = (t_ctr_wire == 6'd63) ? 1'b1 : 1'b0;
	// find new w_mem
	
	assign 	w_i_wire	=  d0_wire + d1_wire + w_mem_wire[00] + w_mem_wire[09];
	
	// Save Block input combination
always@(posedge clk) begin
	if(t_ctr_init == 1'b1) begin
		t_ctr_reg <= 6'b0;
	end
	else if(t_ctr_next == 1'b1) begin
		t_ctr_reg <= t_ctr_wire + 6'b1;
	end
end

	// W_mem combination
always@(posedge clk) begin
	if(w_init == 1'b1) begin
		w_mem_reg[00] <= block_in[511:480];
		w_mem_reg[01] <= block_in[479:448];
		w_mem_reg[02] <= block_in[447:416];
		w_mem_reg[03] <= block_in[415:384];
		w_mem_reg[04] <= block_in[383:352];
		w_mem_reg[05] <= block_in[351:320];
		w_mem_reg[06] <= block_in[319:288];
		w_mem_reg[07] <= block_in[287:256];
		w_mem_reg[08] <= block_in[255:224];
		w_mem_reg[09] <= block_in[223:192];
		w_mem_reg[10] <= block_in[191:160];
		w_mem_reg[11] <= block_in[159:128];
		w_mem_reg[12] <= block_in[127:96];
		w_mem_reg[13] <= block_in[95:64];
		w_mem_reg[14] <= block_in[63:32];
		w_mem_reg[15] <= block_in[31:0];
	end
	else if(w_next == 1'b1 && t_ctr_wire > 6'd15) begin
			w_mem_reg[00] <= w_mem_wire[01];
			w_mem_reg[01] <= w_mem_wire[02];
			w_mem_reg[02] <= w_mem_wire[03];
			w_mem_reg[03] <= w_mem_wire[04];
			w_mem_reg[04] <= w_mem_wire[05];
			w_mem_reg[05] <= w_mem_wire[06];
			w_mem_reg[06] <= w_mem_wire[07];
			w_mem_reg[07] <= w_mem_wire[08];
			w_mem_reg[08] <= w_mem_wire[09];
			w_mem_reg[09] <= w_mem_wire[10];
			w_mem_reg[10] <= w_mem_wire[11];
			w_mem_reg[11] <= w_mem_wire[12];
			w_mem_reg[12] <= w_mem_wire[13];
			w_mem_reg[13] <= w_mem_wire[14];
			w_mem_reg[14] <= w_mem_wire[15];
			w_mem_reg[15] <= w_i_wire;
	end
end

// main_loop combination
always@(posedge clk) begin
	if(digest_init == 1'b1) begin
		if(first_block == 1'b1) begin
			digest_reg[0] <= SHA256_H0_0;
			digest_reg[1] <= SHA256_H0_1;
			digest_reg[2] <= SHA256_H0_2;
			digest_reg[3] <= SHA256_H0_3;
			digest_reg[4] <= SHA256_H0_4;
			digest_reg[5] <= SHA256_H0_5;
			digest_reg[6] <= SHA256_H0_6;
			digest_reg[7] <= SHA256_H0_7;
		end
		else begin
			digest_reg[0] <= prev_digest[255:224];
			digest_reg[1] <= prev_digest[223:192];
			digest_reg[2] <= prev_digest[191:160];
			digest_reg[3] <= prev_digest[159:128];
			digest_reg[4] <= prev_digest[127:96];
			digest_reg[5] <= prev_digest[95:64];
			digest_reg[6] <= prev_digest[63:32];
			digest_reg[7] <= prev_digest[31:0];	
		end
	end	
	else begin
		digest_reg[0] <= digest_0_wire;
		digest_reg[1] <= digest_1_wire;
		digest_reg[2] <= digest_2_wire;
		digest_reg[3] <= digest_3_wire;
		digest_reg[4] <= digest_4_wire;
		digest_reg[5] <= digest_5_wire;
		digest_reg[6] <= digest_6_wire;
		digest_reg[7] <= digest_7_wire;		
	end
end	
always@(posedge clk) begin	
	if(loop_init == 1'b1) begin
		if(first_block == 1'b1) begin
			a_reg <= SHA256_H0_0;
			b_reg <= SHA256_H0_1;
			c_reg <= SHA256_H0_2;
			d_reg <= SHA256_H0_3;
			e_reg <= SHA256_H0_4;
			f_reg <= SHA256_H0_5;
			g_reg <= SHA256_H0_6;
			h_reg <= SHA256_H0_7;
		end
		else begin
			a_reg <= prev_digest[255:224];
			b_reg <= prev_digest[223:192];
			c_reg <= prev_digest[191:160];
			d_reg <= prev_digest[159:128];
			e_reg <= prev_digest[127:96];
			f_reg <= prev_digest[95:64];
			g_reg <= prev_digest[63:32];
			h_reg <= prev_digest[31:0];	
		end
	end
	else if(loop_next == 1'b1) begin
		a_reg <= cal_a;
		b_reg <= a_wire;
		c_reg <= b_wire;
		d_reg <= c_wire;
		e_reg <= cal_e;
		f_reg <= e_wire;
		g_reg <= f_wire;
		h_reg <= g_wire;
	end

end
endmodule