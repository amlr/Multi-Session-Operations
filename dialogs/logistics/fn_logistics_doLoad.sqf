disableserialization;

private ["_index"];
_index = _this select 1;

private ["_target"];
_target = player getvariable "RMM_logistics_target";

private ["_object","_array"];
_object = (player getvariable "RMM_logistics_nearby") select _index;
if (isnull _object) exitwith {};
if (count (crew _object) > 0) exitwith {};
_array = _target getvariable "RMM_logistics_contents";
if (isnil "_array") then {_array = []};
if (_object in _array) exitwith {};

private ["_volume_t","_volume_o"];
_volume_t = _target getvariable "RMM_logistics_volume";
_volume_o = ceil([_object] call RMM_fnc_getvolume);
if (isnil "_volume_t") exitwith {};
if (isnil "_volume_o") exitwith {};
if (_volume_t - _volume_o < 0) exitwith {};

_target setvariable ["RMM_logistics_contents",_array + [_object],true];
_target setvariable ["RMM_logistics_volume",_volume_t - _volume_o];

if (isnil "RMM_logistics_Virtual") then {
	RMM_logistics_Virtual = createVehicle ["HeliHEmpty",[0,0,0],[],0,"NONE"];
	publicvariable "RMM_logistics_Virtual";
};
_object attachto [RMM_logistics_Virtual,[0,0,10]];

waituntil {_object distance RMM_logistics_Virtual < 15};

closeDialog 0;
_target call RMM_fnc_logistics_doOpen;