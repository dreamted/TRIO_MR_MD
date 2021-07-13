/*******************************************************************************
 *
 * This module contains the function HMS39C7092 original source file, a function
 * whole things  initializations - global, include function and so on
 *
 *
 * Note that this function is called before the data segments are
 * initialized, this means that this function cannot rely on the
 * values of global or static variables.
 *
 *
 * Copyright 2008 - bizistyle(bgyoon@hanafos.com), All rights reserved.
 *
 * $Revision: 0.1 $
 * $Revision date: 2008.07.
 *
 ******************************************************************************/
#define KXP_C
#define KXP_DBG

#include "../../include/main.h"

void SlopeConvert(INT16S *rval)	// 0: x_axis, 1: y_axis, 2: z_axis
{
	INT32U	TempX = 0;
	INT32U	TempY = 0;
	INT32U	TempZ = 0;
	INT8U i;

	SlopeBuffCnt %= SlopeBuffMAX;	

	if(ReadSPI(0x03) != 0x04)WriteSPI(0x04,0x04); // Slope Start
	else	SlopeDataBuff[0][SlopeBuffCnt] = ReadSPI(0x00);
	
	if(ReadSPI(0x03) != 0x04)WriteSPI(0x04,0x04); // Slope Start
	else 	SlopeDataBuff[1][SlopeBuffCnt] = ReadSPI(0x02);

	if(ReadSPI(0x03) != 0x04)WriteSPI(0x04,0x04); // Slope Start
	else	SlopeDataBuff[2][SlopeBuffCnt] = ReadSPI(0x01);

	if(SlopeDataBuff[0][SlopeBuffCnt] > 2867) SlopeDataBuff[0][SlopeBuffCnt] = 2867;
	if(SlopeDataBuff[1][SlopeBuffCnt] > 2867) SlopeDataBuff[1][SlopeBuffCnt] = 2867;
	if(SlopeDataBuff[2][SlopeBuffCnt] > 2867) SlopeDataBuff[2][SlopeBuffCnt] = 2867;

	if(SlopeDataBuff[0][SlopeBuffCnt] < 1229) SlopeDataBuff[0][SlopeBuffCnt] = 1229;
	if(SlopeDataBuff[1][SlopeBuffCnt] < 1229) SlopeDataBuff[1][SlopeBuffCnt] = 1229;
	if(SlopeDataBuff[2][SlopeBuffCnt] < 1229) SlopeDataBuff[2][SlopeBuffCnt] = 1229;

#ifdef KXP_DBG
	//Ser0Printf(" X : ReadSPI[%4d, %2.1f] \n",    SlopeDataBuff[0][SlopeBuffCnt], (SlopeDataBuff[0][SlopeBuffCnt] - 2048)/9.1);
	//Ser0Printf(" Y : ReadSPI[%4d] %2.1f] \n",    SlopeDataBuff[1][SlopeBuffCnt], (SlopeDataBuff[1][SlopeBuffCnt] - 2048)/9.1);
	//Ser0Printf(" Z : ReadSPI[%4d] %2.1f] \n\n\n",SlopeDataBuff[2][SlopeBuffCnt], (SlopeDataBuff[2][SlopeBuffCnt] - 2048)/9.1);
#endif

	
	if(SlopeBuffCnt < 20)
	{
		if(SlopeBuffCnt == 19)
		{
			for ( i = 0; i < 20; i++ )
			{
				TempX += SlopeDataBuff[0][i];
				TempY += SlopeDataBuff[1][i];
				TempZ += SlopeDataBuff[2][i];
			}

			SlopeAvgData[0][0] = TempX/20L;
			SlopeAvgData[1][0] = TempY/20L;
			SlopeAvgData[2][0] = TempZ/20L;
			
		}	
	}
	else if((SlopeBuffCnt >= 20)&&(SlopeBuffCnt < 40))
	{
		if(SlopeBuffCnt == 39)
		{
			for ( i = 20; i < 40; i++ )
			{
				TempX += SlopeDataBuff[0][i];
				TempY += SlopeDataBuff[1][i];
				TempZ += SlopeDataBuff[2][i];
			}

			SlopeAvgData[0][1] = TempX/20L;
			SlopeAvgData[1][1] = TempY/20L;
			SlopeAvgData[2][1] = TempZ/20L;
		}

	}
	else
	{
		
		if(SlopeBuffCnt == 59)
		{
			for ( i = 40; i < 60; i++ )
			{
				TempX += SlopeDataBuff[0][i];
				TempY += SlopeDataBuff[1][i];
				TempZ += SlopeDataBuff[2][i];
			}

			SlopeAvgData[0][2] = TempX/20L;
			SlopeAvgData[1][2] = TempY/20L;
			SlopeAvgData[2][2] = TempZ/20L;
			
		}
	}

#ifdef KXP_DBG
		//Ser0Printf(" X :%4d, %4d, %4d \n",    SlopeAvgData[0][0], SlopeAvgData[0][1], SlopeAvgData[0][2]);
		//Ser0Printf(" Y :%4d, %4d, %4d \n",    SlopeAvgData[1][0], SlopeAvgData[1][1], SlopeAvgData[1][2]);
		//Ser0Printf(" Z :%4d, %4d, %4d \n\n\n",SlopeAvgData[2][0], SlopeAvgData[2][1], SlopeAvgData[2][2]);
#endif

	
	if(SlopeBuffCnt == (SlopeBuffMAX-1))
	{
		INT8U i;
		INT32U Gap[3];

		for(i = 0; i < 3; i++)
		{

			if(SlopeData[i] > SlopeAvgData[i][0])Gap[0] = SlopeData[i] - SlopeAvgData[i][0];
			else								 Gap[0] = SlopeAvgData[i][0] - SlopeData[i];

			if(SlopeData[i] > SlopeAvgData[i][1])Gap[1] = SlopeData[i] - SlopeAvgData[i][1];
			else								 Gap[1] = SlopeAvgData[i][1] - SlopeData[i];

			if(SlopeData[i] > SlopeAvgData[i][2])Gap[2] = SlopeData[i] - SlopeAvgData[i][2];
			else								 Gap[2] = SlopeAvgData[i][2] - SlopeData[i];

			if(Gap[0] > Gap[1])
			{
				if(Gap[0] > Gap[2])	SlopeData[i] = (SlopeAvgData[i][1] + SlopeAvgData[i][2])/2L;
				else				SlopeData[i] = (SlopeAvgData[i][0] + SlopeAvgData[i][1])/2L;
				
			}
			else
			{
				if(Gap[1] > Gap[2])	SlopeData[i] = (SlopeAvgData[i][0] + SlopeAvgData[i][2])/2L;
				else				SlopeData[i] = (SlopeAvgData[i][0] + SlopeAvgData[i][1])/2L;

			}
		}		
	}
	SlopeBuffCnt++;

	rval[0] = ((SlopeData[0] - 2048)/9.1)*10L;
	rval[1] = ((SlopeData[1] - 2048)/9.1)*10L;
	rval[2] = ((SlopeData[2] - 2048)/9.1)*10L;

#ifdef KXP_DBG
//	Ser0Printf(" X : ReadSPI[%4d] \n",    SlopeData[0]);
//	Ser0Printf(" Y : ReadSPI[%4d] \n",    SlopeData[1]);
//	Ser0Printf(" Z : ReadSPI[%4d] \n\n\n",SlopeData[2]);
#endif

}

