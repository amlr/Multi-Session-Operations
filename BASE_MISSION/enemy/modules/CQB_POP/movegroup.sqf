if (isDedicated) exitwith {};

private ["_bldgpos","_nearbldgs","_unittype","_spawnpos","_endpos","_unit","_leader","_group","_count","_units","_cleared","_suspended","_patrol","_movehome","_near","_houseguards"];
waitUntil {!isNil "bis_fnc_init"};

_pos = _this select 0;
_house = _this select 1;
_group = _this select 2;
_units = _this select 3;
_debug = debug_mso;
_bldgpos = [];

_house setVariable ["s", true, CQBaiBroadcast];

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

if (_debug) then {diag_log format["MSO-%1 CQB Population: Found %2 buildingpositions...", time, count _bldgpos]};

_leader = leader _group;

for "_i" from 0 to ((count _units)-1) do {
_spawnpos = _bldgpos select floor(random count _bldgpos);
_unit = (_units select _i);
_unit setpos _spawnpos;
if ((getposATL _unit select 2) > 3) then {_unit setUnitPos "DOWN"};
};

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
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Telling group %2 to guard house...", time, _group]};
        
        {
        	_x setUnitPos "AUTO";
        	_x setbehaviour "AWARE";
        	dostop _x;
            0 = [_x, 50, true, 300, _pos] spawn MSO_fnc_CQBhousepos;
        } foreach units _group;

        _patrol = true;
        _movehome = false;
    };
    
    if (!(_near) && !(_movehome)) then {
        _patrol = false;
        _movehome = true;
        
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 home...", time, _group]};
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
if ((count (units _group) == 0) && (_patrol)) then {_house setvariable ["c", true, true]; _cleared = true};
if ((count (units _group) == 0) && (_movehome)) then {_suspended = true};
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
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 on patrol...", time, _group]};
        [_group, _pos, 150] spawn BIN_fnc_taskPatrol;
    	_patrol = true;
        _movehome = false;
    };
    
    if (!(_near) && !(_movehome)) then {
        _patrol = false;
        _movehome = true;
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 home...", time, _group]};
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
if ((count (units _group) == 0) && (_patrol)) then {_house setvariable ["c", true, true]; _cleared = true};
if ((count (units _group) == 0) && (_movehome)) then {_suspended = true};
};

};

{
      _x setdamage 1;
      deletevehicle _x;
} foreach _units;
       
waituntil {count (units _group) == 0};
diag_log format["MSO-%1 CQB Population: Group %2 deleted - script end...", time, _group];
deletegroup _group;
_house setvariable ["s",nil, CQBaiBroadcast];

_group;
