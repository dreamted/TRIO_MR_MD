/*******************************************************************************
 *
 * This module contains the function 'Expio-TLV56xx', a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2006- bgyoon(bgyoon@hanafos.com), All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2006.07.__
 * $Revision: 0.2 $
 * $Revision date: 2006.08.12
 *          : TLV5610 Control Error Correction, by bgyoon
 ******************************************************************************/
 
 typedef union {
	 INT16U Data;
 
	 struct{
		 INT16U	 		:4;
		 INT16U  DACVal :8;
		 INT16U  A		:4;
 
	 } _5629Bit;
	 
	 struct{
		 INT16U			:2;
		 INT16U DACVal  :10;
		 INT16U A		:4;
	 } _5608Bit;
	 
	 struct{
		 INT16U DACVal  :12;
		 INT16U A		:4; 
	 } _5610Bit;
 
	 struct {
		 INT16U IM		 :1;
		 INT16U 		 :2;
		 INT16U DO		 :1;
		 INT16U PD		 :1;
 
	 } _CTRL0Bit;
 
	 struct {
		 INT16U S_AB	 :1;
		 INT16U S_CD	 :1;
		 INT16U S_EF	 :1;
		 INT16U S_GH	 :1;
		 INT16U P_AB	 :1;
		 INT16U P_CD	 :1;
		 INT16U P_EF	 :1;
		 INT16U P_GH	 :1;
		 
	 } _CTRL1Bit;
 } _TLV56xxReg;

////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////
Tlv5610Str TlvPtr1B, TlvPtr2B;
Tlv5610Str *Tlv1Ptr = &TlvPtr1B;
Tlv5610Str *Tlv2Ptr = &TlvPtr2B;

////////////////////////////////////////////////////////////////////////////////
// Prototype Function Definition
/////////////////////////////////

void InitTlv5610(Tlv5610Str *ePtr, INT16U _FS, INT16U _SCLK, INT16U _DIN, INT16U _LDAC);
void DacWriteTlv5608(Tlv5610Str *ePtr, INT8U Channel, INT16U uiValue);
void DacWriteTlv5610(Tlv5610Str *ePtr, INT8U Channel, INT16U uiValue);

extern void ExpioBitSet (unsigned short int Bitaddr);
extern void ExpioBitRst (unsigned short int Bitaddr);
extern void ForDelay(unsigned long int count);
extern unsigned long int Ser0Printf( const char *format, ... );

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

