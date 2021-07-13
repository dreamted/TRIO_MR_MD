/****************************************/
/* Aid  DEFINITION						*/
/****************************************/
#if 1
#define	Aid_RepeaterAlarm				0x0001
#define	Aid_Manufacture					0x0100
#define	Aid_Supplier					0x0101
#define	Aid_RepeaterType				0x0102
#define	Aid_SystemVer					0x0103
#define	Aid_MobileManufacture			0x0104
#define	Aid_MobileModel					0x0105
#define	Aid_MobileVer					0x0106
#define	Aid_MCUManufacture				0x0107
#define	Aid_EsnChecksum					0x0108
#define	Aid_RmtPortType					0x0109
#define	Aid_MCUSupplier					0x010A
#define	Aid_Connect						0x010B
#define	Aid_MCUSwVer					0x010C
#define	Aid_RRCU_Manufacture			0x010E
#define	Aid_RRCU_Supplier				0x010F
#define	Aid_RRCU_Type					0x0110
#define	Aid_CDMA_RRCU_Manufacture		0x0111
#define	Aid_CDMA_RRCU_Supplier			0x0112
#define	Aid_CDMA_RRCU_Type				0x0113

#define	Aid_ICCIDChecksum				0x0116


#define	Aid_DoorOpen					0x0200
#define	Aid_CurrentTemp					0x0201
#define	Aid_TempUpperLmt				0x0202
#define	Aid_Fan1Fail					0x0204
#define	Aid_ACFail						0x0208
#define	Aid_DcFail						0x0209
#define	Aid_StsCheckCon					0x020A
#define	Aid_BattLow						0x020B
#define	Aid_BatteryIns					0x0210
#define	Aid_OpcomUse					0x0211
#define	Aid_OPCOM_Alarm					0x0212
#define	Aid_MimoUse						0x021F
#define	Aid_CdmaUse						0x0213
#define	Aid_WcdmaUse					0x0214
#define	Aid_Sms_Temperature				0x0215
#define	Aid_Sms_TempHighLmt				0x0216
#define	Aid_WI0Use						0x0218
#define	Aid_CurAngle					0x021C
#define	Aid_FAN_Speed					0x021E
#define	Aid_WI1Use						0x021F
#define	Aid_CDMA_CurrentTemp			0x0220
#define	Aid_CDMA_TempHighLmt			0x0221
#define	Aid_CDMA_FanFail				0x0222
#define	Aid_C_AcFail					0x0223
#define	Aid_C_DcFail					0x0224
#define	Aid_C_BattLow					0x0225
#define	Aid_CDMA_Battery_Use			0x0226
#define	Aid_Wcdma_DoorOpen				0x0227
#define	Aid_Cdma_DoorOpen				0x0228
#define	Aid_GPS_Latitude				0x0229
#define	Aid_GPS_Longitude				0x022a
#define	Aid_GPS_Altitude				0x022b
#define	Aid_GPS_Status					0x022c
#define	Aid_GPS_LinkFail				0x022d
#define	Aid_GPS_Reset					0x022e
#define	Aid_GPS_OnOff					0x022f
#define	Aid_GPS_Use						0x0232
#define	Aid_RAU_Use						0x0234
#define	Aid_RefSignalType				0x0240
#define	Aid_T_OEM_Use					0x0262
#define	Aid_LNA_Use						0x0265



#define	Aid_LD0Fail						0x0300
#define Aid_LD0Pwr						0x0301
#define Aid_LD0PwrUpperLmt				0x0302
#define Aid_LD0PwrLowerLmt				0x0303
#define Aid_LD0PwrInit					0x0304
#define Aid_LD0PwrRef					0x0305
#define	Aid_LD1Fail						0x0306
#define Aid_LD1Pwr						0x0307
#define Aid_LD1PwrUpperLmt				0x0308
#define Aid_LD1PwrLowerLmt				0x0309
#define Aid_LD1PwrInit					0x030A
#define Aid_LD1PwrRef					0x030B
#define Aid_PD0Fail						0x030C
#define Aid_PD0Pwr						0x030D
#define Aid_PD0PwrUpperLmt				0x030E
#define Aid_PD0PwrLowerLmt				0x030F
#define	Aid_PD0PwrInit					0x0310
#define	Aid_PD0PwrRef					0x0311
#define Aid_PD1Fail						0x0312
#define Aid_PD1Pwr						0x0313
#define Aid_PD1PwrUpperLmt				0x0314
#define Aid_PD1PwrLowerLmt				0x0315
#define Aid_PD1PwrInit					0x0316
#define Aid_PD1PwrRef					0x0317
#define Aid_OpticSwitch					0x0318
#define Aid_OptCompSenseLvl				0x0319
#define Aid_OptCompLmt					0x031A
#define Aid_OptLoss						0x031B
#define Aid_LDType						0x031C
#define Aid_OptLossCompFwdAttn			0x031D
#define Aid_OptLossCompRx0Attn			0x031E
#define Aid_OptLossCompRx1Attn			0x031F
#define Aid_ExtLDFail					0x0320
#define Aid_ExtLDPwr					0x0321
#define Aid_ExtLDPwrUpperLmt			0x0322
#define Aid_ExtLDPwrLowerLmt			0x0323
#define Aid_ExtLDPwrInit				0x0324
#define Aid_ExtLDPwrRef					0x0325
#define Aid_ExtPDFail					0x0326
#define Aid_ExtPDPwr					0x0327
#define Aid_ExtPDPwrUpperLmt			0x0328
#define Aid_ExtPDPwrLowerLmt			0x0329
#define Aid_ExtPDPwrInit				0x032A
#define Aid_ExtPDPwrRef					0x032B
#define Aid_ExtOptLossCompRx0Attn		0x032C
#define Aid_ExtOptLossCompRx1Attn		0x032D
#define Aid_SectorSet_Brn0				0x032E
#define Aid_SectorSet_Brn1				0x032F
#define Aid_LOULDFail					0x0330
#define Aid_LOUPDFail					0x0331
#define Aid_LOUPDPwr					0x0332
#define Aid_LOUPDPwrUpperLmt			0x0333
#define Aid_LOUPDPwrLowerLmt			0x0334
#define Aid_LOUPDPwrInit				0x0335
#define Aid_LOUPDPwrRef					0x0336
#define Aid_LOUOptCompLmt				0x0337
#define Aid_LOUOptCompAttn				0x0338
#define Aid_LOURvsOptCompFail			0x0339
#define Aid_LOURvsOptCompModeOnOff		0x033A
#define Aid_LOURvsAttn					0x033B
#define Aid_FwdOptCompFail				0x033C
#define Aid_PD0RvsOptCompFail			0x033D
#define Aid_PD1RvsOptCompFail			0x033E
#define Aid_EOUPD0OptPwr				0x0340
#define Aid_EOUPD0OptPwrRef				0x0341
#define Aid_EOUPD0OptPwrLowerLmt		0x0342
#define Aid_EOUPD0RvsOptCompAttn		0x0343
#define Aid_EOUPD1OptPwr				0x0344
#define Aid_EOUPD1OptPwrRef				0x0345
#define Aid_EOUPD1OptPwrLowerLmt		0x0346
#define Aid_EOUPD1RvsOptCompAttn		0x0347
#define Aid_EOULD0Fail					0x0348
#define Aid_EOULD1Fail					0x0349
#define Aid_EOUPD0Fail					0x034A
#define Aid_EOUPD1Fail					0x034B
#define Aid_EOUPD0PwrLowFail			0x034C
#define Aid_EOUPD1PwrLowFail			0x034D
#define Aid_ExtDrvAmpFail				0x034E
#define Aid_EOUPD0OptCompModeOnOff		0x034F

#define Aid_EOUPD1OptCompModeOnOff		0x0351
#define Aid_EOUPD0OptCompFail			0x0352
#define Aid_EOUPD1OptCompFail			0x0353
#define Aid_EOUFwdOptCompFail			0x0354
#define Aid_OptFail						0x0355
#define	Aid_OtruLinkFail				0x0356
#define Aid_LD2Fail						0x0357
#define Aid_PD2Fail						0x0359
#define Aid_PD2Pwr						0x035A
#define	Aid_C_OtruLinkFail				0x035B
#define Aid_PD2PwrLowerLmt				0x035D
#define Aid_LD3Fail						0x035E
#define Aid_PD3Fail						0x0361
#define Aid_PD3Pwr						0x0362
#define Aid_PD3PwrLowerLmt				0x0363
#define Aid_Optic_Use					0x0376
#define Aid_PD4Fail						0x0377
#define Aid_PD4Pwr						0x0378
#define Aid_PD5Fail						0x0379
#define Aid_PD5Pwr						0x037A

#define	Aid_FwdAmpFail_3G				0x0400
#define	Aid_Rx0AmpFail_3G				0x0401
#define	Aid_Rx1AmpFail_3G				0x0402
#define	Aid_LocalFail_3G				0x0403
#define Aid_DrvRvsAmpOnOff_3G			0x0405
#define	Aid_LocalFail_2G				0x0406
#define	Aid_FA1_OnOff					0x0407
#define	Aid_FA2_OnOff					0x0408
#define	Aid_FA3_OnOff					0x0409
#define	Aid_FA4_OnOff					0x040A
#define	Aid_FwdAmpFail_2G				0x040b
#define	Aid_Rx0AmpFail_2G				0x040c
#define	Aid_Rx1AmpFail_2G				0x040d
#define	Aid_DrvRvsAmpOnOff_2G			0x040E
#define	Aid_CDMA_RRFU_FwdPwr			0x040F
#define Aid_Fwd_UDCFail_3G				0x0413
#define Aid_Rvs0_UDCFail_3G				0x0414
#define Aid_Rvs1_UDCFail_3G				0x0415
#define Aid_Fwd_UDCFail_2G				0x0416
#define Aid_Rvs0_UDCFail_2G				0x0417
#define Aid_Rvs1_UDCFail_2G				0x0418

#define Aid_DrvRvsDivAmpOnOff_3G		0x041F
#define Aid_DrvRvsDivAmpOnOff_2G		0x0420
#define Aid_DrvRvsDivAmpOnOff_WI		0x0421
#define Aid_DrvRvsDivAmpOnOff_WI1		0x0422

//#define	Aid_Rvs0AmpOnOff_LTE			0x042B
//#define	Aid_Rvs1AmpOnOff_LTE			0x042C

#define	Aid_DigRvs0AmpOnOff_LTE			0xA1E6
#define	Aid_DigRvs1AmpOnOff_LTE			0xA1E7

#define	Aid_Rvs0AmpOnOff_Common			0x0432
#define	Aid_Rvs1AmpOnOff_Common			0x0435

#define	Aid_FwdPllAlarm_Common			0x0433
#define	Aid_RvsPllAlarm_Common			0x0434


#define	Aid_LocalFail_CDMALTE			0x0436

#define	Aid_LocalFail_LTE_A1			0x0437
#define	Aid_LocalFail_LTE_A2			0x0438


#if 1
#define	Aid_LocalFail_LTE_1				0x0439

#define	Aid_LocalFail_LTE_A1_1			0x043A
#define	Aid_LocalFail_LTE_A2_1			0x043B
#endif






#define	Aid_FwdInPwr_3G					0x0500
#define Aid_FwdInUpperLmt_3G			0x0501
#define Aid_FwdInLowerLmt_3G			0x0502

#define	Aid_FwdOutPwr_3G				0x0503
#define	Aid_FwdOutUpperLmt_3G			0x0504
#define	Aid_FwdOutLowerLmt_3G			0x0505

