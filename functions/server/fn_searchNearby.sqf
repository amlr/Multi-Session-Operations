/* ----------------------------------------------------------------------------
Function: RMM_fnc_searchNearby

Description:
	A function for a group to search a nearby building.
Parameters:
	Group (Group or Object)
Example:
	[group player] spawn RMM_fnc_searchNearby
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_group"];
_group = (_this select 0) call RMM_fnc_getgroup;
_group lockwp true;
private ["_leader","_behaviour"];
_leader = leader _group;
_behaviour = behaviour _leader;
_group setbehaviour "combat";

private ["_array", "_building", "_indices"];
_array = _leader call RMM_fnc_getnearestbuilding;
_building = _array select 0;
_indices = _array select 1;
_group setformdir ([_leader, _building] call bis_fnc_dirto);

if (_leader distance _building > 500) exitwith {_group lockwp false};

private ["_count","_units"];
_units = units _group;
_count = (count _units) - 1;

while {_indices > 0 and _count > 0} do {
	sleep 10;
	while {_indices > 0 and _count > 0} do {
		private "_unit";
		_unit = (_units select _count);
		if (unitready _unit) then {
			_unit commandmove (_building buildingpos _indices);
			_unit spawn {
				sleep 5;
				waituntil {unitready _this};
			};
			_indices = _indices - 1;
		};
		_count = _count - 1;
	};
	_units = units _group;
	_count = (count _units) - 1;
};
waituntil {sleep 3;	{unitready _x} count _units == count (units _group) - 1};
{
	_x dofollow _leader;
} foreach _units;
_group setbehaviour _behaviour;
_group lockwp false;