private ["_spawnhouses","_housecount","_positions","_position","_t","_m","_cqb_spawn_intensity"];

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";

if (isnil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

MSO_fnc_getEnterableHouses = {
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

getGridPos = { 		
    private ["_pos","_x","_y"];
    
 	_pos = getPosATL _this; 
 	_x = _pos select 0;
 	_y = _pos select 1;
 	_x = _x - (_x % 100); 
 	_y = _y - (_y % 100); 
	[_x + 50, _y + 50, 0]
};

_spawnhouses = [markerpos "ammo_1",CRB_LOC_DIST] call MSO_fnc_getEnterableHouses;
_positions = [];
_cqb_spawn_intensity = 1 - (cqb_spawn / 10);

{
    if (((random 1) > _cqb_spawn_intensity) && (((position (_x select 0)) distance _base1) > rmm_ep_safe_zone) && (((position (_x select 0)) distance _base2) > rmm_ep_safe_zone)) then {
        _positions set [count _positions,_x]
        };
} foreach _spawnhouses;

if (_debug) then {
    diag_log format["MSO-%1 CQB Population: Houses found %2", time, count _positions];

    _i = 0;
	for "_i" from 0 to ((count _positions) - 1) do {
         _t = format["op%1",_i];
    	_m = [_t, position ((_positions select _i) select 0), "Icon", [1,1], "TYPE:", "Dot", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
    };
};

_positions;
