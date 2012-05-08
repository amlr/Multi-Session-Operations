if (isnil "CQB_spawn") then {CQB_spawn = 1};
if (CQB_spawn == 0) exitwith {diag_log format["MSO-%1 CQB Population turned off! Exiting...", time]};

_debug = debug_mso;

if (isnil "BIN_fnc_taskDefend") then {BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf"};
if (isnil "BIN_fnc_taskPatrol") then {BIN_fnc_taskPatrol = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskPatrol.sqf"};
if (isnil "BIN_fnc_taskSweep") then {BIN_fnc_taskSweep = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskSweep.sqf"};

if (isserver) then {
private ["_spawnhouses","_housecount","_positions","_position","_t","_m","_cqb_spawn_intensity"];

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";
if (isnil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

mso_fnc_getEnterableHouses = {
// Written by BON_IF
// Adapted by EightySix

private ['_position','_radius'];

_position = _this select 0;
_radius = _this select 1;
_houses = nearestObjects[_position,["House"],_radius];
_houses_enterable=[];
{	_house = _x;
	_i = 0;
	While{count ((_house buildingPos _i)-[0]) > 0} do {_i = _i+1};
	_maxbuildingpos = _i - 1;

	if(_maxbuildingpos>0) then{_houses_enterable = _houses_enterable + [[_house,_maxbuildingpos]]};
} foreach _houses;

_houses_enterable
};


_spawnhouses = [markerpos "ammo_1",CRB_LOC_DIST] call mso_fnc_getEnterableHouses;
_housecount = count _spawnhouses;
if (_debug) then {diag_log format["MSO-%1 CQB Population: Houses found %2", time, _housecount]};

_positions = [];
_position = position ((_spawnhouses select 0) select 0);
_positions set [count _positions, _position];

_cqb_spawn_intensity = 1 - (cqb_spawn / 10);

_i = 0;
for "_i" from 0 to (_housecount-1) do {
    _position = position ((_spawnhouses select _i) select 0);
    
    if (((random 1) > _cqb_spawn_intensity) && ((_position distance _base1) > rmm_ep_safe_zone) && ((_position distance _base2) > rmm_ep_safe_zone)) then {
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

	[_debug] spawn {

		private ["_positionslocal","_suspendedpositions","_debug","_idx","_loopcounter"];
		
		waituntil {!isnil "CQBpositions"};
		CQBpositionsLocal = CQBpositions;
		CQBsuspendedposLocal = [];
        CQBgroupsLocal = [];
        CQBclearedpos = [];
		_debug = _this select 0;
		
		while {true} do {
			{        
				if ((_x distance player < 400) && (((position player) select 2) < 5)) then {
					[_x] execvm "enemy\modules\CQB_POP\spawngrouplocal.sqf";
					CQBsuspendedposLocal set [count CQBsuspendedposLocal, _x];
				
					_idx = [CQBpositionsLocal, _x] call BIS_fnc_arrayFindDeep;
					_idx = _idx select 0;
					CQBpositionsLocal set [_idx, ">REMOVE<"];
					CQBpositionsLocal = CQBpositionsLocal - [">REMOVE<"];
				};
			} foreach CQBpositionsLocal;
			sleep 5;
        	{
            	if (count (units _x) == 0) then {
		   			if (_debug) then {
              	 		diag_log format["MSO-%1 CQB Population: Garbage collecter deleting Group %2...", time, _x];
		   				diag_log format["MSO-%1 CQB Population: Count %2 local AI in %4 CQB-groups (%3 total AI overall)...", time, {local _x} count allUnits, count allUnits, count CQBgroupsLocal];
                        diag_log format["MSO-%1 CQB Population: %2 total | %3 suspended |%4 cleared positions...", time, count CQBpositionsLocal, count CQBsuspendedposLocal, count CQBclearedpos];
           			};
            	    CQBgroupsLocal = CQBgroupsLocal - [_x];
           		    deletegroup _x;
                };
        	} foreach CQBgroupsLocal;
		};
	};
};
