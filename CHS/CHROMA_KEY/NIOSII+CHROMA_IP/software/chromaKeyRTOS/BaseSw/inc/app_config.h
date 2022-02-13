/*
 * app_config.h
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */

#ifndef BASESW_CONFIG_APP_CONFIG_H_
#define BASESW_CONFIG_APP_CONFIG_H_

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/
#include <stdio.h>
#include "includes.h"
#include "isr.h"
#include "MTL.h"
#include "lcd.h"
#include "isr.h"
#include "ledg.h"
#include "task_config.h"
#include "alt_ucosii_simple_error_check.h"
#include "functions.h"


/******************************************************************************/
/*-----------------------------------Macros-----------------------------------*/
/******************************************************************************/




/******************************************************************************/
/*--------------------------------Enumerations--------------------------------*/
/******************************************************************************/




/******************************************************************************/
/*-----------------------------Data Structures--------------------------------*/
/******************************************************************************/





/******************************************************************************/
/*------------------------------Global variables------------------------------*/
/******************************************************************************/


extern volatile int * red_LED_ptr;
extern volatile int * green_LED_ptr;
extern volatile int * HEX3_HEX0_ptr;
extern volatile int * HEX7_HEX4_ptr;
extern volatile int * KEY_ptr;
extern volatile int * SW_switch_ptr;
extern volatile char * LCD_display_ptr;
extern volatile short * pixel_buffer;
extern volatile char * character_buffer;
extern volatile int * chromaProcessor_ptr;

extern volatile int image;
extern volatile int thG;
extern volatile int upDown;




/******************************************************************************/
/*-------------------------Function Prototypes--------------------------------*/
/******************************************************************************/
extern void Init_App(void);



#endif /* APPSW_CONFIG_APP_CONFIG_H_ */