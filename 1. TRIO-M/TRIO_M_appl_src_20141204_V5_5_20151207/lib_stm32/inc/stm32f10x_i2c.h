
/*********************************************
* File Name          : stm31f10x_i2c.c
* Author             : 
* Date First Issued  : 01/17/2008
* Description        : This file provides all the serial prompt firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.01.__
********************************************************************************/
////////////////////////////////////////////////////////////////////////////////

////////////////////// Inter-integrated Circuit Interface
typedef struct
{
	union {
		vu32 Data;
		struct {
			vu32 PE			:1;		// rw, Peripheral Enable
			vu32 SMBUS		:1;		// rw, SMBUS MODE, 0: I2C Mode, 1: SMBUS Mode
			vu32			:1;		
			vu32 SMBTYPE	:1;		// rw, SMBUS Type, 0: SMBus Device, 1: SMBus Hos
			vu32 ENARP		:1;		// rw, ARP Enable
			vu32 ENPEC		:1;		// rw, PEC Enable
			vu32 ENGC		:1;		// rw, General Call Enable
			vu32 NOSTRECTH	:1;		// rw, Clock Stretching Disable(Slave Mode)
			vu32 START		:1;		// rw, Start Generation
			vu32 STOP		:1;		// rw, Stop Generation
			vu32 ACK		:1;		// rw, Acknoledge Enable
			vu32 POS		:1;		// rw, Acknowledge/PEC Position
			vu32 PEC		:1;		// rw, Packet Error Checking
			vu32 ALERT		:1;		// rw, ALERT, SMBus Alert
			vu32			:1;
			vu32 SWRST		:1;		// rw, Software Reset
		} Bit;
	} CR1;

	union {
		vu32 Data;
		struct {
			vu32 FREQ		:6;		// input clock freqecny(20MHz ~ 50 MHz) ( 2 ~ 50)
			vu32			:2;
			vu32 ITERREN	:1;
			vu32 ITEVTEN	:1;
			vu32 ITBUFEN	:1;
			vu32 DMAEN		:1;
			vu32 LAST		:1;
			
		} Bit;
	} CR2;

	union {
		vu32 Data;
		struct {
			vu32 ADD		:10;	// 7-bit or 10-bit addressing mode: don't care, 10-bit: A0
			vu32			:5;
			vu32 ADDMODE	:1;		// 0: 7-bit Address, 1: 10-bit Address
		} Bit;
	} OAR1;	// Own Address register 1

	union {
		vu32 Data;
		struct {
			vu32 ENDUAL		:1;     // Dual addressing mode enable
			vu32 ADD2		:7;     // interface address
		} Bit;
	} OAR2;	// Own Address register 2
	union {
		vu32 Data;
        //vu8  DR;
        //vu8  RS[3];
		struct {
            vu32 DR  		:8;
		} Bit;
	} DR;

  	union {
		vu32 Data;
		struct {
            vu32 SB           	:1;	// r, 0: No start generation
            vu32 ADDR         	:1;	// r, Master: 	0: No end of address transmission
            						//				1: End of address transmismssion
            						//     Slave:	0: address mismatched or not received
            						//				1: Received address matched
            vu32 BTF          	:1;	// r, Byt
            vu32 ADD10        	:1;	// r,
            vu32 STOPF        	:1;	// r,
            vu32              	:1;
            vu32 RxNE         	:1;	// r
            vu32 TxE          	:1;	// r
            vu32 BERR         	:1;	// rc
            vu32 ARLO         	:1;	// rc
            vu32 AF           	:1;	// rc
            vu32 OVR          	:1;	// rc
            vu32 PECERR       	:1;	// rc
            vu32              	:1;
            vu32 TIMEOUT      	:1;	// rc
            vu32 SMBALERT     	:1;	// rc, AMBUS Alert, In SMBus host mode
            						//		0: no SMBAlert
            						//		1: SMBAlert event occured on pin
            						//					In SMBus slave mode
            						//		0: no SMBAlert response address header
            						//		1: SMBAlert response address header to SMB Alert LOW Received
		} Bit;		
  	} SR1;

  	union {
		vu32 Data;
		struct {
			vu32 MSL			:1;
			vu32 BUSY			:1;
			vu32 TRA			:1;
			vu32				:1;
			vu32 GENCALL		:1;
			vu32 SMBDEFAULT		:1;
			vu32 SMBHOST		:1;
			vu32 DUALF			:1;	// r, Dual Flag(slave mode)
			vu32 PEC			:8;	// r, packet error checking register(ENPEC = 1 case)

		} Bit;
  	} SR2;

  	union {
		vu32 Data;
		struct {
			vu32 CCR			:12;
			vu32 				:2;
			vu32 DUTY			:1;	// rw, Fast Mode Duty Cycle 0: 2, 1: Tlow(16)/Thigh(9)(see CCR)
			vu32 FS				:1;	// rw, I2C Master Selection 0: Standart, 1: Fast Mode

		} Bit;
  	} CCR;

	union {
		vu32 Data;
		//vu32 TRISE;
		struct {
			vu32 TRISE			:6;	// rw, 
		} Bit;
  	} TRISE;

} I2C_TypeDef;


