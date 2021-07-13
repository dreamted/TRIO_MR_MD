/*!
*********************************************************************************************************
*              	- AD9362 CODE
*
*              	-(c) Copyright 2007-2012;
*
*              	-All rights reserved.  Protected by international copyright laws.
*              	-Knowledge of the source code may NOT be used to develop a similar product.
*              	-Please help us continue to provide the Embedded community with the finest
*              	-software available.  Your honesty is greatly appreciated.
*
* 				-file 		: iapd.c
* 				-author		: Yoon Byong-Gyu, bgyoon@naver.com
* 				-date		: 2012.05.
*********************************************************************************************************
*/
#define AD9362_C

#include "../include/main.h"

INT8U AD9362Init(INT8U ch, INT8U IsItReset)
{

	union __ADDR_0x000{
		INT8U Data;
		struct{
			INT8U SoftRst		:1; 	// 0: NORMAL,	1: RESET
			INT8U SPIType		:1; 	// 0: 4-Wire,	1: 3-Wire
			INT8U LSBFirst		:1; 	// 0: MSB,		1: LSB
		};
	} tmp;

	tmp.SoftRst = IsItReset;
	tmp.SPIType = RESET;
	tmp.LSBFirst = RESET;

	WriteFPGAs(ch, ADDR_SPICONF, &tmp.Data, 1);

	return tmp.Data;
}

//#define AD9362_DEBUG


void AD9362InitSet(INT8U ch, INT8U type)
{
	INT8U *ptr;
	INT16U i = 0;
	INT8U rRegData = 0;
	
	switch(ch)
	{
		case SPI_3G_TX_CH:
			ptr = (INT8U *)vEE_3G_TX;
		break;

		case SPI_3G_RX_CH:
			ptr = (INT8U *)vEE_3G_RX;
		break;

		case SPI_4G_TX_CH:
			     if(type == LTE_10MHz)	ptr = (INT8U *)vEE_4G_TX_10MHz;
			else if(type == LTE_15MHz)	ptr = (INT8U *)vEE_4G_TX_15MHz;
			else if(type == LTE_20MHz)	ptr = (INT8U *)vEE_4G_TX_20MHz;
		break;

		case SPI_4G_RX_CH:
			     if(type == LTE_10MHz)	ptr = (INT8U *)vEE_4G_RX_10MHz;
			else if(type == LTE_15MHz)	ptr = (INT8U *)vEE_4G_RX_15MHz;
			else if(type == LTE_20MHz)	ptr = (INT8U *)vEE_4G_RX_20MHz;
		break;
	}

	
	for(i = 0; i < sizeAD9362Set; i++)
	{
		if(AD9362SetAddr[i] != 0x064 && AD9362SetAddr[i] != 0x0F4)
		{
			if(AD9362SetAddr[i] == 0x0A3)
			{
				WriteAD9362(ch, AD9362SetAddr[i], rRegData & 0xc0);
#ifdef AD9362_DEBUG
				SerPtr->printf("SPIWrite   %03x,%02x\n", AD9362SetAddr[i], rRegData & 0xc0);
#endif
			}
			else {
				WriteAD9362(ch, AD9362SetAddr[i], *ptr);
#ifdef AD9362_DEBUG
				SerPtr->printf("SPIWrite   %03x,%02x\n", AD9362SetAddr[i], *ptr);
#endif
			}
			ptr++;
		}
		else{
			WriteAD9362(ch, AD9362SetAddr[i], 0x00);
#ifdef AD9362_DEBUG
			SerPtr->printf("SPIWrite   %03x,%02x\n", AD9362SetAddr[i], 0x00);
#endif
		}
		
		switch(i)
		{
			case 0:
			case 9:
        	case 29:
			case 799:
				OSTimeDly(20);
#ifdef AD9362_DEBUG
				SerPtr->printf("wait 20ms\n");
#endif
			break;

			case 30:
			case 801:
			case 1570:
			case 1575:
			case 1585:			// Setup AuxADC
			case 1591:			// Setup Control Outs
			case 1593:			// Setup GPO
			case 1604:
			case 1618:
			case 1621:
			case 1634:
			case 1645:
			case 1774:
			case 2416:
			case 2435:
			case 2439:
			case 2446:
			case 2448:
			case 2456:
			case 2509:
			case 2530:
			case 2534:
			case 2544:
			case 2546:
				OSTimeDly(1);	// wait 1ms
#ifdef AD9362_DEBUG
				if(i == 1593) SerPtr->printf("// Setup GPO\n");
				if(i == 1634) SerPtr->printf("// Setup Synthesizer \n");
				if(i == 1774) SerPtr->printf("// Program Rx Gain Tables with GainTable800MHz.csv \n");
				if(i == 2416) SerPtr->printf("// Setup Rx Manual Gain Registers \n");
				if(i == 2435) SerPtr->printf("// RX Baseband Filter Tuning (Real BW: 7.000000 MHz) 3dB Filter \n");
				if(i == 2446) SerPtr->printf("// TX Baseband Filter Tuning (Real BW: 7.000000 MHz) 3dB Filter \n");
				if(i == 2456) SerPtr->printf("// TX Secondary Filter Calibration Setup:  Real Bandwidth \n");
				if(i == 2530) SerPtr->printf("// Set Tx Attenuation: Tx1: 10.00 dB,  Tx2: 10.00 dB \n");
				if(i == 2534) SerPtr->printf("// Setup RSSI and Power Measurement Duration Registers \n");
				if(i == 2546) SerPtr->printf("// END\n");
				
				SerPtr->printf("wait 1ms\n");
#endif
			break;
			
			case 25:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				if(i == 25)	SerPtr->printf("wait 0x05E lock\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x05E);
					if(BitRead(tmp, 7)) ret = FALSE;
					OSTimeDly(200L);
				}
			}
			break;

			case 1622:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				if(i == 1622)	SerPtr->printf("wait 0x244 lock\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x244);
					if(BitRead(tmp, 7)) ret = FALSE;
					OSTimeDly(200L);
				}
			}
			break;

			case 1623:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("wait 0x284 lock\n");
				SerPtr->printf("Setup Synthesizer\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x284);
					if(BitRead(tmp, 7)) ret = FALSE;
					OSTimeDly(200L);
				}
			}
			break;

			case 1657:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("wait 0x247[1] lock\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x247);
					if(BitRead(tmp, 1)) ret = FALSE;
					OSTimeDly(200L);
				}
			}
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("wait 0x287[1] lock\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x287);
					if(BitRead(tmp, 1)) ret = FALSE;
					OSTimeDly(200L);
				}
			}
