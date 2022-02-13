/*

 * MTL.c
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */


#include "..\inc\MTL.h"



int linea=3;
int primera_linea=3, ultima_linea=30;

 //TEXTO MARGENES PANTALLA MTL
char texto_up[50] = 	"Comunicacion de tareas sobre MTL - CHS 2020/21";
char texto_down[50] = 	"uCOS-II sobre NIOS-II, Cyclone IV, CHS 2020/21";



/*****************************************************************
 *					  FUNCIONES MTL                              *
 * ***************************************************************/



/*
 * Funcion para crear recuadros en la pantalla MTL
 */
void MTL_box(int x1, int y1, int x2, int y2, short pixel_color)
{
	int offset, row, col;


	for (row = y1; row <= y2; row++)
	{
		col = x1;
		while (col <= x2)
		{
			offset = (row << 9) + col;
		* (pixel_buffer + offset) = pixel_color;
			++col;
		}
	}
}

/**
 * Funcion para mostrar texto por la pantalla MTL
 */
void MTL_text(int x, int y, char * text_ptr)
{
	int offset;

  	offset = (y << 6) + x;
  	while ( *(text_ptr) )
  	{
  		*(character_buffer + offset) = *(text_ptr);
  		++text_ptr;
  		++offset;
  	}

}

/**
 *  Funcion para borrar lineas de MTL
 */
void borra_lineas_pantalla(int inicio, int lineas)
{
	int i;
	char blank[50]="                                                  ";
	// borra pantalla desde inicio a lineas
		for (i=inicio;i<lineas;i++){
			MTL_text(0,i,blank);
		}

}



