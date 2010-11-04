/* 
	DEBUG PANEL EXTRAS 
*/
class DPanel : CUI_Frame {
	y = CUI_Row_Y(0);
	x = CUI_Box_X(2);
	h = CUI_Row_DY(0,19);
	w = CUI_Box_W / 1.4;
};
class DPanelCaption : CUI_Caption {
	text = "DPanel";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(0);
	w = CUI_Box_W / 1.4;
};
class DPanelTxt : CUI_Edit {
	idc = 55;
	x = CUI_Box_X(2);
	y = CUI_Row_Y(1);
	h = CUI_Row_DY(1,7);
	w = CUI_Box_W / 1.4;
	autocomplete = "scripting";
};
class DPanelCursorTarget : CUI_Button {
	text = "cursorTarget";
	x = CUI_Box_X(2);
	w = CUI_Box_W / 1.4;
	y = CUI_Row_Y(8);
	action = "CtrlSetText [55,str cursorTarget]; CtrlSetText [1,""cursorTarget""];";
};
class DPanelNearest : DPanelCursorTarget {
	text = "NearestCursor";
	y = CUI_Row_Y(9);
	action = "CtrlSetText [55,str (nearestObject screenToWorld [0.5,0.5])]; CtrlSetText [1,""nearestObject screenToWorld [0.5,0.5]""];";
};
class DPanelCamera : DPanelCursorTarget {
	text = "Camera";
	y = CUI_Row_Y(10);
	action = "player exec ""camera.sqs""";
};
class DPanelOwnID : DPanelCursorTarget {
	text = "OwnID";
	y = CUI_Row_Y(11);
	action = "CtrlSetText [55, (getPlayerUID player)]";
};
class DPanelScreenPos : DPanelCursorTarget {
	text = "ScreenPos";
	y = CUI_Row_Y(13);
	action = "CtrlSetText [55,str (screenToWorld[0.5,0.5])]; CtrlSetText [1,str (screenToWorld [0.5,0.5])];";
};
class DPanelPlayable : DPanelCursorTarget {
	text = "PlayableUnits";
	y = CUI_Row_Y(14);
	action = "CtrlSetText [55,str playableunits]; CtrlSetText [1,""playableunits""];";
};
class DPanelCount : DPanelCursorTarget {
	text = "Count AllUnits";
	y = CUI_Row_Y(15);
	action = "CtrlSetText [55,str [west countside allunits, east countside allunits, resistance countside allunits, civilian countside allunits]];";
};
class DPanelAIGrpMake : DPanelCursorTarget {
	text = "spawnGroup";
	y = CUI_Row_Y(17);
	action = "CtrlSetText [2,""_group = [_this, <SIDE>, <GROUP_NAME>] call BIS_fnc_SpawnGroup;""];";
};
class DPanelCreateVehicle : DPanelCursorTarget {
	text = "createVehicle";
	y = CUI_Row_Y(18);
	action = "CtrlSetText [2,""_vehicle = createvehicle [<TYPE>,_this,[],0,""NONE""];""];";
};