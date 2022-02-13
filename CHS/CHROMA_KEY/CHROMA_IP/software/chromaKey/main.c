#include "key_codes.h" 	// define los valores de KEY1, KEY2, KEY3
#include "system.h"
#include <stdio.h>
#include <stdint.h>
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "altera_up_avalon_video_character_buffer_with_dma.h"

/* funciones */
void LCD_cursor( int, int );
void LCD_text( char * );
void LCD_cursor_off( void );
void LCD_thresholds( void );
void MTL_text (int, int, char *);
void MTL_clean();
void MTL_scroll();
void MTL_box(int , int , int , int , short);
void readBMPFile(int);

/* interrupciones */
void pushbutton_ISR( );
void switches_ISR ( );

typedef unsigned int int32;
typedef short int16;
typedef unsigned char byte;

volatile int image = 1;

volatile int thG = 300;
volatile int upDown = 0;

int main(void)
{
	printf("Hola desde Nios II\n");
	volatile int * KEY_ptr = (int *) PUSHBUTTONS_BASE;	// Direcci�n pulsadores KEY
	volatile int * slider_switch_ptr = (int *) SWITCHES_BASE;	// Direcci�n switches
	volatile int * red_LED_ptr = (int *) RED_LEDS_BASE;
	volatile int * green_LED_ptr = (int *) GREEN_LEDS_BASE;

	// CHROMAPROCESSOR_BASE
	// Registro 0 para umbral del rojo thR
	// Registro 1 para umbral del azul thB
	// Registro 2 para controlar las se�ales que se envian a la MTL (camara, memoria o ambas)
	volatile int * chromaProcessor_ptr = (int *) CHROMAPROCESSOR_BASE;
	*(chromaProcessor_ptr) = thG;
	*(chromaProcessor_ptr + 3) = 3;
	// control = (int *) CHROMAPROCESSOR_BASE;

	//int counter = 0x2625a0*4;				// 1/(50 MHz) x (0x2625a0) = 200 msec
	//*(interval_timer_ptr + 0x1) = counter;
	//*(interval_timer_ptr + 0x3) = counter/2;

	/* comienza el timer y habilita las interrupciones */
	//*(interval_timer_ptr) = 0x1;	// START = 0x1

	//alt_irq_register(MYTIMER_0_IRQ, NULL, interval_timer_isr);

	*(KEY_ptr + 2) = 0xE; 		/* Mascara de los pulsadores (bit 0 es reset) */
	*(KEY_ptr + 3) = 0;
	alt_irq_register(PUSHBUTTONS_IRQ, NULL, pushbutton_ISR);

	*(slider_switch_ptr + 2) = 0xFF;
	alt_irq_register(SWITCHES_IRQ, NULL, switches_ISR);

	readBMPFile(0);

	// Muestra los valores de los umbrales del croma en la pantalla LCD


  	char first_row[40];
	sprintf(first_row, "  G   G-R   G-B ");
  	LCD_cursor (0,0);
	LCD_text (first_row);

	LCD_thresholds();

	while(1)
	{
		*(red_LED_ptr) = *(slider_switch_ptr);
		*(green_LED_ptr) = *(KEY_ptr);

	}
}

/****************************************************************************************
 * Subrutina para mover el cursor del LCD
****************************************************************************************/
void LCD_cursor(int x, int y)
{
  	volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;	// 16x2 character display
	char instruction;

	instruction = x;
	if (y != 0) instruction |= 0x40;			// activar el bit 6 para la fila inferior
	instruction |= 0x80;						// hay que activar el bit 7 para indicar el lugar
	*(LCD_display_ptr) = instruction;			// escribe registro de instrucciones del LCD
}

/****************************************************************************************
 * Subrutina para enviar una cadena de texto al LCD
****************************************************************************************/
void LCD_text(char * text_ptr)
{
  	volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;	// 16x2 character display

	while ( *(text_ptr) )
	{
		*(LCD_display_ptr + 1) = *(text_ptr);	// escribe los datos en el LCD
		++text_ptr;
	}
}

/****************************************************************************************
 * Subrutina para apagar el cursor del LCD
****************************************************************************************/
void LCD_cursor_off(void)
{
  	volatile char * LCD_display_ptr = (char *) CHAR_LCD_BASE;	// 16x2 character display
	*(LCD_display_ptr) = 0x0C;										// desactiva el curso del LCD
}

/****************************************************************************************
 * Subrutina para informar por el LCD sobre los valores de los umbrales
****************************************************************************************/
void LCD_thresholds(void)
{
  	char second_row[16];
	sprintf(second_row, " %d  %d   %d", thG, thG/2, thG/2);
	LCD_cursor (0,1);						// fija el cursor del LCD en la fila inferior
	LCD_text (second_row);
	LCD_cursor_off ();
}

/****************************************************************************************
 * Subrutina para enviar una cadena de texto a la pantalla MTL
****************************************************************************************/
void MTL_text(int x, int y, char * text_ptr)
{
	int offset;
  	volatile char * character_buffer = (char *)  MTL_CHAR_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE;	// MTL character buffer

  	/* asume que la cadena de texto comienza en la primera fila */
	offset = (y << 6) + x;
	while ( *(text_ptr) )
	{
		*(character_buffer + offset) = *(text_ptr);	// escribe en el buffer
		++text_ptr;
		++offset;
	}
}

/****************************************************************************************
 * Subrutina para leer buffer
****************************************************************************************/
void MTL_scroll()
{
	int offset_new;
	int offset_old;
	volatile char * character_buffer = (char *)  MTL_CHAR_BUFFER_AVALON_CHAR_BUFFER_SLAVE_BASE;	// MTL character buffer

	for(int y = 1; y <= 30 ; y++){
		for(int x = 0 ; x < 50 ; x++){
			offset_old = (y << 6) + x;
			offset_new = ((y-2) << 6) + x;
			*(character_buffer + offset_new) = *(character_buffer + offset_old);
		}
	}
}

/****************************************************************************************
 * Subrutina para limpiar pantalla
****************************************************************************************/
void MTL_clean()
{
	alt_up_char_buffer_dev *char_buffer_dev = alt_up_char_buffer_open_dev ("/dev/mtl_char_buffer");
	alt_up_pixel_buffer_dma_dev* pixel_buffer_dev_MTL = alt_up_pixel_buffer_dma_open_dev("/dev/mtl_pixel_buffer_dma");
	alt_up_char_buffer_clear(char_buffer_dev);
	alt_up_pixel_buffer_dma_clear_screen(pixel_buffer_dev_MTL,0);
}

/****************************************************************************************
 * Dibujar un rectangulo en la pantalla MTL
****************************************************************************************/
void MTL_box(int x1, int y1, int x2, int y2, short pixel_color)
{
	int offset, row, col;
	int SRAM_BASE_SIN_CACHE = (SRAM_BASE + 0x080000000);  //Activando el bit m�s significativo se elude la cache de datos
  	volatile short * pixel_buffer = (short *) SRAM_BASE_SIN_CACHE;	// MTL pixel buffer

  	/* se asume que las coordenadas del rectangulo son correctas */
	for (row = y1; row <= y2; row++)
	{
		col = x1;
		while (col <= x2)
		{
			offset = (row << 9) + col;
			*(pixel_buffer + offset) = pixel_color;	//procesa mitad direcciones
			++col;
		}
	}
}

