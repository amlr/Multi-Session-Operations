private ["_unit","_dragger"];
_unit = _this select 0;
_dragger = _this select 1;

if (_unit getvariable "revive_dragged") exitwith {};
_unit setvariable ["revive_dragged", true, true];

_dragger playactionnow "grabdrag";
sleep 1;

//unconscious unit assumes dragging posture
[0,_unit,{_this switchmove "ainjppnemstpsnonwrfldb_still"}] call mso_core_fnc_ExMP;

//attach unconscious unit
_unit attachto [_dragger, [0.1, 1.01, 0]];
sleep 0.1;

//orientation
[0,_unit,{_this setdir 180}] call mso_core_fnc_ExMP;

//drop action
_action = _dragger addaction [localize "dragger.sqf0", revive_fnc_drop_path, _unit];

sleep 1;

//waituntil stopped dragging
while {sleep 0.5;_unit getvariable "revive_dragged"} do {
	if (lifestate _dragger != "alive") exitwith {};
	if not (animationstate _dragger in ["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb"]) exitwith {};
	sleep 0.5;
};
if (_unit getvariable "revive_dragged") then {_unit setvariable ["revive_dragged", false, true]};

_dragger removeaction _action;

//detach
detach _unit;
detach _dragger;

_dragger playaction "released";

[0,_unit,{_this playaction "agonystart"}] call mso_core_fnc_ExMP;