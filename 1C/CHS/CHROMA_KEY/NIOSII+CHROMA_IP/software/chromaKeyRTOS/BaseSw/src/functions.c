/*
 * functions.c
 *
 *  Created on: 10 de feb. de 2022
 *      Author: aruznie
 */

#include "..\inc\functions.h"

void readBMPFile(int x)
{
	FILE *fp;
	int offset, row, col;
	int SRAM_BASE_SIN_CACHE = (SRAM_BASE + 0x0100000 + 0x080000000);  //Activando el bit m�s significativo se elude la cache de datos
  	volatile short * pixel_buffer = (short *) SRAM_BASE_SIN_CACHE;	// MTL pixel buffer
  	char file[22];

  	sprintf(file, "/mnt/rozipfs/imagen0%d.bmp", x);
  	fp = fopen(file, "rb");
  	if (fp == (FILE *)0){
  	   printf("File opening error ocurred. Exiting program.\n");
  	}
  	for(int i=0;i<54;i++) getc(fp);  // strip out BMP header
  	for (row = 239; row >= 0; row--) {
  		for (col = 0; col <= 399; col++) {
  			offset = (row << 9) + col;
  			int r = getc(fp) >> 3;
  			int g = getc(fp) >> 2;
  			int b = getc(fp) >> 3;
  			*(pixel_buffer + offset) = (b << 11 | g << 5 | r);	//procesa mitad direcciones
  		}
  	}

  	fclose(fp);

}