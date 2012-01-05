//#define JCACHE_DEBUG
#include "script_component.hpp"

private["_groupEntry", "_groupUnits", "_distance", "_isDisabled", "_activatedDistance", "_distanceArray", "_groupLeader", "_isCached", "_unit", "_player", "_ctrl", "_maxCompareDistance"];
_groupEntry = _this select 0;

_groupUnits = _groupEntry select 1;

_ctrl = _groupEntry select 0;
SET_CTRL_DELAY(_ctrl, 5);	// hard-set the delay check for 5 seconds

_groupLeader = GET_CTRL_LEADER(_ctrl);

// get the max comparision distance for speed
_maxCompareDistance = -1;
_distanceArray = GET_CTRL_DIST(_ctrl);
{
	if(_x > _maxCompareDistance) then {
		_maxCompareDistance = _x;
	};
} forEach _distanceArray;

_isCached = _groupLeader getVariable [QUOTE(GVAR(isCached)), false];
_isDisabled = _groupLeader getVariable [QUOTE(GVAR(isDisabled)), false];

// now we do all our distance checks from the groupleader. We should do it with CAMan nearest object
// and then do isPLayer. This is faster than searching all players all the time, especially if they are distant
// this also optimizes for high player count
private["_playableUnits"];
_playableUnits = playableUnits;
_activatedDistance = -1;
if(!isDedicated) then { PUSH(_playableUnits, player); };
{
	private["_player"];
	_player = _x;
	//TRACE_1("CHECK", _player);
	
	if(alive _player && isPlayer _player) then {
		_distance = _groupLeader distance _player;
		
		//TRACE_2("did compare", _distance, _maxCompareDistance);
		
		// first, dont bother if distance > the highest distance
		if(_distance < _maxCompareDistance) exitWith {
			
			if((vehicle _player) == _player) then { 			// Infantry/ground unit compare

				//
				// Infantry block
				//
				if(_distance < (_distanceArray select 0) ) then {
					TRACE_1("Activating: infantry view", _groupLeader);
					_activatedDistance = _distance;
					if(!_isCached && _isDisabled) then {
						[_groupEntry, _activatedDistance] call FUNC(activateGroup);
					};
				};
			} else {											// They are in a vehicle, find out what type
				private["_vehicle", "_typeOf"];
				_vehicle = vehicle _player;
				_typeOf = typeOf _vehicle;

				if( (_typeOf isKindOf "Car") || 
					(_typeOf isKindOf "Tank") ||
					(_typeOf isKindOf "Wheeled_APC") ) then {	// Its a vehicle compare
					//
					// Ground vehicle block
					//
					if(_distance < (_distanceArray select 1) ) then {
						TRACE_1("Activating: vehicle view", _groupLeader);
						_activatedDistance = _distance;
						if(!_isCached && _isDisabled) then {
							[_groupEntry, _activatedDistance] call FUNC(activateGroup);
						};
					};
				} else {										// use aircraft distance
					//
					// Aircraft block
					//
					if(_distance < (_distanceArray select 2) ) then {
						TRACE_1("Activating: aircraft view", _groupLeader);
						_activatedDistance = _distance;
						if(!_isCached && _isDisabled) then {
							[_groupEntry, _activatedDistance] call FUNC(activateGroup);
						};
					};
				};
			};
		};
	};
} forEach _playableUnits;

if( !_isDisabled ) then {
	// this block is handled if they are NOT disabled, this means we have uncached them for some reason
	// We need to handle keeping them uncached for a duration, then re-caching them.
	// This depends on their fired type and other factors
	TRACE_2("Checking activated unit", _groupLeader, _activatedDistance);
	
	if(_activatedDistance < 0) then {
		TRACE_1("De-activating unit", _groupLeader);
		[_groupEntry] call FUNC(deactivateGroup);
	};

} else {
	
};