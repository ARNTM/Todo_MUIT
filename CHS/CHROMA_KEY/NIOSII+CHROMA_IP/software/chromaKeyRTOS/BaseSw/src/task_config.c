/*
 * task_config.c
 *
 *  Created on: 16 de nov. de 2020
 *      Author: mpeir
 */

#include "..\inc\task_config.h"

/* variable globales de uso exclusivo en este fichero, por ello no se incluyen en task_config.h */

INT32U number_of_messages_sent = 0;
INT32U number_of_messages_received_task1 = 0;
INT32U number_of_messages_received_task2 = 0;
INT32U getsem_task1_got_sem = 0;
INT32U getsem_task2_got_sem = 0;
INT32U getsem_task3_got_sem = 0;
INT32U getsem_task4_got_sem = 0;
INT32U getmutex_task1_got_sem=0;
INT32U getmutex_task2_got_sem=0;
INT8U highest;
char sem_owner_task_name[20];


// tarea de lectura de los switches
void read_switches() {
	int SW_value;
	INT8U Error=OS_NO_ERR;
	OS_FLAGS return_code;
	while(1){
	SW_value = *(SW_switch_ptr + 3);

	switch (SW_value){
	case (0x01):{*(chromaProcessor_ptr + 3) = *(SW_switch_ptr);}
	break;
	case (0x02):{*(chromaProcessor_ptr + 3) = *(SW_switch_ptr);}
	break;
	case (0x04):{if(upDown) {upDown = 0;}else {upDown = 1;}}
	break;

	alt_ucosii_check_return_code(Error);

	OSTimeDlyHMSM(0,0,0,300);
	}
}
}

// tarea de lectura de los pushbuttons
void read_pushbuttons() {
	int KEY_value;
	INT8U Error=OS_NO_ERR;
	OS_FLAGS return_code;

	while(1){
	KEY_value = *(KEY_ptr + 3);

	switch (KEY_value){
	case (0x08):{
		readBMPFile(image);
		image++;
		if(image == 4) {
			image = 0;
		}
	}
	break;
	case (0x04):{
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
	}
	break;

	alt_ucosii_check_return_code(Error);

	OSTimeDlyHMSM(0,0,0,300);
	}
}
}

int initOSDataStructs(void)
{
  INT8U	ErrorMutex=OS_NO_ERR;
  INT8U ErrorFlags=OS_NO_ERR;
  msgqueue = OSQCreate(&msgqueueTbl[0], MSG_QUEUE_SIZE);
  shared_resource_sem = OSSemCreate(3); //se crea semaforo de nivel 3
  PunteroMutex=OSMutexCreate(PIP_PRIORITY_INHERITANCE,&ErrorMutex); //Mejor prioridad que todos (4)
  alt_ucosii_check_return_code(ErrorMutex);
  EstadoMotor=OSFlagCreate(0x00, &ErrorFlags);
  alt_ucosii_check_return_code(ErrorFlags);
  return 0;
}

void TaskInit(void* pdata)
{
	 INT8U return_code = OS_NO_ERR;
  while (1)
  {
		ledg_OFF_All();
		blinky_ledg(green_LED_ptr,8);
		OSSchedLock();	 /* entramos en seccion critica*/
		OSSchedUnlock(); /* salimos SC */

	    /*create os data structures */
	    initOSDataStructs();

	    /* create the tasks */
	    initCreateTasks();

	    /*This task is deleted because there is no need for it to run again */
	    return_code = OSTaskDel(OS_PRIO_SELF);
	    alt_ucosii_check_return_code(return_code);

  }
}

void CreateTasks (void)
{
	INT8U return_code = OS_NO_ERR;

	 return_code= OSTaskCreateExt(TaskInit,
	                  NULL,
	                  (void *)&initialize_task_stk[TASK_STACKSIZE-1],
					  INITIALIZE_TASK_PRIORITY,
					  INITIALIZE_TASK_PRIORITY,
					  initialize_task_stk,
	                  TASK_STACKSIZE,
	                  NULL,
	                  0);
	  alt_ucosii_check_return_code(return_code);
}


/*This function creates the tasks used in this example
 */

int initCreateTasks(void)
{
	INT8U return_code = OS_NO_ERR;

	return_code = OSTaskCreateExt(read_switches,
							  NULL,
							  (void *)&read_switches_stk[TASK_STACKSIZE],
							  READ_SWITCHES_PRIORITY,
							  READ_SWITCHES_PRIORITY,
							  read_switches_stk,
							  TASK_STACKSIZE,
							  NULL,
							  0);
	alt_ucosii_check_return_code(return_code);

	return_code = OSTaskCreateExt(read_pushbuttons,
							   NULL,
							   (void *)&read_pushbuttons_stk[TASK_STACKSIZE],
							   READ_PUSHBUTTONS_PRIORITY,
							   READ_PUSHBUTTONS_PRIORITY,
							   read_pushbuttons_stk,
							   TASK_STACKSIZE,
							   NULL,
							   0);
	alt_ucosii_check_return_code(return_code);

	return 0;
}


