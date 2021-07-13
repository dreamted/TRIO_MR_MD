
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : exlib.c
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/01/2008
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/

#define TEST_C

#include <math.h>
#include <stdlib.h>
//#include <ctype.h>

#include "../include/main.h"

#define Board_Test



void TestInit(void)
{
	OSTaskCreate(TestTask, (void *)NULL, (OS_STK *)&TestTaskStk[TEST_START_STK_SIZE - 1], TEST_START_PRIO);
}


void TestTask(void *p_arg)
{
	INT16U nCnt = 0;
//	INT32U nFlag = 0;
    nCnt = nCnt;
	gTestFlag = FALSE;
	
	OSTimeDly(TEST_START_PRIO*100L);

	memset((INT8U *)&MonStr,0,sizeof(MON_STR));
//	iUser_Value2 = __ChangeDebug;
	while(1)
	{
		if(iUser_Value2 == __ChangeDebug)
		{
			PrintLogo();
			PromptOut();
			gTestFlag = TRUE;
	
			while(iUser_Value2 == __ChangeDebug)
			{
				if(SerPtr->CheckByte(1, &nCnt))
				{
					if(GetCommand(0)){
						if(!CommandInterpret(0)) SerPtr->printf(NULL,"\n\r Unknown Command!!");
						PromptOut();
					}
				}

				if(TimeOverCheck(Timer_DebugCnt)) DownLoadBootingJump();
				OSTimeDly(10u);
			}
		}

		OSTimeDly(500L);
	}
}

/*#########################################################*/
/*  RS232로 부터 데이타를 받아서 COM_STR.BUFF에 저장한다.  */
/*  RETURN(0x0D)코드가 오면 명령어의 끝으로 인식하고 널    */
/* (0x00)을 저장하고 끝난다.                               */
/*  입력값 : dest_sio --> SIO 포트.                        */
/*  리턴값 : TRUE  --> CR Code가 입력됨.                   */
/*           FALSE --> CR Code가 입력이 안됨.              */
/*#########################################################*/
INT8U GetCommand(INT8U Sio)
{
 	char Data;

	Data = lower(SerPtr->RxGetByte());
	SerPtr->PutToBuffer(Data);			// 입력 키 출력

    switch(MonStr.m_Mode){
       case 0:
            if(Data==CR){ /* Carrige Return */
				MonStr.m_Buff[0]='\0';            /* NULL CODE */
				Parser(MonStr.m_Buff);

				SerPtr->PutToBuffer('\r');
				SerPtr->PutToBuffer('\n');
					
				return(TRUE);
            }
            else if(Data!=' ' && Data!=BS){
               MonStr.m_Buff[MonStr.m_Ptr++]=Data;
               MonStr.m_Mode=1;
            }
            break;
       case 1:
            if(Data==CR){
               MonStr.m_Buff[MonStr.m_Ptr]='\0';  /* NULL CODE */
               MonStr.m_Mode=0;
               MonStr.m_Ptr=0;
               Parser(MonStr.m_Buff);

			   SerPtr->PutToBuffer('\r');
			   SerPtr->PutToBuffer('\n');

			   return(TRUE);
            }
            else if(Data==BS){ /* Backspace */
               if(MonStr.m_Ptr>0)
                  MonStr.m_Ptr--;
            }
            else{
               MonStr.m_Buff[MonStr.m_Ptr++]=Data;
			   
            }
            break;
    }/* End of switch */
  return(FALSE);
}