#define	Aid_FwdOutAttn_3G				0x0506
#define	Aid_FwdInAttn_3G				0x050A
#define	Aid_OverIn_3G					0x050F
#define	Aid_FwdInPwr_2G					0x0510
#define	Aid_FwdInUpperLmt_2G			0x0511
#define	Aid_FwdInLowerLmt_2G			0x0512
#define	Aid_FwdInAttn_2G				0x0513
#define	Aid_FwdOutPwr_2G				0x0514
#define	Aid_FwdOutUpperLmt_2G			0x0515
#define	Aid_FwdOutLowerLmt_2G			0x0516
#define	Aid_FwdOutAttn_2G				0x0517
#define	Aid_OverIn_2G					0x051A
#define	Aid_FwdPllAlarm_2G				0x051B
#define	Aid_FwdInPwr_WI0				0x051C
#define Aid_FwdInUpperLmt_WI0			0x051D
#define Aid_FwdInLowerLmt_WI0			0x051E
#define	Aid_FwdInAttn_WI0				0x051F
#define Aid_FwdOutPwr_WI0				0x0520
#define	Aid_FwdOutUpperLmt_WI0			0x0521
#define	Aid_FwdOutLowerLmt_WI0			0x0522
#define	Aid_FwdAttn_WI0					0x0523
#define	Aid_FwdPllAlarm_3G				0x0526
#define	Aid_FwdGainSet_3G				0x0529
#define	Aid_FwdGain_3G					0x052a
#define	Aid_FwdInPwr_WI1				0x052E
#define Aid_FwdInUpperLmt_WI1			0x052F
#define Aid_FwdInLowerLmt_WI1			0x0530
#define	Aid_FwdInAttn_WI1				0x0531
#define	Aid_FwdOutPwr_WI1				0x0532
#define	Aid_FwdOutHighLmt_WI1			0x0533
#define	Aid_FwdOutLowLmt_WI1			0x0534
#define	Aid_FwdAttn_WI1					0x0535
#define	Aid_W_RRFU_TxOutput				0x0536
#define	Aid_W_RRFU_TxOutHighLmt			0x0537
#define	Aid_W_RRFU_TxOutLowLmt			0x0538
#define	Aid_W_RRFU_FwdAttn				0x0539
#define	Aid_C_RRFU_TxOutput				0x053A
#define	Aid_C_RRFU_TxOutHighLmt			0x053B
#define	Aid_C_RRFU_TxOutLowLmt			0x053C
#define	Aid_C_RRFU_FwdAttn				0x053D
#define	Aid_FwdGainSet_2G				0x0542
#define	Aid_FwdGainSts_2G				0x0543

////////////////////////////////////////////////////////////
#define	Aid_FwdInPwr_LTE				0x0552
#define	Aid_FwdInUpperLmt_LTE			0x0553
#define	Aid_FwdInLowerLmt_LTE			0x0554
#define	Aid_FwdInAttn_LTE				0x0555

#define	Aid_FwdOutPwr_LTE				0x0556
#define	Aid_FwdOutUpperLmt_LTE			0x0557
#define	Aid_FwdOutLowerLmt_LTE			0x0558

#define	Aid_FwdOutAttn_LTE				0x0559
#define	Aid_ExtFwdOutPwr_2G				0x055A
#define	Aid_ExtFwdOutUpperLmt_2G 		0x055B
#define	Aid_ExtFwdOutLowerLmt_2G 		0x055C
#define	Aid_ExtFwdOutAttn_Common 		0x055D
#define	Aid_ExtFwdOutPwr_LTE 			0x055E
#define	Aid_ExtFwdOutUpperLmt_LTE		0x055F
#define	Aid_ExtFwdOutLowerLmt_LTE		0x0560
#define	Aid_FwdGain_LTE					0x0561
#define	Aid_FwdGain_2G					0x0562
#define	Aid_RmtFwdInAttn_Common			0x0563


//#define	Aid_SmsFwdOutPwr_3G				0x0564
//#define	Aid_SmsFwdOutUpperLmt_3G		0x0565
//#define	Aid_SmsFwdOutLowerLmt_3G		0x0566


//#define	Aid_SmsFwdOutPwr_2G				0x0567
//#define	Aid_SmsFwdOutUpperLmt_2G		0x0568
//#define	Aid_SmsFwdOutLowerLmt_2G		0x0569

//#define	Aid_SmsFwdOutPwr_LTE			0x056A
//#define	Aid_SmsFwdOutUpperLmt_LTE		0x056B
//#define	Aid_SmsFwdOutLowerLmt_LTE		0x056C
#define	Aid_OverIn_LTE					0x0567
#define	Aid_OverIn_LTE_A1				0x0568

#define	Aid_FwdGainSet_LTE				0x0569
#define	Aid_FwdGainSts_LTE				0x056A


#define	Aid_FwdInPwr_LTE_A1				0x056B
#define	Aid_FwdOutPwr_LTE_A1			0x056C
#define	Aid_FwdOutUpperLmt_LTE_A1		0x056D
#define	Aid_FwdOutLowerLmt_LTE_A1		0x056E


#define	Aid_FwdGainSet_LTE_A1			0x0571
#define	Aid_FwdGain_LTE_A1				0x0572

#define	Aid_FwdPllAlarm_LTE_A1			0x057A

#define	Aid_FwdOtherOverIn_3G			0x0564
#define	Aid_FwdOtherOverIn_Common		0x0565
#define	Aid_FwdOtherOverIn_LTE_A		0x0566


//////////////////////////
#define Aid_WCDMA_Rvs0Gain				0x0600
#define Aid_WCDMA_Rvs1Gain				0x0601
#define Aid_Rvs0Attn_3G 				0x0602
#define Aid_Rvs1Attn_3G					0x0603
#define	Aid_RvsGainSet_3G				0x0604

#define	Aid_W_RxGainSetting				0x0604
#define Aid_RvsOscilation_3G			0x0607
#define	Aid_Rvs0Attn_2G					0x060e
#define	Aid_Rvs0GainSet_2G				0x060F
#define	Aid_RvsGainSet_2G				0x060F

#define Aid_RvsOscilation_2G			0x0610
#define	Aid_Rvs1Attn_2G					0x0611
#define	Aid_RvsGain1_2G					0x0612
#define	Aid_RvsPllAlarm_2G				0x0613
#define Aid_Rvs0Attn_WI	 				0x0614
#define Aid_Rvs1Attn_WI 				0x0615
#define Aid_Rvs0InPwr_WI 				0x0616
#define Aid_Rvs1InPwr_WI 				0x0617
#define	Aid_RvsPllAlarm_3G				0x061A
#define	Aid_Rvs0OutPwr_3G				0x0623
#define	Aid_Rvs0OutUpperLmt_3G			0x0624
#define	Aid_Rvs0OutPwr_2G				0x0629
#define	Aid_Rvs0OutUpperLmt_2G			0x062A
#define	Aid_RvsGainBalance_3G			0x062D
#define	Aid_RvsGainSts_3G				0x062E
#define Aid_WIBRO_Rvs0Gain				0x062F
#define Aid_WIBRO_Rvs1Gain				0x0630
#define	Aid_Rvs1_PLL_2G					0x063A
#define	Aid_Rvs1_PLL_3G					0x063B
#define	Aid_RvsGainBalance_2G			0x063F
#define	Aid_RvsGainSts_2G				0x0640
#define	Aid_Rvs1OutPwr_3G				0x0643
#define	Aid_Rvs1OutUpperLmt_3G			0x0644
#define	Aid_Rvs1OutPwr_2G				0x0645
#define	Aid_Rvs1OutUpperLmt_2G			0x0646
#define	Aid_Rvs1_PLL_2G					0x063A
#define	Aid_Rvs1_PLL_3G					0x063B
#define Aid_Rvs0OutPwr_WI				0x064B
#define Aid_Rvs1OutPwr_WI				0x064D
#define Aid_RvsOutUpperLmt_WI0			0x064C
#define Aid_RvsOutUpperLmt_WI1			0x064E
#define	Aid_Rvs0Attn_LTE				0x0664
#define	Aid_Rvs1Attn_LTE				0x0665
#define	Aid_Rvs0OutPwr_LTE				0x0666
#define	Aid_Rvs0OutUpperLmt_LTE			0x0667
#if 0
#define	Aid_Rvs1OutPwr_LTE				0x0668
#define	Aid_Rvs1OutUpperLmt_LTE			0x0669
#endif
#define	Aid_Rvs0Gain_LTE				0x066D
#define	Aid_Rvs1Gain_LTE				0x066E
#define	Aid_Rvs0Gain_2G					0x066F
#define	Aid_Rvs1Gain_2G					0x0670
#define	Aid_RvsGainSet_LTE				0x0674

#define Aid_RvsOscilation_LTE			0x0675
#define	Aid_RvsGainBalance_LTE			0x0676
#define	Aid_RvsGainSts_LTE				0x0677

#define	Aid_RvsGainSet_LTE_A1			0x067A
#define Aid_RvsOscilation_LTE_A1		0x067B
#define	Aid_RvsGainBalance_LTE_A1		0x067C
#define	Aid_RvsGainSts_LTE_A1			0x067D
#define	Aid_RvsPllAlarm_LTE_A1			0x067E

#define	Aid_RvsPllAlarm_LTE_A			0x067F


#define	Aid_Over_Pwr_Alarm				0x0700
#define	Aid_High_Temp_Alarm				0x0701
#define	Aid_VSWR_Alarm					0x0702
#define	Aid_Loop_Alarm					0x0703
#define	Aid_FwdAmpOnOff_3G				0x0706
#define	Aid_AmpManufacture_3G			0x0707
#define	Aid_Capability_3G				0x0708
#define	Aid_Amp_Serial					0x0709
#define	Aid_Amp_SWVer_3G				0x070A
#define	Aid_Amp_Reset_3G				0x070B
#define	Aid_AmpLink_Alarm				0x070C
#define	Aid_AmpDCFail_Alarm				0x070D
#define Aid_SystemOnOff					0x070E
#define	Aid_AmpOffCase_3G				0x070F
#define	Aid_Device_Alarm 				0x0710
#define	Aid_C_Over_Pwr_Alarm 			0x0711
#define	Aid_C_High_Temp_Alarm			0x0712
#define	Aid_C_VSWR_Alarm				0x0713
#define	Aid_FwdAmpOnOff_2G				0x0715


#define	Aid_CDMA_AmpManufacture			0x0716
#define	Aid_CDMA_Capability				0x0717
#define	Aid_AmpOffCase_2G				0x0718
#define	Aid_WCDMA_SerialNo				0x0719
#define	Aid_C_Loop_Alarm				0x071A
#define	Aid_C_Device_Alarm 				0x071B
#define	Aid_CDMA_Amp_Reset 				0x071C
#define	Aid_C_AmpLink_Alarm				0x071D
#define	Aid_C_AmpDCFail_Alarm			0x071E
#define	Aid_C_Amp_Serial				0x071F
#define	Aid_C_Amp_SW_Ver				0x0720
#define	Aid_WIBRO_AmpOnoff				0x0725
#define	Aid_WI_AmpManufactureType		0x0726
#define	Aid_WI_Capability				0x0727
#define	Aid_WI_OffCause					0x0728
#define Aid_WIBRO_Amp_Reset				0x072B
#define	Aid_WI_SerialNo					0x072e
#define	Aid_WI_SW_Ver					0x072f
#define	Aid_C_MWAmpSerial				0x0730
#define	Aid_RvsAmpOnOff_3G				0x0733
#define	Aid_RvsAmpOnOff_2G				0x0735
#define	Aid_WI1_AmpOnoff				0x073b
#define	Aid_WI1_AmpManufactureType		0x073c
#define	Aid_WI1_Capability				0x073d
#define	Aid_WI1_OffCause				0x073e
#define	Aid_WI1_Amp_Reset				0x0741
#define	Aid_WI1_SerialNo				0x0744
#define	Aid_WI1_SW_Ver					0x0746
#define	Aid_WI_Path_Gap					0x0748
#define	Aid_WI_Path_Gap_Level			0x0749


