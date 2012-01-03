disableserialization;

private ["_control","_index"];
_control = _this select 0;
_index = _this select 1;

private ["_target"];
_target = player getvariable "logistics_target";

private ["_object","_array"];
_array = _target getvariable "logistics_contents";
_object = _array select _index;
if (isnull _object) exitwith {};

detach _object;

closeDialog 0;

private ["_volume_t","_volume_o"];
_volume_o = [_object] call CBA_fnc_getvolume;
_volume_t = _target getvariable "logistics_volume";

_target setvariable ["logistics_contents",_array - [_object],true];
_target setvariable ["logistics_volume",_volume_t + _volume_o];

//if (_volume_o > 
[_object,player] call logistics_fnc_move;