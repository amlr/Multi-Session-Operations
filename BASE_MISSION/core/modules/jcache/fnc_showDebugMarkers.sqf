#define JCACHE_DEBUG
#include "script_component.hpp"

LOG("ENTER");

while { true } do {
	{
		private["_groupEntry", "_ctrl", "_unit", "_markerName", "_marker"];
		_groupEntry = _x;
		_ctrl = _groupEntry select 0;
		
		_unit = GET_CTRL_LEADER(_ctrl);
		
		if(alive _unit) then {
			_markerName = format["%1", _unit];
			_marker = _unit getVariable _markerName;
			if(isNil "_marker") then {
				// no marker, create it
				_marker = createMarkerLocal [_markerName, (position _unit)];
				_marker setMarkerType "Dot";
				_marker setMarkerAlpha 255;
				_unit setVariable [_markerName, _marker, false];
			};
			_marker setMarkerPos (position _unit);	
			
			_marker setMarkerColor "ColorRed";
			if( (_unit getVariable [QUOTE(GVAR(isCached)), false]) && 
				(_unit getVariable [QUOTE(GVAR(isDisabled)), false]) ) then {
					_marker setMarkerColor "ColorGreen";
			};
			if( !(_unit getVariable [QUOTE(GVAR(isCached)), false]) && 
				(_unit getVariable [QUOTE(GVAR(isDisabled)), false]) ) then {
					_marker setMarkerColor "ColorYellow";
			};
			
		} else {
			_markerName = format["%1", _unit];
			_marker = _markerLogic getVariable _markerName;
			if(!isNil "_marker") then {
				deleteMarker _markerName;
				_unit setVariable [_markerName, nil, false];
			};
		};
	} forEach GVAR(masterGroupList);
	sleep 0.25;
	
	hintSilent format["Group Count: %1\nTotal Count: %2\nActive Unit Count: %3\nDeactivated Unit Count: %4", (count GVAR(masterGroupList)), (count allUnits), ((count allUnits) - GVAR(deactivatedCount)), GVAR(deactivatedCount) ];
};