#define	Aid_FwdAmpOnOff_LTE				0x074F
#define	Aid_AmpOffCase_LTE				0x0754

#define	Aid_FwdAmpOnOff_LTE_A1			0x0750
#define	Aid_FwdAmpOnOff_Common			0x0751
#define	Aid_FwdAmp1OnOff_LTE			0x0752
#define	Aid_FwdAmp1OnOff_LTE_A1			0x0753

#define	Aid_AmpOffCase_LTE_A1			0x0755
#define	Aid_AmpOffCase_Common			0x0756
#define	Aid_Amp1OffCase_LTE				0x0757
#define	Aid_Amp1OffCase_LTE_A1			0x0758

#define	Aid_FwdAmpOnOff_LTE_A2			0x0759
#define	Aid_FwdAmp1OnOff_LTE_A2 		0x075A
#define	Aid_AmpOffCase_LTE_A2			0x075B
#define	Aid_Amp1OffCase_LTE_A2			0x075C


#define	Aid_WCDMA_Rvs_AUTO_SHUT			0x0803
#define	Aid_TDD_Mode					0x0808
#define	Aid_TS_Ref_Mode					0x0809
#define Aid_FA_Aloc_Mode_3G				0x080C
#define Aid_FA_Aloc_Mode_2G				0x080F
#define Aid_FA_Aloc_Mode_WI0			0x0812
#define Aid_FA_Aloc_Mode_WI1			0x0813
#define Aid_BalanceModeOnOff			0x082A

#define	Aid_LinkFailCase				0x0900
#define	Aid_W_LNA0_Fail					0x0901
#define	Aid_W_LNA1_Fail					0x0902
#define	Aid_CW0OnOff_3G					0x0903
#define	Aid_CW1OnOff_3G					0x0904
#define	Aid_Rx0AutoGainSet				0x0905
#define	Aid_Rx1AutoGainSet				0x0906
#define	Aid_Rx0GainResult				0x0907
#define	Aid_Rx1GainResult				0x0908
#define	Aid_AGCOnOff_3G					0x090a

#define	Aid_CW0Lvl_3G					0x0911
#define	Aid_CW1Lvl_3G					0x0912
#define	Aid_RCUReset					0x0914
#define	Aid_HostStn						0x0920
#define	Aid_FANo_3G						0x0921
#define	Aid_AutoReportPriod				0x0922
#define	Aid_ReportTime					0x0923
#define Aid_FANo_2G						0x0928
#define Aid_Digital_Bd0					0x0929

#define	Aid_ReportHours					0x092E

#define	Aid_C_LNA0_Fail					0x0930
#define	Aid_C_LNA1_Fail					0x0931
#define	Aid_CW0OnOff_2G					0x0932
#define	Aid_CW1OnOff_2G					0x0933
#define	Aid_C_Rx0AutoGainSet			0x0934
#define	Aid_AGCOnOff_2G					0x0935
#define	Aid_C_Rx1AutoGainSet			0x0936
#define	Aid_CDMA_Rvs0AutoGainResult		0x0937
#define	Aid_CDMA_Rvs1AutoGainResult		0x0938
#define	Aid_CW0Lvl_2G					0x0939
#define	Aid_CW1Lvl_2G					0x093A
#define	Aid_PassLoss					0x093C
#define	Aid_CW0OnOff_WI					0x0942
#define	Aid_CW1OnOff_WI					0x0943
#define Aid_WI_Rvs0AutoGainResult		0x0947
#define Aid_WI_Rvs1AutoGainResult		0x0948
#define Aid_WI_CW0Lvl					0x0949
#define Aid_WI_CW1Lvl					0x094A
#define	Aid_FA							0x094C
#define Aid_WI_FANo						0x0951
#define Aid_RF_PassLossOnoff 			0x0956
#define Aid_W_RF_RESULT					0x0957
#define Aid_PathLoss_Result_3G			0x0957
#define Aid_WI1_FANo					0x0958
#define	Aid_WCDMA_ResetCase				0x0959
#define	Aid_CDMA_ResetCase				0x095A
#define Aid_CDMA_RF_RESULT				0x095C
#define Aid_PathLoss_Result_2G			0x095C
#define Aid_FA_2G						0x095D

#define	Aid_W_Amp_Moule_Use				0x0963
#define	Aid_W_Amp_Moule_Gain			0x0964
#define Aid_BandSelect_3G				0x0966
#define Aid_FA_3G						0x096E
#define Aid_FA_2G_MPR					0x096F



#define	Aid_SMS_TxRetry					0x0c00
#define	Aid_ActChannel					0x0c01
#define	Aid_OneFAStatus					0x0c02
#define	Aid_RxMaxVal					0x0c03
#define	Aid_RxMinVal					0x0c04
#define	Aid_TxMaxVal					0x0c05
#define	Aid_TxMinVal					0x0c06
#define	Aid_AdjMaxVal					0x0c07
#define	Aid_AdjMinVal					0x0c08
#define	Aid_EcIo						0x0c09
#define	Aid_FARxValue					0x0c0a
#define	Aid_FAAdjValue					0x0c0b
#define	Aid_FAFerValue					0x0c0c
#define	Aid_PN_Val						0x0c0d
#define	Aid_EcIo_Val					0x0c0e
#define	Aid_Tx_Time						0x0c0f

#define	Aid_Master_PN					0x0C10
#define	Aid_ARMode						0x0C11
#define	Aid_RadioReportTime				0x0C12
#define	Aid_RadioReportPeriod			0x0C13
#define	Aid_TestStn						0x0C14
#define	Aid_BootAlarm					0x0C15
#define	Aid_PNUpdate					0x0C16

#define	Aid_TxVal						0x0C17
#define	Aid_WcdmaChannel				0x0C18


#define	Aid_MW_Pll_Alarm				0x0D03
#define Aid_MW_Ch_Val					0x0D06
#define Aid_MW_OutPwr					0x0D08
#define Aid_MW_PLLLock					0x0D09
#define Aid_Freq_Stable					0x0D0A
#define Aid_MW_Manufacture				0x0D0B
#define Aid_MW_Serial					0x0D0C
#define Aid_MW_InPwr					0x0D0D
#define Aid_MWOnOff						0x0D0E
#define Aid_MWOffCase					0x0D0F
#define	Aid_TS_Offset					0x0D10
#define	Aid_TDD_Guard_Offset			0x0D11
#define	Aid_TDD_RTG						0x0D12
#define	Aid_TDD_TTG						0x0D13
#define	Aid_TS_Recv_Sts					0x0D14
#define	Aid_DDM_T_SYNC_DLY_Fail			0x0D15
#define Aid_Delay						0x0D16
#define Aid_DelayLmt					0x0D17
#define Aid_MW_Temp						0x0D1D
#define	Aid_Tx1DelayOffset				0x0D20
#define	Aid__10M_PLL_FAIL				0x0D21
#define	Aid_MW_TempHighLmt				0x0D21
#define	Aid_TDD_Rx1_DelayOffset			0x0D21
#define	Aid_Band_Select					0x0D22
#define	Aid_Band_Freq					0x0D23
#define	Aid_Band_Offset					0x0D24
#define	Aid_Band_OffsetOn				0x0D25
#define Aid_WI_OEM_Delay				0x0D2E
#define Aid_Delay_Setup  				0x0D43
#define Aid_Delay_Measure 				0x0D44
#define Aid_TOEM_Delay 					0x0D45
#define	Aid_PureDelayMeasure			0x0D48
#define	Aid_FwdRepeaterDelay			0x0D49
#define	Aid_Rvs0RepeaterDelay			0x0D4A
#define	Aid_Rvs1RepeaterDelay			0x0D4B
#define	Aid_TOEMDelay_Setup				0x0D4C
#define	Aid_FwdSystemDelay				0x0D4D
#define	Aid_Rvs0SystemDelay				0x0D4E
#define	Aid_Rvs1SystemDelay				0x0D4F
#define	Aid_AutoDelay_Setup 			0x0D50

#define Aid_BandSelect_2G				0x1002
#define Aid_CFROnOff_3G					0x1008
#define Aid_CFRVal_3G					0x100C
#define Aid_FA_WI0						0x1013
#define Aid_FA_WI1						0x1014
#define Aid_ALCFixOnOff					0x1017
#define Aid_ALCATT_3G					0x101D
#define Aid_ALCATT_2G					0x101E
#define Aid_ALCATT_WI0					0x101F
#define Aid_ALCATT_WI1					0x1020

#define Aid_RepeatResetPriod			0x102A

#define Aid_FA_FilterOnOff_3G			0x102B

//#define Aid_CFR_Mode					0x1013
#define Aid_CFR_Mode					0x1033
#define Aid_BandSelect_LTE 		  		0x1042
#define Aid_FwdInALCAttn_LTE			0x1043
#define Aid_NearFAUse					0x1044
#define Aid_Link_Gain_Main				0x1045
#define Aid_LTE_BalanceOnOff			0x1046
#define Aid_Link_Gain_Div				0x1047
#define	Aid_PwrBalance					0x1048
#define	Aid_ASKTxFreg					0x1049
#define	Aid_ASKRxFreg					0x104a
#define	Aid_MainFwdALCAttn_Common		0x104B
#define	Aid_AdjustCableLoss				0x104C
#define	Aid_CDMA1FAPwr					0x104D
#define	Aid_LTE1FAPwr					0x104E
#define	Aid_Keyheight_Setup				0x104F
#define	Aid_Keyheight_Offset			0x1050
#define	Aid_AGCOnOff_LTE				0x1051
#define	Aid_AGCOnOff_LTE_A1				0x1052
#define	Aid_LTE15MUse					0x1059
#define	Aid_AGCMode_3G					0x105B
#define	Aid_AGCMode_2G					0x105C
#define	Aid_AGCMode_LTE					0x105D
#define	Aid_AGCMode_LTE_A1				0x105E
#define	Aid_AGC1OnOff_LTE				0x105F
#define	Aid_AGC1OnOff_LTE_A1			0x1060
#define	Aid_PowerAlarm					0x1061
#define	Aid_FemtocellUseOnOff			0x1062
#define	Aid_AGCOnOff_LTE_A2				0x1063
#define	Aid_AGC1OnOff_LTE_A2 			0x1064
#define	Aid_Band_Select_LTE_A1			0x1065	
#define	Aid_Band_Select_LTE_A2			0x1066	
#define	Aid_AGCMode_LTE_A2				0x1067

#define	Aid_AGCOnOff_CDMALTE			0x1068
#define	Aid_AGCOnOff_LTE_A_0			0x1069
#define	Aid_AGCOnOff_LTE_A_1			0x106A

#define	Aid_RvsOverInAlarmCount			0x106B
#define	Aid_RvsOtherOverInAlarmCount	0x106C




#define Aid_LDWaveInfo					0x1110
#define Aid_SFPInsertInfo0				0x1111
#define Aid_SFPInsertInfo1				0x1113
#define Aid_PD4PwrLowerLmt				0x1116
#define Aid_PD5PwrLowerLmt				0x1117


