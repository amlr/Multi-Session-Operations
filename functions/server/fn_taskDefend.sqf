/* ----------------------------------------------------------------------------
Function: RMM_fnc_taskDefend

Description:
	A function for a group to defend a parsed location. Groups will mount nearby static machine guns, and bunker in nearby buildings. They may also patrol the radius unless otherwise specified.
Parameters:
	- Group (Group or Object)
	Optional:
	- Position (XYZ, Object, Location or Group)
	- Defend Radius (Scalar)
	- Can Patrol(Boolean)
Example:
	[this] call RMM_fnc_taskDefend
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_group","_position","_radius"];
_group = (_this select 0) call RMM_fnc_getgroup;
_position = (if (count _this > 1) then {_this select 1} else {_group}) call RMM_fnc_getpos;
_radius = if (count _this > 2) then {_this select 2} else {50};

_group enableattack false;

private ["_count", "_list", "_list2", "_units", "_i"];
_list = [_position, vehicles, _radius, {(_x iskindof "StaticWeapon") && (_x emptypositions "Gunner" > 0)}] call RMM_fnc_getnearest;
_list2 = _position nearObjects ["building",_radius];
_units = units _group;
_count = count _units;

if (count _this > 3) then {_group setbehaviour (_this select 3)};

{
	if (str(_x buildingpos 2) == "[0,0,0]") then {_list2 = _list2 - [_x]};
} foreach _list2;
_i = 0;
{
	if (random 1 < 0.31) then {
		private ["_count"];
		_count = (count _list) - 1;
		if (_count > -1) then {
			_x assignasgunner (_list select _count);
			_list resize _count;
			[_x] ordergetin true;
			_i = _i + 1;
		};
	} else {
		if (random 1 < 0.93) then {
			private ["_count"];
			_count = (count _list2) - 1;
			if (_count > -1) then {
				private ["_building","_k"];
				_building = _list2 select _count;
				_k = 0;
				while {str(_object buildingpos _k) != "[0,0,0]"} do {_k = _k + 1};
				[_x,_building buildingpos floor(random _k)] spawn {
					(_this select 0) domove (_this select 1);
					(_this select 0) commandmove (_this select 1);
					//waituntil {((expectedDestination _this) select 1) == "LEADER PLANNED"};
					sleep 3;
					waituntil {unitready (_this select 0)};
					(_this select 0) disableai "move";
					commandstop _this;
					waituntil {not (unitready (_this select 0))};
					(_this select 0) enableai "move";
				};
				_list2 resize _count;
				_i = _i + 1;
			};
		};
	};
} foreach (_units - [leader _group]);
if (count _this > 4) then {if !(_this select 4) then {_i = _count}};
if (_i < _count * 0.5) exitwith {
	[_group, _position, _radius, 5, "sad", "safe", "red", "limited"] call RMM_fnc_taskpatrol;
};