#define I2C1              	((I2C_TypeDef*  ) I2C1_BASE)
#define I2C2            	((I2C_TypeDef * ) I2C2_BASE)


// I2C Init structure definition
typedef struct
{
	u16 I2C_Mode;
	u16 I2C_DutyCycle;
	u16 I2C_OwnAddress1;
	u16 I2C_Ack;
	u16 I2C_AcknowledgedAddress;
	u32 I2C_ClockSpeed;
}I2C_InitTypeDef;

// CCR Register
// I2C modes(FS Register)
#define __I2C_STANDARD					0
#define __I2C_FAST						1

// DUTY(FAST)
#define __DUTY3							0		// rising: 1, falling: 2
#define __DUTY25						1		// rising: 9, falling: 16

// CR1 Register
// SMBUS
#define __I2C							0
#define __SMBUS							1

// SMBUS Type
#define __SMBUSDEV						0
#define __SMBUSHOST						1


// OAR1 Register
// ADDMODE
#define __7BIT							0
#define __10BIT							1

/* I2C duty cycle in fast mode */
#define I2C_DutyCycle_16_9              ((u16)0x4000)
#define I2C_DutyCycle_2                 ((u16)0xBFFF)

/* I2C cknowledgementy */
#define I2C_Ack_Enable                  ((u16)0x0400)
#define I2C_Ack_Disable                 ((u16)0x0000)

/* I2C transfer direction */
#define  I2C_Direction_Transmitter      ((u8)0x00)
#define  I2C_Direction_Receiver         ((u8)0x01)

/* I2C acknowledged address defines */
#define I2C_AcknowledgedAddress_7bit    ((u16)0x4000)
#define I2C_AcknowledgedAddress_10bit   ((u16)0xC000)

/* I2C registers */
#define I2C_Register_CR1                ((u8)0x00)
#define I2C_Register_CR2                ((u8)0x04)
#define I2C_Register_OAR1               ((u8)0x08)
#define I2C_Register_OAR2               ((u8)0x0C)
#define I2C_Register_DR                 ((u8)0x10)
#define I2C_Register_SR1                ((u8)0x14)
#define I2C_Register_SR2                ((u8)0x18)
#define I2C_Register_CCR                ((u8)0x1C)
#define I2C_Register_TRISE              ((u8)0x20)

// I2C SMBus alert pin level
#define I2C_SMBusAlert_Low              ((u16)0x2000)
#define I2C_SMBusAlert_High             ((u16)0xCFFF)

// I2C PEC position
#define I2C_PECPosition_Next            ((u16)0x0800)
#define I2C_PECPosition_Current         ((u16)0xF7FF)

/* I2C interrupts definition */
#define I2C_IT_BUF                      ((u16)0x0400)
#define I2C_IT_EVT                      ((u16)0x0200)
#define I2C_IT_ERR                      ((u16)0x0100)

// I2C interrupts definition
#define I2C_IT_SMBALERT                 ((u32)0x10008000)
#define I2C_IT_TIMEOUT                  ((u32)0x10004000)
#define I2C_IT_PECERR                   ((u32)0x10001000)
#define I2C_IT_OVR                      ((u32)0x10000800)
#define I2C_IT_AF                       ((u32)0x10000400)
#define I2C_IT_ARLO                     ((u32)0x10000200)
#define I2C_IT_BERR                     ((u32)0x10000100)
#define I2C_IT_TXE                      ((u32)0x00000080)
#define I2C_IT_RXNE                     ((u32)0x00000040)
#define I2C_IT_STOPF                    ((u32)0x60000010)
#define I2C_IT_ADD10                    ((u32)0x20000008)
#define I2C_IT_BTF                      ((u32)0x60000004)
#define I2C_IT_ADDR                     ((u32)0xA0000002)
#define I2C_IT_SB                       ((u32)0x20000001)

