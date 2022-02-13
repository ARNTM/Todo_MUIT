/*
 * isr.c
 *
 *  Created on: 17 de nov. de 2020
 *      Author: mpeir
 */

#include "..\inc\isr.h"

/**
 * Subrutina de manejo de interrupcion por pulsador incrustada en uCOS
 */

extern volatile int upDown;
extern volatile int thG;
extern volatile int image;

void pushbutton_isr() {
OSIntEnter();
	int KEY_value;

	*(green_LED_ptr) = *(KEY_ptr);

	KEY_value = *(KEY_ptr + 3);		// Leemos registro de pulsadores

	*(KEY_ptr + 3) = 0;				// Borrar la interrupcion

	if (KEY_value & 0x4)// KEY2 ajusta el valor del umbral de diferencia GREEN - RED
		{
			// printf("KEY2");
			if (upDown) {
				thG = thG + 5;
			}
			else {
				thG = thG - 5;
			}

			if (thG > 800){
				thG = 300;
			}
			if (thG < 300) {
				thG = 800;
			}
			*(chromaProcessor_ptr) = thG;
			//printf("G - R: %d\n", *(chromaProcessor_ptr));
		}
	else if (KEY_value & 0x8){
		readBMPFile(image);
		image++;
		if(image == 4) {
			image = 0;
		}
	}
	LCD_thresholds();

OSIntExit();
}


void switches_isr() {
	OSIntEnter();
		int SW_value;
		*(red_LED_ptr) = *(SW_switch_ptr);
		SW_value = *(SW_switch_ptr + 3);	// Leemos registro de Switches

		*(SW_switch_ptr + 3) = 0;

		//printf("%d", SW_value);
		switch(SW_value) {
		case 1:
			//printf("Video Enabled\n");
			*(chromaProcessor_ptr + 3) = *(SW_switch_ptr);
			break;
		case 2:
			//printf("Image Enabled\n");
			*(chromaProcessor_ptr + 3) = *(SW_switch_ptr);
			break;
		case 4:
			if(upDown == 0) {
				upDown = 1;
			}
			else {
				upDown = 0;
			}
			//printf("UpDown: %d\n", upDown);
			break;
		default:
			//printf("Ninguna funci�n asignada\n");
			break;
		}
		OSIntExit();
}



