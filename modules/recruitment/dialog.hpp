class RMM_ui_recruitment { // by Rommel
	idd = 80506;
	movingEnable = 1;
	enableSimulation = 1;

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,4);
			w = CUI_Box_W;
		};
		class Caption : CUI_Caption {
			text = "Recruitment";
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,1);
			w = CUI_Box_W;
		};
		class SoldierWB : CUI_Button {
			text = "Regular";
			w = CUI_Box_W;
			y = CUI_Row_Y(1);
			h = CUI_Row_DY(0,1);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""CZ_Soldier_DES_EP1"", [player, 50] call RMM_fnc_randPos, [], 0, ""FORM""]};";
			default = true;
		};
		class SoldierMG : SoldierWB {
			text = "Machinegunner";
			y = CUI_Row_Y(2);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""CZ_Soldier_MG_DES_EP1"", [player, 50] call RMM_fnc_randPos, [], 0, ""FORM""]};";
		};
		class SoldierAT : SoldierWB {
			text = "Antitank";
			y = CUI_Row_Y(3);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""CZ_Soldier_AT_DES_EP1"", [player, 50] call RMM_fnc_randPos, [], 0, ""FORM""]};";
		};
	};
};