private ["_spawnhouses","_housecount","_positions","_position","_t","_m","_cqb_spawn_intensity"];

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";
if (isnil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

MSO_fnc_getEnterableHouses = {
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

_spawnhouses = [markerpos "ammo_1",CRB_LOC_DIST] call MSO_fnc_getEnterableHouses;
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

_positions;