#ifdef AD9362_DEBUG
				SerPtr->printf("// Program Mixer GM Sub-table \n");
#endif

			break;
			case 2444:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("(Done when 0x016[7]==0)\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x016);
					if(!BitRead(tmp, 7)) ret = FALSE;
					OSTimeDly(10);
				}
			}
			break;
			case 2450:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("(Done when 0x016[6]==0)\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x016);
					if(!BitRead(tmp, 6)) ret = FALSE;
					OSTimeDly(10);
				}
			}		
			break;
			case 2451:
#ifdef AD9362_DEBUG
				if(i == 2451) SerPtr->printf("// RX TIA Setup:  Setup values scale based on RxBBF calibration \n");
#endif
				{
					INT8U tmp = 0;
					tmp = ReadAD9362(ch, 0x1EB);
                    tmp = tmp;
#ifdef AD9362_DEBUG
					SerPtr->printf("// Read RXBBF C3(MSB) = %02x\n", tmp);
#endif
					tmp = ReadAD9362(ch, 0x1EC);
#ifdef AD9362_DEBUG
					SerPtr->printf("// Read RXBBF C3(LSB) = %02x\n", tmp);
#endif
					tmp = ReadAD9362(ch, 0x1E6);
#ifdef AD9362_DEBUG
					SerPtr->printf("// Read RXBBF R2346 = %02x\n", tmp);
#endif
				}
			break;

			case 2459:
				{
					INT8U tmp = 0;
					tmp = ReadAD9362(ch, 0x1EB);
                    tmp = tmp;
#ifdef AD9362_DEBUG
					SerPtr->printf("// Read RXBBF C3(MSB) = %02x\n", tmp);
#endif
					tmp = ReadAD9362(ch, 0x1EC);
#ifdef AD9362_DEBUG
					SerPtr->printf("// Read RXBBF C3(LSB) = %02x\n", tmp);
#endif
					tmp = ReadAD9362(ch, 0x1E6);
#ifdef AD9362_DEBUG
					SerPtr->printf("// Read RXBBF R2346 = %02x\n", tmp);
#endif
				}
