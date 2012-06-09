private ["_spawnhouses","_positions","_t","_m","_cqb_spawn_intensity","_BuildingTypeStrategic"];

_spawnhouses = _this select 0;

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";
if ((str(_base1) == "[0,0,0]") && (str(_base2) == "[0,0,0]")) then {_base1 = markerpos "respawn_west"};
if (isnil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

_positions = [];
_cqb_spawn_intensity = 1 - (cqb_spawn / 10);

_BuildingTypeStrategic = [
"Land_A_TVTower_Base",
"Land_Dam_ConcP_20",
"Land_Ind_Expedice_1",
"Land_Ind_SiloVelke_02",
"Land_Mil_Barracks",
"Land_Mil_Barracks_i",
"Land_Mil_Barracks_L",
"Land_Mil_Guardhouse",
"Land_Mil_House",
"Land_trafostanica_velka",
"Land_Ind_Oil_Tower_EP1",
"Land_A_Villa_EP1",
"Land_Mil_Barracks_EP1",
"Land_Mil_Barracks_i_EP1",
"Land_Mil_Barracks_L_EP1",
"Land_Barrack2",
"Land_fortified_nest_small_EP1",
"Land_fortified_nest_big_EP1",
"Land_Fort_Watchtower_EP1",
"Land_Ind_PowerStation_EP1",
"Land_Ind_PowerStation"];

{
    if (!(typeof (_x select 0) in _BuildingTypeStrategic) && ((random 1) > _cqb_spawn_intensity) && (((position (_x select 0)) distance _base1) > rmm_ep_safe_zone) && (((position (_x select 0)) distance _base2) > rmm_ep_safe_zone)) then {
    	_positions set [count _positions,_x];
    };
} foreach _spawnhouses;

if (_debug) then {
    diag_log format["MSO-%1 CQB Population: Regular positions found %2", time, count _positions];
    
    _i = 0;
	for "_i" from 0 to ((count _positions) - 1) do {
         _t = format["op%1",_i];
    	_m = [_t, position ((_positions select _i) select 0), "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorRed","GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
    };
};

_positions;