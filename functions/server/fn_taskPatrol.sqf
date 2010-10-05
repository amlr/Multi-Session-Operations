/* ----------------------------------------------------------------------------
Function: RMM_fnc_taskPatrol

Description:
	A function for a group to randomly patrol a parsed radius and location.
Parameters:
	- Group (Group or Object)
	Optional:
	- Position (XYZ, Object, Location or Group)
	- Radius (Scalar)
	- Waypoint Count (Scalar)
	- Waypoint Type (String)
	- Behaviour (String)
	- Combat Mode (String)
	- Speed Mode (String)
	- Formation (String)
	- Code To Execute at Each Waypoint (String)
	- TimeOut at each Waypoint (Array [Min, Med, Max])
Example:
    [this, getmarkerpos "objective1"] call RMM_fnc_taskPatrol
    [this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn RMM_fnc_searchNearby", [3,6,9]] call RMM_fnc_taskPatrol;
	
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_group","_radius","_count"];
_group = _this select 0;
_radius = if (count _this > 2) then {_this select 2} else {100};
_count = if (count _this > 3) then {_this select 3} else {3};

_this =+ _this;
if (count _this > 3) then {
    _this set [3, "$null$"];
    _this = _this - ["$null$"];
};
for "_x" from 0 to _count do {
    _this call RMM_fnc_addwaypoint;
};
_this2 =+ _this;
_this2 set [3, "CYCLE"];
_this2 call RMM_fnc_addwaypoint;

deleteWaypoint ((waypoints _group) select 0);
