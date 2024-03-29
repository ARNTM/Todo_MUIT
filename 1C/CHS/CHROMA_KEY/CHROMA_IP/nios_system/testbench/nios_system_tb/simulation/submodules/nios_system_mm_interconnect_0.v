// nios_system_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 17.1 593

`timescale 1 ps / 1 ps
module nios_system_mm_interconnect_0 (
		input  wire        clk_50_clk_clk,                                      //                                    clk_50_clk.clk
		input  wire        mm_master_bfm_clk_reset_reset_bridge_in_reset_reset, // mm_master_bfm_clk_reset_reset_bridge_in_reset.reset
		input  wire [2:0]  mm_master_bfm_m0_address,                            //                              mm_master_bfm_m0.address
		output wire        mm_master_bfm_m0_waitrequest,                        //                                              .waitrequest
		input  wire        mm_master_bfm_m0_read,                               //                                              .read
		output wire [31:0] mm_master_bfm_m0_readdata,                           //                                              .readdata
		input  wire        mm_master_bfm_m0_write,                              //                                              .write
		input  wire [31:0] mm_master_bfm_m0_writedata,                          //                                              .writedata
		output wire [2:0]  ChromaProcessor_avalon_slave_address,                //                  ChromaProcessor_avalon_slave.address
		output wire        ChromaProcessor_avalon_slave_write,                  //                                              .write
		output wire        ChromaProcessor_avalon_slave_read,                   //                                              .read
		input  wire [31:0] ChromaProcessor_avalon_slave_readdata,               //                                              .readdata
		output wire [31:0] ChromaProcessor_avalon_slave_writedata,              //                                              .writedata
		output wire        ChromaProcessor_avalon_slave_chipselect              //                                              .chipselect
	);

	wire         mm_master_bfm_m0_translator_avalon_universal_master_0_waitrequest;   // ChromaProcessor_avalon_slave_translator:uav_waitrequest -> mm_master_bfm_m0_translator:uav_waitrequest
	wire  [31:0] mm_master_bfm_m0_translator_avalon_universal_master_0_readdata;      // ChromaProcessor_avalon_slave_translator:uav_readdata -> mm_master_bfm_m0_translator:uav_readdata
	wire         mm_master_bfm_m0_translator_avalon_universal_master_0_debugaccess;   // mm_master_bfm_m0_translator:uav_debugaccess -> ChromaProcessor_avalon_slave_translator:uav_debugaccess
	wire   [4:0] mm_master_bfm_m0_translator_avalon_universal_master_0_address;       // mm_master_bfm_m0_translator:uav_address -> ChromaProcessor_avalon_slave_translator:uav_address
	wire         mm_master_bfm_m0_translator_avalon_universal_master_0_read;          // mm_master_bfm_m0_translator:uav_read -> ChromaProcessor_avalon_slave_translator:uav_read
	wire   [3:0] mm_master_bfm_m0_translator_avalon_universal_master_0_byteenable;    // mm_master_bfm_m0_translator:uav_byteenable -> ChromaProcessor_avalon_slave_translator:uav_byteenable
	wire         mm_master_bfm_m0_translator_avalon_universal_master_0_readdatavalid; // ChromaProcessor_avalon_slave_translator:uav_readdatavalid -> mm_master_bfm_m0_translator:uav_readdatavalid
	wire         mm_master_bfm_m0_translator_avalon_universal_master_0_lock;          // mm_master_bfm_m0_translator:uav_lock -> ChromaProcessor_avalon_slave_translator:uav_lock
	wire         mm_master_bfm_m0_translator_avalon_universal_master_0_write;         // mm_master_bfm_m0_translator:uav_write -> ChromaProcessor_avalon_slave_translator:uav_write
	wire  [31:0] mm_master_bfm_m0_translator_avalon_universal_master_0_writedata;     // mm_master_bfm_m0_translator:uav_writedata -> ChromaProcessor_avalon_slave_translator:uav_writedata
	wire   [2:0] mm_master_bfm_m0_translator_avalon_universal_master_0_burstcount;    // mm_master_bfm_m0_translator:uav_burstcount -> ChromaProcessor_avalon_slave_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (3),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (5),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (0),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) mm_master_bfm_m0_translator (
		.clk                    (clk_50_clk_clk),                                                      //                       clk.clk
		.reset                  (mm_master_bfm_clk_reset_reset_bridge_in_reset_reset),                 //                     reset.reset
		.uav_address            (mm_master_bfm_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (mm_master_bfm_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (mm_master_bfm_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (mm_master_bfm_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (mm_master_bfm_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (mm_master_bfm_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (mm_master_bfm_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (mm_master_bfm_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (mm_master_bfm_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (mm_master_bfm_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (mm_master_bfm_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (mm_master_bfm_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (mm_master_bfm_m0_waitrequest),                                        //                          .waitrequest
		.av_read                (mm_master_bfm_m0_read),                                               //                          .read
		.av_readdata            (mm_master_bfm_m0_readdata),                                           //                          .readdata
		.av_write               (mm_master_bfm_m0_write),                                              //                          .write
		.av_writedata           (mm_master_bfm_m0_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                                //               (terminated)
		.av_byteenable          (4'b1111),                                                             //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                                //               (terminated)
		.av_begintransfer       (1'b0),                                                                //               (terminated)
		.av_chipselect          (1'b0),                                                                //               (terminated)
		.av_readdatavalid       (),                                                                    //               (terminated)
		.av_lock                (1'b0),                                                                //               (terminated)
		.av_debugaccess         (1'b0),                                                                //               (terminated)
		.uav_clken              (),                                                                    //               (terminated)
		.av_clken               (1'b1),                                                                //               (terminated)
		.uav_response           (2'b00),                                                               //               (terminated)
		.av_response            (),                                                                    //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                //               (terminated)
		.av_writeresponsevalid  ()                                                                     //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (3),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (5),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) chromaprocessor_avalon_slave_translator (
		.clk                    (clk_50_clk_clk),                                                      //                      clk.clk
		.reset                  (mm_master_bfm_clk_reset_reset_bridge_in_reset_reset),                 //                    reset.reset
		.uav_address            (mm_master_bfm_m0_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (mm_master_bfm_m0_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (mm_master_bfm_m0_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (mm_master_bfm_m0_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (mm_master_bfm_m0_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (mm_master_bfm_m0_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (mm_master_bfm_m0_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (mm_master_bfm_m0_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (mm_master_bfm_m0_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (mm_master_bfm_m0_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (mm_master_bfm_m0_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (ChromaProcessor_avalon_slave_address),                                //      avalon_anti_slave_0.address
		.av_write               (ChromaProcessor_avalon_slave_write),                                  //                         .write
		.av_read                (ChromaProcessor_avalon_slave_read),                                   //                         .read
		.av_readdata            (ChromaProcessor_avalon_slave_readdata),                               //                         .readdata
		.av_writedata           (ChromaProcessor_avalon_slave_writedata),                              //                         .writedata
		.av_chipselect          (ChromaProcessor_avalon_slave_chipselect),                             //                         .chipselect
		.av_begintransfer       (),                                                                    //              (terminated)
		.av_beginbursttransfer  (),                                                                    //              (terminated)
		.av_burstcount          (),                                                                    //              (terminated)
		.av_byteenable          (),                                                                    //              (terminated)
		.av_readdatavalid       (1'b0),                                                                //              (terminated)
		.av_waitrequest         (1'b0),                                                                //              (terminated)
		.av_writebyteenable     (),                                                                    //              (terminated)
		.av_lock                (),                                                                    //              (terminated)
		.av_clken               (),                                                                    //              (terminated)
		.uav_clken              (1'b0),                                                                //              (terminated)
		.av_debugaccess         (),                                                                    //              (terminated)
		.av_outputenable        (),                                                                    //              (terminated)
		.uav_response           (),                                                                    //              (terminated)
		.av_response            (2'b00),                                                               //              (terminated)
		.uav_writeresponsevalid (),                                                                    //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                 //              (terminated)
	);

endmodule