// I2C flags definition
#define I2C_FLAG_DUALF                  ((u32)0x00800000)
#define I2C_FLAG_SMBHOST                ((u32)0x00400000)
#define I2C_FLAG_SMBDEFAULT             ((u32)0x00200000)
#define I2C_FLAG_GENCALL                ((u32)0x00100000)
#define I2C_FLAG_TRA                    ((u32)0x00040000)
#define I2C_FLAG_BUSY                   ((u32)0x00020000)
#define I2C_FLAG_MSL                    ((u32)0x00010000)
#define I2C_FLAG_SMBALERT               ((u32)0x10008000)
#define I2C_FLAG_TIMEOUT                ((u32)0x10004000)
#define I2C_FLAG_PECERR                 ((u32)0x10001000)
#define I2C_FLAG_OVR                    ((u32)0x10000800)
#define I2C_FLAG_AF                     ((u32)0x10000400)
#define I2C_FLAG_ARLO                   ((u32)0x10000200)
#define I2C_FLAG_BERR                   ((u32)0x10000100)
#define I2C_FLAG_TXE                    ((u32)0x00000080)
#define I2C_FLAG_RXNE                   ((u32)0x00000040)
#define I2C_FLAG_STOPF                  ((u32)0x60000010)
#define I2C_FLAG_ADD10                  ((u32)0x20000008)
#define I2C_FLAG_BTF                    ((u32)0x60000004)
#define I2C_FLAG_ADDR                   ((u32)0xA0000002)
#define I2C_FLAG_SB                     ((u32)0x20000001)

////////////////////////////////////////////////////////////////////////////////
// I2C Events
// EV1
#define  I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED 		0x00060082L
											// TRA, BUSY, TXE and ADDR flags
#define  I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED  			0x00020002L
											// BUSY and ADDR flags
#define  I2C_EVENT_SLAVE_TRANSMITTER_SECONDADDRESS_MATCHED 	0x00860080L
											// DUALF, TRA, BUSY and TXE flags
#define  I2C_EVENT_SLAVE_RECEIVER_SECONDADDRESS_MATCHED 	0x00820000L
											// DUALF and BUSY flags
#define  I2C_EVENT_SLAVE_GENERALCALLADDRESS_MATCHED			0x00120000L
											// GENCALL and BUSY flags

// EV2
#define  I2C_EVENT_SLAVE_BYTE_RECEIVED  					0x00020040L
											// BUSY and RXNE flags
     
// EV3
#define  I2C_EVENT_SLAVE_BYTE_TRANSMITTED  					0x00060084L
											// TRA, BUSY, TXE and BTF flags

// EV4
#define  I2C_EVENT_SLAVE_STOP_DETECTED 						0x00000010L
											// STOPF flag

// EV5
#define  I2C_EVENT_MASTER_MODE_SELECT  						0x00030001L
											// BUSY, MSL and SB flag

// EV6
#define  I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED  		0x00070082L
											// BUSY, MSL, ADDR, TXE and TRA flags
#define  I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED  			0x00030002L
											// BUSY, MSL and ADDR flags

// EV7
#define  I2C_EVENT_MASTER_BYTE_RECEIVED  					0x00030040L
											// BUSY, MSL and RXNE flags

// EV8
#define  I2C_EVENT_MASTER_BYTE_TRANSMITTED  				0x00070084L
											// TRA, BUSY, MSL, TXE and BTF flags
      
// EV9
#define  I2C_EVENT_MASTER_MODE_ADDRESS10 	 				0x00030008L
											// BUSY, MSL and ADD10 flags
                                          
// EV3_1
#define  I2C_EVENT_SLAVE_ACK_FAILURE  						0x00000400L
											// AF flag

////////////////////////////////////////////////////////////////////////////////
// Private definition
#define CR1_PE_Set              		((u16)0x0001)		// I2C SPE mask
#define CR1_PE_Reset            		((u16)0xFFFE)
#define CR2_DMAEN_Set           		((u16)0x0800)		// I2C DMAEN mask
#define CR2_DMAEN_Reset         		((u16)0xF7FF)
#define CR2_LAST_Set           			((u16)0x1000)		// I2C LAST mask
#define CR2_LAST_Reset          		((u16)0xEFFF)

