/*
__          __        _     _   _          _____             __ _ _      _     _______          _ 
\ \        / /       | |   | | (_)        / ____|           / _| (_)    | |   |__   __|        | |
 \ \  /\  / /__  _ __| | __| |  _ _ __   | |     ___  _ __ | |_| |_  ___| |_     | | ___   ___ | |
  \ \/  \/ / _ \| '__| |/ _` | | | '_ \  | |    / _ \| '_ \|  _| | |/ __| __|    | |/ _ \ / _ \| |
   \  /\  / (_) | |  | | (_| | | | | | | | |___| (_) | | | | | | | | (__| |_     | | (_) | (_) | |
    \/  \/ \___/|_|  |_|\__,_| |_|_| |_|  \_____\___/|_| |_|_| |_|_|\___|\__|    |_|\___/ \___/|_|

  ,---.                     ,---.  ,--.,--.,--.            ,--.,--.      
 /  O  \ ,--.--.,--,--,--. /  O  \ |  ||  ||  ,---.  ,---. |  |`--' ,---.
|  .-.  ||  .--'|        ||  .-.  ||  ||  ||  .-.  || .-. ||  |,--.| .--'
|  | |  ||  |   |  |  |  ||  | |  ||  ||  ||  | |  |' '-' '|  ||  |\ `--.
`--' `--'`--'   `--`--`--'`--' `--'`--'`--'`--' `--' `---' `--'`--' `---'
*/
/*
 =======================================================================================================================
Script: BIN_taskDefend.sqf v1.3a
Author(s): Binesi
Partly based on original code by BIS

Description:
Group will mount all nearby static defenses and vehicle turrets and guard/patrol the position and surrounding area.

Parameter(s):
_this select 0: group (Group)
_this select 1: defense position (Array)
    
Returns:
Boolean - success flag

Example(s):
null = [group this,(getPos this)] execVM "BIN_taskDefend.sqf"

-----------------------------------------------------------------------------------------------------------------------
Notes:

To prevent this script from mounting vehicle turrets find and replace "LandVehicle" with "StaticWeapon".

The "DISMISS" waypoint is nice but bugged in a few ways. The odd hacks in this code are used to force the desired behavior.
The ideal method would be to write a new FSM and I may attempt that in a future project if no one else does.

ArmAIIholic
-- first waypoint is now 25m with completion radius 25m
-- changed numbers for waypoints to match the number of previous waypoints
-- not mounting - see static.sqf!!!

=======================================================================================================================
*/

if (isServer) then
{

	private ["_grp", "_pos"];
	_grp = _this select 0;
	_pos = _this select 1;

	_grp setBehaviour "SAFE";

	// Setup Waypoints
	private ["_wp1","_wp2","_wp3","_wp4","_unit","_i"];

	_i = count (waypoints _grp);


	_wp1 = _grp addWaypoint [_pos, 25];
	_wp1 setWaypointType "MOVE";
	[_grp, _i+1] setWaypointSpeed "LIMITED";
	[_grp, _i+1] setWaypointBehaviour "SAFE";
	[_grp, _i+1] setWaypointCombatMode "YELLOW";
	[_grp, _i+1] setWaypointFormation "STAG COLUMN";
	[_grp, _i+1] setWaypointCompletionRadius 25;
	[_grp, _i+1] setWaypointStatements ["true", "null = [this] spawn {
			_grp = group (_this select 0);
			sleep (30+(random 60));
			{doStop _x} forEach units _grp;
			_grp setCurrentWaypoint [_grp,3];
			{_x doMove getPos _x} forEach units _grp;
			sleep 1;
			{_x forceSpeed 3} forEach units _grp;
			if ((random 3)> 2) then {sleep 3} else {sleep 30 + (random 30)};
			_grp setCurrentWaypoint [_grp, _i+1];
	}; "];

	_wp2 = _grp addWaypoint [_pos, 25];
	_wp2 setWaypointType "DISMISS";
	[_grp, _i+2] setWaypointStatements ["true", "null = [this] spawn {
			_grp = group (_this select 0);
			{_x forceSpeed -1 } forEach units _grp;
	}; "];

	_wp3 = _grp addWaypoint [_pos, 25];
	_wp3 setWaypointType "SAD";
	[_grp, _i+3] setWaypointSpeed "FULL";
	[_grp, _i+3] setWaypointBehaviour "ALERT";
	[_grp, _i+3] setWaypointCombatMode "RED";
	[_grp, _i+3] setWaypointFormation "VEE";
	[_grp, _i+3] setWaypointCompletionRadius 50;
	[_grp, _i+3] setWaypointStatements ["true", "null = [this] spawn {
			_grp = group (_this select 0);
			_grp setCurrentWaypoint [_grp, _i+1];
	}; "];

	_wp4 = _grp addWaypoint [_pos, 0];
	_wp4 setWaypointType "CYCLE"; // Redundant failsafe

	true
};