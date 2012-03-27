
if !(isServer) exitWith {};

// Get all friendly factions and man classes for recruitment
tup_recruit_classes = [];

private ["_faction","_fx","_fac","_type"];

// Get factions
_faction = [];

{
	_fx = toUpper(faction _x);
	if !(_fx in _faction) then {
		_faction = _faction + [_fx];
	};
} foreach playableunits;

_type = "Man";

// Get Classes
{
	_fac = _x;
	tup_recruit_classes = tup_recruit_classes + [0,_fac,_type] call mso_core_fnc_findVehicleType;
} foreach _faction;

publicvariable "tup_recruit_classes";