hint "x";
private ["_data","_list","_waypoints","_params","_side","_behaviour","_combatmode","_speedmode","_formation","_group","_array","_current"];
_data = _this getvariable "data";
_list = _data select 0;
_waypoints = _data select 1;
_params = _data select 2;

_side = _params select 0;
_behaviour = _params select 1;
_combatmode = _params select 2;
_speedmode = _params select 3;
_formation = _params select 4;

_group = creategroup _side;
if (isnull _group) exitwith {};

_group setspeedmode _speedmode;
_group setformation _formation;
_group setbehaviour _behaviour;
_group setcombatmode _combatmode;

_array = _waypoints select 0;
_current = _waypoints select 1;
{
	private "_waypoint";
	_waypoint = _group addwaypoint [(_x select 0), 0];
	_waypoint setwaypointtype (_x select 1);
	_waypoint setwaypointbehaviour (_x select 2);
	_waypoint setwaypointspeed (_x select 3);
	_waypoint setwaypointcombatmode (_x select 4);
	_waypoint setwaypointformation (_x select 5);
	_waypoint setwaypointstatements (_x select 6);
	_waypoint setwaypointtimeout (_x select 7);
	_waypoint setwaypointhouseposition (_x select 8);
} foreach _array;
_group setcurrentwaypoint [_group,_current];

{
	[_x,_group] call OSOM_fnc_spawn;
} foreach _list;

_this setvariable ["group",_group];
_this setvariable ["data",nil];

diag_log format["MSO-%1 OSOM Total Units: %2", time, count allUnits];
