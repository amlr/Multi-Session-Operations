class RMM_ui_jipmarkers { // by Rommel
	idd = 80511;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "[] spawn {{lbAdd [1,_x];} foreach RMM_jipmarkers_types;};";

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,4);
			w = CUI_Box_W;
		};
		class Caption : CUI_Caption {
			text = "JIP Markers";
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,1);
			w = CUI_Box_W;
		};
		class MLb : CUI_Combo {
			idc = 1;
			y = CUI_Row_Y(1);
			w = CUI_Box_W;
		};
		class MarkerText : CUI_Edit {
			idc = 2;
			y = CUI_Row_Y(2);
			w = CUI_Box_W;
		};
		class Confirm : CUI_Button {
			text = "Confirm";
			w = CUI_Box_W;
			y = CUI_Row_Y(3);
			action = "if ((lbCurSel 1) > -1) then {_string = format [""%1/%2 %3 - %4"",(date select 2),(date select 1),([daytime] call BIS_fnc_timeToString),(ctrlText 2)]; _mkr = createMarker [""mkr"" + str(random time + 1), RMM_jipmarkers_position]; _mkr setmarkertype (RMM_jipmarkers_types select (lbCurSel 1)); _mkr setmarkertext _string; RMM_jipmarkers set [count RMM_jipmarkers, [getMarkerPos _mkr, getMarkerType _mkr, _string]]; publicvariable ""RMM_jipmarkers""; closeDialog 0;};";
		};
	};
};