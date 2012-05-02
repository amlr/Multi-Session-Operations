if (isserver) exitwith {};

private ["_bldgpos","_nearbldgs","_unittype","_spawnpos","_endpos","_unit","_leader","_group"];
waitUntil {!isNil "bis_fnc_init"};

_debug = debug_mso;

_pos = _this select 0;
_bldgpos = [];

_count = 0;
{        
	if ((str(_x) == str(_pos))) then {
         _count = _count + 1;
    };
} foreach CQBclearedpos;
if (_count > 0) exitwith {if (_debug) then {diag_log format["MSO-%1 CQB Population - Position already cleared, script exiting...", time]}};

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

diag_log format["MSO-%1 CQB Population - Created group name %2 with %3 units...", time, _group, count units _group];

[_group, _pos, _bldgpos,_debug,_units] spawn {
    private ["_group","_units","_pos","_cleared","_counter"];
    _group = _this select 0;
    _pos = _this select 1;
    _bldgpos = _this select 2;
    _debug = _this select 3;
    _units = _this select 4;
    _cleared = false;
    
    [_group, _pos, 150] spawn BIN_fnc_taskPatrol;
    //[_group,_pos,120] execVM "enemy\scripts\BIN_tasksweep.sqf";
    sleep 20;
    
    {if (unitpos _x == "DOWN") then {_x setUnitPos "AUTO"}} foreach units (_group);
    while {({_pos distance _x < 500} count ([] call BIS_fnc_listPlayers) > 0) && (count units _group > 0)} do {sleep 5};
    
    if !(count units _group > 0) then {
        if (_debug) then {diag_log format["MSO-%1 CQB Population - All units in group %2 are dead ...", time, _group]
        };
        _cleared = true;
    };
        
    _endpos = _bldgpos select floor(random count _bldgpos);
    if (_debug) then {diag_log format["MSO-%1 CQB Population - Group name %2 splitting up...", time, _group]};
    
    while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
    _group move _endpos;
    
    {
        [_x] join grpNull;
        _x domove _endpos;
    } foreach _units;
    
    
    {
        _counter = 0;
        while {(alive _x) && (_x distance _endpos > 1) && ({_pos distance _x < 2500} count ([] call BIS_fnc_listPlayers) > 0)} do {
        _x domove _endpos; 
        if (_x distance _endpos < 4) then {deletevehicle _x};
        if (_counter > 300) then {_endpos = _bldgpos select floor(random count _bldgpos); _counter = 0};
        sleep 10;
        _counter = _counter + 10;
        };
    } foreach _units;

    {deletevehicle _x} foreach _units;
    deletegroup _group;
        
	if (_cleared) then {
            CQBclearedpos set [count CQBclearedpos, _pos];
            if (_debug) then {diag_log format["MSO-%1 CQB Population - Setting cleared posistion %2...", time, _pos]};
    } else {
            CQBpositionsLocal set [count CQBpositionsLocal, _pos];
            if (_debug) then {diag_log format["MSO-%1 CQB Population - Adding posistion back to spawnpoints %2...", time, _pos]};
    };
 
	_idx = [CQBsuspendedposLocal, _pos] call BIS_fnc_arrayFindDeep;
	_idx = _idx select 0;
	CQBsuspendedposLocal set [_idx, ">REMOVE<"];
	CQBsuspendedposLocal = CQBsuspendedposLocal - [">REMOVE<"];
    
    diag_log format["MSO-%1 CQB Population - Group deleted - script end...", time];
};

_group;