INT8U CommandInterpret(INT8U Sio)
{
	INT16U addr;
	INT8U data;
	INT32U Data32;
	INT32U faddr;



	if(!Argc)
		return(1);  /* Enter키가 입력됨. */

//	SerPtr->printf("Argv[%s][%s]\n",Argv[0],Argv[1]);

#if 1
	if(!strcmp((char *)Argv[0], "HELP"))
	{
		SerPtr->printf("[%s]\n",Argv[0]);

		PrintLogo();
	}
	else if(!strcmp((char *)Argv[0], "FPGA"))
	{
		DTUTest = SET;
		
		if(!strcmp((char *)Argv[1], "DET"))
		{
			#if 1
			type32 tmp;
			
			addr = strtol(Argv[2], NULL, 16);
			DTU_WriteData(CS0SEL, DTU_ReadSelect, addr);
			{

				INT8U tmpAddr = DTU_PeakPower_B0;
				tmp.sD8[3] = DTU_ReadData(CS0SEL, tmpAddr + 0);
				tmp.sD8[2] = DTU_ReadData(CS0SEL, tmpAddr + 1);
				tmp.sD8[1] = DTU_ReadData(CS0SEL, tmpAddr + 2);
				tmp.sD8[0] = DTU_ReadData(CS0SEL, tmpAddr + 3);

				Data32 = logx(tmp.uD32);

//				Data = logx(100);

				if( Sio == 0)	SerPtr->printf("DTUPeakPower[%x][%x][%x][%x]:%d.%d \n",tmp.sD8[3],tmp.sD8[2],tmp.sD8[1],tmp.sD8[0],Data32/10, Data32%10);
			}
			{
				INT8U tmpAddr = DTU_AverPower_B0;

				tmp.sD8[3] = DTU_ReadData(CS0SEL, tmpAddr + 0);
				tmp.sD8[2] = DTU_ReadData(CS0SEL, tmpAddr + 1);
				tmp.sD8[1] = DTU_ReadData(CS0SEL, tmpAddr + 2);
				tmp.sD8[0] = DTU_ReadData(CS0SEL, tmpAddr + 3);

				Data32 = logx(tmp.uD32);
				if( Sio == 0)	SerPtr->printf("DTUAverPower[%x][%x][%x][%x]:%d.%d \n",tmp.sD8[3],tmp.sD8[2],tmp.sD8[1],tmp.sD8[0],Data32/10, Data32%10);

			}
			#endif

		}
		else if(!strcmp((char *)Argv[1], "ISO"))
		{
			type32 tmp;
			
			INT32U ecs_x, ecs_0;
			INT16S Temp;

			addr = strtol(Argv[2], NULL, 16);
			{
				DTU_WriteData(CS0SEL, DTU_ISOPathSel, addr);

				tmp.sD8[3] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 0);
				tmp.sD8[2] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 1);
				tmp.sD8[1] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 2);
				tmp.sD8[0] = DTU_ReadData(CS0SEL, DTU_ISO_O_Power + 3);
				ecs_0 = tmp.uD32;

				tmp.sD8[3] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 0);
				tmp.sD8[2] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 1);
				tmp.sD8[1] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 2);
				tmp.sD8[0] = DTU_ReadData(CS0SEL, DTU_ISO_x_Power + 3);
				ecs_x = tmp.uD32;
				Temp = -log2x((double)ecs_x/(double)ecs_0);
				SerPtr->printf("ISOPower[%x]:[%x][%x]>[%x][%d] \n",addr,ecs_0,ecs_x,Temp,Temp);
			}
		}
		else if(!strcmp((char *)Argv[1], "W"))
		{

			addr = strtol(Argv[2], NULL, 16);
			data = strtol(Argv[3], NULL, 16);

			DTU_WriteData(CS0SEL, addr, data);
			
			data = DTU_ReadData(CS0SEL, addr);

			SerPtr->printf ("FPGA Write[%x]: data[%x]\n",addr,data);
		}
		else if(!strcmp((char *)Argv[1], "R"))
		{
			addr = strtol(Argv[2], NULL, 16);
			data = DTU_ReadData(CS0SEL, addr);

			SerPtr->printf ("FPGA Read[%x]: data[%x]\n",addr,data);
		}
	}
	else if(!strcmp((char *)Argv[0], "RESET"))
	{
		SerPtr->printf("[%s]\n",Argv[0]);
		
		DownloadFlagClr();
		ForDelay(20L);
		DownLoadBootingJump();
	}
	else if(!strcmp((char *)Argv[0], "SPI"))
	{
		INT8U OPCODE;
		INT8U tmp = 0;

		OPCODE = strtol(Argv[1], NULL, 16);
		faddr = strtol(Argv[2], NULL, 16);

		sSPI_DataRead(&AT25DFSpi,SPI_FLASH_CH0,OPCODE,faddr,&tmp, 1);

		SerPtr->printf("[%02x]\n",tmp);		
	}	
	else if(!strcmp((char *)Argv[0], "FLASH"))
	{
		INT16U i;
		INT8U tmp;

		if(!strcmp((char *)Argv[1], "0"))
		{
			if(!strcmp((char *)Argv[2], "W"))
			{
#define DUMPSIZE	16			

				INT8U tmpData[DUMPSIZE];
				INT8U data1[4] = {0,};

				faddr = strtol(Argv[3], NULL, 16);
				data1[0] = strtol(Argv[4], NULL, 16);
				data1[1] = strtol(Argv[5], NULL, 16);
				data1[2] = strtol(Argv[6], NULL, 16);
				data1[3] = strtol(Argv[7], NULL, 16);

				tmpData[0] = data1[0];
				tmpData[1] = data1[1];
				tmpData[2] = data1[2];
				tmpData[3] = data1[3];
				tmpData[4] = data1[0];
				tmpData[5] = data1[1];
				tmpData[6] = data1[2];
				tmpData[7] = data1[3];
				
				tmpData[8] = data1[0];
				tmpData[9] = data1[1];
				tmpData[10] = data1[2];
				tmpData[11] = data1[3];
				tmpData[12] = data1[0];
				tmpData[13] = data1[1];
				tmpData[14] = data1[2];
				tmpData[15] = data1[3];

				for(i = 0; i < DUMPSIZE; i++)
				{
//					tmpData[i] = data;
				}
 				
//				sFLASH_CS0_DataWriteExt(0);
//				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr + faddr, DUMPSIZE);
//				sFLASH_CS0_DataWrite(sFLASH_APPLAddr + faddr, tmpData, DUMPSIZE);
#if 0
				if(faddr > SPI_FLASH_16MB_BOUN)
				{
					INT8U tmp1[4];

					tmp = sFLASH_CS0_SetRegister(CMD_EXTNADDR_WREAR,NULL,tmp1,0);
				}
#endif
				sFLASH_CS0_BL4kCheckErase(faddr, DUMPSIZE);
				sFLASH_CS0_DataWrite(faddr, tmpData, DUMPSIZE);

				for(i = 0; i < DUMPSIZE; i++)
				{
					tmp = sFLASH_CS0_DataRead(faddr + i);
					SerPtr->printf("[%x]",tmp);
				}
				
				SerPtr->printf("\n");
 
			}
			if(!strcmp((char *)Argv[2], "R"))
			{
				INT32U i = 0;
				INT8U tmp;
#define DUMPSIZE	16			
				faddr = strtol(Argv[3], NULL, 16);

//				sFLASH_CS0_DataWriteExt(0);

#if 0
				if(faddr > SPI_FLASH_16MB_BOUN)
				{
					INT8U tmp1[4];

					tmp = sFLASH_CS0_SetRegister(CMD_EXTNADDR_WREAR,NULL,tmp1,0);
				}
#endif

				for(i = 0; i < DUMPSIZE; i++)
				{
//					tmp = sFLASH_CS0_DataRead(sFLASH_APPLAddr + faddr + i);
					tmp = sFLASH_CS0_DataRead(faddr + i);

					SerPtr->printf("[%02x]",tmp);
				}
				SerPtr->printf("\n");
 			}
			if(!strcmp((char *)Argv[2], "P"))
			{

				faddr = strtol(Argv[3], NULL, 16);
//				tmp = sFLASH_CS0_DataReadExt(faddr);
				SerPtr->printf("[%x]\n",tmp);
			}
			if(!strcmp((char *)Argv[2], "E9"))
			{
				tmp = sFLASH_CS0_SetRegister(0xE9,NULL,NULL,0);
				
				SerPtr->printf("0xE9 tmp[%d]\n",tmp);
			}
			if(!strcmp((char *)Argv[2], "B7"))
			{
				tmp = sFLASH_CS0_SetRegister(0xB7,NULL,NULL,0);
				
				SerPtr->printf("0xB7 tmp[%d]\n",tmp);
			}



			if(!strcmp((char *)Argv[2], "E"))
			{

				faddr = strtol(Argv[3], NULL, 16);
//				tmp = sFLASH_CS0_DataWriteExt(faddr);
				SerPtr->printf("[%x]\n",tmp);
			}
			if(!strcmp((char *)Argv[2], "S"))
			{
				INT8U tmp1[20];
				tmp = sFLASH_CS0_SetRegister(READ_EXT,NULL,tmp1,0);
				SerPtr->printf("tmp[%d]\n",tmp);
			}
			if(!strcmp((char *)Argv[2], "D"))
			{
				INT8U tmp1[20];

//				tmp = sFLASH_CS0_SetRegister(RDID,NULL,tmp1,20);

//				tmp = sFLASH_CS0_SetRegister(WRITE_EXT,NULL,tmp1,0);
//				tmp = sFLASH_CS0_SetRegister(READFlagSTS,NULL,tmp1,1);
				tmp = sFLASH_CS0_SetRegister(READNVCR,NULL,tmp1,2);

//				SerPtr->printf("tmp[%d]\n",tmp);

				#if 1
				SerPtr->printf("tmp[%d]>>",tmp);
				for(i = 0; i < 2; i++)
				{
					SerPtr->printf("[%x]",tmp1[i]);

				}

				SerPtr->printf("\n");
				#endif
			}

			if(!strcmp((char *)Argv[2], "F"))
			{
				INT8U tmp1[20];

//				tmp = sFLASH_CS0_SetRegister(RDID,NULL,tmp1,20);

//				tmp = sFLASH_CS0_SetRegister(WRITE_EXT,NULL,tmp1,0);
//				tmp = sFLASH_CS0_SetRegister(READFlagSTS,NULL,tmp1,1);
				tmp1[0] = 0xff;
				tmp1[1] = 0xfD;

				tmp = sFLASH_CS0_SetRegister(WRITENVCR,NULL,tmp1,2);

//				SerPtr->printf("tmp[%d]\n",tmp);

				#if 1
				SerPtr->printf("tmp[%d]>>",tmp);
				for(i = 0; i < 2; i++)
				{
					SerPtr->printf("[%x]",tmp1[i]);

				}

				SerPtr->printf("\n");
				#endif
			}

		
			if(!strcmp((char *)Argv[2], "70"))
			{
				INT8U tmp1[20];

				tmp = sFLASH_CS0_SetRegister(0x70,NULL,tmp1,1);

				SerPtr->printf("70 tmp[%d]>>",tmp);
				for(i = 0; i < 1; i++)
				{
					SerPtr->printf("[%x]",tmp1[i]);
				}

				SerPtr->printf("\n");
			}	
		}
		else if(!strcmp((char *)Argv[1], "1"))
		{
			if(!strcmp((char *)Argv[2], "W"))
			{
#define DUMPSIZE1	16			
				INT8U tmpData[DUMPSIZE1];

				faddr = strtol(Argv[3], NULL, 16);
				data = strtol(Argv[4], NULL, 16);

				for(i = 0; i < DUMPSIZE1; i++)
				{
					tmpData[i] = data;
				}
				
				sFLASH_CS1_BL4kCheckErase(sFLASH_APPLAddr+faddr, DUMPSIZE1);
				sFLASH_CS1_DataWrite(sFLASH_APPLAddr, tmpData, DUMPSIZE1);
				for(i = 0; i < DUMPSIZE1; i++)
				{
					tmp = sFLASH_CS1_DataRead(sFLASH_APPLAddr + i);
					SerPtr->printf("[%x]",tmp);
				}
				
				SerPtr->printf("\n");
 
			}
			if(!strcmp((char *)Argv[2], "R"))
			{
				INT32U i = 0;
				INT8U tmp;
				_DTU_SEL0 = SET;
#define DUMPSIZE	16			
				faddr = strtol(Argv[3], NULL, 16);
				data = strtol(Argv[4], NULL, 16);

				for(i = 0; i < DUMPSIZE; i++)
				{
					tmp = sFLASH_CS1_DataRead(sFLASH_APPLAddr + faddr +i);
					SerPtr->printf("[%x]",tmp);
				}
				SerPtr->printf("\n");
			}
		}


	}
	
	else if(!strcmp((char *)Argv[0], "TEST"))
	{
//		SerPtr->printf("0 TEST[%s]\n",Argv[0]);
//////////////////
		INT8U tdata = TRUE;
//0x1FFF 7A22
//		SerPtr->printf("Flash Size[%x][%x]\n", READ_REG(0x1FFF7A22),READ_REG(0x1FFF7A22));

#ifdef	Board_Test

		if(!strcmp((char *)Argv[1], "A"))
		{
			char *tstmsg = "ADC Input";

			if(SavetoTestBackup(ADCTest, SET, NULL) == SET)
			{
				tdata = returnmsgTest(tstmsg);
			}
			if(tdata)
			{
				INT16U nCnt;

				SerPtr->printf("\n* [%s] TEST START TimeOut 5 Min]\n", tstmsg);

				TimerRegist(TimerTest, Time1Sec*60L*5L);

				while(1)
				{
					AdInputStatus();


					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s Test TimeOut\n", tstmsg);

						TimerRegist(TimerTest, Time1Sec);
						break;
					}
					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'c' || nCnt == 'C')
						{
							SerPtr->printf("%s Test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'f' || nCnt == 'F')
						{
//							gOK:
							SerPtr->printf("%s Test Finished\n", tstmsg);
							SavetoTestBackup(ADCTest, SET, SET);
							break;
						}
					}
					OSTimeDly(2000L);
					/////////////////////////////////////////////////////////////
				}
			}
		}
		else if(!strcmp((char *)Argv[1], "O"))
		{
			char *tstmsg = "Dig Output";
			
			if(SavetoTestBackup(OutputTest, SET, NULL) == SET)
			{
				tdata = returnmsgTest(tstmsg);
			}
			
			if(tdata)
			{
				INT32U nFlag = 0;
				INT16U nCnt;

				SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);

				TimerRegist(TimerTest, Time1Sec*60L*5L);

				while(1)
				{
					HwTestOutFunc(&nFlag);

					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s test TimeOut\n", tstmsg);
						TimerRegist(TimerTest, Time1Sec);
						break;
					}
					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'C' || nCnt == 'c')
						{
							SerPtr->printf("%s test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'F' || nCnt == 'f')
						{
							SerPtr->printf("%s test Finished\n", tstmsg);
							SavetoTestBackup(OutputTest, SET, SET);
							break;
						}
					}
					OSTimeDly(250L*1L);
				}
			}
		}
		else if(!strcmp((char *)Argv[1], "I"))
		{
			char *tstmsg = "Dig Input";

			if(SavetoTestBackup(InputTest, SET, NULL) == SET)
			{
				tdata = returnmsgTest(tstmsg);
			}
			if(tdata)
			{
				INT16U nCnt;

				SerPtr->printf("\n* [%s TEST START TimeOut 5 Min]\n", tstmsg);
				TimerRegist(TimerTest, Time1Sec*60L*1L);

				CurrentInputStatus(0);
				tinputStsOld = tinputSts;

				while(1)
				{
					CurrentInputStatus(1);

					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s Test TimeOut\n", tstmsg);
						TimerRegist(TimerTest, Time1Sec);
						break;
					}
					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'c' || nCnt == 'C')
						{
							SerPtr->printf("%s Test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'f' || nCnt == 'F')
						{
							SerPtr->printf("%s Test Finished\n", tstmsg);
							SavetoTestBackup(InputTest, SET, SET);
							break;
						}
					}
					OSTimeDly(300L);
				}
			}
		}
		else if(!strcmp((char *)Argv[1], "C"))
		{
			char *tstmsg = "COM 시험";
			
			if(SavetoTestBackup(CommTest, SET, NULL) == SET)
			{
				tdata = returnmsgTest(tstmsg);
			}

			if(tdata)
			{
				INT16U nCnt;

				SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);

				TimerRegist(TimerTest, Time1Sec*60L*5L);

				while(1)
				{
					COMTestFunc();
					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s test Test TimeOut\n", tstmsg);
						TimerRegist(TimerTest, Time1Sec);
						break;
					}

					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'C' || nCnt == 'c')
						{
							SerPtr->printf("%s test Test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'F' || nCnt == 'f')
						{
							
							SerPtr->printf("%s Test Test Finished\n", tstmsg);
							SavetoTestBackup(CommTest, SET, SET);
							break;
						}
					}
					OSTimeDly(2000L);
				}
			}
		}
		else if(!strcmp((char *)Argv[1], "S"))
		{
			
			SerPtr->printf("\n Default Back-up End -> Reboot...  \n\n");

			DefaultTable();
			ForDelay(20L);

			WriteEEprom(At24cDevID, DownLoadFlag1,	(INT8U)(0x5A5A >> 8), 0);
			WriteEEprom(At24cDevID, DownLoadFlag2,	(INT8U)(0x5A5A	 ), 0);
			
			DownLoadBootingJump();

		}		
