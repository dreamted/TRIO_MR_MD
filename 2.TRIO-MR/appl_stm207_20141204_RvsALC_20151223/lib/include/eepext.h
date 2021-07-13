
/******************** (C) COPYRIGHT 2008 PILOG, NSINFO *************************
* File Name          : i2c_ee.h
* Author             : Yoon Byong-Gyu(bgyoon@naver.com)
* Date First Issued  : 02/xx/2008
* Description        : This file provides all the serial prompt firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.02.__
********************************************************************************/
/////////////////////////////////////////////////////////////////////////////////
// Predeclaration
#define At24cAddr		(0x00 << 1)
#define At24cAddr_21G	(0x01 << 1)
#define At24cAddr_25G	(0x02 << 1)
#define At24cAddr_900M	(0x04 << 1)

#define At24cDevID		(0x0A << 4) | At24cAddr
#define At24cDevID_21G	(0x0A << 4) | At24cAddr_21G
#define At24cDevID_900M	(0x0A << 4) | At24cAddr_900M
#define At24cDevID_25G	(0x0A << 4) | At24cAddr_25G


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void EEpromInit(void);
signed short int WriteEEprom(unsigned char DevID, unsigned short int ADDR, unsigned char DATA, unsigned char Path);
unsigned char ReadEEprom(unsigned char DevID, unsigned short int ADDR, unsigned char Path);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

