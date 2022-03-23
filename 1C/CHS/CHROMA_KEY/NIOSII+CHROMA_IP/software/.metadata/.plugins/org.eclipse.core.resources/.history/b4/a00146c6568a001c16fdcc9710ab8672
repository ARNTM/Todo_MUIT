/*
 * app_config.c
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */


#include "..\inc\app_config.h"


volatile int * red_LED_ptr = (int *) RED_LEDS_BASE;
volatile int * green_LED_ptr = (int *) GREEN_LEDS_BASE;
volatile int * HEX3_HEX0_ptr= (int *) HEX3_HEX0_BASE;
volatile int * HEX7_HEX4_ptr= (int *) HEX7_HEX4_BASE;
volatile int * KEY_ptr = (int *) PUSHBUTTONS_BASE;
volatile int * SW_switch_ptr = (int *) SWITCHES_BASE;
volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;
volatile short * pixel_buffer= (short *) SRAM_BASE;	// MTL pixel buffer
volatile char * character_buffer= (char *)  MTL_CHAR_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE; // MTL character buffer




// inicializacion de la aplicacion
void Init_App(void)
{
	borra_lineas_pantalla(1,32);


//	char texto_up[100] = "Comunicaciones de RTOS sobre MTL - CHS";


//Crea el texto en la pantalla
	MTL_text (2, 0, texto_up);		// primera linea

//Pintar en la pantalla cuadros
	MTL_box (0, 0, 400, 240, 0x1111);	 	//Pinta de azul toda la pantalla
	MTL_box (0, 0, 400, 8, 0x01100);  		//Franja superior
//	MTL_box (155, 30, 395, 235, 0x0100);	//cuadro para mensajes

// Texto LCD
	LCD_cursor (0,0);
	LCD_text (text_top_row);
	LCD_cursor (0,1);
	LCD_text (text_bottom_row);
	LCD_cursor_off();

// Interrupcion pulsador para los pulsadores
	*(KEY_ptr + 2) = 0xE;
	*(KEY_ptr + 3) = 0;
	alt_irq_register(PUSHBUTTONS_IRQ, NULL, pushbutton_isr);

// LEDGs apagados
	ledg_OFF_All();
}