void SetSPICommand(INT8U Comm)
{
	INT16U i = 0, bMask = 0x80;
	
	for(i = 0; i < 8; i++)
	{
		if(Comm & bMask)ExpioBitSet(KXP74_SDI);
		else		 	ExpioBitRst(KXP74_SDI);

		ExpioBitSet(KXP74_CLK);
		ExpioBitRst(KXP74_CLK);
		
		Comm <<= 1;
	}
	
}

void WriteSPI(INT16U Comm, INT8U DATA)
{
	INT8U i = 0;

	ExpioBitRst(KXP74_CS);

	SetSPICommand(Comm);

	/////////////////////////////////////////////
	// Write Operation
	for(i = 0; i < 8; i++)
	{
		if(DATA & 0x80)	ExpioBitSet(KXP74_SDI);
		else			ExpioBitRst(KXP74_SDI);

		ExpioBitSet(KXP74_CLK);
		ExpioBitRst(KXP74_CLK);
		
		DATA <<= 1;
	}

	ExpioBitRst(KXP74_SDI);
	ExpioBitSet(KXP74_CS);
	
}

INT16U ReadSPI(INT8U Comm)
{
	INT8U i = 0;
	INT16U RetData = 0;
	INT16U DataLen = 0;

	ExpioBitRst(KXP74_CS);
	
	SetSPICommand(Comm);
	
	if(Comm == 0x03)DataLen = 8;
	else
	{
		DataLen = 12;
		OSTimeDly(1);
	}	
	
	for(i = 0; i < DataLen; i++)
	{
		RetData <<= 1;

		ExpioBitSet(KXP74_CLK);
		
		if(ExpioBitRead(KXP74_SDO))	RetData |= 1;
		
		ExpioBitRst(KXP74_CLK);
	}
		
	ExpioBitRst(KXP74_SDI);
	ExpioBitSet(KXP74_CS);
		
	return RetData;
}

////////////////////////////////////////////////////////////////////////////////
// End of Source File
/////////////////////

