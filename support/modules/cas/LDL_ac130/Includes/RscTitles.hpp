class RscLDL_Text
{
	type = CT_STATIC;
	idc = -1;
	style = ST_LEFT;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = FontM;
	sizeEx = 0.02;
	text = "";
	x = -1; 
	y = -1; 
	w = 0; 
	h = 0; 
};

class RscLDL_Line: RscLDL_Text
{
    	type = 0;
    	style = 176;
};

class RscLDL_Rec: RscLDL_Text
{
	style = ST_FRAME;
};

class RscLDL_Picture
{
	idc = -1;
        type = 0;
        colorText[] = {1, 1, 1, 1};
        font = "Bitstream";
	colorBackground[] = {0, 0, 0, 0};
	text = ;
        style = 48;
	sizeEx = 0.015;
	x = -1;
	y = -1;
	w = 0;
	h = 0;
};	


class LDL_HUD_pilot
{
  idd = 100;
  movingEnable =  1;
  duration     =  1000;
  fadein       =  0;
  fadeout      =  0;
  name = "LDL_HUD_pilot";
  onLoad = "with uiNameSpace do {LDL_HUD_pilot_disp = (_this select 0);}";


  class controls 
  {
	class LDL_Rec01 : RscLDL_Rec
	{
		colorText[] = {0.2,1,0.2,1};
	    	x = SafeZoneX+SafeZoneW/2-3*0.04+0.08*0;
	     	y = SafeZoneY+SafeZoneH/6;
	     	w = 0.08;
	     	h = 0.02;
	};
	class LDL_Text01: RscLDL_Text
	{
		idc = 101;
		colorText[] = {0.2,1,0.2,1};
		colorBackground[] = {0, 0, 0, 0.3};
	    	x = SafeZoneX+SafeZoneW/2-3*0.04+0.08*0;
	     	y = SafeZoneY+SafeZoneH/6;
	     	w = 0.08;
	     	h = 0.02;
		text = "0°";
	};
	class LDL_Rec02 : RscLDL_Rec
	{
		colorText[] = {0.2,1,0.2,1};
	    	x = SafeZoneX+SafeZoneW/2-3*0.04+0.08*1;
	     	y = SafeZoneY+SafeZoneH/6;
	     	w = 0.08;
	     	h = 0.02;
	};
	class LDL_Text02: RscLDL_Text
	{
		idc = 102;
		colorText[] = {0.2,1,0.2,1};
		colorBackground[] = {0, 0, 0, 0.3};
	    	x = SafeZoneX+SafeZoneW/2-3*0.04+0.08*1;
	     	y = SafeZoneY+SafeZoneH/6;
	     	w = 0.08;
	     	h = 0.02;
		text = "0°";
	};
	class LDL_Rec03 : RscLDL_Rec
	{
		colorText[] = {0.2,1,0.2,1};
	    	x = SafeZoneX+SafeZoneW/2-3*0.04+0.08*2;
	     	y = SafeZoneY+SafeZoneH/6;
	     	w = 0.08;
	     	h = 0.02;
	};
	class LDL_Text03: RscLDL_Text
	{
		idc = 103;
		colorText[] = {0.2,1,0.2,1};
		colorBackground[] = {0, 0, 0, 0.3};
	    	x = SafeZoneX+SafeZoneW/2-3*0.04+0.08*2;
	     	y = SafeZoneY+SafeZoneH/6;
	     	w = 0.08;
	     	h = 0.02;
		text = "0°";
	};
	
	/*
	class LDL_Line01 : RscLDL_Line
	{
		idc = 104;
		colorText[] = {1, 0, 0, 1};
	};
	*/
	
	/*
	class LDL_Picture01 : RscLDL_Picture
	{
		text = "support\modules\cas\LDL_ac130\Pictures\back.paa";
	    	x = SafeZoneX+SafeZoneW/4 - SafeZoneW/16;
	     	y = SafeZoneY+SafeZoneH/4 - SafeZoneH/16;
	     	w = SafeZoneW/6;
	     	h = SafeZoneH/8;
		colorText[] = {1, 1, 1, 0.1};
	};
	*/


  };

};