#ifdef AD9362_DEBUG
				if(i == 2459) SerPtr->printf("// ADC Setup:  Tune ADC Performance based on RX analog filter tune \n");
#endif
			break;

			case 2499:
				//if(i == 2499) SerPtr->printf("// Tx Quadrature Calibration Settings \n");
				rRegData = ReadAD9362(ch, 0x0A3);
			break;

			case 2513:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("(Done when 0x016[0]==0)\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x016);
					if(!BitRead(tmp, 0)) ret = FALSE;
					OSTimeDly(10);
				}
			}
			break;
			
			case 2520:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("(Done when 0x016[1]==0)\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x016);
					if(!BitRead(tmp, 1)) ret = FALSE;
					OSTimeDly(10);
				}
			}
			break;
			
			case 2521:
			{
				INT8U ret = TRUE;
				INT8U cnt = 20;
				INT8U tmp;
#ifdef AD9362_DEBUG
				SerPtr->printf("(Done when 0x016[4]==0)\n");
#endif
				while(ret && cnt--)
				{
					tmp = ReadAD9362(ch, 0x016);
					if(!BitRead(tmp, 4)) ret = FALSE;
					OSTimeDly(10);
				}
			}
			break;

		}
			
	}
	switch(ch)
	{
		case SPI_3G_TX_CH:
			SerPtr->printf("3G TX AD9362 INIT END\n");
		break;

		case SPI_3G_RX_CH:
			SerPtr->printf("3G RX AD9362 INIT END\n");
		break;

		case SPI_4G_TX_CH:
			SerPtr->printf("4G TX AD9362 INIT END\n");
		break;

		case SPI_4G_RX_CH:
			SerPtr->printf("4G RX AD9362 INIT END\n");
		break;
	}
	
	OSTimeDly(20L);
}


INT8U AD9362TxOn(INT8U ch, INT8U TxOn)
{
	union __ADDR_0x014{
		INT8U Data;
		struct{
			INT8U ToAlert		:1;
			INT8U AutoGainLock	:1;
			INT8U ForceAlertSts	:1;
			INT8U LvlMode		:1;
			
			INT8U EnENSMpin		:1;
			INT8U TxOn			:1;
			INT8U RxOn			:1;
			INT8U EnRxDataPort	:1;
			
		};
	} tmp;
	tmp.Data = 0x09;
	tmp.TxOn = TxOn;
	WriteAD9362(ch, ADDR_ENSMCFG1, tmp.Data);
    
    return tmp.Data;
}



INT8U AD9362TxEnable(INT8U ch, INT8U Tx1En, INT8U Tx2En)
{
	union __ADDR_0x002{
		INT8U Data;
		struct{
			INT8U TxFIREn		:2;
			INT8U THB1En		:1;
			INT8U THB2En		:1;
			
			INT8U THB3En		:2;
			INT8U Tx1En			:1;
			INT8U Tx2En			:1;
		};
	} tmp;

	ReadFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);

	tmp.Tx1En = Tx1En;
	tmp.Tx2En = Tx2En;

	WriteFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);

	return tmp.Data;
}

INT8U AD9362TxFilterSet(INT8U ch, INT8U THB3En, INT8U THB2En, INT8U THB1En, INT8U TxFIREn)
{
	union __ADDR_0x002{
		INT8U Data;
		struct{
			INT8U TxFIREn		:2;
			INT8U THB1En		:1;
			INT8U THB2En		:1;
			
			INT8U THB3En		:2;
			INT8U Tx1En			:1;
			INT8U Tx2En			:1;
			
		};
	} tmp;

	ReadFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);

	tmp.TxFIREn = TxFIREn;
	tmp.THB1En = THB1En;
	tmp.THB2En = THB2En;
	tmp.THB3En = THB3En;

	WriteFPGAs(ch, ADDR_TXEN, &tmp.Data, 1);

	return tmp.Data;
}


