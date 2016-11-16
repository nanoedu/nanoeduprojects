{ Turbo Pascal Unit:  CSPMHelp.pas                  }
{                                                 }
{ This is an interface unit containing integer    }
{ mappings of Topic IDs (names of Help            }
{ Topics) which are located in CSPMHelp.rtf     }
{                                                 }
{ This file is re-written by RoboHELP           }
{ whenever CSPMHelp.rtf is saved.   	          }
{                                                 }
{ However, the numeric values stored in           }
{ CSPMHelp.hh are the 'master values' and if you    }
{ modify the value in CSPMHelp.hh and then          }
{ save the CSPMHelp.rtf again, this file will }
{ reflect the changed values.                     }
{                                                 }

Unit CSPMHelp;
   Interface
   Const
	IDH_error_landing_option = 1;
	IDH_error_load_lib = 60;
	IDH_Oscilloscope = 64;
	IDH_Fast_Scan = 65;
	IDH_Fast_Scan_STM = 66;
	IDH_One_Line_Scan = 67;
	IDH_imagefiltr = 70;
	IDH_Z_Scale = 71;
	IDH_scaleX_Y = 72;
	IDH_Tip = 74;
	IDH_Micro = 75;
	IDH_Select_Img_Fragment = 76;
	IDH_Image_Processing = 77;
	IDH_Rising = 78;
	IDH_Force_Sensor = 79;
	IDH_Introduction1 = 80;
	IDH_Turn_On = 81;
	IDH_Additional_Scan_Regims = 82;
	IDH_STM_Sensor = 83;
	IDH_Probe_is_too_High = 84;
	IDH_Landing = 85;
	IDH_Change_Scan_Params = 86;
	IDH_Change_Scan_Params_STM = 87;
	IDH_Tunnel_Current_Regim = 88;
	IDH_Feed_Back_Loop = 89;
	IDH_Rule = 90;
	IDH_Indicate_Visualize = 91;
	IDH_Start_Program = 92;
	IDH_Probe_Position = 93;
	IDH_Landing_Interface = 94;
	IDH_Prepare_Experiment_Stm = 95;
	IDH_Landing_interface_STM = 96;
	IDH_Rising_STM = 97;
	IDH_Indicate_Visualize_STM = 98;
	IDH_Start_NanoEdu = 100;
	IDH_Prepare_Experiment = 101;
	IDH_NanoEdu_Principle = 102;
	IDH_MicroScaner = 103;
	IDH_Fast_Landing = 104;
	IDH_General_View = 105;
	IDH_Contrast = 106;
	IDH_Parameters = 107;
	IDH_paramers_SSM = 108;
	IDH_Resonance = 109;
	IDH_Device_Panel = 110;
	IDH_Landing_SFM = 111;
	IDH_Scanning_SFM = 112;
	IDH_Landing_STM = 113;
	IDH_Scanning_STM = 114;
	IDH_Images = 115;
	IDH_Section = 116;
	IDH_Spectroscopy = 117;
	IDH_LItho = 118;
	IDH_One_Line_STM = 119;
	IDH_Install_Program = 120;
	IDH_Install_Progr_NanoEdu = 121;
	IDH_Probe_Install = 122;
	IDH_Put_Sample = 123;
	IDH_Set_ScanParameters = 124;
	IDH_SaveResults = 125;
	IDH_Set_Interaction = 126;
	IDH_Set_Scan_Params_STM = 127;
	IDH_SaveResults_STM = 128;
	IDH_Angles = 129;
	IDH_Image_Analysis = 130;
	IDH_Spectroscopy_STM = 131;
	IDH_Instr_Panel = 132;
	IDH_Files_Explorer = 3;
	IDH_Change_work_dir = 4;
	IDH_Save1 = 2;
	IDH_Save2 = 5;
	IDH_Recording_scripts = 6;
	IDH_Flash_drive = 7;
	IDH_training_scanner = 8;
	IDH_reportR = 9;
	IDH_Control_Panel__Beginner = 10;
	IDH_samples = 11;
	IDH_probe = 12;
	IDH_FAQR_Approach = 13;
	IDH_workR = 14;
	IDH_setupUSBR = 15;
	IDH_CommonR = 16;
	IDC_Demo = 17;
	IDH_Start_SFM = 18;
	IDH_Start_STM = 19;
	Implementation
	end.
