RMM_supply_crates = [];

#define LOGISTICS	_this setvariable ["logistics",true,true]
//#define CLEAR	clearWeaponCargoGlobal _this; clearMagazineCargoGlobal _this
#define CLEAR	clearWeaponCargo _this; clearMagazineCargo _this

[[
	["BAF_Merlin_HC3_D",	1,	{CLEAR; LOGISTICS;}],
	["MtvrRepair_DES_EP1",	2,	{CLEAR;}],
	["MtvrRefuel_DES_EP1",	2,	{CLEAR;}],
	["MtvrReammo_DES_EP1",	2,	{CLEAR;}],
	["Misc_cargo_cont_net2",	8,	{RMM_supply_crates set [count RMM_supply_crates, _this]}],
	["BAF_VehicleBox",		4,	{CLEAR; _this setvehicleinit "this execvm ""scripts\ammocrate.sqf"""; processinitcommands;}],
	["USBasicAmmunitionBox_EP1", 10, {CLEAR;}],
	["BAF_Offroad_W",	8,	{CLEAR; LOGISTICS;}],
	["BAF_Jackal2_L2A1_D",	4,	{CLEAR; LOGISTICS;}],
	["Land_Pneu", 40, {}],
	["Barrel4", 20, {}],
	["M2StaticMG_US_EP1", 4, {}],
	["MK19_TriPod_US_EP1", 4, {}],
	["M252_US_EP1", 2, {}],
	["BAF_FV510_W", 2, {CLEAR; LOGISTICS;}],
	["M1030_US_DES_EP1", 20, {}]
],
	getmarkerpos "farp", //position
	markerdir "farp", //direction
	100 //row length (metres)
] call {
	private ["_array", "_position", "_offset", "_direction", "_distance"];
	_array = _this select 0;
	_position = _this select 1;
	_offset = [0,0,0];
	_direction = _this select 2;
	_distance = _this select 3;
	_max = 0;
	
	_fnc_offsetPos = {
		_a = _this select 0; _b = _this select 1;
		[(_a select 0) + (_b select 0),(_a select 1) + (_b select 1),(_a select 2) + (_b select 2)]
	};
	
	{
		player groupchat str _x;
		for "_i" from 1 to (_x select 1) do {
			private ["_v","_p","_s"];
			_p = [_position,_offset] call _fnc_offsetPos;
			_v = createvehicle [_x select 0, _p, [], 0, "NONE"];
			_v setposatl _p;
			_v setdir _direction;
			_v call (_x select 2);
			_s = sizeOf (_x select 0);
			if (_s > _max) then {
				_max = _s;
			};
			if (_v distance _position > _distance) then {
				_position set [0,(_position select 0) + (_max * (sin _direction))];
				_position set [1,(_position select 1) + (_max * (cos _direction))];
				_offset = [0,0,0];
				_max = 0;
			} else {
				_offset set [0,(_offset select 0) + _s * (cos _direction)];
				_offset set [1,(_offset select 1) + _s * (sin _direction)];
			};
		};
	} foreach _array;
};

publicvariable "RMM_supply_crates";