INT8U AD9362RxEnable(INT8U ch, INT8U Rx1En, INT8U Rx2En)
{
	union __ADDR_0x003{
		INT8U Data;
		struct{
			INT8U RxFIREn		:2;
			INT8U RHB1En		:1;
			INT8U RHB2En		:1;
			
			INT8U RHB3En		:2;
			INT8U Rx1En			:1;
			INT8U Rx2En			:1;
		};
	} tmp;
	
	ReadFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);

	tmp.Rx1En = Rx1En;
	tmp.Rx2En = Rx2En;

	WriteFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);

	return tmp.Data;
}

INT8U AD9362RxFilterSet(INT8U ch, INT8U RHB3En, INT8U RHB2En, INT8U RHB1En, INT8U RxFIREn)
{
	union __ADDR_0x003{
		INT8U Data;
		struct{
			INT8U RxFIREn		:2;
			INT8U RHB1En		:1;
			INT8U RHB2En		:1;
			
			INT8U RHB3En		:2;
			INT8U Rx1En 		:1;
			INT8U Rx2En 		:1;
		};
	} tmp;
	
	ReadFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);

	tmp.RxFIREn = RxFIREn;
	tmp.RHB1En = RHB1En;
	tmp.RHB2En = RHB2En;
	tmp.RHB3En = RHB3En;

	WriteFPGAs(ch, ADDR_RXEN, &tmp.Data, 1);

	return tmp.Data;
}




INT8U AD9362InOutSelect(INT8U ch, INT8U Tx_AEn,
								  INT8U Rx_ANEn, INT8U Rx_APEn,
								  INT8U Rx_BNEn, INT8U Rx_BPEn,
								  INT8U Rx_CNEn, INT8U Rx_CPEn)
{
	union __ADDR_0x004{
		INT8U Data;
		struct{
			INT8U Rx_ANEn		:1;
			INT8U Rx_APEn		:1;
			INT8U Rx_BNEn		:1;
			INT8U Rx_BPEn		:1;
			
			INT8U Rx_CNEn		:1;
			INT8U Rx_CPEn		:1;
			INT8U Tx_2AEn		:1;
		};
	} tmp;
	
	ReadFPGAs(ch, ADDR_INPUTSEL, &tmp.Data, 1);

	tmp.Rx_ANEn = Rx_ANEn;
	tmp.Rx_APEn = Rx_APEn;
	tmp.Rx_BNEn = Rx_BNEn;
	tmp.Rx_BPEn = Rx_BPEn;
	tmp.Rx_CNEn = Rx_CNEn;
	tmp.Rx_CPEn = Rx_CPEn;
	
	tmp.Tx_2AEn = Tx_AEn;

	WriteFPGAs(ch, ADDR_INPUTSEL, &tmp.Data, 1);

	return tmp.Data;
}

void AD9362CLKSelect(INT8U ch, INT8U type)
{
	{
		union __ADDR_0x009{
			INT8U Data;
			struct{
				INT8U BBPLLEn			:1;
				INT8U DCXOEn			:1;
				INT8U DigPwrUp			:1;
				INT8U BBPLLForceLock	:1;
				
				INT8U XOBypass			:1;
				INT8U BypassBBPLL		:1;
			};
		} tmp;
		
		ReadFPGAs(ch, ADDR_CLKEN, &tmp.Data, 1);

		tmp.BBPLLEn = SET;
		if(type == XTALN)
		{
			tmp.DCXOEn = SET;
			tmp.XOBypass = SET;
		}
		else if(type == REFCLK)
		{
			tmp.DCXOEn = RESET;
			tmp.XOBypass = RESET;
		}
		else if(type == DCXOCLK)
		{
			tmp.DCXOEn = SET;
			tmp.XOBypass = RESET;
		}
		WriteFPGAs(ch, ADDR_CLKEN, &tmp.Data, 1);
	}

	{
		union __ADDR_0x2AB{
			INT8U Data;
			struct{
				INT8U RxRefDiv			:1;
				INT8U RxrefRstBar		:1;
				INT8U RefclkPwrDn		:1;
			};
		} tmp;
		
		ReadFPGAs(ch, ADDR_REFDIV1, &tmp.Data, 1);

			 if(type == XTALN) 	tmp.RefclkPwrDn = SET;
		else if(type == REFCLK) tmp.RefclkPwrDn = RESET;
		else if(type == DCXOCLK)tmp.RefclkPwrDn = SET;

		WriteFPGAs(ch, ADDR_REFDIV1, &tmp.Data, 1);
	}
}


