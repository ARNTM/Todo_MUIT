// nios_system_tb.v

// Generated using ACDS version 17.1 593

`timescale 1 ps / 1 ps
module nios_system_tb (
	);

	wire    nios_system_inst_clk_50_in_bfm_clk_clk; // nios_system_inst_clk_50_in_bfm:clk -> [nios_system_inst:clk_50_in_clk, nios_system_inst_reset_bfm:clk]
	wire    nios_system_inst_reset_bfm_reset_reset; // nios_system_inst_reset_bfm:reset -> nios_system_inst:reset_reset_n

	nios_system nios_system_inst (
		.clk_50_in_clk (nios_system_inst_clk_50_in_bfm_clk_clk), // clk_50_in.clk
		.reset_reset_n (nios_system_inst_reset_bfm_reset_reset)  //     reset.reset_n
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) nios_system_inst_clk_50_in_bfm (
		.clk (nios_system_inst_clk_50_in_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) nios_system_inst_reset_bfm (
		.reset (nios_system_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (nios_system_inst_clk_50_in_bfm_clk_clk)  //   clk.clk
	);

endmodule