#define	Aid_Fwd1OutPwr_LTE				0x1B00
#define	Aid_Fwd1OutUpperLmt_LTE			0x1B01
#define	Aid_Fwd1OutLowerLmt_LTE			0x1B02
#define	Aid_Fwd1GainSet_LTE				0x1B03
#define	Aid_Fwd1GainSts_LTE				0x1B04
#define	Aid_Fwd1PllAlarm_LTE			0x1B05


#define	Aid_Fwd1OutPwr_LTE_A1			0x1B06
#define	Aid_Fwd1OutUpperLmt_LTE_A1		0x1B07
#define	Aid_Fwd1OutLowerLmt_LTE_A1		0x1B08
#define	Aid_Fwd1GainSet_LTE_A1			0x1B09
#define	Aid_Fwd1GainSts_LTE_A1			0x1B10
#define	Aid_Fwd1PllAlarm_LTE_A1			0x1B11
#define	Aid_Fwd1InPwr_LTE				0x1B12
#define	Aid_Fwd1InPwr_LTE_A1			0x1B13

#define	Aid_FwdInPwr_LTE_A2				0x1B14
#define	Aid_FwdOutPwr_LTE_A2			0x1B15
#define	Aid_FwdOutUpperLmt_LTE_A2	 	0x1B16  
#define	Aid_FwdOutLowerLmt_LTE_A2 		0x1B17
#define	Aid_FwdGainSet_LTE_A2			0x1B1A  
#define	Aid_FwdGain_LTE_A2				0x1B1B
#define	Aid_FwdPllAlarm_LTE_A2			0x1B1C


#define	Aid_Fwd1InPwr_LTE_A2			0x1B1D
#define	Aid_Fwd1OutPwr_LTE_A2	 		0x1B1E
#define	Aid_Fwd1OutUpperLmt_LTE_A2		0x1B1F
#define	Aid_Fwd1OutLowerLmt_LTE_A2		0x1B20
#define	Aid_Fwd1GainSet_LTE_A2			0x1B21 
#define	Aid_Fwd1Gain_LTE_A2				0x1B22 
#define	Aid_Fwd1PllAlarm_LTE_A2			0x1B23

#define	Aid_OverIn_LTE_A2				0x1B24

#define	Aid_OverIn_LTE_1				0x1B25
#define	Aid_OverIn_LTE_A1_1				0x1B26
#define	Aid_OverIn_LTE_A2_1				0x1B27



#define	Aid_Rvs1GainSet_LTE				0x1C00
#define Aid_Rvs1Oscilation_LTE			0x1C01
#define	Aid_Rvs1GainBalance_LTE			0x1C02
#define	Aid_Rvs1GainSts_LTE				0x1C03
#define	Aid_Rvs1PllAlarm_LTE			0x1C04
#define	Aid_Rvs1GainSet_LTE_A1			0x1C05
#define Aid_Rvs1Oscilation_LTE_A1		0x1C06
#define	Aid_Rvs1GainBalance_LTE_A1		0x1C07
#define	Aid_Rvs1GainSts_LTE_A1			0x1C08
#define	Aid_Rvs1PllAlarm_LTE_A1			0x1C09

#define Aid_RvsOscilation_LTE_A2		0x1C0A


#define	Aid_RvsGainSet_LTE_A2			0x1C0B	
#define	Aid_RvsGainSts_LTE_A2			0x1C0D	
#define	Aid_RvsGainBalance_LTE_A2		0x1C0C
#define	Aid_RvsPllAlarm_LTE_A2			0x1C0E

#define	Aid_Rvs1GainSet_LTE_A2			0x1C11
#define Aid_Rvs1Oscilation_LTE_A2		0x1C12
#define	Aid_Rvs1GainBalance_LTE_A2		0x1C13	
#define	Aid_Rvs1GainSts_LTE_A2			0x1C14	

#define	Aid_Rvs1PllAlarm_LTE_A2			0x1C15


///////////////////////////////////////////////////////
#define Aid_TPTL_OnOff					0xA000
#define	Aid_TempOffset					0xA001
#define	Aid_FAN_Auto					0xA002
#define	Aid_FANOnOff					0xA003
#define	Aid_FANOnAction					0xA004
#define	Aid_FANOffAction				0xA005
#define	Aid_RCUAddVer					0xA006
#define	Aid_ODUVer						0xA007
#define	Aid_FPGAVer						0xA008
#define	Aid_DPDVer_2G					0xA009
#define	Aid_DPDVer_3G					0xA00A
#define	Aid_DPDVer_Wibro0				0xA00b
#define	Aid_DPDVer_Wibro1				0xA00c
#define	Aid_AlarmMask					0xA00d
#define	Aid_LedAlarm					0xA00e
#define	Aid_ModemMINNumber				0xA00f
#define	Aid_ESNCheck					0xA010
#define	Aid_ModemOnOff					0xA011
#define	Aid_ModuleAlarm					0xA012
#define	Aid_ModuleTemp					0xA013
#define	Aid_TableSts					0xA014


#define	Aid_FAN2_Auto					0xA016
#define	Aid_FAN2_OnOff					0xA017
#define	Aid_FAN2_OnTemp					0xA018
#define	Aid_FAN2_OffTemp				0xA019


#define	Aid_InitialSet					0xA01F
#define	Aid_DefaultSet					0xA021

#define	Aid_DEUAddVer					0xA024
#define	Aid_DEO_Ver						0xA025


#define	Aid_RemoteType					0xA026
#define	Aid_Optic_Insert				0xA027
#define	Aid_LNA_Insert					0xA028

#define	Aid_DEO_Type					0xA029

#define	Aid_LockOrderSts				0xA02A
#define Aid_VccDet_Lmt					0xA02B

#define	Aid_NMS_Alarm					0xA0FF

#define	Aid_MhuDetVoltage				0xA100
#define Aid_FwdInPwrOffset_2G			0xA101
#define Aid_FwdInPwrOffset_3G			0xA102
#define Aid_FwdInPwrOffset_WI0			0xA103
#define Aid_FwdInPwrOffset_WI1			0xA104
#define Aid_FwdOptInPwrOffset_2G		0xA105
#define Aid_FwdOptInPwrOffset_3G		0xA106
#define Aid_FwdOptInPwrOffset_WI0		0xA107
#define Aid_FwdOptInPwrOffset_WI1		0xA108
#define Aid_Rvs0OutPwrOffset_2G			0xA109
#define Aid_Rvs1OutPwrOffset_2G			0xA10A
#define Aid_Rvs0OutPwrOffset_3G			0xA10B
#define Aid_Rvs1OutPwrOffset_3G			0xA10C
#define Aid_Rvs0OutPwrOffset_WI			0xA10D
#define Aid_Rvs1OutPwrOffset_WI			0xA10E
#define Aid_PD0PwrOffset				0xA10F
#define Aid_PD1PwrOffset				0xA110
#define Aid_PD2PwrOffset				0xA111
#define Aid_PD3PwrOffset				0xA112
#define Aid_PD4PwrOffset				0xA113
#define Aid_PD5PwrOffset				0xA114
#define Aid_FwdOptInALCLvl_2G			0xA115
#define Aid_FwdOptInALCLvl_3G			0xA116
#define Aid_FwdOptInALCLvl_WI0			0xA117
#define Aid_FwdOptInALCLvl_WI1			0xA118
#define Aid_FwdOptInALCOnOff_2G			0xA119
#define Aid_FwdOptInALCOnOff_3G			0xA11A
#define Aid_FwdOptInALCOnOff_WI0		0xA11B
#define Aid_FwdOptInALCOnOff_WI1		0xA11C
#define	Aid_FwdAttnOffset_2G			0xA11D
#define	Aid_Rvs0AttnOffset_2G			0xA11E
#define	Aid_Rvs1AttnOffset_2G			0xA11F
#define	Aid_FwdAttnOffset_3G			0xA120
#define	Aid_Rvs0AttnOffset_3G			0xA121
#define	Aid_Rvs1AttnOffset_3G			0xA122
#define	Aid_FwdInAttnOffset_WI0			0xA123
#define	Aid_Rvs0AttnOffset_WI			0xA124
#define	Aid_FwdInAttnOffset_WI1			0xA125
#define	Aid_Rvs1AttnOffset_WI			0xA126
#define Aid_BIP0ErrCnt					0xA127
#define Aid_BIP1ErrCnt					0xA128
#define Aid_BIP2ErrCnt					0xA129
#define Aid_BIP3ErrCnt					0xA12A
#define Aid_BIP4ErrCnt					0xA12B
#define Aid_BIP5ErrCnt					0xA12C
#define Aid_RODelay						0xA12D
#define Aid_RHU0DelayOffset				0xA12E
#define Aid_RHU1DelayOffset				0xA12F
#define Aid_RHU2DelayOffset				0xA130
#define Aid_RHU3DelayOffset				0xA131
#define Aid_RHU4DelayOffset				0xA132
#define Aid_RHU5DelayOffset				0xA133
#define Aid_RHU6DelayOffset				0xA134
#define Aid_RHU7DelayOffset				0xA135
#define Aid_RHU8DelayOffset				0xA136
#define Aid_RHU9DelayOffset				0xA137
#define Aid_RHU10DelayOffset			0xA138
#define Aid_RHU11DelayOffset			0xA139
#define Aid_RHU12DelayOffset			0xA13A
#define Aid_RHU13DelayOffset			0xA13B
#define Aid_RHU14DelayOffset			0xA13C
#define Aid_RHU15DelayOffset			0xA13D
#define Aid_RHU16DelayOffset			0xA13E
#define Aid_RHU17DelayOffset			0xA13F
#define Aid_RHU18DelayOffset			0xA140
#define Aid_RHU19DelayOffset			0xA141
#define Aid_RHU20DelayOffset			0xA142
#define Aid_RHU21DelayOffset			0xA143
#define Aid_RHU22DelayOffset			0xA144
#define Aid_RHU23DelayOffset			0xA145
#define Aid_RHU24DelayOffset			0xA146
#define Aid_RHU25DelayOffset			0xA147
#define Aid_RHU26DelayOffset			0xA148
#define Aid_RHU27DelayOffset			0xA149
#define Aid_RHU28DelayOffset			0xA14A
#define Aid_RHU29DelayOffset			0xA14B
#define Aid_RHU30DelayOffset			0xA14C
#define Aid_RHU31DelayOffset			0xA14D
#define	Aid_FwdInAttnTemp_2G			0xA14E
#define	Aid_Rvs0AttnTemp_2G				0xA14F
#define	Aid_Rvs1AttnTemp_2G				0xA150
#define	Aid_FwdInAttnTemp_3G			0xA151
#define	Aid_Rvs0AttnTemp_3G				0xA152
#define	Aid_Rvs1AttnTemp_3G				0xA153
#define	Aid_FwdInAttnTemp_WI0			0xA154
#define	Aid_Rvs0AttnTemp_WI				0xA155
#define	Aid_FwdInAttnTemp_WI1			0xA156
#define	Aid_Rvs1AttnTemp_WI				0xA157
#define	Aid_FwdOutPwrOffset_2G			0xA158
#define	Aid_FwdOutPwrOffset_3G			0xA159
#define	Aid_FwdOutPwrOffset_WI0			0xA15A
#define	Aid_FwdOutPwrOffset_WI1			0xA15B
#define	Aid_OutAttValue					0xA15c
#define	Aid_TotAttOffset				0xA15d
#define	Aid_FwdAttn1_2G					0xA15E
#define	Aid_FwdAttn2_2G					0xA15f
#define	Aid_FwdAttn3_2G					0xA160
#define	Aid_FwdAttn4_2G					0xA161
#define	Aid_FwdAttn1_3G					0xA162
#define	Aid_FwdAttn2_3G					0xA163
#define	Aid_FwdAttn3_3G					0xA164
#define	Aid_FwdAttn4_3G					0xA165
#define	Aid_RvsAttn1_2G					0xA166
#define	Aid_RvsAttn2_2G					0xA167
#define	Aid_RvsAttn3_2G					0xA168
#define	Aid_RvsAttn4_2G					0xA169
#define	Aid_RvsAttn1_3G					0xA16A
#define	Aid_RvsAttn2_3G					0xA16B
#define	Aid_RvsAttn3_3G					0xA16C
#define	Aid_RvsAttn4_3G					0xA16D
#define	Aid_RmtInstall					0xA16E
#define	Aid_RmtStatus					0xA16F
#define	Aid_IFOnOff_2G					0xA170
#define	Aid_IFOnOff_3G					0xA171
#define Aid_10M_REF_On					0xA172
#define Aid_AGSPLLOnOff					0xA173  //Aid_MainCWPLLSel
#define	Aid_FwdPLLFreg_2G				0xA174
#define	Aid_RvsPLLFreg_2G				0xA175
#define	Aid_FwdPLLFreg_3G				0xA176
#define	Aid_RvsPLLFreg_3G				0xA177
#define	Aid_AgsPLLFreq					0xA178
#define	Aid_FwdPLLFregOffset_2G			0xA179
#define	Aid_FwdPLLFregOffset_3G			0xA17a
#define	Aid_RvsPLLFregOffset_2G			0xA17b
#define	Aid_RvsPLLFregOffset_3G			0xA17c



