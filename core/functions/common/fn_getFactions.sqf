private ["_side","_position","_radius","_switch","_debug","_name","_currentFaction","_currentFactionCount","_factions","_afactions","_units","_facs"];

_side = _this select 0;
_position = _this select 1;
_radius = _this select 2;
_switch = _this select 3;
_debug = _this select 4;
_name = _this select 5;

_currentFactionCount = 0;
_factions = [];
_factionsCount = [];
_facs = [];

_units = [_position, _radius] call mso_core_fnc_getUnitsInArea;
								  
// Set factions to count

switch (_side) do 
{
		case WEST: {_afactions = ["USMC","BIS_US","CDF","BIS_CZ","BIS_GER","BIS_BAF"]}; //
		case EAST: {_afactions = ["RU","INS","BIS_TK","BIS_TK_INS"]};
		case resistance: {_afactions = ["GUE","BIS_UN","PMC_BAF","BIS_TK_GUER"]};
		case civilian: {_afactions = ["BIS_TK_CIV","BIS_CIV_special","CIV", "CIV_RU"]};
};

// Count factions at location for side
{
	_currentFaction = _x;	
	_currentFactionCount = {faction _x == _currentFaction} count _units;
	sleep 0.01;

	// Use the faction count as the bias - count factions
	If (_currentFactionCount > 0) then {
			_factions = _factions + [_currentFaction];
			_factionsCount = _factionsCount + [_currentFactionCount];
	};
} foreach _afactions;
		
// If there are no factions then set factions to civilian (default side)
if (count _factions == 0) then {
		_factions = _afactions;
		{
				_factionsCount = _factionsCount + [1];
		} forEach _afactions;
};

if (_debug) then {
		diag_log format ["MSO-%1 Factions: %2 will have this split: %3 , %4", time, _name, _factions, _factionsCount];
};

switch (_switch) do 
{
		case "count": {_facs = _factionsCount};
		case "factions": {_facs = _factions};
};

_facs;