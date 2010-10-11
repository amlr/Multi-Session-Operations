class RMM_ui_EODD { // by Rommel
	idd = 80505;
	movingEnable = 1;
	enableSimulation = 1;

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,6);
			w = CUI_Box_W;
		};
		class Caption : CUI_Caption {
			text = "Explosive Ordance Detection Dog";
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,1);
			w = CUI_Box_W;
		};
		class Follow : CUI_Button {
			text = "Follow";
			w = CUI_Box_W;
			y = CUI_Row_Y(1);
			h = CUI_Row_DY(0,1);
			action = "player setvariable [""EODD_canmove"",true];";
			default = true;
		};
		class Stop : Follow {
			text = "Stop";
			y = CUI_Row_Y(2);
			action = "player setvariable [""EODD_canmove"",false];";
		};
		class Sniff : Follow {
			text = "Sniff Around";
			y = CUI_Row_Y(3);
			action = "private ""_array""; _array = player nearObjects [""Pipebomb"",20]; hint (if (count _array > 0) then {format[""EODD RESPONDS POSITIVELY.\nWITHIN %1m"",((round((player distance (_array select 0))/5))*5)]} else {""EODD DETECTS NOTHING""})";
		};
		class Disband : Follow {
			text = "Disband";
			y = CUI_Row_Y(5);
			action = "deletevehicle (player getvariable ""EODD""); player setvariable [""EODD"", nil, true]; closedialog 0;";
		};
	};
};