#endif		

		if(!strcmp((char *)Argv[1], "SRAM"))
		{
			u8 *tptr = (u8 *)(Bank1_SRAM1_ADDR + (256*1024));
			INT32U i = 0;
			SerPtr->printf("\n");
			
			for(i = 0; i < (256*1024); i++)
			{
				tptr[i] = (INT8U)i;
				
				if((INT8U)i != tptr[i])
				{
					SerPtr->printf("\nRAM TEST ERROR \n");
					break;
				}
				if((i%1024) == 0)
				{
					OSTimeDly(10);
					SerPtr->printf(".");

				}
			}
			if(i == (256*1024)){
			}
			
			SerPtr->printf("\n");
		}
	}
	else 											SerPtr->printf("ETC[%s]\n",Argv[0]);
#endif
	return(1);
}


void KeyProc( char sbuf, void (*func)(void))
{
	INT16U nSize = sizeof(tRevData);

	tRevData[tIndex%nSize] = sbuf;
//	
	if( tRevData[tIndex%nSize] == 0x0D )			// Enter 입력
	{
		SerPtr->PutToBuffer('\r');
		SerPtr->PutToBuffer('\n');
		tRevData[tIndex%nSize] = '\0';

		if(tIndex != 0)
		{
			strcpy((char *)PrevData[PrevWRCnt++], (const char *)tRevData);
			PrevWRCnt %= 5;
		}
		PrevRDCnt = PrevWRCnt;
		func();
		tIndex = 0;
		Parser(rRevData);

		return;
	}
	else if(tRevData[tIndex%nSize] == 0x08) // Back Space
	{
		if (tIndex == 0)
			return;

		SerPtr->PutToBuffer(0x08);
		SerPtr->PutToBuffer(' ');
		SerPtr->PutToBuffer(0x08);
		tIndex--;

		return;
	}
	else if( tRevData[tIndex%nSize] == 0x09 )	// tab
	{
		while(tIndex)
		{
			SerPtr->PutToBuffer(0x08);
			SerPtr->PutToBuffer(' ');
			SerPtr->PutToBuffer(0x08);
			tIndex--;
		}

		PrevRDCnt--;
		if(PrevRDCnt < 0) PrevRDCnt = 4;
		strcpy((char *)tRevData, (const char *)PrevData[PrevRDCnt]);

		SerPtr->printf("%s", PrevData[PrevRDCnt]);
		tIndex = strlen((const char *)PrevData[PrevRDCnt]);

		return;
	}
	rRevData[tIndex%nSize] = tRevData[tIndex%nSize];
	SerPtr->PutToBuffer(tRevData[tIndex%nSize]);			// 입력 키 출력

	if(++tIndex >= nSize) tIndex = 0;
}

