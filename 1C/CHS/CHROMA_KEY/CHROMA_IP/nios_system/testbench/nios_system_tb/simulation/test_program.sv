`timescale 1 ns / 1 ps


// console messaging level
`define VERBOSITY VERBOSITY_INFO


//BFM jerarquía
`define CLK tb.nios_system_inst_clk_50_in_bfm_clk_clk
`define RST tb.nios_system_inst_reset_bfm_reset_reset
`define BFM tb.nios_system_inst.mm_master_bfm
`define BFM_st_source_back_tb tb.nios_system_inst.st_source_bfm_background
`define BFM_st_source_fore_tb tb.nios_system_inst.st_source_bfm_foreground
`define BFM_st_sink tb.nios_system_inst.st_sink_bfm

`define AV_ADDRESS_W      3
`define AV_DATA_W         32

module test_program();

import avalon_mm_pkg::*;
import verbosity_pkg::*;

reg [`AV_DATA_W-1:0] datos_out;


initial
  begin
    set_verbosity(`VERBOSITY);
    `BFM.init();
    `BFM_st_source_back_tb.init();
    
    // Espera hasta que el reset esté inactivo
    wait(`RST == 1);
    #100
    // Escritura en registro 0 para conectar video e imagen
    avalon_write (3'h3,32'h3);
	repeat (5) @(posedge `CLK);
	// Escritura en registro 0 para conectar sólo vídeo
    avalon_write (3'h3,32'h1);
	repeat (5) @(posedge `CLK);
	// Escritura en registro 0 para conectar sólo imagen
    avalon_write (3'h3,32'h2);
	repeat (5) @(posedge `CLK);
	// Escritura en registro 0 para no conectar vídeo e imagen
    avalon_write (3'h3,32'h0);
	repeat (5) @(posedge `CLK);
	// Escritura en registro 3 para marcar el umbral en 300
	avalon_write (3'h0,32'h12C);
    repeat (5) @(posedge `CLK);
    $display("Operacion Escritura acabada");
    
    //repeat (5) @(posedge `CLK);
     
    // Lee dato del esclavo y comprueba si es correcto
    avalon_read (3'h2,datos_out);
    
    $display("Datos leidos del IP: %h",datos_out);
	
	repeat (160) @(posedge `CLK);
    //ST_write(3'h0,32'hFFF);	
    repeat (1) @(posedge `CLK);
	
    $stop();
    
  end
    
    // ============================================================
    // Tasks
    // ============================================================
    //
    // Avalon-MM single-transaction read and write procedures.
    //
    // ------------------------------------------------------------
    task avalon_write (
    // ------------------------------------------------------------

        input [`AV_ADDRESS_W-1:0] addr,
        input [`AV_DATA_W-1:0] data
    );
    begin
        // Construct the BFM request
        `BFM.set_command_request(REQ_WRITE);
        `BFM.set_command_idle(0, 0);
        `BFM.set_command_init_latency(0);
        `BFM.set_command_address(addr);    
        `BFM.set_command_byte_enable('1,0);
        `BFM.set_command_data(data, 0);      
        `BFM.set_command_burst_count(1);
        `BFM.set_command_burst_size(1);
        // Queue the command
        `BFM.push_command();
        
        // Wait until the transaction has completed
        while (`BFM.get_response_queue_size() != 1)
            @(posedge `CLK);

        // Dequeue the response and discard
        `BFM.pop_response();
    end
    endtask
            
            
            
    // ------------------------------------------------------------
    task avalon_read (
    // ------------------------------------------------------------
        input [`AV_ADDRESS_W-1:0] addr,
        output [`AV_DATA_W-1:0] data
    );
    begin
       // Construct the BFM request
      `BFM.set_command_request(REQ_READ);
      `BFM.set_command_idle(0, 0);
      `BFM.set_command_init_latency(0);
      `BFM.set_command_address(addr);    
      `BFM.set_command_byte_enable('1,0);
      `BFM.set_command_data(0, 0);      
      `BFM.set_command_burst_count(1);
      `BFM.set_command_burst_size(1);
        
      // Queue the command
      `BFM.push_command();
        
        // Wait until the transaction has completed
        while (`BFM.get_response_queue_size() != 1)
            @(posedge `CLK);

        // Dequeue the response and return the data
        `BFM.pop_response();
        data = `BFM.get_response_data(0);        
    end
    endtask
    
        // ------------------------------------------------------------
    /*task ST_write (
    // ------------------------------------------------------------
        input [`AV_ADDRESS_W-1:0] addr,
        output [`AV_DATA_W-1:0] data
    );
    begin

       // Construct the BFM request
      `BFM_st_source_back_tb.set_transaction_data(REQ_READ);
	  `BFM_st_source_back_tb.set_transaction_sop(bit sop);
      `BFM.set_command_request(REQ_READ);
	  `BFM.set_src_request();
      `BFM.set_transaction_idles(bit[31:0] idle_cycles);
      `BFM.set_transaction_empty(STEmpty_t empty);
      `BFM.set_command_address(addr);    
      `BFM.set_command_byte_enable('1,0);
      `BFM.set_command_data(0, 0);      
      `BFM.set_command_burst_count(1);
      `BFM.set_command_burst_size(1);
    
      // Queue the command
      `BFM.push_command();
        
        // Wait until the transaction has completed
        while (`BFM_st_source_back_tb.get_response_queue_size() != 1)
            @(posedge `CLK);

        // Dequeue the response and return the data
        `BFM.pop_response();
        data = `BFM_st_source_back_tb.get_response_data(0);        
    end
    endtask*/

    // ------------------------------------------------------------
    /*task ST_read (
    // ------------------------------------------------------------
        input [`AV_ADDRESS_W-1:0] addr,
        output [`AV_DATA_W-1:0] data
    );
    begin
       // Construct the BFM request
      `BFM.set_command_request(REQ_READ);
      `BFM.set_command_idle(0, 0);
      `BFM.set_command_init_latency(0);
      `BFM.set_command_address(addr);    
      `BFM.set_command_byte_enable('1,0);
      `BFM.set_command_data(0, 0);      
      `BFM.set_command_burst_count(1);
      `BFM.set_command_burst_size(1);
        
      // Queue the command
      `BFM.push_command();
        
        // Wait until the transaction has completed
        while (`BFM.get_response_queue_size() != 1)
            @(posedge `CLK);

        // Dequeue the response and return the data
        `BFM.pop_response();
        data = `BFM.get_response_data(0);        
    end
    endtask*/
    
endmodule
