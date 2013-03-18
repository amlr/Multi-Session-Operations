class dsl_Slider : RscSlider
{
}; 

#define X_MOD 60 // this needs to be adjusted if an aspect ratio other than 16:9 is used, as I am dialog-retarded.  
#define Y_MOD 10
#define SLIDER_START -19
#define SLIDER_INTERVAL 4
#define SLIDER_TITLE_SPACE 1.3

class dsl_gear_dialog
{
	idd = 10568; 
	movingEnable = 1; 
	enableSimulation = 1;
	enableDisplay = 1; 
	
	onLoad = "dsl_gear_dialog = _this; disableSerialization"; 
	onunLoad = "dsl_ShowingSelfCam = false"; 

	class controls 
	{
		class RscSlider_1900: dsl_Slider // headgear
		{
			idc = 1900;
			
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = SLIDER_START * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			
		};
		class RscSlider_1901: dsl_Slider  // vest
		{
			idc = 1901;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 1)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class RscSlider_1902: dsl_Slider // uniform
		{
			idc = 1902;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 2)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class RscSlider_1903: dsl_Slider  // backpack
		{
			idc = 1903;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 3)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class RscSlider_1904: dsl_Slider  // weapon
		{
			idc = 1904;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 4)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class RscSlider_1905: dsl_Slider // optic
		{
			idc = 1905;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 5)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		
		class RscSlider_1906: dsl_Slider  // rail
		{
			idc = 1906;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 6)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		
		class RscSlider_1907: dsl_Slider // sidearm
		{
			idc = 1907;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 7)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class RscSlider_1908: dsl_Slider  // faces
		{
			idc = 1908;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 8)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		
		class RscSlider_1914: dsl_Slider  // launchers
		{
			idc = 1914;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 9)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		
		class RscSlider_1913: dsl_Slider // glasses
		{
			idc = 1913;
			type = CT_SLIDER;
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START + (SLIDER_INTERVAL * 10)) * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		
		
		
		// ((SLIDER_START + (SLIDER_INTERVAL * 1))-1) 
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Headgear"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = (SLIDER_START - SLIDER_TITLE_SPACE)  * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Vest";
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 1))-SLIDER_TITLE_SPACE)  * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Uniform";
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 2))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "Backpack";
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 3))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "Weapon"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 4))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "Optic"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 5))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1006: RscText
		{
			idc = 1006;
			text = "Rail";
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 6))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1007: RscText
		{
			idc = 1007;
			text = "Sidearm"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 7))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscText_1008: RscText
		{
			idc = 1008;
			text = "Face"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 8))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscText_1014: RscText
		{
			idc = 1014;
			text = "Launcher"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 9))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "Glasses"; 
			x = X_MOD * GUI_GRID_W + GUI_GRID_X;
			y = ((SLIDER_START + (SLIDER_INTERVAL * 10))-SLIDER_TITLE_SPACE) * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		
		class RscText_1015: RscText
		{
			idc = 1015;
			text = "Dslyecxi's Gear Menu";
			SizeEx = 0.075; 
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = -15 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
		};
		
		
		
		class RscText_1009: RscText
		{
			idc = 1009;
			text = "Time of Day"; 
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = -6 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		
		class RscText_1010: RscText
		{
			idc = 1010;
			text = "Overcast"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = -3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1011: RscText
		{
			idc = 1011;
			text = "Day of Month"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = -1 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1012: RscText
		{
			idc = 1012;
			text = "Viewdistance"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		
		
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Randomize"; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Copy"; //--- ToDo: Localize;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Presets"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
			
		
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Head"; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			text = "Body"; //--- ToDo: Localize;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			text = "Backpack"; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscButton_1606: RscButton
		{
			idc = 1606;
			text = "Weapon"; //--- ToDo: Localize;
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		
		class RscButton_1607: RscButton
		{
			idc = 1607;
			text = "Muzzle Device"; //--- ToDo: Localize;
			x = 35 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		
		class RscButton_1608: RscButton
		{
			idc = 1608;
			text = "Thermal"; //--- ToDo: Localize;
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		class RscButton_1609: RscButton
		{
			idc = 1609;
			text = "Nightvision"; //--- ToDo: Localize;
			x = 43 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		
		
		
		
		class RscSlider_1909: RscSlider // time
		{
			idc = 1909;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = -5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		class RscSlider_1910: RscSlider // overcast
		{
			idc = 1910;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = -2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscSlider_1911: RscSlider // day of month
		{
			idc = 1911;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscSlider_1912: RscSlider // view distance
		{
			idc = 1912;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};	
	};
};



