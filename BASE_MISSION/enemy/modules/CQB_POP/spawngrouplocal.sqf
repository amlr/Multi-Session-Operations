if (isDedicated) exitwith {};

private ["_bldgpos","_nearbldgs","_unittype","_spawnpos","_endpos","_unit","_leader","_group","_count","_units","_cleared","_suspended","_patrol","_movehome","_near","_houseguards"];
waitUntil {!isNil "bis_fnc_init"};

_debug = debug_mso;

_pos = _this select 0;
_house = _this select 1;
_bldgpos = [];

_nearbldgs = nearestObjects [_pos, ["Building"], 100];
{
	private["_housepos", "_poscount","_i","_y"];
    _poscount = 0;
    _i = 0;
	_housepos = _x buildingPos _poscount;
    _y = _x buildingPos _i;
	
    while {format["%1", _housepos] != "[0,0,0]"} do {
        _poscount = _poscount + 1;
        _housepos = _x buildingPos _poscount;
        
    }; 
    
    if (_poscount > 4) then {
    		for "_z" from 0 to (_poscount - 4) do {
				if(_y select 2 < 3) then {
					_bldgpos set [count _bldgpos, _y];
				};
				_i = _i + 1;
				_y = _x buildingPos _i;
			};
    };
} forEach _nearbldgs;

if (_debug) then {diag_log format["MSO-%1 CQB Population - Found %2 buildingpositions...", time, count _bldgpos]};

_group = creategroup EAST;
_units = [];

for "_i" from 0 to (1 + floor(random 2)) do {

	_unittype = [0, MSO_FACTIONS,"Man"] call mso_core_fnc_findVehicleType;
	_unittype = _unittype call BIS_fnc_selectRandom;
	_spawnpos = _bldgpos select floor(random count _bldgpos);
    
	if (_i < 1) then {
		_leader = _group createUnit [_unittype,[0,0,0],[],0,"NONE"];
        _leader setpos _spawnpos;
        if ((getposATL _leader select 2) > 2) then {_leader setUnitPos "DOWN"};
        _units set [count _units,_leader];
	} else {
	_unit = _group createUnit [_unittype,[0,0,0],[],0,"NONE"];
    _unit setpos _spawnpos;
    if ((getposATL _unit select 2) > 3) then {_unit setUnitPos "DOWN"};
    _units set [count _units,_unit];
	};

};

_leader = leader _group;
CQBgroupsLocal set [count CQBgroupsLocal, _group];

diag_log format["MSO-%1 CQB Population - Created group name %2 with %3 units...", time, _group, count units _group];

[_units] spawn {
{
    if (unitpos _x == "DOWN") then {
        sleep 20;
        _x setUnitPos "AUTO";
    };
} foreach (_this select 0);
};

if ((random 1 > 0.35)) then {_houseguards = true;} else {_houseguards = false;};
waituntil {!(isnil "_houseguards")};

if (_houseguards) then {
    
_cleared = false;
_suspended = false;
_patrol = false;
_movehome = false;

while {!(_cleared) && !(_suspended) && ({_pos distance _x < 2500} count ([] call BIS_fnc_listPlayers) > 0)} do {
sleep 2;   
	_near = ({_pos distance _x < 500} count ([] call BIS_fnc_listPlayers) > 0);
    
    if ((_near) && !(_patrol)) then {
        if (_debug) then {diag_log format["MSO-%1 CQB Population - Telling group %2 to guard house...", time, _group]};
        
        {
        	_x setUnitPos "AUTO";
        	_x setbehaviour "AWARE";
        	dostop _x;
        } foreach units _group;

        _patrol = true;
        _movehome = false;
    };
    
    if (!(_near) && !(_movehome)) then {
        _patrol = false;
        _movehome = true;
        
        if (_debug) then {diag_log format["MSO-%1 CQB Population - Deleting houseguards %2 ...", time, _group]};
		while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
		{
            _x setdamage 1;
            deletevehicle _x;
		} foreach units _group;
    };
if ((count (units _group) == 0) && (_patrol)) then {_house setvariable ["cleared",true,true]};
if ((count (units _group) == 0) && (_movehome)) then {_house setvariable ["suspended",nil]};
};
    
} else {
    
_cleared = false;
_suspended = false;
_patrol = false;
_movehome = false;

while {!(_cleared) && !(_suspended) && ({_pos distance _x < 2500} count ([] call BIS_fnc_listPlayers) > 0)} do {
sleep 2;   
	_near = ({_pos distance _x < 500} count ([] call BIS_fnc_listPlayers) > 0);
    
    if ((_near) && !(_patrol)) then {
        if (_debug) then {diag_log format["MSO-%1 CQB Population - Sending group %2 on patrol...", time, _group]};
        [_group, _pos, 150] spawn BIN_fnc_taskPatrol;
    	_patrol = true;
        _movehome = false;
    };
    
    if (!(_near) && !(_movehome)) then {
        _patrol = false;
        _movehome = true;
        if (_debug) then {diag_log format["MSO-%1 CQB Population - Sending group %2 home...", time, _group]};
		while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
		_endpos = _bldgpos select floor(random count _bldgpos);

        {
            _x domove _endpos;
		} foreach units _group;
    };
    
if (_movehome) then {
	{
		if (_x distance _endpos < 4) then {
            _x setdamage 1;
       		deletevehicle _x;
        };
    } foreach units _group;
};
if ((count (units _group) == 0) && (_patrol)) then {_house setvariable ["cleared",true,true]};
if ((count (units _group) == 0) && (_movehome)) then {_house setvariable ["suspended",nil];};
};

};

{
      _x setdamage 1;
      deletevehicle _x;
} foreach _units;
       
waituntil {count (units _group) == 0};
diag_log format["MSO-%1 CQB Population - Group %2 deleted - script end...", time, _group];
deletegroup _group;
_house setvariable ["suspended",nil];

_group;