INT8U AD8362BPPLLWrite(INT8U ch, INT32U fLo)
{
	{
#define BPPLLx1			0x00
#define BPPLLd2			0x01
#define BPPLLd4			0x02
#define BPPLLx2			0x03

		union __ADDR_0x045{
			INT8U Data;
			struct{
				INT8U RefClkSclaer		:2;
				INT8U PFDClkEdge		:1;
				INT8U PFDRstDelay		:2;
				
				INT8U RefClkInv			:1;
				INT8U FBClkInv			:1;
				INT8U PLLFBInv			:1;
			};
		} tmp;
		
		ReadFPGAs(ch, ADDR_BBCLKCTRL, &tmp.Data, 1);
		tmp.RefClkSclaer = BPPLLx2;
		WriteFPGAs(ch, ADDR_BBCLKCTRL, &tmp.Data, 1);	// Set BBPLL reflclk scale to REFCLK * 2
	}

	WriteAD9362(ch, 0x046, 0x03);	// Set BBPLL Loop Filter Charge Pump current
	WriteAD9362(ch, 0x048, 0xE8);	// Set BBPLL Loop Filter C1, R1
	WriteAD9362(ch, 0x049, 0x5B);	// Set BBPLL Loop Filter R2, C2, C1
	WriteAD9362(ch, 0x04A, 0x35);	// Set BBPLL Loop Filter C3,R2
	WriteAD9362(ch, 0x04B, 0xE0);	// Allow calibration to occur and set cal count to 1024 for max accuracy
	WriteAD9362(ch, 0x04E, 0x10);	// Set calibration clock to REFCLK/4 for more accuracy
	{
		unsigned long int PLL_INT = 0;
		unsigned long int PLL_MOD = 0;
		
		INT8U tmp;
		
		PLL_INT = fLo/AD9362BPPRefClk;
		PLL_MOD = (unsigned int)((((float)fLo / (float)AD9362BPPRefClk) - (float)PLL_INT)* 2088960); 
//		tmp1	= ((float)fLo / (float)AD9362BPPRefClk);
//		SerPtr->printf("%d, %d %f, \n", PLL_INT, PLL_MOD, tmp1);
		tmp = PLL_INT;
		WriteFPGAs(ch, ADDR_BBINT, &tmp, 1);
		tmp = (PLL_MOD >> 16) & 0xff;
		WriteFPGAs(ch, ADDR_BBMOD1, &tmp, 1);
		tmp = (PLL_MOD >> 8) & 0xff;
		WriteFPGAs(ch, ADDR_BBMOD2, &tmp, 1);
		tmp = (PLL_MOD >> 0) & 0xff;
		WriteFPGAs(ch, ADDR_BBMOD3, &tmp, 1);

	}

	{
		union __ADDR_0x03F{
			INT8U Data;
			struct{
				INT8U BBPLLRstBar		:1;
				INT8U BBPLLSDMBypass	:1;
				INT8U InitBBFOCAL		:1;
				INT8U BBPLLSDMClkEnBar	:1;
				
				INT8U SDMSIFData		:4;
			};
		} tmp;
		
		ReadFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1);
		tmp.BBPLLRstBar = SET;
		tmp.InitBBFOCAL = SET;
		WriteFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1);	// Start BBPLL Calibration

		ReadFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1);
		tmp.InitBBFOCAL = RESET;
		WriteFPGAs(ch, ADDR_SDMCTRL1, &tmp.Data, 1); 	// Clear BBPLL start calibration bit
	}

	WriteAD9362(ch, 0x04C, 0x86);	// Increase BBPLL KV and phase margin
	WriteAD9362(ch, 0x04D, 0x01);	// Increase BBPLL KV and phase margin
	WriteAD9362(ch, 0x04D, 0x05);	// Increase BBPLL KV and phase margin

	{
		union __ADDR_0x05E{
			INT8U Data;
			struct{
				INT8U 				:7;
				INT8U BBPLLLock		:1;
			};
		} tmp;
		INT8U rtry = 100;
		
		tmp.BBPLLLock = 0;
		while(!tmp.BBPLLLock && rtry--)
		{
			ReadFPGAs(ch, 0x05E, &tmp.Data, 1); // Check BBPLL locked status  (0x05E[7]==1 is locked)
			OSTimeDly(100L);
		}

		return tmp.BBPLLLock;
	}
}

