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

if (!isServer) exitWith {};
_this execFSM "support\scripts\resupply.fsm";