/*  
=========================================================
  Simple Vehicle Respawn Script v1.6
  by Tophe of �stg�ta Ops [OOPS]
  
  Put this in the vehicles init line:
  veh = [this] execVM "vehicle.sqf"


  Options:
  There are some optional settings. The format for these are:
  veh = [this, Delay, Deserted timer, Respawns, Effect, Static] execVM "vehicle.sqf"

  
  Default respawn delay is 30 seconds, to set a custom
  respawn delay time, put that in the init as well. 
  Like this:
  veh = [this, 15] execVM "vehicle.sqf"

  Default respawn time when vehicle is deserted, but not
  destroyed is 120 seconds. To set a custom timer for this 
  first put the respawn delay, then the deserted vehicle timer-
  Like this:  
  veh = [this, 15, 10] execVM "vehicle.sqf"

  By default the number of respawns is infinite. To set a limit
  First set the other values then the number of respawns you want (0 = infinite).
  Like this:
  veh = [this, 15, 10, 5] execVM "vehicle.sqf"


  Set this value to TRUE to add a special explosion effect to the wreck when respawning.
  Default value is FALSE, which will simply have the wreck disappear.
  Like this:
  veh = [this, 15, 10, 5, TRUE] execVM "vehicle.sqf"
  
  By default the vehicle will respawn to the point where it first
  was when the mission started (static). This can be changed to 
  dynamic. Then the vehicle will respawn to the position where it was destroyed. 
  First set all the other values then set TRUE for dynamic or FALSE for static.
  Like this:
  veh = [this, 15, 10, 5, TRUE, TRUE] execVM "vehicle.sqf"
  
  If you you want to set the INIT field of the respawned vehicle, first set all other 
  values, then set init commands. Those must be inside quotations.
  Like this:
  veh = [this, 15, 10, 5, TRUE, FALSE, "this setDammage 0.5"] execVM "vehicle.sqf"
  
  Default values of all settings are:
  veh = [this, 30, 120, 0, FALSE, FALSE] execVM "vehicle.sqf"
  


	
Contact & Bugreport: harlechin@hotmail.com

=========================================================
*/

if (!isServer) exitWith {};
_this execFSM "support\scripts\vehicle.fsm";