#define Aid_LNAOnOff_3G					0xA181
#define Aid_LNAOnOff_2G					0xA182
#define	Aid_FwdPLLFregTemp_2G			0xA19F

#define	Aid_FwdPLLFregTemp_3G			0xA1A0
#define	Aid_FwdOverVoltage_2G			0xA1A1
#define	Aid_FwdOverVoltage_3G			0xA1A2
#define	Aid_CWPLLFreq					0xA1A3
#define Aid_UDCOnOff_2G					0xA1A4
#define Aid_UDCOnOff_WI0				0xA1A5
#define Aid_FwdInPwrCAL_2G				0xA1AD
#define Aid_FwdInPwrCAL_3G				0xA1AE
#define Aid_FwdInPwrCAL_WI0				0xA1AF
#define Aid_FwdInPwrCAL_WI1				0xA1B0


#define Aid_ResetPeriodCountSts			0xA1BD
#define Aid_ResetPeriodCountSet			0xA1BE


#define Aid_Service_Use					0xA1BF
#define Aid_DE_DnrDet					0xA1C1
#define Aid_FwdOutPwrOffset_2G_1		0xA1C2
#define Aid_FwdInPwrOffset_LTE			0xA1C3
#define Aid_FwdOutPwrOffset_LTE			0xA1C4
#define Aid_FwdDigInPwr_LTE				0xA1C5
#define Aid_FwdDigInPwrOffset_LTE		0xA1C6
#define Aid_FwdOptInALCLvl_LTE			0xA1C7
#define Aid_FwdOptInALCOnOff_LTE 		0xA1C8
#define Aid_FwdALCAttnOffset_LTE 		0xA1C9
#define Aid_FwdAttn0Offset_LTE			0xA1CA
#define Aid_FwdAttn_LTE					0xA1CB/////////////////////Aid_Fwd1Attn_LTE
#define Aid_FwdAttn1Offset_LTE			0xA1CC
#define Aid_Rvs0OutPwrOffset_LTE 		0xA1CD
#if 0
#define Aid_Rvs1OutPwrOffset_LTE 		0xA1CE
#endif
#define Aid_Rvs0AttnOffset_LTE			0xA1CF
#define Aid_Rvs1AttnOffset_LTE			0xA1D0
#define Aid_Rvs0DigInPwr_LTE 			0xA1D1
#define Aid_Rvs0DigInPwrOffset_LTE		0xA1D2
#define Aid_Rvs1DigInPwr_LTE 			0xA1D3
#define Aid_Rvs1DigInPwrOffset_LTE		0xA1D4

#define Aid_FwdInAttnTemp_LTE			0xA1DD
#define Aid_Rvs0AttnTemp_LTE 			0xA1DF
#define Aid_Rvs1AttnTemp_LTE 			0xA1E0
#define	Aid_Ref10MVoltDet 				0xA1E3
#define	Aid_10MRefPwrOffset 			0xA1E4
#define	Aid_FwdIFMOnOff_LTE 			0xA1E5
#define Aid_Fwd_DigPathOnOff_LTE		0xA1E5
#define	Aid_FwdUDCOnOff_LTE 			0xA1E8
#define	Aid_Rvs0SDLevel_LTE 			0xA1EE
#define	Aid_Rvs1SDLevel_LTE 			0xA1EF

#define	 Aid_Rvs0OptInALCLvl_LTE 		0xA1F0
#define	 Aid_Rvs1OptInALCLvl_LTE 		0xA1F1
#define	 Aid_Rvs0OptInALCOnOff_LTE 		0xA1F2
#define	 Aid_Rvs1OptInALCOnOff_LTE 		0xA1F3
#define	 Aid_Rvs0ALCAttn_LTE 			0xA1F4
#define	 Aid_Rvs1ALCAttn_LTE 			0xA1F5
#define	 Aid_CurrDelayMeasure 			0xA1F6
#define	 Aid_FwdRefAttn_LTE		 		0xA1F7
#define	 Aid_Ref_10M_Pwr 				0xA1F9

#define	 Aid_LCU_TxAmpAlarm 			0xA1FA
#define	 Aid_LCU_Rvs0AmpAlarm 			0xA1FC
#define	 Aid_LCU_Rvs1AmpAlarm 			0xA1FD

#define Aid_UDCOnOff_3G					0xD200
#define Aid_UDCOnOff_WI1				0xD210

#define	Aid_RhuDet0Voltage				0xA200
#define	Aid_LIFDetVoltage				0xA201
#define Aid_RmtRvs0InPwr_2G				0xA202
#define Aid_RmtRvs1InPwr_2G				0xA203
#define Aid_RmtRvs0InPwr_3G				0xA204
#define Aid_RmtRvs1InPwr_3G				0xA205
#define Aid_RmtRvs0InPwr_WI				0xA206
#define Aid_RmtRvs1InPwr_WI				0xA207
#define Aid_RmtPilotDet_2G				0xA20c
#define Aid_RmtPilotDet_3G				0xA20d
#define Aid_RmtPilotDet_WI0				0xA20e
#define Aid_RmtPilotDet_WI1				0xA20f
#define Aid_RmtRvs0InPwrOffset_2G		0xA210
#define Aid_RmtRvs1InPwrOffset_2G		0xA211
#define Aid_RmtRvs0InPwrOffset_3G		0xA212
#define Aid_RmtRvs1InPwrOffset_3G		0xA213
#define Aid_RmtRvsInPwrOffset_WI0		0xA214
#define Aid_RmtRvsInPwrOffset_WI1		0xA215
#define Aid_RmtPilotDetOffset_2G		0xA21a
#define Aid_RmtPilotDetOffset_3G		0xA21b
#define Aid_RmtPilotDetOffset_WI0		0xA21c
#define Aid_RmtPilotDetOffset_WI1		0xA21d
#define Aid_RmtFwdPwrOffset_2G			0xA21E
#define Aid_RmtFwdPwrOffset_3G			0xA21F
#define Aid_RmtFwdPwrOffset_WI0			0xA220
#define Aid_RmtFwdPwrOffset_WI1			0xA221
#define Aid_RmtFeedAttn_2G				0xA23F
#define Aid_RmtRvs0Attn_2G				0xA240
#define Aid_RmtRvs1Attn_2G				0xA241
#define Aid_RmtFeedAttn_3G				0xA243
#define Aid_RmtRvs0Attn_3G				0xA244
#define Aid_RmtRvs1Attn_3G				0xA245
#define Aid_RmtFeed0Attn_WI				0xA248
#define Aid_RmtFeed1Attn_WI				0xA249
#define Aid_RmtRvs0Attn_WI				0xA24A
#define Aid_RmtRvs1Attn_WI				0xA24B
#define Aid_RmtFwdAttnOffset_2G			0xA24c
#define Aid_RmtFeedAttnOffset_2G		0xA24d
#define Aid_RmtRvs0AttnOffset_2G		0xA24e
#define Aid_RmtRvs1AttnOffset_2G		0xA24f
#define Aid_RmtFwdAttnOffset_3G			0xA250
#define Aid_RmtFeedAttnOffset_3G		0xA251
#define Aid_RmtRvs0AttnOffset_3G		0xA252
#define Aid_RmtRvs1AttnOffset_3G		0xA253
#define Aid_RmtFwd0AttnOffset_WI		0xA254
#define Aid_RmtFwd1AttnOffset_WI		0xA255
#define Aid_RmtFeed0AttnOffset_WI		0xA256
#define Aid_RmtFeed1AttnOffset_WI		0xA257
#define Aid_RmtRvs0AttnOffset_WI		0xA258
#define Aid_RmtRvs1AttnOffset_WI		0xA259
#define Aid_RmtFwdAttnTemp_2G			0xA28a
#define Aid_RmtRvs0AttnTemp_2G 			0xA28b
#define Aid_RmtRvs1AttnTemp_2G 			0xA28c
#define Aid_RmtFwdAttnTemp_3G			0xA28d
#define Aid_RmtRvs0AttnTemp_3G 			0xA28e
#define Aid_RmtRvs1AttnTemp_3G 			0xA28f
#define Aid_RmtFwdAttnTemp_WI0			0xA290
#define Aid_RmtRvs0AttnTemp_WI0 		0xA291
#define Aid_RmtFwdAttnTemp_WI1			0xA292
#define Aid_RmtRvs0AttnTemp_WI1 		0xA293
#define Aid_RvsTempAttn_WI 				0xA291
#define Aid_RvsTempAttn_WI1 			0xA293
#define	Aid_UDC0OnOff_2G				0xA294
#define	Aid_UDC1OnOff_2G				0xA295
#define	Aid_UDC0OnOff_3G				0xA296
#define	Aid_UDC1OnOff_3G				0xA297
#define	Aid_UDC0OnOff_WI				0xA298
#define	Aid_UDC1OnOff_WI				0xA299
#define	Aid_UDC1OnOff_WI				0xA299
#define	Aid_ReturnDelayOnOff			0xA29A
#define	Aid_ReturnOnOff					0xA2AF


#define Aid_LIFRStatus			 		0xA300
#define	Aid_LIFRRvsPLLFreg_2G			0xA301
#define	Aid_LIFRRvsPLLFreg_3G			0xA302
#define	Aid_LIFRRvsPLLFregOffset_2G		0xA303
#define	Aid_LIFRRvsPLLFregOffset_3G		0xA304
#define Aid_RvsPwrOffset_2G				0xA305
#define Aid_RvsPwrOffset_3G				0xA306
#define Aid_FwdRauOutPwrOffset_2G		0xA307
#define Aid_FwdRauOutPwrOffset_3G		0xA308
#define	Aid_ROutAttValue				0xA309
#define	Aid_RTotAttOffset				0xA30A
#define	Aid_RmtFwdAttn1_2G				0xA30B
#define	Aid_RmtFwdAttn2_2G				0xA30C
#define	Aid_RmtFwdAttn3_2G				0xA30D
#define	Aid_RmtFwdAttn1_3G				0xA30E
#define	Aid_RmtFwdAttn2_3G				0xA31F
#define	Aid_RmtFwdAttn3_3G				0xA310
#define	Aid_RmtRvsAttn1_2G				0xA311
#define	Aid_RmtRvsAttn2_2G				0xA312
#define	Aid_RmtRvsAttn3_2G				0xA313
#define	Aid_RmtRvsAttn1_3G				0xA314
#define	Aid_RmtRvsAttn2_3G				0xA315
#define	Aid_RmtRvsAttn3_3G				0xA316
#define	Aid_RmtRefAttn					0xA317
#define	Aid_TxEquVal_2G					0xA318
#define	Aid_TxEquVal_3G					0xA319
#define	Aid_RxEquVal_2G					0xA31A
#define	Aid_RxEquVal_3G					0xA31B
#define	Aid_FwdPathOnOff_2G				0xA324
#define	Aid_FwdPathOnOff_3G				0xA325
#define	Aid_RmtRvsLNAOnOff_2G			0xA181
#define	Aid_RmtRvsLNAOnOff_3G			0xA182