INT8U htob(INT8U hex)
{
	INT8U i;
	
	if (hex >= '0' && hex <= '9') i=hex-'0';
	else if ( hex >= 'A' && hex <= 'F' )i=hex-'A'+10;
	else i=hex-'a'+10;
	
	return i;
}

INT8U dGetHex (INT8U Data_H, INT8U Data_L)
{
	INT8U i;
	
	i=htob( Data_H );
	i=htob( Data_L )+(i<<4);
	return i;
}

void TestCommand(void)
{

	INT8U tdata = FALSE;
	
	if(tRevData[0] == 't' && tRevData[1] == 'e' && tRevData[2] == 's' && tRevData[3] == 't') tdata = TRUE;
	if(tRevData[0] == 'T' && tRevData[1] == 'E' && tRevData[2] == 'S' && tRevData[3] == 'T') tdata = TRUE;

	if(tdata){
		iUser_Value2 = __ChangeDebug;
		iDebugCnt = 0; 
		TimerRegist(Timer_DebugCnt, Time1Min*30L);
		TimerRegist(TimerSioRx, Time100mSec);
	}
	PromptOut();
}

//void OnCommand2nd(INT8U *pdata)


void OnCommand ( void )
{
	INT8U tdata = TRUE;
//	if( memcmp( rxd_buff, "$$GMM_REJ:", cmdLen ) == 0 )
#if 0
	if(memcmp(Argv[0],"TEST",4) && Argc==1)
	{
		SerPtr->printf("Test OK\n");
	}
	else
	{
		SerPtr->printf("Test NOK\n");
	}
#endif
//	else if(Ustrcmp(Argv[0],"HELP") && Argc==1)  DisplayHelpMenu(Sio);
	switch(tRevData[0])
	{
		case '?':
			PrintLogo();
		break;
		
		case 'A':
		case 'a':
		{
			char *tstmsg = "ADC Input";

			
			if(SavetoTestBackup(ADCTest, SET, NULL) == SET)
			{
				tdata = returnmsgTest(tstmsg);
			}
			

			if(tdata)
			{
				INT16U nCnt;

				SerPtr->printf("\n* [%s] TEST START TimeOut 5 Min]\n", tstmsg);

				TimerRegist(TimerTest, Time1Sec*60L*5L);

				while(1)
				{
					AdInputStatus();


					if(TimeOverCheck(TimerTest))
					{
						SerPtr->printf("%s Test TimeOut\n", tstmsg);

						TimerRegist(TimerTest, Time1Sec);
						break;
					}
					if(SerPtr->CheckByte(1, &nCnt))
					{
						nCnt = SerPtr->RxGetByte();
						if(nCnt == 'c' || nCnt == 'C')
						{
							SerPtr->printf("%s Test Canceled\n", tstmsg);
							break;
						}
						else if(nCnt == 'f' || nCnt == 'F')
						{
//							gOK:
							SerPtr->printf("%s Test Finished\n", tstmsg);
							SavetoTestBackup(ADCTest, SET, SET);
							break;
						}
					}
					OSTimeDly(2000L);
					/////////////////////////////////////////////////////////////
				}
			}
		}
		break;

		case 'O':
		case 'o':
			{
				char *tstmsg = "Dig Output";
				
				if(SavetoTestBackup(OutputTest, SET, NULL) == SET)
				{
					tdata = returnmsgTest(tstmsg);
				}
				
				if(tdata)
				{
					INT32U nFlag = 0;
					INT16U nCnt;
	
					SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);
	
					TimerRegist(TimerTest, Time1Sec*60L*5L);
	
					while(1)
					{
						HwTestOutFunc(&nFlag);
	
						if(TimeOverCheck(TimerTest))
						{
							SerPtr->printf("%s test TimeOut\n", tstmsg);
							TimerRegist(TimerTest, Time1Sec);
							break;
						}
						if(SerPtr->CheckByte(1, &nCnt))
						{
							nCnt = SerPtr->RxGetByte();
							if(nCnt == 'C' || nCnt == 'c')
							{
								SerPtr->printf("%s test Canceled\n", tstmsg);
								break;
							}
							else if(nCnt == 'F' || nCnt == 'f')
							{
								SerPtr->printf("%s test Finished\n", tstmsg);
								SavetoTestBackup(OutputTest, SET, SET);
								break;
							}
						}
						OSTimeDly(250L*1L);
						/////////////////////////////////////////////////////////////						
					}
				}
			}
		break;

		case 'I':
		case 'i':
			{
				char *tstmsg = "Dig Input";

				if(SavetoTestBackup(InputTest, SET, NULL) == SET)
				{
					tdata = returnmsgTest(tstmsg);
				}
				if(tdata)
				{
					INT16U nCnt;
	
					SerPtr->printf("\n* [%s TEST START TimeOut 5 Min]\n", tstmsg);
					TimerRegist(TimerTest, Time1Sec*60L*1L);
	
					CurrentInputStatus(0);
					tinputStsOld = tinputSts;

					while(1)
					{
						CurrentInputStatus(1);
	
						if(TimeOverCheck(TimerTest))
						{
							SerPtr->printf("%s Test TimeOut\n", tstmsg);
							TimerRegist(TimerTest, Time1Sec);
							break;
						}
						if(SerPtr->CheckByte(1, &nCnt))
						{
							nCnt = SerPtr->RxGetByte();
							if(nCnt == 'c' || nCnt == 'C')
							{
								SerPtr->printf("%s Test Canceled\n", tstmsg);
								break;
							}
							else if(nCnt == 'f' || nCnt == 'F')
							{
								SerPtr->printf("%s Test Finished\n", tstmsg);
								SavetoTestBackup(InputTest, SET, SET);
								break;
							}
						}
						OSTimeDly(300L);
						/////////////////////////////////////////////////////////////
					}
				}
			}
		break;
		
		case 'C':
		case 'c':
			{
				char *tstmsg = "COM 시험";
				
				if(SavetoTestBackup(CommTest, SET, NULL) == SET)
				{
					tdata = returnmsgTest(tstmsg);
				}

				if(tdata)
				{
					INT16U nCnt;
	
					SerPtr->printf("\n* [%s TEST START TimeOut 5Min]\n", tstmsg);
	
					TimerRegist(TimerTest, Time1Sec*60L*5L);
	
					while(1)
					{
						COMTestFunc();
						if(TimeOverCheck(TimerTest))
						{
							SerPtr->printf("%s test Test TimeOut\n", tstmsg);
							TimerRegist(TimerTest, Time1Sec);
							break;
						}
	
						if(SerPtr->CheckByte(1, &nCnt))
						{
							nCnt = SerPtr->RxGetByte();
							if(nCnt == 'C' || nCnt == 'c')
							{
								SerPtr->printf("%s test Test Canceled\n", tstmsg);
								break;
							}
							else if(nCnt == 'F' || nCnt == 'f')
							{
								
								SerPtr->printf("%s Test Test Finished\n", tstmsg);
								SavetoTestBackup(CommTest, SET, SET);
								break;
							}
						}
						OSTimeDly(2000L);
					}
				}
			}
		break;

		case 'G':
		case 'g':
			DownloadFlagClr();
			ForDelay(20L);
			DownLoadBootingJump();
		break;

		case 'E':
		case 'e':
#if 0      
		{
			EE_TABLE1 *ptr = &gEE_TABLE1;
			INT32U AddrOffset = vEE_TABLE1Addr + (INT32U)&(ptr->BdTestBp) - (INT32U )&gEE_TABLE1;

			if(SavetoTestBackup(EepromTest, SET, NULL) == SET)
			{
				char *tstmsg = "EEPROM(AT24C64) 시험";
				tdata = returnmsgTest(tstmsg);
			}

			if(tdata)
			{
				WriteEEprom(At24cDevID, AddrOffset + EepromResult, 'e', 0);
				tdata = ReadEEprom(At24cDevID, AddrOffset + EepromResult, 0);

				SerPtr->printf("\n\nWriting 24C64_Addr[%d] = 'e' -> ", AddrOffset);
				if(tdata == 'e'){
					SerPtr->printf("success read_data = [%c][0x%02x]\n\n", tdata, tdata);
					SavetoTestBackup(EepromTest, SET, SET);
				}
				else{
					SerPtr->printf("failed  read_data = [%d][0x%02x]\n\n", tdata, tdata);
					SavetoTestBackup(EepromTest, RESET, SET);
				}
			}
		}
#endif       
		break;		
		case 'S':
		case 's':
		#if 1	
			{
				u8 *tptr = (u8 *)(Bank1_SRAM1_ADDR + (256*1024));
				INT32U i = 0;
				SerPtr->printf("\n");
				
				for(i = 0; i < (256*1024); i++)
				{
					tptr[i] = (INT8U)i;
					
					if((INT8U)i != tptr[i])
					{
						SerPtr->printf("\n      RAM TEST ERROR \n");
//						SavetoTestBackup(SramTest,  NULL, SET);
						break;
					}
					if((i%1024) == 0)
					{
						OSTimeDly(10);
						SerPtr->printf(".");
//						SerPtr->printf("[%x][%x]:[%x][%d]\n",(u32)&nCS15,__pAPBK_SRAMAddr,i,*(vu8 *)(&nCS10 + i + (256*1024)));

					}
				}
				if(i == (256*1024)){
					SerPtr->printf("\n      RAM TEST OK!!\n");
//					SavetoTestBackup(SramTest,  SET, SET);
				}
				SerPtr->printf("\n");
			}
		#endif
		
		break;


		
		break;


		
#if 0
		case 'T':
		case 't':
		#if 1
			{
				INT32U i = 0;
			//	DevSPIxStr *Devptr = &FPGASpi;
				INT8U tmp;
			
#define DUMPSIZE	200			
						INT8U tmpData[DUMPSIZE];
//						INT8U tmpData1[DUMPSIZE]= {0,};
						
				for(i = 0; i < DUMPSIZE; i++)
				{
	//				tmpData[i] = 2;
				}
		#if 1
				tmpData[0] =0x19;
 				tmpData[1] =0x38;
  				tmpData[2] =0x57;
 				tmpData[3] =0x76;
		#endif
//				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr + DUMPSIZE, DUMPSIZE);

				sFLASH_CS0_BL4kCheckErase(sFLASH_APPLAddr, DUMPSIZE);
//				sFLASH_CS0_4kErase(0);
				OSTimeDly(1);

				sFLASH_CS0_DataWrite(sFLASH_APPLAddr, tmpData, DUMPSIZE);
			
				OSTimeDly(1);

//				sFLASH_CS0_BufferRead(sFLASH_APPLAddr, tmpData1, DUMPSIZE);
				for(i = 0; i < DUMPSIZE; i++)
				{
					tmp = sFLASH_CS0_DataRead(sFLASH_APPLAddr + i);
					SerPtr->printf("[%x]",tmp);
				}
			}
			SerPtr->printf("\n");
		#endif

		
		break;

		case 'P':
		case 'p':
			{
				INT32U i = 0;
				INT8U tmp;

				for(i = 0; i < DUMPSIZE; i++)
				{
					tmp = sFLASH_CS0_DataRead(sFLASH_APPLAddr + i);
					SerPtr->printf("[%x]",tmp);
				}
			
			}
			SerPtr->printf("\n");

		break;

		
		case 'F':
		case 'f':
			if(tRevData[1] == ' ') AdditionalOnCommand((INT8U *)&tRevData[2]);
		break;


		case 'D':
		case 'd':
			if(tRevData[1] == ' ') DtuAdditionalOnCommand((INT8U *)&tRevData[2]);
		break;
#endif		

		default:
		break;

	}
	PromptOut();
}
 

