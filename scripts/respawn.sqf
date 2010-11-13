/*  
=========================================================
  Based on Simple Vehicle Respawn Script v1.6
  by Tophe of Östgöta Ops [OOPS]
  
  Put this in the vehicles init line:
  veh = [this, Delay] execVM "respawn.sqf"

  Default respawn delay is 30 seconds, to set a custom
  respawn delay time, put that in the init as well. 
  Like this:
  veh = [this, 15] execVM "vehicle.sqf"

=========================================================
*/
  
if (!isServer) exitWith {};

// Define variables
_unit = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {30};

_hasname = false;
_unitname = vehicleVarName _unit;
if (isNil _unitname) then {_hasname = false;} else {_hasname = true;};
_noend = true;
_run = true;
_rounds = 0;

if (_delay < 0) then {_delay = 0};

_dir = getDir _unit;
_position = getPosASL _unit;
_type = typeOf _unit;
_dead = false;
_nodelay = false;


// Start monitoring the vehicle
while {_run} do 
{	
	waitUntil{getPosASL _unit distance _position > 10};
	sleep _delay;
	_unit = _type createVehicle _position;
	_unit setPosASL _position;
	_unit setDir _dir;

	if (_haveinit) then {
		_unit setVehicleInit format ["%1;", _unitinit];
		processInitCommands;
	};
	if (_hasname) then {
		_unit setVehicleInit format ["%1 = this; this setVehicleVarName ""%1""",_unitname];
		processInitCommands;
	};
};