#define	Aid_LIFRFWD_EQ_A_2G				0xA305
#define	Aid_LIFRFWD_EQ_B1_2G			0xA306
#define	Aid_LIFRFWD_EQ_B2_2G			0xA307
#define	Aid_LIFRRvs_EQ_A_2G				0xA308
#define	Aid_LIFRRvs_EQ_B1_2G			0xA309
#define	Aid_LIFRRvs_EQ_B2_2G			0xA30a
#define	Aid_LIFRFWD_EQ_A_3G				0xA30b
#define	Aid_LIFRFWD_EQ_B1_3G			0xA30c
#define	Aid_LIFRFWD_EQ_B2_3G			0xA30d
#define	Aid_LIFRRvs_EQ_A_3G				0xA30e
#define	Aid_LIFRRvs_EQ_B1_3G			0xA30f
#define	Aid_LIFRRvs_EQ_B2_3G			0xA310
#define	Aid_LIFRvs_FR_A_2G				0xA311
#define	Aid_LIFRvs_FR_B1_2G				0xA312
#define	Aid_LIFRvs_FR_B2_2G				0xA313
#define	Aid_LIFRvs_FR_A_3G				0xA314
#define	Aid_LIFRvs_FR_B1_3G				0xA315
#define	Aid_LIFRvs_FR_B2_3G				0xA316
#define	Aid_LIFRvs_FR2_A_3G				0xA317
#define	Aid_LIFRefAttOnOff				0xA318
#define	Aid_LIFAgsPwr					0xA345

#define	Aid_SmsFwdInPwr_3G				0xA348
#define	Aid_SmsFwdInPwr_2G				0xA349
#define	Aid_SmsRvsOutPwr_3G 			0xA34A
#define	Aid_SmsRvsOutPwr_2G 			0xA34B
#define	Aid_ShutDownOnOff_3G 			0xA34C
#define	Aid_ShutDownOnOff_2G 			0xA34D
#define	Aid_RvsOutUpperLmt_3G 			0xA367
#define	Aid_RvsOutUpperLmt_2G 			0xA369
#define	Aid_FwdGainOffset_3G 			0xA36A
#define	Aid_RvsGainOffset_3G 			0xA36B
#define	Aid_FwdGainOffset_2G 			0xA36C
#define	Aid_RvsGainOffset_2G 			0xA36D
#define	Aid_FwdTemp_3G					0xA36E
#define	Aid_RvsTemp_3G					0xA36F
#define	Aid_FwdTemp_2G					0xA370
#define	Aid_RvsTemp_2G					0xA371
#define	Aid_FwdOutHighLmt_3G			0xA373
#define	Aid_FwdOutHighLmt_2G			0xA374
#define	Aid_DebugOnOff					0xA391
#define	Aid_RadioMeasureOnOff			0xA392

#define	Aid_DE_RmtDet					0xA3A4
#define	Aid_RmtFwdInPwr_Common			0xA3A5
#define	Aid_RmtRvs0InPwr_Common			0xA3A6
#define	Aid_RmtRvs1InPwr_Common			0xA3A7

#define	Aid_RmtFwdInPwrOffset_Common	0xA3A8
#define	Aid_RmtRvs0InPwrOffset_Common	0xA3A9
#define	Aid_RmtRvs1InPwrOffset_Common	0xA3AA
#define	Aid_RmtDigRvs0InPwr_2G			0xA3AB
#define	Aid_RmtDigRvs1InPwr_2G			0xA3AC
#define	Aid_RmtDigRvs0InPwr_LTE			0xA3AD
#define	Aid_RmtDigRvs1InPwr_LTE			0xA3AE
#define	Aid_RmtDigRvs0InPwrOffset_2G	0xA3AF
#define	Aid_RmtDigRvs1InPwrOffset_2G	0xA3B0
#define	Aid_RmtDigRvs0InPwrOffset_LTE 	0xA3B1
#define	Aid_RmtDigRvs1InPwrOffset_LTE 	0xA3B2
#define	Aid_RmtRvs0SDLevel_Common 		0xA3B3
#define	Aid_RmtRvs1SDLevel_Common 		0xA3B4
#define	Aid_RmtRvs0OptInALCLvl_Common 	0xA3B5
#define	Aid_RmtRvs1OptInALCLvl_Common 	0xA3B6
#define	Aid_RmtRvs0OptInALCOnOff_Common	0xA3B7
#define	Aid_RmtRvs1OptInALCOnOff_Common	0xA3B8
#define	Aid_RmtFwdOutAttn_Common 		0xA3BA
#define	Aid_RmtExtFwdInAttn_Common		0xA3BB
#define	Aid_RmtFwdInAttnOffset_Common	0xA3BC
#define	Aid_RmtFwdOutAttnOffset_Common	0xA3BD
#define	Aid_ExtFwdOutAttnOffset_Common	0xA3BE
#define	Aid_RmtRvs0InAttn_Common			0xA3BF
#define	Aid_RmtRvs0OutAttn_Common 			0xA3C0
#define	Aid_RmtExtRvsOutAttn_Common			0xA3C1
#define	Aid_RmtRvs0InAttnOffset_Common		0xA3C2
#define	Aid_RmtRvs0OutAttnOffset_Common		0xA3C3
#define	Aid_RmtExtRvsOutAttnOffset_Common	0xA3C4
#define	Aid_RmtRvs0Attn_LTE				0xA3C5
#define	Aid_RmtFwdAttnOffset_LTE		0xA3C7
#define	Aid_RmtRvs0AttnOffset_LTE		0xA3C8
#define	Aid_RmtRvs1AttnOffset_LTE		0xA3C9
#define	Aid_RmtFwdInAttnTemp_Common		0xA3CC
#define	Aid_RmtRvs0AttnTemp_Common		0xA3CD
#define	Aid_RmtRvs1AttnTemp_Common		0xA3CE
#define	Aid_RmtDigFwdInpwr_LTE			0xA3D1
#define	Aid_RmtDigFwdInpwr_2G 			0xA3D2
#define	Aid_RmtDigFwdInPwrOffset_LTE	0xA3D3
#define	Aid_RmtDigFwdInPwrOffset_2G 	0xA3D4
#define	Aid_FwdDelayOffset_LTE			0xA3D5
#define	Aid_Rvs0DelayOffset_LTE 		0xA3D6
#define	Aid_Rvs1DelayOffset_LTE 		0xA3D7
#define	Aid_FwdDelay_Setup				0xA3D8
#define	Aid_RvsDelay_Setup				0xA3D9
#define	Aid_Rvs1Delay_Setup 			0xA3DA
#define	Aid_FwdDelayTempOffset			0xA3DC
#define	Aid_RvsDelayTempOffset 			0xA3DD
#define	Aid_FwdOptInALCLvl_Common		0xA3DE
#define	Aid_FwdOptInALCOnOff_Common		0xA3DF
#define	Aid_FwdALCAttn_Common			0xA3E0
#define	Aid_FwdGainAttn_2G				0xA3E8
#define	Aid_FwdGainAttn_LTE				0xA3E9
#define	Aid_Rvs0GainAttn_2G				0xA3EA
#define	Aid_Rvs1GainAttn_2G				0xA3EB	 
#define	Aid_Rvs0GainAttn_LTE 			0xA3EC	 
#define	Aid_Rvs1GainAttn_LTE 			0xA3ED	 
#define	Aid_ModemDelayOffset			0xA3EE	 
#define	Aid_ModemDelayOffset_Common		0xA3EF	 
#define	Aid_FwdDelay_Measure 			0xA3F0
#define	Aid_RvsDelay_Measure 			0xA3F1
#define	Aid_Rvs1Delay_Measure 			0xA3F2
#define	Aid_FwdDelayOffset_Common		0xA3F3
#define	Aid_Rvs0DelayOffset_Common 		0xA3F4
#define	Aid_Rvs1DelayOffset_Common 		0xA3F5

#define	Aid_RmtRvs1InAttn_Common			0xA3FA
#define	Aid_RmtRvs1OutAttn_Common 			0xA3FB
#define	Aid_RmtRvs1InAttnOffset_Common		0xA3FC
#define	Aid_RmtRvs1OutAttnOffset_Common		0xA3FD



#define Aid_OptReset					0xA500
#define Aid_Opt0Alarm					0xA501
#define Aid_LD0Type						0xA502
#define Aid_Opt1Alarm					0xA503
#define Aid_LD1Type						0xA504
#define Aid_Opt2Alarm					0xA505
#define Aid_LD2Type						0xA506
#define Aid_Opt3Alarm					0xA507
#define Aid_LD3Type						0xA508
#define Aid_Opt4Alarm					0xA509
#define Aid_LD4Type						0xA50A
#define Aid_Opt5Alarm					0xA50B
#define Aid_LD5Type						0xA50C
#define Aid_FwdISOLmt_2G				0xA50D
#define Aid_FwdISOMaxGap_2G				0xA50E
#define Aid_FwdISOLmt_3G				0xA50F
#define Aid_FwdISOMaxGap_3G				0xA510
#define Aid_FwdALCLmt_3G				0xA511
#define Aid_FwdALCLmt_2G				0xA512
#define Aid_DigitalBdOnoff				0xA51F


#define Aid_AutoShutDownSts_2G			0xA605
#define Aid_AutoShutDownSts_3G			0xA606

#define Aid_AutoShutDownSts_LTE			0xA86b
#define Aid_AutoShutDownSts_LTE_A1		0xA86c

#define Aid_AutoShutDownSts_LTE1		0xA93B
#define Aid_AutoShutDownSts_LTE_A1_1	0xA93C

#define Aid_DnrSts						0xA611
#define Aid_DE_RmtStatus				0xA612
#define Aid_HubInstall					0xA613
#define Aid_DE_RmtInstall				0xA614


