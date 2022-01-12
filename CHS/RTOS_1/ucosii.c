/* *******************************************
 * CHS EJERCICIO 1 RTOS
 * Profesor: Marcos Martinez Peiro
 * mpeiro@eln.upv.es
 * *******************************************/

// Opcion de eliminar los printf por JTAG
#define PRINT


#include <stdio.h>
#include "includes.h"


/*
 * Punteros de perifericos
 */

 volatile int * red_LED_ptr = (int *) RED_LEDS_BASE;
 volatile int * green_LED_ptr = (int *) GREEN_LEDS_BASE;
 volatile int * HEX3_HEX0_ptr= (int *) HEX3_HEX0_BASE;
 volatile int * HEX7_HEX4_ptr= (int *) HEX7_HEX4_BASE;
 volatile int * KEY_ptr = (int *) PUSHBUTTONS_BASE;
 volatile int * SW_switch_ptr = (int *) SWITCHES_BASE;



/*
 * Declaracion de Funciones
 */

// Funciones MTL
void MTL_box (int, int, int, int, short);
void MTL_text (int, int, char *);
void borra_lineas_pantalla(int inicio, int lineas);

// Funciones para LCD
void LCD_cursor(int, int);
void LCD_text(char *);
void LCD_cursor_off (void);

// INTERRUPCIONES
void pushbutton_isr();

/*
 * Constantes Globales
 */

 int linea=3;
 int primera_linea=3, ultima_linea=30;
 int HEX_Bits = 0x0000000F;
 int SW_Value, KEY_Value;


 //TEXTO MARGENES PANTALLA MTL
char texto_up[50] = 	"Funcionamiento de RTOS sobre MTL - CHS 2021/22";
char texto_down[50] = 	"uCOS-II sobre NIOS-II, Cyclone IV, CHS 2021/22";
// TEXTO LCD
char text_top_row[20] =		" Intel DE2 RTOS \0";
char text_bottom_row[20]=	"  USA MASCARA!!  \0";




/*****************************************************************
 *					  FUNCIONES MTL                              *
 * ***************************************************************/

/*
 * Funcion para crear recuadros en la pantalla MTL
 */