INT8U AD9362RxLOPLLCtrl(INT8U ch, INT64U fLo, INT32U offset)
{
	unsigned long long int FrfVCO;
	unsigned int Fref = AD9362RefClk;
	unsigned int VCODivider = 0;	
	int i = 0;
	INT8U multiplier = 0;


	VCODivider = (ReadAD9362(ch, ADDR_RFPLLDIVIDER) & 0x03);

	for(i = 0, multiplier = 1; i < VCODivider + 1; i++)
	{
		multiplier = multiplier*2;		
	}

	FrfVCO = fLo*multiplier;

	{
		INT8U A_Div = 0;
		union __ADDR_0x2AB {
			INT8U Data;
			struct {
				INT8U RxRefDiv1			:1;
				INT8U RxRefRstBar		:1;
				INT8U RefClkInPwrDn		:1;
			};
		} A_2AB;

		union __ADDR_0x2AC {
			INT8U Data;
			struct {
				INT8U TxRefFBDelay		:2;
				INT8U TxRefDiv			:2;

				INT8U TxRefRstBar		:1;
				INT8U RxRefFBDelay		:2;
				INT8U RxRefDiv0			:1;
			};
		} A_2AC;

		A_2AB.Data = ReadAD9362(ch, ADDR_REFDIV1);
		A_2AC.Data = ReadAD9362(ch, ADDR_REFDIV2);

		if(A_2AB.RxRefDiv1) BitSet(A_Div, 1);
		if(A_2AC.RxRefDiv0) BitSet(A_Div, 0);

		     if(A_Div == 0)	Fref = Fref * 1;
		else if(A_Div == 1)	Fref = Fref / 2;
		else if(A_Div == 2)	Fref = Fref / 4;
		else				Fref = Fref * 2;
		
	}

	{
		unsigned long int PLL_INT = 0;
		unsigned long int PLL_MOD = 0;
		
		PLL_INT = FrfVCO/Fref;
		PLL_MOD = (unsigned int)((((double)FrfVCO / (double)Fref) - (float)PLL_INT)* 8388593);
		PLL_MOD += offset;

		WriteAD9362(ch, ADDR_RXFRAC0, (PLL_MOD >>  0) & 0xff);
		WriteAD9362(ch, ADDR_RXFRAC1, (PLL_MOD >>  8)& 0xff);
		WriteAD9362(ch, ADDR_RXFRAC2, (PLL_MOD >> 16) & 0xff);
		
		WriteAD9362(ch, ADDR_RXINT1, (PLL_INT >> 8) & 0xff);
		WriteAD9362(ch, ADDR_RXINT0, (PLL_INT >> 0) & 0xff);

	//SerPtr->printf("PLL_INT = %d \n", PLL_INT);
	//SerPtr->printf("0x231 = %02x, 0x232 = %02x \n", PLL_INT & 0xFF, (PLL_INT >> 8) & 0x07); 
	//SerPtr->printf("0x233 = %02x, 0x234 = %02x 0x235 = %02x\n", PLL_MOD & 0xFF, (PLL_MOD >> 8) & 0xFF, (PLL_MOD >> 16)& 0xFF); 

	}

	{
		INT8U tmp = 0;
		INT8U rtry = 100;
		
		while(rtry--)
		{
			tmp = ReadAD9362(ch, 0x247); // Check BBPLL locked status  (0x05E[7]==1 is locked)
			if(BitRead(tmp, 1)) break;
			OSTimeDly(20L);
		}
		return (!BitRead(tmp, 1));
	}
}