#define Aid_DetVolt 					0xA800
#define Aid_DetPwr						0xA801
#define Aid_DetOffset					0xA802
#define Aid_AttValue					0xA803
#define Aid_AttOffset					0xA804
#define Aid_FwdInPwrOffset_LTE_A1 		0xA805
#define Aid_RvsOutPwrOffset_LTE_A1		0xA806
#define Aid_FwdOutPwrOffset_LTE_A1		0xA807
#define Aid_FwdAttn1_CDMALTE			0xA808
#define Aid_FwdAttn2_CDMALTE			0xA809
#define Aid_FwdAttn3_CDMALTE			0xA80A
#define Aid_RvsAttn1_CDMALTE			0xA80B
#define Aid_RvsAttn2_CDMALTE			0xA80C
#define Aid_RvsAttn3_CDMALTE			0xA80D
#define Aid_RvsAttn4_CDMALTE			0xA80E
#define Aid_RvsAttn5_3G					0xA80F
#define Aid_FwdAttn1_LTE 				0xA810
#define Aid_FwdAttn2_LTE 				0xA811
#define Aid_FwdAttn3_LTE 				0xA812
#define Aid_FwdAttn4_LTE 				0xA813
#define Aid_FwdAttn1_LTE_A1				0xA814
#define Aid_FwdAttn2_LTE_A1				0xA815
#define Aid_FwdAttn3_LTE_A1				0xA816
#define Aid_FwdAttn4_LTE_A1				0xA817
#define Aid_RvsAttn1_LTE 				0xA818
#define Aid_RvsAttn2_LTE 				0xA819
#define Aid_RvsAttn3_LTE 				0xA81A
#define Aid_RvsAttn4_LTE 				0xA81B
#define Aid_RvsAttn5_LTE 				0xA81C
#define Aid_RvsAttn1_LTE_A1				0xA81D
#define Aid_RvsAttn2_LTE_A1				0xA81E
#define Aid_RvsAttn3_LTE_A1				0xA81F
#define Aid_RvsAttn4_LTE_A1				0xA820
#define Aid_RvsAttn5_LTE_A				0xA821
#define Aid_FwdGainOffset_LTE			0xA822
#define Aid_RvsGainOffset_LTE			0xA823
#define Aid_FwdGainOffset_LTE_A1		0xA824
#define Aid_RvsGainOffset_LTE_A1		0xA825
#define Aid_FwdAgcAttn_2G				0xA826
#define Aid_FwdAgcAttn_LTE				0xA827
#define Aid_FwdAgcAttn_LTE_A1 			0xA828
#define Aid_FwdAgcAttn_3G				0xA829
#define Aid_RvsAlcAttn_2G				0xA82A
#define Aid_RvsAlcAttn_LTE				0xA82B
#define Aid_RvsAlcAttn_LTE_A1 			0xA82C
#define Aid_RvsAlcAttn_3G				0xA82D
#define Aid_RvsAlcOnOff_2G				0xA82E
#define Aid_RvsAlcOnOff_LTE				0xA82F
#define Aid_RvsAlcOnOff_LTE_A1			0xA830
#define Aid_RvsAlcOnOff_3G				0xA831
#define Aid_SmsFwdInPwr_LTE				0xA842
#define Aid_SmsFwdInPwr_LTE_A1 			0xA843
#define Aid_RvsOutPwr_LTE	 			0xA844
#define Aid_RvsOutPwr_LTE_A1			0xA845
#define Aid_RvsInPwr_2G					0xA846
#define Aid_RvsInPwr_LTE				0xA847
#define Aid_RvsInPwr_LTE_A1				0xA848
#define Aid_RvsInPwr_3G					0xA849
#define Aid_ShutDownOnOff_LTE			0xA84A
#define Aid_ShutDownOnOff_LTE_A1		0xA84B
#define Aid_RvsOutUpperLmt_LTE			0xA84C
#define Aid_RvsOutUpperLmt_LTE_A1		0xA84D
#define Aid_FwdTemp_LTE					0xA84E
#define Aid_RvsTemp_LTE					0xA84F
#define Aid_FwdTemp_LTE_A1				0xA850
#define Aid_RvsTemp_LTE_A1				0xA851
#define Aid_FwdOutHighLmt_LTE	 		0xA852
#define Aid_FwdOutHighLmt_LTE_A1		0xA853
#define Aid_OverInAlarmLmt_2G			0xA854
#define Aid_OverInAlarmLmt_LTE			0xA855
#define Aid_OverInAlarmLmt_LTE_A1		0xA856
#define Aid_OverInAlarmLmt_3G			0xA857
#define Aid_OtherOverInAlarmLmt_2G		0xA858
#define Aid_OtherOverInAlarmLmt_LTE		0xA859
#define Aid_OtherOverInAlarmLmt_LTE_A1	0xA85A
#define Aid_OtherOverInAlarmLmt_3G		0xA85B
#define Aid_RvsAttn5_2G					0xA85C
#define Aid_RvsALCLvl_2G 				0xA85D
#define Aid_RvsALCLvl_3G				0xA85E
#define Aid_RvsALCLvl_LTE				0xA85F
#define Aid_RvsALCLvl_LTE_A1			0xA860

#define Aid_ShunDownTime				0xA862
#define	Aid_FwdInPwrOffset_LTE_A2		0xA870
#define	Aid_RvsOutPwrOffset_LTE_A2		0xA871
#define	Aid_FwdOutPwrOffset_LTE_A2		0xA872
#define	Aid_FwdAttn1_LTE_A2				0xA873	
#define	Aid_FwdAttn2_LTE_A2				0xA874	
#define	Aid_FwdAttn3_LTE_A2				0xA875

#define	Aid_RvsAttn1_LTE_A2				0xA877	
#define	Aid_RvsAttn2_LTE_A2				0xA878	
#define	Aid_RvsAttn3_LTE_A2				0xA879	
#define	Aid_RvsAttn4_LTE_A2				0xA87A	
#define	Aid_FwdGainOffset_LTE_A2 		0xA87C
#define	Aid_RvsGainOffset_LTE_A2 		0xA87D
#define	Aid_FwdAgcAttn_LTE_A2			0xA87E
#define	Aid_RvsAlcAttn_LTE_A2			0xA87F
#define	Aid_RvsAlcOnOff_LTE_A2			0xA880
#define	Aid_SmsFwdInPwr_LTE_A2			0xA889
#define	Aid_RvsOutPwr_LTE_A2			0xA88A
#define	Aid_RvsInPwr_LTE_A2				0xA88B
#define	Aid_ShutDownOnOff_LTE_A2 		0xA88C
#define	Aid_RvsOutUpperLmt_LTE_A2	 	0xA88D
#define	Aid_FwdTemp_LTE_A2				0xA88E
#define	Aid_RvsTemp_LTE_A2				0xA88F
#define	Aid_FwdOutHighLmt_LTE_A2		0xA890
#define	Aid_OverInAlarmLmt_LTE_A2		0xA891
#define	Aid_OtherOverInAlarmLmt_LTE_A2	0xA892
#define	Aid_RvsALCLvl_LTE_A2	 		0xA893
#define	Aid_AutoShutDownSts_LTE_A2		0xA895

#define	Aid_FwdAttn1_LTE_A				0xA896	
#define	Aid_RvsAttn1_LTE_A				0xA899	

#define	Aid_PllFregOffset_LTE_A2		0xA8AF	

#define	Aid_PllFregOffset_LTE			0xA8AD	



#define Aid_Det1Volt 					0xA900
#define Aid_Det1Pwr						0xA901
#define Aid_Det1Offset					0xA902
#define Aid_Att1Value					0xA903
#define Aid_Att1Offset					0xA904
#define Aid_Fwd1InPwrOffset_LTE 		0xA905

#define Aid_Rvs1OutPwrOffset_LTE		0xA906
#define Aid_Fwd1OutPwrOffset_LTE		0xA907

#define Aid_Fwd1InPwrOffset_LTE_A1 		0xA908
#define Aid_Rvs1OutPwrOffset_LTE_A1		0xA909
#define Aid_Fwd1OutPwrOffset_LTE_A1		0xA90A
#define Aid_Fwd1Attn1_LTE 				0xA90B
#define Aid_Fwd1Attn2_LTE 				0xA90C
#define Aid_Fwd1Attn3_LTE 				0xA90D
#define Aid_Fwd1Attn4_LTE 				0xA90E
#define Aid_Fwd1Attn1_LTE_A1			0xA90F
#define Aid_Fwd1Attn2_LTE_A1			0xA910
#define Aid_Fwd1Attn3_LTE_A1			0xA911
#define Aid_Fwd1Attn4_LTE_A1			0xA912
#define Aid_Rvs1Attn1_LTE 				0xA913
#define Aid_Rvs1Attn2_LTE 				0xA914
#define Aid_Rvs1Attn3_LTE 				0xA915
#define Aid_Rvs1Attn4_LTE 				0xA916
#define Aid_Rvs1Attn5_LTE 				0xA917
#define Aid_Rvs1Attn1_LTE_A1			0xA918
#define Aid_Rvs1Attn2_LTE_A1			0xA919
#define Aid_Rvs1Attn3_LTE_A1			0xA91A
#define Aid_Rvs1Attn4_LTE_A1			0xA91B
#define Aid_Rvs1Attn5_LTE_A				0xA91C
#define Aid_Fwd1GainOffset_LTE			0xA91D
#define Aid_Rvs1GainOffset_LTE			0xA91E
#define Aid_Fwd1GainOffset_LTE_A1		0xA91F
#define Aid_Rvs1GainOffset_LTE_A1		0xA920
#define Aid_Fwd1AgcAttn_LTE				0xA921
#define Aid_Fwd1AgcAttn_LTE_A1 			0xA922
#define Aid_Rvs1AlcAttn_LTE				0xA923
#define Aid_Rvs1AlcAttn_LTE_A1 			0xA924
#define Aid_Rvs1AlcOnOff_LTE			0xA925
#define Aid_Rvs1AlcOnOff_LTE_A1			0xA926
#define Aid_SmsFwd1InPwr_LTE			0xA929
#define Aid_SmsFwd1InPwr_LTE_A1 		0xA92A
#define Aid_Rvs1OutPwr_LTE	 			0xA92B
#define Aid_Rvs1OutPwr_LTE_A1			0xA92C
#define Aid_Rvs1InPwr_LTE				0xA92D
#define Aid_Rvs1InPwr_LTE_A1			0xA92E
#define Aid_ShutDownOnOff1_LTE			0xA92F
#define Aid_ShutDownOnOff1_LTE_A1		0xA930
#define Aid_Rvs1OutUpperLmt_LTE			0xA931
#define Aid_Rvs1OutUpperLmt_LTE_A1		0xA932
#define Aid_Fwd1Temp_LTE				0xA933
#define Aid_Rvs1Temp_LTE				0xA934
#define Aid_Fwd1Temp_LTE_A1				0xA935
#define Aid_Rvs1Temp_LTE_A1				0xA936
#define Aid_Fwd1OutHighLmt_LTE	 		0xA937
#define Aid_Fwd1OutHighLmt_LTE_A1		0xA938
#define Aid_Rvs1ALCLvl_LTE				0xA939
#define Aid_Rvs1ALCLvl_LTE_A1			0xA93A
#define	Aid_Fwd1InPwrOffset_LTE_A2		0xA93D
#define	Aid_Rvs1OutPwrOffset_LTE_A2		0xA93E
#define	Aid_Fwd1OutPwrOffset_LTE_A2		0xA93F
#define	Aid_Fwd1Attn1_LTE_A2 			0xA940	
#define	Aid_Fwd1Attn2_LTE_A2 			0xA941	
#define	Aid_Fwd1Attn3_LTE_A2 			0xA942	

