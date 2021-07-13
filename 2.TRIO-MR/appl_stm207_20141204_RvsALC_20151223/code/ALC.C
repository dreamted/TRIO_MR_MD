 
/*********************************************
* File Name          : alc.c
* Author             :
* Date First Issued  : 10/20/2010
* Description        : This file provides all the port/input/update firmware functions.
* $Revision: 0.1 $
* $Revision date: 2010.10.__
********************************************************************************/

#define ALC_C1

#include "../include/main.h"

#include <stdlib.h>



INT8S PwrTableOffset(INT8S Temp,INT8U tIndex)
{
	INT8S DectVal = 0;

	__Dnr_Sts *Sts = tDnrSts;
////////////////////////////////////////////////
 	if(!Sts->TPTL_OnOff)
	{
		INT8S tindex = 0;
		// Hysterisys !!
			 if(Sts->CurrentTemp >= tempIndexHys)		tempIndexHys = Sts->CurrentTemp;
		else if(Sts->CurrentTemp < (tempIndexHys - 1))	tempIndexHys = Sts->CurrentTemp;

		tindex = TemptoIndex(tempIndexHys);

		if(tIndex == Index_FwdOutAvgPwr_LTE_A2)
		{
			DectVal = FwdOutPwrTemp_LTE_A2[tindex];

		}
		else if(tIndex == Index_RvsOutPwr_LTE_A2)
		{
			DectVal = RvsOutPwrTemp_LTE_A2[tindex];
		}
	}
	else
	{
		DectVal 		= 0;
	}
	
	return (DectVal);
}


  
////////////////////////
