/* 
	DEBUG PANEL EXTRAS 
*/
class DPanel : CUI_Frame {
	y = CUI_Row_Y(0);
	x = CUI_Box_X(2);
	h = CUI_Row_DY(0,17);
	w = CUI_Box_W / 1.4;
};
class DPanelCaption : CUI_Caption {
	text = "DPanel";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(0);
	w = CUI_Box_W / 1.4;
};
class DPanelTxt : CUI_Edit {
	idc = 51;
	x = CUI_Box_X(2);
	y = CUI_Row_Y(1);
	h = CUI_Row_DY(1,3);
	w = CUI_Box_W / 1.4;
	autocomplete = "scripting";
};
class DPanelCaptionP : CUI_Caption {
	text = "Parameters";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(3);
	w = CUI_Box_W / 1.4;
};
class DPanelScreenPos : CUI_Button {
	text = "ScreenPos";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(4);
	w = CUI_Box_W / 1.4;
	action = "CtrlSetText [1,str (screenToWorld [0.5,0.5])];";
};
class DPanelCursorTarget : DPanelScreenPos {
	text = "cursorTarget";
	y = CUI_Row_Y(5);
	action = "CtrlSetText [55,str cursorTarget]; CtrlSetText [1,""cursorTarget""];";
};
class DPanelNearest : DPanelScreenPos {
	text = "NearestCursor";
	y = CUI_Row_Y(6);
	action = "CtrlSetText [55,str (nearestObject (screenToWorld [0.5,0.5]))]; CtrlSetText [1,""nearestObject (screenToWorld [0.5,0.5])""];";
};
class DPanelCaptionC : CUI_Caption {
	text = "Code";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(7);
	w = CUI_Box_W / 1.4;
};
class DPanelAIGrpMake : DPanelScreenPos {
	text = "spawnGroup";
	y = CUI_Row_Y(8);
	action = "CtrlSetText [2,""_side = resistance; _group = [_this, _side, <GROUP_NAME>] call BIS_fnc_SpawnGroup; _units = units _group; {_x setskill (skill _x);} foreach _units; _group""];";
};
class DPanelAIVehMake : DPanelScreenPos {
	text = "spawnVehicle";
	y = CUI_Row_Y(9);
	action = "CtrlSetText [2,""_type = <TYPE>; _array = [_this, random 360, _type, group player] call BIS_fnc_spawnVehicle; _vehicle = _array select 0; _units = _array select 1;""]; ";
};
class DPanelCreateVehicle : DPanelScreenPos {
	text = "createVehicle";
	y = CUI_Row_Y(10);
	action = "CtrlSetText [2,""_type = <TYPE>; _position = _this; _vehicle = createvehicle [_type,_position,[],0,'']; _vehicle setpos _position; _vehicle""];";
};
class DPanelCreateUnit : DPanelScreenPos {
	text = "createUnit";
	y = CUI_Row_Y(11);
	action = "CtrlSetText [2,""_type = <TYPE>; _group = group player; _position = _this; _unit = _group createunit [_type,_position,[],0,'']; _unit setpos _position; _unit""];";
};
class DPanelCaptionS : CUI_Caption {
	text = "Search";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(12);
	w = CUI_Box_W / 1.4;
};
class DPanelSearchBox : CUI_Edit {
	idc = 52;
	x = CUI_Box_X(2);
	y = CUI_Row_Y(13);
	w = (CUI_Box_W / 1.4) - CUI_Row_H;
	h = CUI_Row_DY(0,1);
	autocomplete = "scripting";
};
class DPanelSearch : CUI_Button {
	text = "^F";
	x = CUI_Box_X(2) + ((CUI_Box_W / 1.4) - CUI_Row_H);
	y = CUI_Row_Y(13);
	w = CUI_Row_H;
	action = "CtrlSetText [51,str ([CtrlText 52] call CBA_fnc_searchConfig)];";
};
class DPanelCaptionM : CUI_Caption {
	text = "Misc";
	x = CUI_Box_X(2);
	y = CUI_Row_Y(14);
	w = CUI_Box_W / 1.4;
};
class DPanelSelPlayer : DPanelScreenPos {
	text = "Select Player";
	y = CUI_Row_Y(15);
	action = "_unit = nearestObject (screenToWorld [0.5,0.5]); if (isnull _unit) then {_unit = cursorTarget;}; if (!isnull _unit) then {selectPlayer _unit;};";
};
class DPanelCamera : DPanelScreenPos {
	text = "Camera";
	y = CUI_Row_Y(16);
	action = "player exec ""camera.sqs""";
};