void AdInputStatus(void)
{
////////////////////////////////////////////////////////////////////////////////
	if(ADC_CheckFinish(ADC_Channel_0))		ADC_ChannelEnable(ADC_Channel_0);
	if(ADC_CheckFinish(ADC_Channel_1))		ADC_ChannelEnable(ADC_Channel_1);

//	SerPtr->printf("ADC_Channel_0[%04d]\n", 	ADC_DATA1[FwdOutAvgVolt_2G],	ADC_DATA1[RvsOutVolt_2G],ADC_DATA1[FwdOutAvgVolt_LTE],ADC_DATA1[RvsOutVolt_LTE]);	

//	Data = AdctoVolt5opamp(ADC_AVR[adcFWDPWRdect_3G][0]);

	PrintStar();
	
	ADC_Select(0);

#if 1
	{

//		INT16S Data, tmpx;
        INT16S Data;
        
//		Data = AdctoVolt33V(ADC_SUM[ADC_Channel_14]);
		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_0][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN0] : %d.%03d[V]\n", Data/1000, Data%1000);

		Data = AdctoVolt33V(ADC_AVR[ADC_Channel_1][0]);
		SerPtr->printf(STARMSG);
		SerPtr->printf("[AIN1] : %d.%03d[V]\n", Data/1000, Data%1000);

#if 0 
		Data = (ADC_AVR[ADC_Channel_15][0]);
		tmpx = ReadEnvTempTable(Data);
		SerPtr->printf(STARMSG);
		SerPtr->printf("TEMP                   : %d.%03d[V], %d['C]\n", Data/1000, Data%1000, tmpx/10);
#endif
		
		OSTimeDly(30L);

	}
