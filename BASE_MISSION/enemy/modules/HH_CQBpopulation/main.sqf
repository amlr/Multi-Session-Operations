if (isnil "CQB_spawn") then {CQB_spawn = 1};
if (CQB_spawn == 0) exitwith {diag_log format["MSO-%1 CQB Population turned off! Exiting...", time]};

_debug = true;

if (isserver) then {
private ["_spawnhouses","_housecount","_positions","_position","_t","_m"];

_spawnhouses = [markerpos "ammo_1",10000] call mps_getEnterableHouses;
_housecount = count _spawnhouses;
if (_debug) then {diag_log format["MSO-%1 CQB Population: Houses found %2", time, _housecount]};

_positions = [];
_position = position ((_spawnhouses select 0) select 0);
_positions set [count _positions, _position];

_i = 0;
for "_i" from 0 to (_housecount-1) do {
    _position = position ((_spawnhouses select _i) select 0);
    
    if ((random 1) > 0.9) then {
        _positions set [count _positions, _position];
        if (_debug) then {
         		_t = format["op%1",_i];
    			_m = [_t, _position, "Icon", [1,1], "TYPE:", "Dot", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
        };
        
    };
};

CQBpositions = _positions;
Publicvariable "CQBpositions";
};

if !(isserver) then {
private ["_positionslocal","_suspendedpositions","_idx"];

waituntil {!isnil "CQBpositions"};
_positionslocal = CQBpositions;
_suspendedpositions = [];

	while {true} do {
    
	   if (_debug) then {diag_log format["MSO-%1 CQB Population: Count all positions: %2 ", time, count _positionslocal]};
	   if (_debug) then {diag_log format["MSO-%1 CQB Population: Count suspended positions: %2 ", time, count _suspendedpositions]};

		{        
			if ((_x distance player < 400) && (((position player) select 2) < 5)) then {
				[_x] execvm "enemy\modules\HH_CQBpopulation\spawngrouplocal.sqf";
				_suspendedpositions set [count _suspendedpositions, _x];
            
	     	    _idx = [_positionslocal, _x] call BIS_fnc_arrayFindDeep;
 	     	    _idx = _idx select 0;
				_positionslocal set [_idx, ">REMOVE<"];
				_positionslocal = _positionslocal - [">REMOVE<"];
       		};
    	} foreach _positionslocal;
    
    sleep 5;
    
    	{        
        	if (_x distance player > 400) then {
           		_positionslocal set [count _positionslocal, _x];
            
           		_idx = [_suspendedpositions, _x] call BIS_fnc_arrayFindDeep;
            	_idx = _idx select 0;
				_suspendedpositions set [_idx, ">REMOVE<"];
				_suspendedpositions = _suspendedpositions - [">REMOVE<"];
       		};
    	} foreach _suspendedpositions;
	};
};
