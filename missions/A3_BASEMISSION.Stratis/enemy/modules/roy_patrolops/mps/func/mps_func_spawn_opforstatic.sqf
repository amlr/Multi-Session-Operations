// Written by EightySix
// Derived from BON_IF

if(!isServer) exitWith {};
private ["_side","_strength","_unit","_allunits","_pos","_radius","_count","_inftype","_spawnpos"];

if(count _this < 1) exitWith{};

_pos = (_this select 0) call mps_get_position;
_side = (SIDE_B select 0);

sleep 0.5;
_ang = round random 360;
_radius = 30 + (random 40);
_a = (_pos select 0)+(sin(_ang)*_radius);
_b = (_pos select 1)+(cos(_ang)*_radius);
_mgpos = [ [_a,_b,0],10,0.1,2] call mps_getFlatArea;

if(not surfaceIsWater [_mgpos select 0, _mgpos select 1]) then{
	_mg = (["O_Mk6","O_Mk6"] call mps_getRandomElement) createVehicle _mgpos;
	_grp = [_mgpos,"INF",1,50] call CREATE_OPFOR_SQUAD;
	leader _grp moveInGunner _mg;
};