#endif

	SerPtr->printf("\n\n");
	
	PrintStar();
}




void AdcPrintf(char *sptr, INT16U rawData, INT8U is_5V)
{
	INT16U Data=0;
	if(is_5V) 	Data = AdctoVolt5opamp(rawData);
	else		Data = AdctoVolt33V(rawData);
	
	SerPtr->printf(STARMSG);
	SerPtr->printf("%s: %d.%d[V], [raw:%04d]", sptr, Data/10, Data%10, rawData);
	SerPtr->printf(ENTMSG);
}




INT32U comtstcnt = 0;

void COMTestFunc(void)
{
	INT16U Recv;

	{
		pUSART1.printf(STARMSG);
		pUSART1.printf("통신시험 Ser4[MODEM] 시험을 체크하여 주세요     ");
		pUSART4.BuffClear();
		pUSART4.PutToBuffer(comtstcnt & 0x0f);		

		OSTimeDly(100L);

		if(pUSART4.CheckByte(1, &Recv))
		{
			if( pUSART4.RxGetByte() == (comtstcnt & 0x0f)// &&
				//pUSART3.RxGetByte() == 'b' &&
				//pUSART3.RxGetByte() == 'i' &&
				//pUSART3.RxGetByte() == 'z' &&
				//pUSART3.RxGetByte() == 'i'
				)
						pUSART1.printf("[OK]");
			else		pUSART1.printf("[FAIL 1]");
		}
		else pUSART1.printf("[FAIL 2]: %d", Recv);
		pUSART1.printf(ENTMSG);
	}
		

	pUSART1.printf(ENTMSG);
	pUSART1.printf(ENTMSG);
	comtstcnt++;
}

void CurrentInputStatus(INT8U vcheck)
{
	INT8U tcnt = 0;
	INT8U tval = FALSE;
	
//	INT8U tmpData;

    tcnt = tcnt;

	__PC15_IN_PU();				// F_DONE

//	tmpData = F_DONE;
//	SerPtr->printf("F_DONE[%d]\n",tmpData);

	if(!vcheck)PrintStar();
	{
#if 0
		tval += DigitalInputDiplay(tcnt++, _4G_PLL_LD, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, _3G_PLL_LD, PHAMSG, ENTMSG, vcheck);
#endif
		tval += DigitalInputDiplay(tcnt++, AC_Alarm, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_CDMALTE, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, PLLAlarm_LTE_A2, PHAMSG, ENTMSG, vcheck);


		tval += DigitalInputDiplay(tcnt++, PLLAlarm_WCDMA, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, F_DONE, PHAMSG, ENTMSG, vcheck);

		tval += DigitalInputDiplay(tcnt++, _DTU_Insert, STARMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, _DTU_Insert1, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, _RF_Module_Insert, PHAMSG, NULL, vcheck);
		tval += DigitalInputDiplay(tcnt++, _Ext_Module_Insert, PHAMSG, ENTMSG, vcheck);

 	}
	
	if(!vcheck)PrintStar();
	if(vcheck)
	{
		if(tval) SerPtr->printf("\n");
	}
}



