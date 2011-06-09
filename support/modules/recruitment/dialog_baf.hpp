class RMM_ui_recruitment_baf { // by Rommel
	idd = 80506;
	movingEnable = 1;
	enableSimulation = 1;

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,7);
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
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""BAF_Soldier_N_MTP"", [player, 50] call CBA_fnc_randPos, [], 0, ""FORM""]};";
			default = true;
		};
		class SoldierMG : SoldierWB {
			text = "Machinegunner";
			y = CUI_Row_Y(2);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""BAF_Soldier_MG_MTP"", [player, 50] call CBA_fnc_randPos, [], 0, ""FORM""]};";
		};
		class SoldierAT : SoldierWB {
			text = "Antitank";
			y = CUI_Row_Y(3);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""BAF_Soldier_AT_MTP"", [player, 50] call CBA_fnc_randPos, [], 0, ""FORM""]};";
		};
		class SoldierMED : SoldierWB {
			text = "Medic";
			y = CUI_Row_Y(4);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""BAF_Soldier_Medic_MTP"", [player, 50] call CBA_fnc_randPos, [], 0, ""FORM""]};";
		};
		class SoldierMarksman : SoldierWB {
			text = "Marksman";
			y = CUI_Row_Y(5);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""BAF_Soldier_Marksman_MTP"", [player, 50] call CBA_fnc_randPos, [], 0, ""FORM""]};";
		};
		class SoldierEN : SoldierWB {
			text = "Engineer";
			y = CUI_Row_Y(6);
			action = "if ({!isplayer _x} count (units player) < 6) then {(group player) createunit [""BAF_Soldier_EN_MTP"", [player, 50] call CBA_fnc_randPos, [], 0, ""FORM""]};";
		};
	};
};



