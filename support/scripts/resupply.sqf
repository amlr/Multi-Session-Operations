/*  
=========================================================
  Based on Simple Vehicle Respawn Script v1.6
  by Tophe of �stg�ta Ops [OOPS]
  
  Put this in the vehicles init line:
  veh = [this, Delay] execVM "respawn.sqf"

  Default respawn delay is 30 seconds, to set a custom
  respawn delay time, put that in the init as well. 
  Like this:
  veh = [this, 15] execVM "vehicle.sqf"

=========================================================
*/

private ["_delay","_unit"];
if (!isServer) exitWith {};

// Define variables
_unit = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {30};

[_unit, _delay] execFSM "support\scripts\resupply.fsm";