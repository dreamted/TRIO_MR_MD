//-----------------------------------------------------------------------------

#define IF_USED_SPI2		USE_SPI2	// ethernet 0
#define IF_USED_SPI1		USE_SPI1	// ethernet 1

extern unsigned long int USART1Printf( const char *format, ...);

#if defined(IF_USED_SPI1) || defined(IF_USED_SPI2)
	#define SPI_CS_SET(nUSE){\
								     if(nUSE == USE_SPI2) GPIOB->__B.ODR.B12 =  1;\
								else if(nUSE == USE_SPI1) GPIOA->__B.ODR.B15 = 1;\
							}
								
	#define SPI_CS_RST(nUSE){\
								     if(nUSE == USE_SPI2) GPIOB->__B.ODR.B12 =  0;\
								else if(nUSE == USE_SPI1) GPIOA->__B.ODR.B15 = 0;\
							}
	SPI_TypeDef *SPI_BASE(uint32 nUSE);
	SPI_TypeDef *SPI_BASE(uint32 nUSE)
	{
		SPI_TypeDef *nBASE;
		     if(nUSE == USE_SPI2) 	nBASE = SPI2;
		else if(nUSE == USE_SPI1) 	nBASE = SPI1;

		return nBASE;
	}
#else
	#define SPI_CS_SET(nUSE)
	#define SPI_CS_RST(nUSE)
	#define SPI_BASE(nUSE)		10
#endif


#define SPI0_WaitForSend(nUSE) {\
											INT8U rtry = 0xff;\
											while(rtry-- && SPI_I2S_GetFlagStatus(SPI_BASE(nUSE), SPI_I2S_FLAG_TXE) == RESET);\
										}
// PB3(MISO), PB2(MOSI), PB1(SCK), PB0(/SS)         // CS=1, waiting for SPI start // SPI mode 0, 4MHz
#if defined(IF_USED_SPI2) || defined(IF_USED_SPI1)
	#define wSPI0_Init(nUSE)			{\
											if(nUSE == USE_SPI1) {\
			                                    __PA15_NSS();\
												__PB3_SPI_SCK();\
												__PB4_SPI_MISO();\
												__PB5_SPI_MOSI();\
												SPI1Init();\
											}\
											SPI_CS_SET(nUSE);\
										}
#else
	#define wSPI0_Init(nUSE)		USART1Printf("wSPI0_Init() is NULL function, ch = %d", nUSE)
#endif


//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//IInChip SPI HAL
uint16 IINCHIP_SpiSendData(uint32 nUSE, uint8 Comm);

#define IINCHIP_SpiInit			wSPI0_Init
#define IINCHIP_SpiRecvData		IINCHIP_SpiSendData


#define IINCHIP_CS_BIT					//0x01
#define IINCHIP_CS_DDR					//DDRB
#define IINCHIP_CS_PORT					//PORTB

#define IINCHIP_CSon					SPI_CS_SET
#define IINCHIP_CSoff					SPI_CS_RST
//-----------------------------------------------------------------------------
