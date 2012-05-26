if (({(local _x) && ((faction _x) in MSO_FACTIONS)} count allunits) > CQBaicap) exitwith {diag_log format["MSO-%1 CQB Population: Local AI unitcount above limits. Exiting...", time]};

_pos = _this select 0;
_house = _this select 1;
_despawn = _this select 2;

sleep (random 1);

_group = creategroup EAST;
_units = [];

for "_i" from 0 to (1 + floor(random 2)) do {
	_unittype = [0, MSO_FACTIONS,"Man"] call mso_core_fnc_findVehicleType;
	_unittype = _unittype call BIS_fnc_selectRandom;
	_unit = _group createUnit [_unittype,[0,0,0],[],0,"NONE"];
    _units set [count _units,_unit];
};

CQBgroupsLocal set [count CQBgroupsLocal, _group];
leader _group setvariable ["PM","CQB",true];
diag_log format["MSO-%1 CQB Population: Created group name %2 with %3 units...", time, _group, count units _group];

[_pos, _house, _group, _units, _despawn] spawn MSO_fnc_CQBmovegroup;
_group;