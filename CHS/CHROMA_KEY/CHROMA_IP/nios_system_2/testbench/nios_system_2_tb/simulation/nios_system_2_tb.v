// nios_system_2_tb.v

// Generated using ACDS version 17.1 593

`timescale 1 ps / 1 ps
module nios_system_2_tb (
	);

	wire    nios_system_2_inst_clk_50_in_bfm_clk_clk; // nios_system_2_inst_clk_50_in_bfm:clk -> [nios_system_2_inst:clk_50_in_clk, nios_system_2_inst_reset_bfm:clk]
	wire    nios_system_2_inst_reset_bfm_reset_reset; // nios_system_2_inst_reset_bfm:reset -> nios_system_2_inst:reset_reset_n

	nios_system_2 nios_system_2_inst (
		.chromaprocessor_avalon_streaming_source_data          (),                                         // chromaprocessor_avalon_streaming_source.data
		.chromaprocessor_avalon_streaming_source_empty         (),                                         //                                        .empty
		.chromaprocessor_avalon_streaming_source_ready         (),                                         //                                        .ready
		.chromaprocessor_avalon_streaming_source_startofpacket (),                                         //                                        .startofpacket
		.chromaprocessor_avalon_streaming_source_valid         (),                                         //                                        .valid
		.chromaprocessor_avalon_streaming_source_endofpacket   (),                                         //                                        .endofpacket
		.chromaprocessor_background_sink_data                  (),                                         //         chromaprocessor_background_sink.data
		.chromaprocessor_background_sink_empty                 (),                                         //                                        .empty
		.chromaprocessor_background_sink_endofpacket           (),                                         //                                        .endofpacket
		.chromaprocessor_background_sink_ready                 (),                                         //                                        .ready
		.chromaprocessor_background_sink_startofpacket         (),                                         //                                        .startofpacket
		.chromaprocessor_background_sink_valid                 (),                                         //                                        .valid
		.chromaprocessor_foreground_sink_data                  (),                                         //         chromaprocessor_foreground_sink.data
		.chromaprocessor_foreground_sink_empty                 (),                                         //                                        .empty
		.chromaprocessor_foreground_sink_endofpacket           (),                                         //                                        .endofpacket
		.chromaprocessor_foreground_sink_ready                 (),                                         //                                        .ready
		.chromaprocessor_foreground_sink_startofpacket         (),                                         //                                        .startofpacket
		.chromaprocessor_foreground_sink_valid                 (),                                         //                                        .valid
		.clk_50_in_clk                                         (nios_system_2_inst_clk_50_in_bfm_clk_clk), //                               clk_50_in.clk
		.reset_reset_n                                         (nios_system_2_inst_reset_bfm_reset_reset)  //                                   reset.reset_n
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) nios_system_2_inst_clk_50_in_bfm (
		.clk (nios_system_2_inst_clk_50_in_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) nios_system_2_inst_reset_bfm (
		.reset (nios_system_2_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (nios_system_2_inst_clk_50_in_bfm_clk_clk)  //   clk.clk
	);

endmodule
