/*******************************************************************************
 *
 * This module contains the function HMS39C7092 Header source file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bizistyle(bgyoon@hanafos.com) All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.08.__
 *
 ******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
// Control Bits Definition
//////////////////////////
enum {

	__RFNDividerRegSel = 0,
	__RFRDividerRegSel,
	__RFControlRegSel,
	__MasterRegSel,
	__IFNDividerRegSel,
	__IFRDividerRegSel,
	__IFControlRegSel
	
};


typedef union {
	INT32U Data;

	struct {
		INT32U tot			:24;
	} Grp;

	struct {
		INT32U CtrlBits		:3;
		INT32U FRACVAL		:12;
		INT32U INTVAL		:8;
		INT32U RS23			:1;
	} Bit;
	
} _RFNDividerReg, *_pRFNDividerReg;


typedef union {
	INT32U Data;

	struct {
		INT32U tot		:21;
	} Grp;

	struct {
		INT32U CtrlBits		:3;
		INT32U MODVAL		:12;
		INT32U R			:4;
		
			#define __DISABLE			0
			#define __ENABLE			1
		INT32U RFDOUBLER	:1;

			#define __RF_PR4			0	// RF prescaler
			#define __RF_PR8			1	// RF prescaler
		INT32U RFPRESCALER	:1;

	} Bit;

} _RFRDividerReg, *_pRFRDividerReg;


typedef union {
	INT32U	Data;

	struct {
		INT32U tot		:16;
	} Grp;

	struct {
		INT32U CtrlBits		:3;
		INT32U RFCOUNTERRst	:1;

			#define __RFThreeState	1
		INT32U RFCPThreeSts	:1;
	
		INT32U RFPWRDN		:1;

			#define __LOWESTSPUR	0
			#define __LOWSPUR		1
			#define __LOWESTNOISE	7
		INT32U RFNASSet1	:1;

			#define __NEG			0
			#define __POS			1
		INT32U RFPDPOL		:1;
		INT32U 				:1;

			#define __RFICP1mA		0
			#define __RFICP3mA		1
			#define __RFICP5mA		2
			#define __RFICP7mA		3
		INT32U RFCPCURSet	:2;
		INT32U RFNASSet2	:1;
		INT32U 				:3;
		INT32U RFNASSet3	:1;
	} Bit;

} _RFControlReg, *_pRFControlReg;


typedef union {
	INT32U	Data;

	struct {
		INT32U tot			:11;
	} Grp;


	struct {
		INT32U CtrlBits		:3;
		INT32U COUNTERRst	:1;
		INT32U CPThreeSts	:1;
		INT32U PWRDN		:1;
		
			#define __XOEnable		0
			#define __XODisable		1
		INT32U XODisable	:1;
		
			#define __IFANALock		0
			#define __RFANALock		4
			#define	__IFDIGLock		6
			#define __RFDIGLock		12
			#define __RFIFDIGLock	13
		INT32U MuxOut		:4;
	} Bit;

} _MasterReg, *_pMasterReg;


typedef union {
	INT32U	Data;

	struct {
		INT32U tot			:24;
		
	} Grp;

	struct {
		INT32U CtrlBits		:3;
		INT32U A			:6;
		INT32U B			:12;

			#define __IF_PR8			0	// IF prescaler
			#define __IF_PR16			1	// IF prescaler
			#define __IF_PR32			2
			#define __IF_PR64			3
		INT32U IFPRESCALER	:2;
		INT32U IFCPGain		:1;
	} Bit;
} _IFNDividerReg, *_pIFNDividerReg;


typedef union {
	INT32U	Data;

	struct {
		INT32U tot			:19;
	} Grp;
	
	struct {
		INT32U CtrlBits		:3;
		INT32U R			:15;
		INT32U IFDOUBLER	:1;
	} Bit;

} _IFRDividerReg, *_pIFRDividerReg;

typedef union {
	INT32U Data;

	struct {
		INT32U tot			:16;
	} Grp;

	struct {
		INT32U CtrlBits		:3;
		INT32U IFCOUNTERRst	:1;
		INT32U IFCPThreeSts :1;
		INT32U IFPWRDN		:1;
		
			#define __IFLDP3	0
			#define __IFLDP5	2
		INT32U IFLDP		:1;
		INT32U IFPDPOL		:1;

			#define __IFICP1mA		0
			#define __IFICP2mA		1
			#define __IFICP3mA		2
			#define __IFICP4mA		3
			#define __IFICP5mA		4
			#define __IFICP6mA		5
			#define __IFICP7mA		6
			#define __IFICP9mA		7
			
		INT32U IFCPCURSet	:3;

			#define __RFRSyncDisable	0
			#define __RFRSyncEnable		7
			
		INT32U RFPhaseRSync1:1;
		INT32U 				:2;
		INT32U RFPhaseRSync2:2;
	} Bit;
	
} _IFControlReg, *_pIFControlReg;


void ADF4252Init(INT32U rfrq, INT32U rsol, INT16U pllClkAddr, INT16U pllDataAddr, INT16U pllEnAddr);
void ADF4252RFOutput(INT64U fvco);
void ADF4252IFOutput(INT64U fvco);

extern unsigned long int Ser0Printf( const char *format, ... );

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

