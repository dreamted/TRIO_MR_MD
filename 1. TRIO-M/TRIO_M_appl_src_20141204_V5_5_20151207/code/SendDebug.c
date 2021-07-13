#define SEND_DEBUG_C

#include "../include/main.h"

void Debug_PutChar( INT8U ch )
{
    OS_CPU_SR  cpu_sr;
    
    while(1)
    {
	    OS_ENTER_CRITICAL();
	    if( tx_que_cnt < (DEBU_TX_QUE_SIZE-1) )
	    {
			debug_tx_que[tx_que_st++] = ch;
			tx_que_cnt++;
			tx_que_st %= DEBU_TX_QUE_SIZE;
			OS_EXIT_CRITICAL();
			break;
		}
		OS_EXIT_CRITICAL();
		OSTimeDly( 10L );
	}
}

void ADD_CR( void )
{
	Debug_PutChar( '\r' );
	Debug_PutChar( '\n' );
}

INT8U MakeACS_HEX( INT8U v )
{
	v &= 0x0F;
	if( v<10 ) return (v+'0');
	
	v-=10;
	return (v+'A');
}

void Debug_Tx_Data(INT8U*data, INT16U len ,__ProtocolPtr *nPtr)
{
	INT32U i;
	INT8U port;

	if		( nPtr == PcSer) 	port = COMM_Pcser;
	else if	( nPtr == SmsSer) 	port = COMM_FskSer;

	if(( tDnrSts->Comm_Debug_Mode._Tx == 0x1 )||( tDnrSts->Comm_Debug_Mode.Data == 0x03 ))
	{
		if( port == tDnrSts->TestMode )
		{
			INT8U err;
		
			OSSemPend(Debug_Send_Sem, OS_DELAY_1sec*10, &err );
			if(err != OS_NO_ERR ) return ;
		
			
			ADD_CR();
			ADD_CR();
			
			Debug_PutChar( 'T' );
			Debug_PutChar( 'x' );
			Debug_PutChar( ':' );

			for( i=0; i<len; i++ )
			{
				Debug_PutChar( MakeACS_HEX( (INT8U)(data[i]>>4) ) );
				Debug_PutChar( MakeACS_HEX( (INT8U)(data[i]&0x0F) ) );
				Debug_PutChar( ' ' );
				if( (i%30)==29 ) ADD_CR();
			}

			ADD_CR();
			Debug_PutChar( 0 );
			ADD_CR();
			Debug_PutChar( 0 );

			OSSemPost( Debug_Send_Sem );
		}
	}
}



void Debug_Rx_Data(INT8U*data, INT16U len,__ProtocolPtr *nPtr)
{
	INT32U i = 0;
	INT8U port;

	if		( nPtr == PcSer) 	port = COMM_Pcser;
	else if	( nPtr == SmsSer) 	port = COMM_FskSer;

	if(( tDnrSts->Comm_Debug_Mode._Rx == 0x1 )||( tDnrSts->Comm_Debug_Mode.Data == 0x03 ))
	{
		if( port == tDnrSts->Comm_Debug_Port )
		{
			INT8U err;
		
			OSSemPend(Debug_Send_Sem, OS_DELAY_1sec*10, &err );
			if(err != OS_NO_ERR ) return ;
			rx_data_count=0;

			ADD_CR();
			ADD_CR();
			Debug_PutChar( 'R' );
			Debug_PutChar( 'x' );
			Debug_PutChar( ':' );
			for( i = 0; i < len; i++ )
			{
				Debug_PutChar( MakeACS_HEX( (INT8U)(data[i]>>4) ) );
				Debug_PutChar( MakeACS_HEX( (INT8U)(data[i]&0x0F) ) );
				Debug_PutChar( ' ' );
				rx_data_count++;
				if( rx_data_count >= 30 )
				{
					rx_data_count = 0;
					Debug_PutChar( 0 );
				}

			}
			ADD_CR();
			Debug_PutChar( 0 );

			OSSemPost( Debug_Send_Sem );

		}
	}
}


void DebugInit(void)
{
#if 1
	OSTaskCreate(Debug_Uart_Task, (void *)0, (OS_STK *)&DebugTaskStk[Debug_START_STK_SIZE - 1], Debug_PRIO);
#endif	
}

void Debug_Uart_Task( void *p_arg )
{

	INT8U ch;
    OS_CPU_SR  cpu_sr;
	
    (void)p_arg;

	Debug_Send_Sem = OSSemCreate(1);

	while (1)
	{
	    OS_ENTER_CRITICAL();
		while( tx_que_st != tx_que_ed )
		{
			ch = debug_tx_que[tx_que_ed++];
			tx_que_cnt--;
			tx_que_ed %= DEBU_TX_QUE_SIZE;
			OS_EXIT_CRITICAL();
			
			if( ch )dubug_txf.BodyFrame[0].SubData[tx_buff_co++] = ch;
			
			if( (tx_buff_co == DEBU_TX_BUF_SIZE) || (ch==0) )
			{

				INT8U tid[3] = {0x00, 0xff, 0xff};
				GenBodyFrame(tid, (INT8U *)dubug_txf.BodyFrame[0].SubData, tx_buff_co, 0x2A, PcSer, 0);
				WRCS_ProDataAckTx(PcSer);

				tx_buff_co = 0;
				OSTimeDly( OS_DELAY_10msec*10 );

			}
		    OS_ENTER_CRITICAL();
		}
		OS_EXIT_CRITICAL();
		tx_que_st = 0;
		tx_que_ed = 0;

		OSTimeDly( OS_DELAY_10msec*10 );
		
	}
}

#if 0
unsigned long int pPrintf( const char *format, ...)
{
	INT8U tmpData[512];
    OS_CPU_SR  cpu_sr;

	OS_ENTER_CRITICAL();
	va_list argptr;	
	va_start(argptr, format);
	vsprintf((char *)tmpData, format, argptr);
	va_end( argptr );

	{
		INT8U tid[3] = {0x00, 0xff, 0xff};
		GenBodyFrame(tid[0], tid[1], tid[2], (INT8U *)tmpData, strlen((const char *)tmpData), 0x2A, PcSer, 0);
		WRCS_ProDataAckTx(PcSer);
	}

	OS_EXIT_CRITICAL();
	return FALSE;
}

#endif
