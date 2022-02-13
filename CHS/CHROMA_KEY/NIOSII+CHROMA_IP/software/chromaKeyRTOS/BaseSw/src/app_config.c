/*
 * app_config.c
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */


#include "..\inc\app_config.h"


volatile int * red_LED_ptr = (int *) RED_LEDS_BASE;
volatile int * green_LED_ptr = (int *) GREEN_LEDS_BASE;
volatile int * KEY_ptr = (int *) PUSHBUTTONS_BASE;
volatile int * SW_switch_ptr = (int *) SWITCHES_BASE;
volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;
volatile short * pixel_buffer= (short *) SRAM_BASE;	// MTL pixel buffer
volatile char * character_buffer= (char *)  MTL_CHAR_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE; // MTL character buffer
volatile int * chromaProcessor_ptr = (int *) CHROMAPROCESSOR_BASE;

volatile int image = 1;
volatile int thG = 300;
volatile int upDown = 0;

// inicializacion de la aplicacion
void Init_App(void)
{
	*(chromaProcessor_ptr) = thG;
	*(chromaProcessor_ptr + 3) = 3;

	*(KEY_ptr + 2) = 0xE;
	*(KEY_ptr + 3) = 0;
	alt_irq_register(PUSHBUTTONS_IRQ, NULL, pushbutton_isr);

	*(SW_switch_ptr + 2) = 0xFF;
	alt_irq_register(SWITCHES_IRQ, NULL, switches_isr);

	readBMPFile(0);

  	char first_row[40];
	sprintf(first_row, "  G   G-R   G-B ");
  	LCD_cursor (0,0);
	LCD_text (first_row);

	LCD_thresholds();
}