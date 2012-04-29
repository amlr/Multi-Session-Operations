if (isnil "CQB_spawn") then {CQB_spawn = 1};
if (CQB_spawn == 0) exitwith {diag_log format["MSO-%1 CQB Population turned off! Exiting...", time]};

_debug = debug_mso;

if (isserver) then {
private ["_spawnhouses","_housecount","_positions","_position","_t","_m","_cqb_spawn_intensity"];

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";

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

		private ["_positionslocal","_suspendedpositions","_debug","_idx"];
		
		waituntil {!isnil "CQBpositions"};
		_positionslocal = CQBpositions;
		_suspendedpositions = [];
		_debug = _this select 0;
		
		while {true} do {
		
		   if (_debug) then {diag_log format["MSO-%1 CQB Population: Count all positions: %2 ", time, count _positionslocal]};
		   if (_debug) then {diag_log format["MSO-%1 CQB Population: Count suspended positions: %2 ", time, count _suspendedpositions]};

			{        
				if ((_x distance player < 400) && (((position player) select 2) < 5)) then {
					[_x] execvm "enemy\modules\CQB_POP\spawngrouplocal.sqf";
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
};
