class RMM_ui_recruitment { // by Rommel
	idd = 80506;
	movingEnable = 1;
	enableSimulation = 1;

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,3);
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
			action = "if (count (units player) < 6) then {(group player) createunit [""BAF_Soldier_MTP"", getmarkerpos ""headquarters"", [], 0, ""FORM""]};";
			default = true;
		};
		class SoldierMG : SoldierWB {
			text = "Machinegunner";
			y = CUI_Row_Y(2);
			action = "if (count (units player) < 6) then {(group player) createunit [""BAF_Soldier_MG_MTP"", getmarkerpos ""headquarters"", [], 0, ""FORM""]};";
		};
	};
};