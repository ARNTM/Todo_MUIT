/*
 * lcd.c
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */


#include "..\inc\lcd.h"

/*****************************************************************
 *					  FUNCIONES LCD                              *
 * ***************************************************************/

/**
 * Subrutina para mover Cursor del LCD en DE2-115
 */
void LCD_cursor (int x, int y)
{
//	volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;
	char instruccion;
	instruccion =x;
	if (y!=0)instruccion |= 0x40;
	instruccion |= 0x80;
	*(LCD_display_ptr)=instruccion;
}

/**
 * Subrutina para enviar cadena texto a LCD
 */

void LCD_text (char *text_ptr)
{
//	volatile char *LCD_display_ptr =(char *)CHAR_LCD_BASE;
	while (*(text_ptr))
	{
		*(LCD_display_ptr+1)=*(text_ptr);
		++text_ptr;
	}
}

/**
 * Subrutina para apagar el cursor del LCD
 */

void LCD_cursor_off (void)
{
//	volatile char *LCD_display_ptr =(char *)CHAR_LCD_BASE;
	*(LCD_display_ptr)=0x0C;
}

void LCD_thresholds(void)
{
  	char second_row[16];
	sprintf(second_row, " %d  %d   %d", thG, thG/2, thG/2);
	LCD_cursor (0,1);						// fija el cursor del LCD en la fila inferior
	LCD_text (second_row);
	LCD_cursor_off ();
}


