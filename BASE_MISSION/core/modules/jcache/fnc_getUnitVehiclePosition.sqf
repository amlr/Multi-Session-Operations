#include "script_component.hpp"

private["_unit", "_vehicle", "_ret"];
_unit = _this select 0;
_ret = "other";

if( (vehicle _unit) == _unit) exitWith {
	nil
};
_vehicle = vehicle _unit;


if(((commander _vehicle) == _unit) && (((assignedVehicleRole _unit) select 0) == "Turret")) exitWith {
	_ret = "commander";
	_ret
};

if((driver _vehicle) == _unit) exitWith {
	_ret = "driver";
	_ret
};

if((gunner _vehicle) == _unit) exitWith {
	_ret = "gunner";
	_ret
};

if((Count (assignedVehicleRole _unit)>1)) exitWith {
	_ret = "gunner";
	_ret
};

if(((assignedVehicleRole _unit) select 0) == "Cargo") exitWith {
	_ret = "cargo";
	_ret 
};

_ret