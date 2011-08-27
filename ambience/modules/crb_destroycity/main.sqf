
private ["_blacklist"];
if(isNil "destroyCity") then {destroyCity = 3;};
if(destroyCity > 0) then {
	_blacklist = ((markerPos "respawn_guerrila") nearObjectS ["House", 30]) + ((markerPos "respawn_guerrila_3") nearObjects ["House", 30]);

	["destroyCentre", 1200, 529, _blacklist] call compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";
	if(destroyCity > 1) then {
		["destroyCentre", 1200, 889, _blacklist] call compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";
	};
	if(destroyCity > 2) then {
		["destroyCentre", 1200, 1138, _blacklist] call compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";
	};
};