INT8U AD9362TxLOPLLCtrl(INT8U ch, INT64U fLo, INT32U offset)
{

	unsigned long long int FrfVCO;
	unsigned int Fref = AD9362RefClk;
	unsigned int VCODivider = ((ReadAD9362(ch, ADDR_RFPLLDIVIDER) >> 4) & 0x03);
	
	int i = 0;
	INT8U multiplier = 0;
	
	for(i = 0, multiplier = 1; i < VCODivider + 1; i++)
	{
		multiplier = multiplier*2;		
	}

	FrfVCO = fLo*multiplier;

	{
		INT8U A_Div = 0;

		union __ADDR_0x2AC {
			INT8U Data;
			struct {
				INT8U TxRefFBDelay		:2;
				INT8U TxRefDiv			:2;

				INT8U TxRefRstBar		:1;
				INT8U RxRefFBDelay		:2;
				INT8U RxRefDiv0			:1;
			};
		} A_2AC;

		A_2AC.Data = ReadAD9362(ch, ADDR_REFDIV2);

		A_Div = A_2AC.TxRefDiv;
		
		     if(A_Div == 0)	Fref = Fref * 1;
		else if(A_Div == 1)	Fref = Fref / 2;
		else if(A_Div == 2)	Fref = Fref / 4;
		else				Fref = Fref * 2;
		
	}

	{
		unsigned long int PLL_INT = 0;
		unsigned long int PLL_MOD = 0;
		
		PLL_INT = FrfVCO/Fref;
		PLL_MOD = (unsigned int)((((double)FrfVCO / (double)Fref) - (float)PLL_INT)* 8388593);
		PLL_MOD += offset;
		
		WriteAD9362(ch, ADDR_TXFRAC0, (PLL_MOD >>  0) & 0xff);
		WriteAD9362(ch, ADDR_TXFRAC1, (PLL_MOD >>  8)& 0xff);
		WriteAD9362(ch, ADDR_TXFRAC2, (PLL_MOD >> 16) & 0xff);
		
		WriteAD9362(ch, ADDR_TXINT1, (PLL_INT >> 8) & 0xff);
		WriteAD9362(ch, ADDR_TXINT0, (PLL_INT >> 0) & 0xff);
	}

	{
		INT8U tmp = 0;
		INT8U rtry = 100;
		
		while(rtry--)
		{
			tmp = ReadAD9362(ch, 0x287); // Check BBPLL locked status  (0x05E[7]==1 is locked)
			if(BitRead(tmp, 1)) break;
			OSTimeDly(20L);
		}
		return (!BitRead(tmp, 1));
	}
}


void AD9362BPPLLCtrl(INT8U ch, INT8U ADCDiv, INT8U DACDiv2En)
{
	union __ADDR_0x00A{
		INT8U Data;
		struct{
			INT8U BBPLLDiv			:3;
			INT8U DACDiv2En			:1;
			
			INT8U CLKOutEn			:1;
			INT8U CLKOutSel			:3;
		};
	} tmp;
	
	ReadFPGAs(ch, ADDR_BPPLL, &tmp.Data, 1);

	tmp.BBPLLDiv = ADCDiv;
	tmp.DACDiv2En = DACDiv2En;

	WriteFPGAs(ch, ADDR_BPPLL, &tmp.Data, 1);

}

void AD9362RxFilterConf(INT8U ch, INT8U NoOfTabs)
{
	union __ADDR_0x0F5{
		INT8U Data;
		struct{
			INT8U 					:1;
			INT8U StarRxClk 		:1;
			INT8U WriteRx			:1;
			INT8U Rx1Sel			:1;

			INT8U Rx2Sel			:1;
			INT8U NoOfTabs			:3;
		};
	} tmp;

	ReadFPGAs(ch, ADDR_RXFILTER, &tmp.Data, 1);

	tmp.NoOfTabs = NoOfTabs;

	WriteFPGAs(ch, ADDR_RXFILTER, &tmp.Data, 1);
	

}



void AD9362RxFilterGain(INT8U ch, INT8U Gain)
{
	union __ADDR_0x0F6{
		INT8U Data;
		struct{
			INT8U Gain			:2;
		};
	} tmp;

	tmp.Data = 0;
	
	tmp.Gain = Gain;

	WriteFPGAs(ch, ADDR_RXFILTERGAIN, &tmp.Data, 1);
}