void MTL_box(int x1, int y1, int x2, int y2, short pixel_color)
{
	int offset, row, col;
  	volatile short * pixel_buffer = (short *) SRAM_BASE;	// MTL pixel buffer

	for (row = y1; row <= y2; row++)
	{
		col = x1;
		while (col <= x2)
		{
			offset = (row << 9) + col;
			*(pixel_buffer + offset) = pixel_color;
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
  	volatile char * character_buffer = (char *)  MTL_CHAR_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE;	// MTL character buffer

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

/*****************************************************************
 *                   FUNCIONES DE MANEJO DE LEDS
 ****************************************************************/

int ledg_ON (volatile int * ptr_led, int i)
{
	if ((i<0) & (i>7))
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
	if (( i<0) & (i>7))
	{
		return 0;
	}
	else
	{
		*(ptr_led) &= (0xFF) ^ (1 << i);	//switch off LED-i
//		*(ptr_led) |= (0xFF & (0 << i));
		return 1;
	}
}

int blinky_ledg (volatile int * ptr_led, int i)
{

	if ((i<0) & (i>7))
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
	for (i=0; i<8; i++)
	{
	ledg_OFF(green_LED_ptr,i);
	}
}


/*****************************************************************
 *					  FUNCIONES LCD                              *
 * ***************************************************************/

/**
 * Subrutina para mover Cursor del LCD en DE2-115
 */
void LCD_cursor (int x, int y)
{
	volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;
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
	volatile char *LCD_display_ptr =(char *)CHAR_LCD_BASE;
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
	volatile char *LCD_display_ptr =(char *)CHAR_LCD_BASE;
	*(LCD_display_ptr)=0x0C;
}

/**
 * Subrutina de manejo de interrupcion por pulsador incrustada en uCOS
 */
void pushbutton_isr() {
	OSIntEnter();
		int KEY_value, SW_value;
		static int num_int=0; 			// static permite que el valor no se inicia a 0 cada vez que se entra en la int
		char vector[27];

		KEY_value = *(KEY_ptr + 3);		// Leemos registro de pulsadores
		SW_value = *(SW_switch_ptr);	// Leemos registro de Switches
		SW_value = SW_value & 1;

		*(KEY_ptr + 3) = 0;				// Borrar la interrupcion

		if (KEY_value == 0x2) {			// Texto de Atencion Interrupcion y contador de veces
			borra_lineas_pantalla(1,30);
			if (num_int<100)
				{
				++num_int;
				sprintf(vector,"Interrupcion Activada= %02u",num_int);
				MTL_text (21,2, vector);
	#ifdef PRINT
				printf("numero de interrupcion = %02u\n",num_int);
	#endif
				linea=3;
				}
			else
				{
				num_int=0;
				sprintf(vector,"Interrupcion LIMITE= %02u",num_int);
				MTL_text (21,2, vector);
	#ifdef PRINT
				printf("ALCANZADO LIMITE DE INTERRUPCIONES = %02u\n",num_int);
	#endif
				linea=3;
				}

		KEY_value=0;
		}
	OSIntExit();
}

/* _____________PROGRAMA DE PRACTICAS DE RTOS DE LA ASIGNATURA CHS. MASTER MUIT._____________ */

/* Definition of Task Stacks */
#define   TASK_STACKSIZE       2048
OS_STK    task1_stk[TASK_STACKSIZE];
OS_STK    task2_stk[TASK_STACKSIZE];
OS_STK    task3_stk[TASK_STACKSIZE];
OS_STK    task4_stk[TASK_STACKSIZE];

/* Definition of Task Priorities */

#define TASK1_PRIORITY      1
#define TASK2_PRIORITY      2
#define TASK3_PRIORITY      3
#define TASK4_PRIORITY      4

/* Prints "Hello World" and sleeps for x seconds */
void task1(void* pdata)
{
	char visualiza_string[40] = "Hello from task1";
	static int posicion=0;
  while (1)
  {
	ledg_ON (green_LED_ptr, 0);
#ifdef PRINT
    printf("%s\n",visualiza_string);
#endif
    posicion=(linea>ultima_linea)?primera_linea:linea++;
    if (linea>ultima_linea){linea=primera_linea;}
    MTL_text (2, posicion, visualiza_string);
    borra_lineas_pantalla(posicion+1,posicion+2);
    ledg_OFF (green_LED_ptr, 0);

    OSTimeDlyHMSM(0, 0, 0, 500);
  }
}
/* Prints "Hello World" and sleeps for x seconds */
void task2(void* pdata)
{
	char visualiza_string[40] = "Hello from task2";
	int posicion;
  while (1)
  {
	ledg_ON(green_LED_ptr,1);

#ifdef PRINT
    printf("%s\n",visualiza_string);
#endif
    posicion=(linea>ultima_linea)?primera_linea:linea++;
    if (linea>ultima_linea){linea=primera_linea;}
    MTL_text (2, posicion, visualiza_string);
    borra_lineas_pantalla(posicion+1,posicion+2);

    ledg_OFF(green_LED_ptr,1);

    OSTimeDlyHMSM(0, 0, 1, 500);
  }
}

/* Prints "Hello World" and sleeps for x seconds */
void task3(void* pdata)
{
	char visualiza_string[40] = "Hello from task3 2s";
	char visualiza_string1[40] = "Hasta luego!";
	int posicion;
  while (1)
  {
	blinky_ledg(green_LED_ptr,2);

#ifdef PRINT
    printf("%s\n",visualiza_string);
#endif
    posicion=(linea>ultima_linea)?primera_linea:linea++;
    if (linea>ultima_linea){linea=primera_linea;}
    MTL_text (2, posicion, visualiza_string);
    borra_lineas_pantalla(posicion+1,posicion+2);

    OSTaskChangePrio(TASK1_PRIORITY,8);

    //OSTaskSuspend(OS_PRIO_SELF); // Ejercicio 6

    if(OSTaskDelReq(OS_PRIO_SELF) == OS_ERR_TASK_DEL_REQ) {
    	posicion=(linea>ultima_linea)?primera_linea:linea++;
		if (linea>ultima_linea){linea=primera_linea;}
		MTL_text (2, posicion, visualiza_string1);
		borra_lineas_pantalla(posicion+1,posicion+2);
    	OSTaskDel(OS_PRIO_SELF);
    }

    OSTimeDlyHMSM(0, 0, 0, 500);
    //OSTaskSuspend(TASK2_PRIORITY);
  }
}

/* Prints "Hello from Recovery" and sleeps for x seconds */
void task4(void* pdata)
{
	char visualiza_string[40] = "Hello from Recovery";
	int posicion;
	INT8U err;
  while (1)
  {
	blinky_ledg(green_LED_ptr,3);

#ifdef PRINT
    printf("%s\n",visualiza_string);
#endif
    posicion=(linea>ultima_linea)?primera_linea:linea++;
    if (linea>ultima_linea){linea=primera_linea;}
    MTL_text (2, posicion, visualiza_string);
    borra_lineas_pantalla(posicion+1,posicion+2);

    OSTaskResume(TASK2_PRIORITY);

    //OSTimeDlyResume(TASK3_PRIORITY);
    //OSTimeDlyResume(TASK2_PRIORITY);
    //OSTimeDlyResume(TASK1_PRIORITY);
    // OSTaskDel(TASK3_PRIORITY);
    err = OSTaskDelReq(TASK3_PRIORITY);
    if (err == OS_ERR_NONE) {
    	while (err != OS_ERR_TASK_NOT_EXIST) {
    		err = OSTaskDelReq(TASK3_PRIORITY);
    		OSTimeDly(1);
    	}
    }
    OSTimeDlyHMSM(0, 0, 7, 0);
  }
}







/* The main function creates the tasks and starts multi-tasking */
int main(void)
{
	borra_lineas_pantalla(1,32);

//Crea el texto en la pantalla
	MTL_text (2, 0, texto_up);		// primera linea

//Pintar en la pantalla cuadros
	MTL_box (0, 0, 400, 240, 0x1111);	 	//Pinta de azul toda la pantalla
	MTL_box (0, 0, 400, 8, 0x01100);  		//Franja superior
	MTL_box (155, 30, 395, 235, 0x0100);	//cuadro para mensajes

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

// Creacion de Tareas

  OSTaskCreateExt(task1,
                  NULL,
                  (void *)&task1_stk[TASK_STACKSIZE-1],
                  TASK1_PRIORITY,
                  TASK1_PRIORITY,
                  task1_stk,
                  TASK_STACKSIZE,
                  NULL,
                  0);


  OSTaskCreateExt(task2,
                  NULL,
                  (void *)&task2_stk[TASK_STACKSIZE-1],
                  TASK2_PRIORITY,
                  TASK2_PRIORITY,
                  task2_stk,
                  TASK_STACKSIZE,
                  NULL,
                  0);

  OSTaskCreateExt(task3,
                  NULL,
                  (void *)&task3_stk[TASK_STACKSIZE-1],
                  TASK3_PRIORITY,
                  TASK3_PRIORITY,
                  task3_stk,
                  TASK_STACKSIZE,
                  NULL,
                  0);

  OSTaskCreateExt(task4,
                  NULL,
                  (void *)&task4_stk[TASK_STACKSIZE-1],
                  TASK4_PRIORITY,
                  TASK4_PRIORITY,
                  task4_stk,
                  TASK_STACKSIZE,
                  NULL,
                  0);


  OSStart();
  return 0;
}



/******************************************************************************
*                                                                             *
* MIEMBROS DEL GRUPO:                                                         *
*                                                                             *
*                                                                             *
*                                                                             *
* 																			  *
******************************************************************************/