#define CR1_START_Set           		((u16)0x0100)		// I2C START mask
#define CR1_START_Reset         		((u16)0xFEFF)
#define CR1_STOP_Set            		((u16)0x0200)		// I2C STOP mask
#define CR1_STOP_Reset          		((u16)0xFDFF)
#define CR1_ACK_Set             		((u16)0x0400)		// I2C ACK mask
#define CR1_ACK_Reset           		((u16)0xFBFF)
#define CR1_ENGC_Set            		((u16)0x0040)		// I2C ENGC mask
#define CR1_ENGC_Reset          		((u16)0xFFBF)
#define OAR1_ADD0_Set           		((u16)0x0001)		// I2C ADD0 mask
#define OAR1_ADD0_Reset         		((u16)0xFFFE)
#define CR1_SWRST_Set           		((u16)0x8000)		// I2C SWRST mask
#define CR1_SWRST_Reset         		((u16)0x7FFF)
#define CR1_PEC_Set             		((u16)0x1000)		// I2C PEC mask
#define CR1_PEC_Reset           		((u16)0xEFFF)
#define CR1_ENPEC_Set           		((u16)0x0020)		// I2C ENPEC mask
#define CR1_ENPEC_Reset         		((u16)0xFFDF)
#define CR1_ENARP_Set           		((u16)0x0010)		// I2C ENARP mask
#define CR1_ENARP_Reset         		((u16)0xFFEF)
#define CR1_NOSTRETCH_Set       		((u16)0x0080)		// I2C NOSTRETCH mask
#define CR1_NOSTRETCH_Reset     		((u16)0xFF7F)
#define OAR2_ENDUAL_Set         		((u16)0x0001)		// I2C ENDUAL mask
#define OAR2_ENDUAL_Reset       		((u16)0xFFFE)
#define CCR_FS_Set              		((u16)0x8000)		// I2C F/S mask
#define OAR2_ADD2_Reset         		((u16)0xFF01)		// I2C ADD2 mask
#define CR2_FREQ_Reset          		((u16)0xFFC0)		// I2C FREQ mask
#define CCR_CCR_Set             		((u16)0x0FFF)		// I2C CCR mask
#define I2C_FLAG_Mask           		((u32)0x00FFFFFF)	// I2C FLAG mask
#define I2C_CR1_CLEAR_Mask          	((u16)0xFBF5)		// I2C registers Masks

////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void I2C_Init(I2C_TypeDef* I2Cx, I2C_InitTypeDef* I2C_InitStruct);
void I2C_StructInit(I2C_InitTypeDef* I2C_InitStruct);
void I2C_Cmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_DMACmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_DMALastTransferCmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_GenerateSTART(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_GenerateSTOP(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_AcknowledgeConfig(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_OwnAddress2Config(I2C_TypeDef* I2Cx, u8 Address);
void I2C_DualAddressCmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_GeneralCallCmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_ITConfig(I2C_TypeDef* I2Cx, u16 I2C_IT, u32 NewState);
void I2C_SendData(I2C_TypeDef* I2Cx, u8 Data);
void I2C_Send7bitAddress(I2C_TypeDef* I2Cx, u8 Address, u8 I2C_Direction);
void I2C_ClearFlag(I2C_TypeDef* I2Cx, u32 I2C_FLAG);
void I2C_ClearITPendingBit(I2C_TypeDef* I2Cx, u32 I2C_IT);
void I2C_SoftwareResetCmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_SMBusAlertConfig(I2C_TypeDef* I2Cx, u16 I2C_SMBusAlert);
void I2C_TransmitPEC(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_PECPositionConfig(I2C_TypeDef* I2Cx, u16 I2C_PECPosition);
void I2C_CalculatePEC(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_ARPCmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_StretchClockCmd(I2C_TypeDef* I2Cx, u32 NewState);
void I2C_FastModeDutyCycleConfig(I2C_TypeDef* I2Cx, u16 I2C_DutyCycle);

u8 I2C_ReceiveData(I2C_TypeDef* I2Cx);
u8 I2C_GetPEC(I2C_TypeDef* I2Cx);

u16 I2C_ReadRegister(I2C_TypeDef* I2Cx, u8 I2C_Register);

u32 I2C_GetLastEvent(I2C_TypeDef* I2Cx);
u32 I2C_CheckEvent(I2C_TypeDef* I2Cx, u32 I2C_EVENT);
u32 I2C_GetFlagStatus(I2C_TypeDef* I2Cx, u32 I2C_FLAG);
u32 I2C_GetITStatus(I2C_TypeDef* I2Cx, u32 I2C_IT);
////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