#define	Aid_Rvs1Attn1_LTE_A2 			0xA944	
#define	Aid_Rvs1Attn2_LTE_A2 			0xA945	
#define	Aid_Rvs1Attn3_LTE_A2 			0xA946	
#define	Aid_Rvs1Attn4_LTE_A2 			0xA947	
#define	Aid_Fwd1GainOffset_LTE_A2		0xA949
#define	Aid_Rvs1GainOffset_LTE_A2		0xA94A
#define	Aid_Fwd1AgcAttn_LTE_A2			0xA94B
#define	Aid_Rvs1AlcAttn_LTE_A2			0xA94C
#define	Aid_Rvs1AlcOnOff_LTE_A2			0xA94D
#define	Aid_SmsFwd1InPwr_LTE_A2			0xA94F
#define	Aid_Rvs1OutPwr_LTE_A2	 		0xA950
#define	Aid_Rvs1InPwr_LTE_A2			0xA951
#define	Aid_ShutDownOnOff_LTE_A2_1		0xA952
#define	Aid_Rvs1OutUpperLmt_LTE_A2		0xA953
#define	Aid_Fwd1Temp_LTE_A2				0xA954
#define	Aid_Rvs1Temp_LTE_A2				0xA955
#define	Aid_Fwd1OutHighLmt_LTE_A2	 	0xA956
#define	Aid_Rvs1ALCLvl_LTE_A2			0xA957
#define	Aid_AutoShutDownSts_LTE_A2_1 	0xA958
#define	Aid_Fwd1Attn1_LTE_A				0xA959	
#define	Aid_Rvs1Attn1_LTE_A				0xA95c	


#define	Aid_BalanceModeAttn				0xAD05	
#define	Aid_BalanceModeDetPwr			0xAD06	
#define	Aid_BalanceModeVolt				0xAD08	
#define	Aid_BalanceModeDetOffset		0xAD09	



#define	Aid_SMS_ALARM					0xE503
#define	Aid_System_Time					0xE504

#define	Aid_Backup_Time					0xE505
#define	Aid_Last_AutoReport				0xE506
#define	Aid_Auto_Remain_Time			0xE507
#define	Aid_AR2_Remain_Time				0xE508
#define	Aid_AR3_Remain_Time				0xE509
#define	Aid_MinCID						0xE50A
#define Aid_ESNCode						0xE50B


#define	Aid_ModuleTptlOnOff				0xAA02

//////////////////////////////////////////////////////////
#define Aid_SDOn_Off					0xF602
#define	Aid_SMS_ALARM					0xE503
#define	Aid_System_Time					0xE504
#define	Aid_Last_SMS_Time				0xE505
//#define	Aid_Last_AutoReport				0xE506
#define	Aid_Auto_Remain_Time			0xE507
#define	Aid_AR2_Remain_Time				0xE508
#define	Aid_AR3_Remain_Time				0xE509

#define	Aid_MinCID						0xE50A
#define Aid_ESNCode						0xE50B
#define Aid_ESN_Check					0xF607


#define	Aid_Converter_Temp				0xF600
#define	Aid_Converter_Type				0xF601
#define	Aid_Converter_SWVer				0xF602
#define	Aid_ConverterOnOff_2G			0xF603
#define	Aid_ConverterOnOff_3G			0xF604
#define	Aid_Converter_Reset				0xF605
#define	Aid_W_Tx_CW_Level				0xF607
#define	Aid_SMS_OnOff					0xF608
#define	Aid_C_Tx_CW_Level				0xF609
#define	Aid_C_Rx_CW_Level				0xF60A
#define	Aid_CW_Level					0xF60B
#define	Aid_ShutDownOnOff				0xF60C
#define	Aid_SD_Seqence					0xF60D
#define	Aid_PathLossAtt					0xF60E
#define	Aid_RmtID_Value					0xF60F
#define	Aid_EQU_Att						0xF610
#define	Aid_PassTxAttn_3G				0xF611
#define	Aid_PassRxAttn_3G				0xF612
#define	Aid_PassTxAttn_2G				0xF613
#define	Aid_PassRxAttn_2G				0xF614
#define Aid_AttnOffsetOnOff				0xF61A
#define	Aid_Converter_HWVer				0xF61B

#define Aid_AGS_CW_OnOff				0xF648
#define	Aid_Adc_Value					0xA100
#define	Aid_RmtInsert					0x1D1A
#define	Aid_RauInsert					0x1D1B


#define Aid_2G_Type						0xF668
#define Aid_3G_Type						0xF669
#define Aid_WI_Type						0xF66A
#define Aid_OPT_Type					0xF66B
#define Aid_2G_SWVer					0xF66C
#define Aid_3G_SWVer					0xF66D
#define Aid_WI_SWVer					0xF66E
#define Aid_OPT_SWVer					0xF66F
#define	Aid_AgsAttn						0xF619
#define	Aid_AgsDetOffset				0xF61b			//12E
#define	Aid_CWLevelOffset				0xF60B


#define Aid_SystemDate					0xF670
#define Aid_SystemTime					0xF671
#define Aid_rFwdInAttn_3G				0xF672
#define Aid_rRvs0Attn_3G				0xF673
#define Aid_rRvs1Attn_3G				0xF674
#define Aid_rFwdAttnOffset_3G			0xF675
#define Aid_rRvs0AttnOffset_3G			0xF676
#define Aid_rRvs1AttnOffset_3G			0xF677
#define Aid_rFwdInAttn_2G				0xF678
#define Aid_rRvs0Attn_2G				0xF679
#define Aid_rRvs1Attn_2G				0xF67A
#define Aid_rFwdAttnOffset_2G			0xF67B
#define Aid_rRvs0AttnOffset_2G			0xF67D
#define Aid_rRvs1AttnOffset_2G			0xF67E

#define Aid_rFwdInAttn_WI0				0xF67F
#define Aid_rRvsAttn_WI0				0xF680
#define Aid_rFwdInAttn_WI1				0xF681
#define Aid_rRvsAttn_WI1				0xF682

#define Aid_rRmtRvsAttn_2G				0xF683
#define Aid_rRmtRvsAttn_3G				0xF684

#define Aid_rRmtRvsAttn_WI0				0xF685
#define Aid_rRmtRvsAttn_WI1				0xF686

#define Aid_RefSignalLow				0xF683

//#define Aid_VccDet_Lmt					0xF696
#define Aid_ISOHour_Cycle				0xF697
#define Aid_ISOMin_Cycle				0xF698


#define	Aid_Backup_Time					0xE505
#define Aid_FwdInLvlSts_2G				0xA1AF
#define Aid_FwdOutLvlSts_2G				0xA1B0
#define Aid_FwdInLvlSts_3G				0xA1B1
#define Aid_FwdOutLvlSts_3G				0xA1B2


#define	Aid_SlopeValue					0xE016
#define	Aid_SlopeLimit					0xE017
#define	Aid_SlopeReset					0xE018


//////////////////////////////////////////////////////////////
#define Aid_CFR_Module_Fail				0x1031
#define Aid_CFR_Fpga_Ver				0xA01B
#define Aid_CFR_MCU_Ver					0xA01C

#define Aid_CFR_Target_Level			0xA2B6

#define Aid_CFR_Module_Sts				0xA399
#define Aid_CFR_FwdInPwr				0xA39A
//#define Aid_CFR_FwdInAttn				0xA39B
#define Aid_CFR_FA_Aloc_Mode			0xA39C
#define Aid_CFR_FA						0xA39D
#define Aid_CFR_Mode_Bak				0xA39E
#define Aid_CFR_FwdInPwrOffset			0xA39F
#define Aid_CFR_FwdALCLvl				0xA3A0
#define Aid_CFR_FwdALCOnOff				0xA3A1
#define Aid_CFR_Temp					0xA3A2

#define Aid_CFR_FwdPwrOut				0xF000
#define Aid_CFR_MCU_Reset				0xF001
#define Aid_CFR_Reset					0xF002
#define Aid_CFR_App_Ver					0xF003
#define Aid_CFR_FwdOutAttn				0xF004
#define Aid_CFR_FwdDigAttn				0xF005
#define Aid_CFR_ALCATT					0xF006
#define Aid_CFR_TempATT					0xF007
#define Aid_CFR_rFwdInAttn				0xF008
#define Aid_CFR_rFwdOutAttn				0xF009
#define Aid_CFR_rFwdInPwr				0xF00A
#define Aid_CFR_rFwdPwrOut				0xF00B
#define Aid_CFR_Alarm_Val				0xF00c
#define Aid_CFR_CommCnt					0xF00D
#define Aid_CFR_FwdInAttnOffset			0xF00E
#define Aid_CFR_FwdOutAttnOffset		0xA39B
#define Aid_CFR_FwdInAttn				0xF00F


#define	Aid_TestPwr						0xD000
#define	Aid_TestMode					0xD001
#define	Aid_TestValue					0xD002
#define Aid_ModemRxAttn					0xD003
#define Aid_Digital_Alarm				0xD004  //No Change
#define Aid_Fwd_DigPathOnOff_2G			0xD005  //No Change
#define Aid_Rvs0_DigPathOnOff_2G		0xD006  //No Change
#define Aid_DelayMeasureData			0xD007  //No Change
#define Aid_DE_ShunDown_OnOff 			0xD008
#define Aid_ReturnOnOffVal				0xD009  //No Change
#define Aid_D_Attn						0xD00A
#define Aid_R_Attn						0xD00B
#define Aid_DE_Factory_default			0xD00C
#define Aid_ShunDown_Value 				0xD00D
#define Aid_Rvs0ShunDown_Step			0xD00E
#define	Aid_Rvs1ShunDown_Step			0xD00F
#define	Aid_CurrFwdInPwr_LTE			0xD010
#define	Aid_cR0_Attn					0xD011
#define	Aid_cR1_Attn					0xD012

#define Aid_Rvs1_DigPathOnOff_2G		0xD013  //No Change

#define Aid_RB_Value					0xD016
#define Aid_RB_Sts						0xD017


#define Aid_OverInputAGCOnOff			0xD018
#define Aid_RB_StsOnOff					0xD019


#define Aid_DCOffSet					0xD01C


#define Aid_SleepMode_2G				0xD01D
#define Aid_SleepMode_LTE				0xD01E
#define Aid_SleepMode_LTE_A1			0xD01F
#define Aid_SleepMode_LTE_A2			0xD020

#define Aid_AvgMAXGARBAGE_Tx			0xD021
#define Aid_AvgMINGARBAGE_Tx			0xD022
#define Aid_PeakMAXGARBAGE_Tx			0xD023
#define Aid_PeakMINGARBAGE_Tx			0xD024
#define Aid_PeakMAXGARBAGE_Rx			0xD025
#define Aid_PeakMINGARBAGE_Rx			0xD026

#define Aid_ADCAVRMAX					0xD027

#define Aid_PwrTblAlarm					0xD028
#define Aid_AttTblAlarm					0xD029




#define Aid_RvsOSCAlarmCount_3G				0x2876
#define Aid_RvsOSCAlarmCount_2G				0x2877
#define Aid_RvsOSCAlarmCount_LTE 			0x2878
#define Aid_RvsOSCAlarmCount_LTE_A1			0x2879
#define Aid_RvsOSCAlarmCount_LTE_A2			0x287A
#define Aid_Rvs1OSCAlarmCount_LTE			0x287B
#define Aid_Rvs1OSCAlarmCount_LTE_A1		0x287C
#define Aid_Rvs1OSCAlarmCount_LTE_A2		0x287D



#define Aid_CurrRvsOSCAlarmCount_3G				0xD051
#define Aid_CurrRvsOSCAlarmCount_2G				0xD052
#define Aid_CurrRvsOSCAlarmCount_LTE 			0xD053
#define Aid_CurrRvsOSCAlarmCount_LTE_A1			0xD054
#define Aid_CurrRvsOSCAlarmCount_LTE_A2			0xD055
#define Aid_CurrRvs1OSCAlarmCount_LTE			0xD056
#define Aid_CurrRvs1OSCAlarmCount_LTE_A1		0xD057
#define Aid_CurrRvs1OSCAlarmCount_LTE_A2		0xD058



#endif



////////////////////////////////////////////////////////////////////////////////
// End of Header File
///////////////////////////

