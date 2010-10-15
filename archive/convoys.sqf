_paths = [
	["r1"]+["r3","r4","r5"]+["r9","r10"],
	["r1"]+["r3","r4","r5"]+["r6","r7","r8"],
	["r2"]+["r3","r4","r5"]+["r6","r7","r8"],
	["r8","r7","r6"]+["r9","r10"]
];
//add reverse paths aswell
_pathsR = [];
for "_i" from 0 to ((count _paths)-1) do {
	private "_x";
	_x = _paths select _i;
	_pathsR set [_i,[]];
	for "_k" from ((count _x)-1) to 0 step -1 do {
		(_pathsR select _i) set [-_k + ((count _x)-1),_x select _k];
	};
};
_paths = _paths + _pathsR;
_convoys = [
	["Pickup_PK_TK_GUE_EP1","V3S_Supply_TK_GUE_EP1","V3S_Supply_TK_GUE_EP1"],
	["Pickup_PK_TK_GUE_EP1","V3S_Supply_TK_GUE_EP1","V3S_TK_GUE_EP1"],
	["Pickup_PK_TK_GUE_EP1","V3S_TK_GUE_EP1","Offroad_SPG9_TK_GUE_EP1"],
	["Pickup_PK_TK_GUE_EP1","Ural_ZU23_TK_GUE_EP1","Pickup_PK_TK_GUE_EP1"]
];
while {true} do {
	sleep (random 14400);
	if (playersnumber west > 0) then {
		private ["_path","_convoy","_group","_start"];
		_path = _paths call BIS_fnc_selectRandom;
		_convoy = _convoys call BIS_fnc_selectRandom;
		_group = createGroup resistance;
		_start = (_path select 0) call RMM_fnc_getpos;
		{
			[[_start,100] call RMM_fnc_randPos, 0, _x, _group] call BIS_fnc_spawnVehicle;
		} foreach _convoy;
		_group setFormation "COLUMN";
		for "_i" from 1 to ((count _paths) - 1) do {
			_group addwaypoint [(_path select _i) call RMM_fnc_getpos, 0];
		};
		_group spawn {
			private "_count";
			_count = count (waypoints _this);
			while {not isnull _this} do {
				if ({alive _x} count (units _this) == 0) exitwith {deletegroup _this;};
				if (currentwaypoint _this == _count) exitwith {
					{if (vehicle _x != _x) then {(vehicle _x) call RMM_fnc_Deleteentity;}} foreach (units _this);
					_this call RMM_fnc_deleteentity;
				};
				sleep 2;
			};
		};
	};
};