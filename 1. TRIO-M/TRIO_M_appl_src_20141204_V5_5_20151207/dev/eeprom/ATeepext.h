
/*********************************************
* File Name          : i2c_ee.h
* Author             :
* Date First Issued  : 02/xx/2008
* Description        : This file provides all the serial prompt firmware functions.
* $Revision: 0.1 $
* $Revision date: 2008.02.__
********************************************************************************/
/////////////////////////////////////////////////////////////////////////////////
// Predeclaration


////////////////////////////////////////////////////////////////////////////////
// Global Variable Declaration
//////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Global Function Prototype Definition
//////////////////////
void EEpromInit(void);
signed short int WriteEEprom(unsigned short int ADDR, unsigned char DATA);
unsigned char ReadEEprom(unsigned short int ADDR);

////////////////////////////////////////////////////////////////////////////////
// End of Header File
/////////////////////

