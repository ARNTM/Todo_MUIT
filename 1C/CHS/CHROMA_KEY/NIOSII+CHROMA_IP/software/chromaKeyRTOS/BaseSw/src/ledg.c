/*

 * ledg.c
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */

#include "..\inc\ledg.h"

/*****************************************************************
 *                   FUNCIONES DE MANEJO DE LEDS
 ****************************************************************/

int ledg_ON (volatile int * ptr_led, int i)
{
	if ((i<0) & (i>8))
	{
		return 0;
	}
	else
	{
		*(ptr_led) |= (0x00 | (1 << i));	//switch on LED-i
		return 1;
	}
}

int ledg_OFF (volatile int * ptr_led, int i)
{
	if (( i<0) & (i>8))
	{
		return 0;
	}
	else
	{
		*(ptr_led) &= (0xFF) ^ (1 << i);	//switch off LED-i

		return 1;
	}
}

int blinky_ledg (volatile int * ptr_led, int i)
{

	if ((i<0) & (i>8))
		{
			return 0;
		}
		else
		{
			*(ptr_led) ^= (0x00 | (1 << i)); //switch LED-i
			return 1;
		}
}

void ledg_OFF_All ()
{
	int i;
	for (i=0; i<9; i++)
	{
	ledg_OFF(green_LED_ptr,i);
	}
}


void ledg_ON_All ()
{
	int i;
	for (i=0; i<9; i++)
	{
	ledg_ON(green_LED_ptr,i);
	}
}



