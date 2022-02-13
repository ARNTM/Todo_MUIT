
/* *******************************************
 * CHS EJERCICIO 1 RTOS
 * Profesor: Marcos Martinez Peiro
 * mpeiro@eln.upv.es
 * *******************************************/


#include "Chs_Comm.h"




/* The main function creates a single task and starts multi-tasking */
int main(void)
{

	Init_App();

	CreateTasks();

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
