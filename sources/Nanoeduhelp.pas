{ Turbo Pascal Unit:  Nanoeduhelp.pas                  }
{                                                 }
{ This is an interface unit containing integer    }
{ mappings of Topic IDs (names of Help            }
{ Topics) which are located in Nanoeduhelp.rtf     }
{                                                 }
{ This file is re-written by RoboHelp           }
{ whenever Nanoeduhelp.rtf is saved.   	          }
{                                                 }
{ However, the numeric values stored in           }
{ Nanoeduhelp.hh are the 'master values' and if you    }
{ modify the value in Nanoeduhelp.hh and then          }
{ save the Nanoeduhelp.rtf again, this file will }
{ reflect the changed values.                     }
{                                                 }

Unit Nanoeduhelp;
   Interface
   Const
	Welcome = 1;
	IDH_Install_Program = 2;
	IDH_Install_Progr_NanoEdu = 3;
	IDH_Probe_Install = 4;
	IDH_Put_Sample = 5;
	IDH_Resonance = 6;
	IDH_Additional_Scan_Regims = 7;
	IDH_Set_ScanParameters = 8;
	IDH_Indicate_Visualize = 9;
	IDH_Change_Scan_Params = 10;
	IDH_SaveResults = 11;
	IDH_Start_Program = 12;
	IDH_Device_Panel = 13;
	IDH_Probe_Position = 14;
	IDH_Landing_Interface = 15;
	IDH_Landing_SFM = 16;
	IDH_Set_Interaction = 17;
	IDH_Rising = 18;
	IDH_Scanning_SFM = 19;
	IDH_Prepare_Experiment_Stm = 20;
	IDH_Landing_interface_STM = 21;
	IDH_Landing_STM = 22;
	IDH_Rising_STM = 23;
	IDH_Scanning_STM = 24;
	IDH_Set_Scan_Params_STM = 25;
	IDH_Indicate_Visualize_STM = 26;
	IDH_Change_Scan_Params_STM = 27;
	IDH_SaveResults_STM = 28;
	IDH_Tunnel_Current_Regim = 29;
	IDH_Files_Explorer = 30;
	IDH_Images = 31;
	IDH_Image_Processing = 32;
	IDH_Select_Img_Fragment = 33;
	IDH_Section = 34;
	IDH_Spectroscopy = 35;
	IDH_Probe_is_too_High = 36;
	IDH_Start_NanoEdu = 37;
	IDH_Prepare_Experiment = 38;
	IDH_NanoEdu_Principle = 39;
	IDH_Force_Sensor = 40;
	IDH_STM_Sensor = 41;
	IDH_MicroScaner = 42;
	IDH_Fast_Landing = 43;
	IDH_General_View = 44;
	IDH_Feed_Back_Loop = 45;
	IDH_Landing = 46;
	IDH_Introduction1 = 47;
	IDH_Rule = 48;
	IDH_Angles = 49;
	IDH_Contrast = 50;
	IDH_Image_Analysis = 51;
	IDH_LItho = 52;
	IDH_Spectroscopy_STM = 53;
	IDH_error_load_lib = 54;
	IDH_error_landing_option = 55;
	IDH_paramers_SSM = 56;
	IDH_Parameters = 57;
	IDH_Oscilloscope = 58;
	IDH_Fast_Scan = 59;
	IDH_Fast_Scan_STM = 60;
	IDH_One_Line_Scan = 61;
	IDH_One_Line_STM = 62;
	IDH_Instr_Panel = 63;
	IDH_imagefiltr = 64;
	IDH_Z_Scale = 65;
	IDH_scaleX_Y = 66;
	IDH_Tip = 67;
	IDH_Micro = 68;
	IDH_Change_work_dir = 69;
	IDH_Save1 = 70;
	IDH_Save2 = 71;
	IDH_Recording_scripts = 72;
	IDH_Flash_drive = 73;
	IDH_training_scanner = 74;
	IDH_reportR = 75;
	IDH_Control_Panel_Beginner = 76;
	IDH_samples = 77;
	IDH_probe = 78;
	IDH_FAQR_Approach = 79;
	IDH_WorkR = 80;
	IDH_setupUSBR = 81;
	IDH_CommonR = 82;
	IDC_Demo = 83;
	IDH_Start_SFM = 84;
	IDH_Start_STM = 85;
	IDH_Turn_On = 86;
	IDH_CurrentLitho = 87;
	IDH_Export = 88;
	Implementation
	end.
