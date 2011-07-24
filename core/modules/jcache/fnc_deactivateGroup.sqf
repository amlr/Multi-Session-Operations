#include "script_component.hpp"

private["_groupEntry", "_unitArray", "_groupLeader"];
_groupEntry = _this select 0;
_ctrl = _groupEntry select 0;

_groupLeader = GET_CTRL_LEADER(_ctrl);
_unitArray = _groupEntry select 1;

TRACE_1("Deactivating group", _groupLeader);

#define JCACHE_CACHE_POSITION [-5000,5000,0]


// next, we move all the AI units and disable them
{
	private["_unit", "_state"];
	_unit = _x;
	if(_unit != _groupLeader) then {
		_unit disableAI "TARGET";
		_unit disableAI "AUTOTARGET";
		_unit disableAI "MOVE";
		_unit disableAI "ANIM";
		_unit disableAI "FSM";

		_unit enableSimulation false;
		_unit allowDammage false;
		
		GVAR(deactivatedCount) = GVAR(deactivatedCount) + 1;
		
		// move them
		// save a state incase they are in a vehicle, any other stuff?
		_state = [ [] ];
		if((vehicle _unit) != _unit) then {
			private["_vehicleState", "_vehicle"];
			_vehicle = vehicle _unit;
			_vehicleState = [_vehicle, ([_unit] call FUNC(getUnitVehiclePosition)) ];
			_state set [0, _vehicleState];
			moveOut _unit;
			
			// if the vehicle isn't moved yet, move it and cache it
			if( !(_vehicle getVariable[QUOTE(GVAR(isDisabled)), false]) ) then {
				_vehicle setVariable[QUOTE(GVAR(isDisabled)), true, false];
				_vehicle setVariable[QUOTE(GVAR(originalPosition)), (getPosATL _vehicle), false];
				_vehicle setPosATL ([JCACHE_CACHE_POSITION, 100] call CBA_fnc_randPos);
			};
			_unit setPosATL ([JCACHE_CACHE_POSITION , 100] call CBA_fnc_randPos);
		};
		
		_unit setVariable [QUOTE(GVAR(state)), _state, false];
		
		_unit setPosATL ([JCACHE_CACHE_POSITION, 100] call CBA_fnc_randPos);
		
		// flag it
		_unit setVariable[QUOTE(GVAR(isDisabled)), true, false];
	};
} foreach _unitArray;

//publicVariable QUOTE(GVAR(deactivatedCount));

_groupLeader setVariable [QUOTE(GVAR(isCached)), false, false];
_groupLeader setVariable [QUOTE(GVAR(isDisabled)), true, false];