#ifdef SEND_DEBUG_C
	#define _USR_EXT_DEBUG
#else
	#define _USR_EXT_DEBUG	extern
#endif


#define OS_DELAY_1sec			1000
#define OS_DELAY_10msec			10

#define DEBU_TX_QUE_SIZE	2048
#define DEBU_TX_BUF_SIZE	800

#ifdef SEND_DEBUG_C

	INT8U debug_tx_que[DEBU_TX_QUE_SIZE];
	INT16U tx_que_st;
	INT16U tx_que_ed;
	INT16U tx_que_cnt;
	INT16U tx_buff_co=0;
	INT8U rx_data_count = 0;
//	__WRCS_SIO	dubug_txf;
	__WRCSSIO	dubug_txf;


	#define Debug_START_STK_SIZE 	256
	static OS_STK DebugTaskStk[Debug_START_STK_SIZE];

	OS_EVENT		*Debug_Send_Sem;

#else
	extern INT8U debug_tx_que[DEBU_TX_QUE_SIZE];
	extern INT16U tx_que_st;

#endif

void Debug_PutChar( INT8U ch );
void ADD_CR( void );
INT8U MakeACS_HEX( INT8U v );
void Make_UInt( INT32U v );


void Debug_PutString( INT8U *s, INT8U add_cr );
void Debug_PutUInt( INT32U v, INT8U add_cr );
void Debug_PutSInt( INT32S v, INT8U add_cr );
void Debug_PutHex( INT32U v, INT8U nibble_num, INT8U add_cr );
void Debug_UART_Init( void );
void Debug_Uart_Task( void *p_arg );
void Debug_Tx_Data(INT8U*data, INT16U len ,__ProtocolPtr *nPtr);
void Debug_Rx_Data(INT8U*data, INT16U len,__ProtocolPtr *nPtr);


void DebugInit(void);


//unsigned long int pPrintf( const char *format, ...);


