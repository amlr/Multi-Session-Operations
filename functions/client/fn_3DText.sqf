/*
	Author: Karel Moricky
			Edited by Rommel

	Description:
	3D text

	Parameter(s):
	_this select 0: STRING - Text
	_this select 1: ARRAY - Position in 3D world
	OPTIONAL
	_this select 2: NUMBER - Full opacity distance (20,[0:10,1:20,0:30])
	_this select 3: CONDITION - Condition to run

	Returns:
	True
*/
disableserialization;
private ["_text","_pos","_display","_control","_w","_h","_minsDis","_dis","_alpha","_pos2D","_condition"];

_text = _this select 0;
_pos = _this select 1;
_minDis = if (count _this > 2) then {_this select 2} else {20};
_condition = if (count _this > 3) then {_this select 3} else {{true}};
if (isnil "BIS_fnc_3dCredits_n") then {BIS_fnc_3dCredits_n = 2733;};

if (typename _pos == typename objnull) then {_pos = position _pos};
if (typename _pos == typename "") then {_pos = markerpos _pos};

BIS_fnc_3dCredits_n cutrsc ["rscDynamicText","plain"];
BIS_fnc_3dCredits_n = BIS_fnc_3dCredits_n + 1;


_display = uinamespace getvariable "BIS_dynamicText";
_control = _display displayctrl 9999;

_control ctrlsetfade 1;
_control ctrlcommit 0;
_control ctrlsetstructuredtext parsetext _text;
_control ctrlcommit 0;

_w = safezoneW;
_h = safezoneH / 2;

while _condition do {
	_dis = player distance _pos;
	_alpha = abs ((_dis / _minDis) - 1);

	if (_alpha <= 1) then {
		_pos2D = worldtoscreen _pos;

		if (count _pos2D > 0) then {
			_control ctrlsetposition [
				(_pos2D select 0) - _w/2,
				(_pos2D select 1) - _h/2,
				_w,
				_h
			];
			//_control ctrlsetbackgroundcolor [0,0,0,0.5];
			_control ctrlsetstructuredtext parsetext _text;
			_control ctrlsetfade (_alpha^3);
			_control ctrlcommit 0.01;
		} else {
			_control ctrlsetfade 1;
			_control ctrlcommit 0.1;
		};
	} else {
		_control ctrlsetfade 1;
		_control ctrlcommit 0.1;
		sleep (2 + (player distance _pos)/10);
	};
	sleep 0.01;
};

_control ctrlsetfade 1;
_control ctrlcommit 0.1;