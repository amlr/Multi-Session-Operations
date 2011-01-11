class RMM_ui_cas { // by Rommel
	idd = 80512;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "0 spawn cas_fnc_onload;";

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,7);
			w = CUI_Box_W;
		};
		class Caption : CUI_Caption {
			text = "AIRSUPREQ";
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,1);
			w = CUI_Box_W;
		};
		class Help: CUI_Button {
			text = "?";
			x = CUI_Box_X(1) - CUI_Row_H;
			y = CUI_Row_Y(0);
			w = CUI_Row_H;
			action = """modules\cas\help.html"" call help_fnc_display;";
		};
		class Lb0 : CUI_Combo {
			idc = 0;
			y = CUI_Row_Y(1);
			w = CUI_Box_W;
		};
		class Lb1 : Lb0 {idc = 1;y = CUI_Row_Y(2);};
		class Lb2 : Lb0 {idc = 2;y = CUI_Row_Y(3);};
		class Lb3 : Lb0 {idc = 3;y = CUI_Row_Y(4);};
		class Lb4 : Lb0 {idc = 4;y = CUI_Row_Y(5);};
		class Transmit: CUI_Button {
			text = "Transmit";
			w = CUI_Box_W;
			y = CUI_Row_Y(6);
			action = "if (lbCurSel 2 > -1) then {0 call cas_fnc_call}; closeDialog 0;";
		};
	};
};