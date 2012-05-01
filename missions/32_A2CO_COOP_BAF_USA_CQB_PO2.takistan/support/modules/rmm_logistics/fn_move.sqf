private["_object","_unit"];
_object = _this select 0;
_unit = _this select 1;

private ["_typeOf","_sizeOf","_placing","_action","_bounds","_pos"];
_typeOf = typeOf _object;
_sizeOf = sizeOf _typeOf;

_placing = {_object getvariable "logistics_placing"};
if (not isnil _placing) exitwith {};

_bounds = boundingBox _object;
_object attachTo [_unit,[0,(_bounds select 1 select 1)/2 max 1.4,(_bounds select 1 select 2)]];
_object allowdamage false;
_unit reveal _object;

_action = _unit addaction [localize "dragger.sqf0","functions\client\fn_actionargument.sqf",[_object,{_this setvariable ["logistics_placing",false]}, true]];
_object setvariable ["logistics_placing",true,true];
_unit playActionNow "grabDrag";

while _placing do {
	sleep 0.5;
	if (not alive _unit) exitwith {};
	if (count crew _object > 0) exitwith {};
	if (vehicle _unit != _unit) exitwith {};
	if (not (animationState _unit in ["amovpercmstpslowwrfldnon_acinpknlmwlkslowwrfldb_1","amovpercmstpslowwrfldnon_acinpknlmwlkslowwrfldb_2","acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb"])) exitWith {};
};
detach _object;

_pos = getposatl _object;
_pos set [2, 0];
_object setposatl _pos;
_object allowdamage true;

_unit removeaction _action;
_unit playAction "released";
sleep 2;
_unit playmove "amovpknlmstpsraswrfldnon";
_object setvariable ["logistics_placing",nil,true];