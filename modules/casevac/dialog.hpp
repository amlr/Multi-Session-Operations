class RMM_ui_casevac { // by Rommel
	idd = 80513;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "[] spawn {for ""_i"" from 0 to ((count RMM_casevac_lines)-1) do {_x = RMM_casevac_lines select _i; {lbAdd [_i,_x];} foreach _x;};};";

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,11);
			w = CUI_Box_W;
		};
		class Caption : CUI_Caption {
			text = "CASEVAC";
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,1);
			w = CUI_Box_W;
		};
		class Lb0 : CUI_Combo {
			idc = 0;
			y = CUI_Row_Y(1);
			w = CUI_Box_W;
			onLBSelChanged = "_this call casevac_fnc_help";
		};
		class Lb1 : Lb0 {idc = 1;y = CUI_Row_Y(2);};
		class Lb2 : Lb0 {idc = 2;y = CUI_Row_Y(3);};
		class Lb3 : Lb0 {idc = 3;y = CUI_Row_Y(4);};
		class Lb4 : Lb0 {idc = 4;y = CUI_Row_Y(5);};
		class Lb5 : Lb0 {idc = 5;y = CUI_Row_Y(6);};
		class Lb6 : Lb0 {idc = 6;y = CUI_Row_Y(7);};
		class Lb7 : Lb0 {idc = 7;y = CUI_Row_Y(8);};
		class Lb8 : Lb0 {idc = 8;y = CUI_Row_Y(9);};
		class Transmit : CUI_Button {
			text = "Transmit";
			w = CUI_Box_W;
			y = CUI_Row_Y(10);
			action = "if (lbCurSel 1 > -1) then {}; closeDialog 0;";
		};
	};
};