void HwTestOutFunc(INT32U *nFlag)
{
#if 1
	INT32U MaxValue = 0xFFFF;
	INT8U Data = *nFlag;

	INT8U i = 0;

	PCA9555BitRst(GreenLED_CDMA, &AttnCS1Val);
	PCA9555BitRst(RedLED_CDMA,	&AttnCS1Val);
	PCA9555BitRst(GreenLED_WCDMA, &AttnCS1Val);
	PCA9555BitRst(RedLED_WCDMA,	&AttnCS1Val);
	PCA9555BitRst(GreenLED_LTE, &AttnCS1Val);
	PCA9555BitRst(RedLED_LTE,	&AttnCS1Val);
	PCA9555BitRst(GreenLED_LTE_A2, &AttnCS1Val);
	PCA9555BitRst(RedLED_LTE_A2,	&AttnCS1Val);

	PCA9555BitRst(GreenLED_LTE_21, &AttnCS1Val);
	PCA9555BitRst(RedLED_LTE_21,   &AttnCS1Val);


	DL_AmpOnOff_CDMALTE		= 0;
	UL_AmpOnOff_CDMALTE		= 0;
	DL_AmpOnOff_LTEA		= 0;
	UL_AmpOnOff_LTEA		= 0;
	DL_AmpOnOff_WCDMA		= 0;
	UL_AmpOnOff_WCDMA		= 0;

	PCA9555BitRst(Fwd_PLLEN_LTE,  &AttnCS1Val);
	PCA9555BitRst(Rvs_PLLEN_LTE,  &AttnCS1Val);
	PCA9555BitRst(PLLEN_LTE_A,	  &AttnCS1Val);
	PCA9555BitRst(Fwd_PLLEN_WCDMA,&AttnCS1Val);
	PLL_CLK					= 0;
	PLL_DATA				= 0;
	PCA9555BitRst(RVS_PLLEN_WCDMA,&AttnCS1Val);
	
	SMS_PWR 			= 0;


	PCA9555BitRst(SP_EN1,&AttnCS0Val); 
	PCA9555BitRst(SP_EN2,&AttnCS1Val); 


//	DTU_WriteData(CS0, 0, 0);

	for(i = 0;i < Att_SelMax ; i++)
	{
		AttnDataOutput(i, ~0);
	}
	OSTimeDly(50);
	switch(Data)
	{
		case 0:
			PCA9555BitSet(GreenLED_CDMA, &AttnCS1Val);
		break;
		
		case 1:
			PCA9555BitSet(RedLED_CDMA, &AttnCS1Val);
		break;

		case 2:
			PCA9555BitSet(GreenLED_LTE, &AttnCS1Val);
		break;
		
		case 3:
			PCA9555BitSet(RedLED_LTE, &AttnCS1Val);
		break;			
		
		case 4:
			PCA9555BitSet(GreenLED_LTE_A2, &AttnCS1Val);
		break;
		
		case 5:
			PCA9555BitSet(RedLED_LTE_A2, &AttnCS1Val);
		break;	

		case 6:
			PCA9555BitSet(GreenLED_WCDMA, &AttnCS1Val);
		break;
		
		case 7:
			PCA9555BitSet(RedLED_WCDMA, &AttnCS1Val);
		break;			

		case 8:
			PCA9555BitSet(GreenLED_LTE_21, &AttnCS1Val);
		break;
		
		case 9:
			PCA9555BitSet(RedLED_LTE_21, &AttnCS1Val);
		break;


		
		case 10:
			DL_AmpOnOff_CDMALTE 	= 1;
		break;
		
		case 11:
			UL_AmpOnOff_CDMALTE 	= 1;
		break;
		
		case 12:
			DL_AmpOnOff_LTEA		= 1;
		break;
		
		case 13:
			UL_AmpOnOff_LTEA		= 1;
		break;

        case 14:
			DL_AmpOnOff_WCDMA		= 1;
		break;

        case 15:
			UL_AmpOnOff_WCDMA		= 1;
		break;

   		case 16:
			PCA9555BitSet(Fwd_PLLEN_LTE,  &AttnCS1Val);
		break;

   		case 17:
			PCA9555BitSet(Rvs_PLLEN_LTE,  &AttnCS1Val);
		break;

   		case 18:
			PCA9555BitSet(PLLEN_LTE_A,	  &AttnCS1Val);
		break;

   		case 19:
			PCA9555BitSet(Fwd_PLLEN_WCDMA,&AttnCS1Val);
		break;

   		case 20:
			PLL_CLK 				= 1;
		break;

   		case 21:
			PLL_DATA				= 1;
		break;

   		case 22:
			PCA9555BitSet(RVS_PLLEN_WCDMA,&AttnCS1Val);
		break;

   		case 23:
			SMS_PWR				= 1;
		break;

   		case 24:
			PCA9555BitSet(SP_EN1,&AttnCS0Val); 
		break;

   		case 25:
			PCA9555BitSet(SP_EN2,&AttnCS1Val); 
		break;
#if 1
		case 26:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~1);
			}
		break;

		case 27:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~2);
			}
		break;

		case 28:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~4);
			}
		break;

		case 29:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~8);
			}
		break;

		case 30:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~16);
			}
		break;

		case 31:
			for(i = 0;i < Att_SelMax ; i++)
			{
				AttnDataOutput(i, ~32);
			}
		break;
		case 32:
//			DTU_WriteData(CS0, 0, 0xff);
		break;



#endif
 		case 33:
			MaxValue = Data;
			//BuzzShort();
		break;
	}

	*nFlag = *nFlag + 1;

	if(*nFlag >= MaxValue) *nFlag = 0;
#endif
}

INT32U DigitalInputDiplay(INT8U num, INT8U ival,
							INT8U *fmsg, INT8U *emsg,
							INT8U vcheck)
{
	INT32U temp = FALSE;
	INT8U *currentptr = (INT8U *)&tinputSts;
	INT8U *beforeptr = (INT8U *)&tinputStsOld;

	// first
	if(!vcheck)
	{
		if(fmsg != NULL) SerPtr->printf("%s", fmsg);	// start // phase mssage
	}

	currentptr[num] = ival;

	{

		if( (vcheck && (beforeptr[num] != currentptr[num]) ) )
		{
			SerPtr->printf("%02d. ", num);
			SerPtr->printf("%s", tDisplay[num]);
			{
				if(ival) SerPtr->printf(OFFMSG);
				else	 SerPtr->printf(ONMSG);
			}
			temp = TRUE;
		}
		else if(!vcheck)
		{
			SerPtr->printf("%s", tDisplay[num]);
			{
				if(ival) SerPtr->printf(OFFMSG);
				else	 SerPtr->printf(ONMSG);
			}
		}
	}

////////////////////////////////////////////////////////////////////////////////
	if(vcheck)
	{
		if(temp)
		{
			OSTimeDly(1L);
			SerPtr->printf(ENTMSG);
		}
	}
	else
	{
		if(emsg)
		{
			OSTimeDly(1L);
			SerPtr->printf(ENTMSG);
		}
	}

	beforeptr[num] = currentptr[num];
	return (INT32U)temp;
}


INT8U returnmsgTest(char *str)
{
	SerPtr->printf("%s이 수행되어 있습니다. 계속 진행하시겠습니까?[Y]es, [C]ancel\n", str);
	return WaringMssageReturn();
}

INT8U WaringMssageReturn(void)
{
	INT16U nCnt;

	TimerRegist(TimerTest, Time1Sec*5L);

	while(1)
	{
		if(TimeOverCheck(TimerTest))
		{
			TimerRegist(TimerTest, Time1Sec*5L);
			return TRUE;
		}
		if(SerPtr->CheckByte(1, &nCnt))
		{
			nCnt = SerPtr->RxGetByte();
			if(nCnt == 'C' || nCnt == 'c')
			{
				SerPtr->printf("CANCEL TEST \n");
				return FALSE;
			}
			else return TRUE;
		}
		OSTimeDly(10L);
	}
}
#if 1
INT8U SavetoTestBackup(INT8U tmpIndex, INT8U tSet, INT8U IsItLoad)
{
#if 0
	EE_TABLE1 *ptr = &gEE_TABLE1;
	INT32U AddrOffset = vEE_TABLE1Addr + (INT32U)&(ptr->BdTestBp) - (INT32U )&gEE_TABLE1;

	AddrOffset += tmpIndex;

	if(IsItLoad)
	{
		ptr->BdTestBp[tmpIndex] = tSet;
		WriteEEprom(At24cDevID, AddrOffset, tSet, 0);
	}
	return (ptr->BdTestBp[tmpIndex]);
#endif

return 0;

}
#endif

