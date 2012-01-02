//#define JCACHE_DEBUG
#include "script_component.hpp"

private["_groupEntry", "_unitArray", "_groupLeader", "_ctrl", "_activatedDistance"];

_groupEntry = _this select 0;
_activatedDistance = _this select 1;

_ctrl = _groupEntry select 0;

_groupLeader = GET_CTRL_LEADER(_ctrl);
_unitArray = _groupEntry select 1;


TRACE_1("Activating group", _groupLeader);

// next, we move all the AI units and disable them
{
	private["_unit", "_state", "_vehicleState"];
	_unit = _x;
	if(_unit != _groupLeader) then {
		// count
		GVAR(deactivatedCount) = GVAR(deactivatedCount) - 1;
		
		// check the units state
		
		_state = _unit getVariable[QUOTE(GVAR(state)), [] ];
		
//
// Handle vehicle state
//
		if( (count (_state select 0)) > 0) then { 
			private["_vehicle", "_originalPosition"];
			_vehicleState = _state select 0;
			_vehicle = _vehicleState select 0;
			
			// if the vehicle hasnt been un-moved yet, move it back
			if( (_vehicle getVariable[QUOTE(GVAR(isDisabled)), false]) ) then {
				_vehicle setVariable[QUOTE(GVAR(isDisabled)), false, false];

				_originalPosition = _vehicle getVariable[QUOTE(GVAR(originalPosition)), (getPosATL _groupLeader)];
				
				_vehicle setPosATL _originalPosition;
			};
			
			switch ( (_vehicleState select 1) ) do { 
				case "commander": { 
					_unit assignAsCommander _vehicle;
					_unit moveInCommander _vehicle; 
				};
				case "driver": { 
					_unit assignAsDriver _vehicle;
					_unit moveInDriver _vehicle; 
				};
				case "gunner": { 
					private["_checkGunner"];
					_checkGunner = gunner _vehicle;
					if(!isNil "_checkGunner") then {
						_unit assignAsGunner _vehicle;
						_unit moveInGunner _vehicle; 
					} else {
						_unit assignAsCargo _vehicle;
						_unit moveInCargo _vehicle; 
					};
				};
				default { 
					_unit assignAsCargo _vehicle;
					_unit moveInCargo _vehicle; 
				};
			};
		} else {
			_unit setPosATL (formationPosition _unit);
		};
		
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";

		_unit enableSimulation true;
		_unit allowDammage true;		

		// flag it
		_unit setVariable[QUOTE(GVAR(state)), nil, false];
		_unit setVariable[QUOTE(GVAR(isDisabled)), false, false];
	};
} foreach _unitArray;

//publicVariable QUOTE(GVAR(deactivatedCount));

_groupLeader setVariable [QUOTE(GVAR(isDisabled)), false, false];
_groupLeader setVariable [QUOTE(GVAR(activatedDistance)), _activatedDistance, false];