void AD9362TxFilterConf(INT8U ch, INT8U NoOfTabs, INT8U Gain)
{
	union __ADDR_0x065{
		INT8U Data;
		struct{
			INT8U Gain				:1;
			INT8U StarTxClk			:1;
			INT8U WriteTx			:1;
			INT8U Tx1Sel			:1;

			INT8U Tx2Sel			:1;
			INT8U NoOfTabs			:3;
		};
	} tmp;

	ReadFPGAs(ch, ADDR_TXFILTER, &tmp.Data, 1);

	tmp.NoOfTabs = NoOfTabs;

	WriteFPGAs(ch, ADDR_TXFILTER, &tmp.Data, 1);
	

}
void AD9362DCXOSet(INT8U ch, INT8U Coarse, INT16U Fine)
{
	INT8U tmp;

	tmp = Coarse;
	//SerPtr->printf("1. %02x \n", tmp);
	WriteFPGAs(ch, ADDR_DCXOCOAR, &tmp, 1);

	tmp = (Fine >> 5);
	//SerPtr->printf("2. %02x \n", tmp);
	WriteFPGAs(ch, ADDR_DCXOFINE2, &tmp, 1);
	
	tmp = (Fine >> 0) & 0x1f;
	//SerPtr->printf("3. %02x \n", tmp);
	WriteFPGAs(ch, ADDR_DCXOFINE2, &tmp, 1);
}

void AD9362Rx1GainSet(INT8U ch, INT8U gain)
{
	INT8U tmp = gain + 5;	
	WriteAD9362(ch, ADDR_RX1MANGAIN, tmp);
}

void AD9362Rx2GainSet(INT8U ch, INT8U gain)
{
	INT8U tmp = gain + 5;	
	WriteAD9362(ch, ADDR_RX2MANGAIN, tmp);
}

void AD9362Tx1AttnSet(INT8U ch, INT16U Tx1Attn)	// 0.25/dB
{

	WriteAD9362(ch, ADDR_TX1ATTN0, (Tx1Attn >> 0) & 0xff);
	WriteAD9362(ch, ADDR_TX1ATTN1, (Tx1Attn >> 8) & 0x01);
}

void AD9362Tx2AttnSet(INT8U ch, INT16U Tx2Attn)	// 0.25/dB
{

	WriteAD9362(ch, ADDR_TX2ATTN0, (Tx2Attn >> 0) & 0xff);
	WriteAD9362(ch, ADDR_TX2ATTN1, (Tx2Attn >> 8) & 0x01);
}


INT8U AD9362GetRssi(INT8U ch, INT8U isItRx2)
{
	INT16U Addr = ADDR_RX1POWER;
	if(isItRx2) Addr =  ADDR_RX2POWER;

	return (ReadAD9362(ch, Addr));
}


void AD9362Tx12AllSel(INT8U ch, INT8U Tx1TTx2)
{
	union __ADDR_0x079{
		INT8U Data;
		struct{
			INT8U Tx1Attn			:5;
			INT8U TPCModeTx1		:1;
			INT8U Tx1TTx2			:1;
		};
	} tmp;

	ReadFPGAs(ch, ADDR_TX1DIGATTN, &tmp.Data, 1);

	tmp.Tx1TTx2 = Tx1TTx2;

	WriteFPGAs(ch, ADDR_TX1DIGATTN, &tmp.Data, 1);
}

void AD9362TxAttnUpdateEn(INT8U ch, INT8U iEn)
{
	union __ADDR_0x07C{
		INT8U Data;
		struct{
			INT8U Tx2Attn			:5;
			INT8U TPCModeTx2		:1;
			INT8U UpdateTPAttn		:1;
		};
	} tmp;

	ReadFPGAs(ch, ADDR_TX2DIGATTN, &tmp.Data, 1);

	tmp.UpdateTPAttn = iEn;

	WriteFPGAs(ch, ADDR_TX2DIGATTN, &tmp.Data, 1);
}



void WriteAD9362(INT8U OPCODE, INT16U ADDR, INT8U DATA)
{
	WriteFPGAs(OPCODE, ADDR, (INT8U *)&DATA, 1);
}

INT8U ReadAD9362(INT8U OPCODE, INT16U ADDR)
{
	INT8U DATA;
	
	ReadFPGAs(OPCODE, ADDR, (INT8U *)&DATA, 1);

	return DATA;
}

//////////////////////////////////////////////////////////////////////////////
// End of Source File
////////////////////////