void PrintLogo(void)
{

	SerPtr->printf("\n\n");
	PrintStar();
	SerPtr->printf("*\n");
	SerPtr->printf("* %s [VER:%d.%d]\n", BoardTestMode, (SystemVer >> 4 & 0x0f), (SystemVer >> 0 & 0x0f));
	SerPtr->printf("*    -COMMAND 1st-\n");
	SerPtr->printf("*  ?        : help(this message)\n");
	SerPtr->printf("*  TEST I        : INPUT Test          [%s]\n", testResult[0x03 & SavetoTestBackup(InputTest, NULL, NULL)]);
	SerPtr->printf("*  TEST O        : OUTPUT Test         [%s]\n", testResult[0x03 & SavetoTestBackup(OutputTest,  NULL, NULL)]);
	SerPtr->printf("*  TEST C        : SERIAL[UART]        [%s]\n", testResult[0x03 & SavetoTestBackup(CommTest, NULL, NULL)]);
	SerPtr->printf("*  TEST A        : ANALOG DECT         [%s]\n", testResult[0x03 & SavetoTestBackup(ADCTest, 	NULL, NULL)]);
//	SerPtr->printf("*  TEST E        : EEPROM TEST         [%s]\n", testResult[0x03 & SavetoTestBackup(EepromTest, NULL, NULL)]);
//	SerPtr->printf("*  TEST S        : Factory SET\n");
	SerPtr->printf("*  RESET         : RESET\n");
	SerPtr->printf("*  TEST SRAM	 : SRAM TEST\n");
	SerPtr->printf("*  FPGA DET 0(ADDR) : DTU DET TEST\n");
	SerPtr->printf("*  FPGA ISO 0(ADDR) : DTU ISO TEST\n");
	SerPtr->printf("*  FPGA W 0(ADDR) 1(Data)    : DTU REG Write TEST\n");
	SerPtr->printf("*  FPGA R 0(ADDR)            : DTU REG Read TEST\n");
	SerPtr->printf("*  FLASH 0 W 0(ADDR) 1(Data) : DTU Flash REG Write TEST\n");
	SerPtr->printf("*  FLASH 0 R 0(ADDR)         : DTU Flash REG Read TEST\n");


//	SerPtr->printf("*  G        : compulsory boot/#,\n");
	
	PrintStar();
}




void PrintStar(void)
{
	SerPtr->printf("*******************************************************************************\n");
}

void PromptOut(void)
{
	SerPtr->printf("TRIO-MD >>");
}


INT8U RAMAccesscheck(void)
{
	int i = 0;
	INT8U rval = FALSE;
	
	volatile INT8U	*upLdAddr = (INT8U * )(Bank1_SRAM1_ADDR);

//	if(msRAMIns == SRAM_INSERT){
	{
		rval = TRUE;
		
		for(i = 0; i < (1*(1024)); i++)
		{
			*(upLdAddr + i) = (INT8U)i;
			if(*(upLdAddr + i) != (INT8U)i)
			{
				rval = FALSE;
				break;			
			}
		}
		
	}
////
#if 0
	{
		INT32U i = 0, j = 0, ret = 0;

		INT8U *rptr = (INT8U *)__pAPBK_SRAMAddr;				

		tptr->printf("SRAM START --> \n");

		for(i = 0; i < (512*1024) && !ret; i++)
		{
			for(j = 0; j < 8 && !ret; j++)
			{
				*(rptr + i) = 1 << j;

				if( *(rptr + i) != (1 << j))
				{
					tptr->printf("SRAM WRITE ERROR: ADDR: %02x, %02x \n", i, j, *(rptr + i));
					ret = TRUE;
					break;
				}
			}
			WatchdogClear();
			if(!(i%32)) tptr->printf(".");
		}
		tptr->printf("\nEND\n");
	}

#endif



///


	return rval;
}
/*#################################################*/
/*###  입력된 문자열에서 Space로 분리된 단어를  ###*/
/*###  분리한다.                                ###*/
/*###  입력 : buff    --> 문자열 포인터.        ###*/
/*###  출력 : argc    --> Argument Number.      ###*/
/*###         *argv[] --> Argument Buff.        ###*/
/*#################################################*/
void Parser(char *buff)
{
    Argc=0;
    while(*buff){
        while(*buff==' ')
            buff++;
        if(!*buff)
            break;
        Argv[Argc++]=buff++;
        while(*buff!=' ' && *buff)
            buff++;
        if(*buff)
            *buff++='\0';
        if(Argc>=MAX_SARGC)
            break;
    }
}

/*#################################################*/
/*## 입력된 ASCII문자를 32Bit HEX로 변환.        ##*/
/*#################################################*/
int Atox(char *Buff)
{
	int Hex;
	INT8U Len;
	INT8U i;

	Len=strlen(Buff);
	for(i=0,Hex=0;i<Len;i++){
		Hex|=(((int)Atox4(*Buff++))<<((Len-i-1)*4));
	}
	return(Hex);
}
/*#################################################*/
/*## 입력된 2 Byte ASCII문자를 8Bit HEX로 변환.  ##*/
/*#################################################*/
char Atox8(char *Buff)
{
	char Data;
	Data=Atox4(*Buff++)<<4 & 0xF0;
	Data|=Atox4(*Buff);
	return(Data);
}
/*#################################################*/
/*## 입력된 한 Byte ASCII문자를 4Bit HEX로 변환. ##*/
/*#################################################*/
char Atox4(char Ascii)
{
   	if(Ascii>='0' && Ascii<='9') return(Ascii-'0');
   	if(Ascii>='A' && Ascii<='F') return(Ascii-'A'+10);
   	if(Ascii>='a' && Ascii<='f') return(Ascii-'a'+10);
   	return(0);
}



int lower(char c)
{
	if(c>='a'&&c<='z')
		return c+'A'-'a';
	else

	return c;
}




INT32S sSPI_DataRead(DevSPIxStr *Devptr, INT8U Path, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT8U err = 0;
	INT8U tmp = 0;
	INT32U i = 0;

//	OSSemPend(Devptr->OSSem, 0, &err);

	Devptr->nDevNo = Path;

	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand_Test(Devptr->SPIx, OPCODE);

	SetSPIxCommand_Test(Devptr->SPIx, (ADDR >> 16) & 0xFF);
	SetSPIxCommand_Test(Devptr->SPIx, (ADDR >>  8) & 0xFF);
	SetSPIxCommand_Test(Devptr->SPIx, (ADDR >>  0) & 0xFF);


	for(i = 0; i < nlen; i++)
	{
		DATA[i] = SetSPIxCommand_Test(Devptr->SPIx, DATA[i]);
	}

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	
//	OSSemPost(Devptr->OSSem);

	return tmp;
}



INT32S sSPI_SetRegister(DevSPIxStr *Devptr, INT8U Path, INT8U OPCODE, INT32U ADDR, INT8U *DATA, INT32U nlen)
{
	INT32U i = 0;
	INT8U NeedAddr = FALSE;

	Devptr->nDevNo = Path;

	iDev_SPIx_CS_RST(Devptr->nDevNo);

	SetSPIxCommand(Devptr->SPIx, OPCODE);

	if(NeedAddr){
		SetSPIxCommand(Devptr->SPIx, (ADDR >> 16) & 0xFF);
		SetSPIxCommand(Devptr->SPIx, (ADDR >>  8) & 0xFF);
		SetSPIxCommand(Devptr->SPIx, (ADDR >>  0) & 0xFF);
	}

	for(i = 0; i < nlen; i++)
	{
		DATA[i] = SetSPIxCommand(Devptr->SPIx, DATA[i]);
	}

	iDev_SPIx_CS_SET(Devptr->nDevNo);

	return i;
}



///////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

