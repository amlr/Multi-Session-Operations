_paths = [
	["r0_1","r0_2"]/*,"r0_3","r0_4","r0_5","r0_6","r0_7","r0_8","r0_9","r0_10"],
	["r1_1","r1_2","r1_3","r1_4","r1_5","r1_6","r1_7","r1_8","r1_9"],
	["r0_1","r0_2","r0_3","r0_4","r2_2","r2_3","r2_4","r2_5","r2_6","r2_7"],
	["r3_1","r3_2","r3_3","r3_4","r0_9","r0_8","r0_7","r0_6","r0_5","r1_5","r1_6","r1_7","r1_8","r1_9"],
	["r3_1","r3_2","r3_3","r3_4","r0_9","r0_8","r0_7","r0_6","r0_5","r1_5","r1_4","r1_3","r1_2","r1_1"],
	["r4_1","r4_2","r4_3","r4_4","r4_5","r4_6","r4_7","r4_8","r4_9","r4_10","r4_11","r4_12","r4_13","r0_3","r0_4","r0_5","r0_6","r0_7","r0_8","r0_9","r0_10"],
	["r3_8","r3_7","r3_6","r3_5","r0_2","r0_3","r0_4","r0_5","r0_6","r0_7","r0_8","r0_9","r0_10"],
	["r3_8","r3_7","r3_6","r3_5","r0_2","r0_3","r0_4","r0_5","r0_6","r1_5","r1_4","r1_3","r1_2","r1_1"]*/
];
_convoys = [
	["Pickup_PK_TK_GUE_EP1","V3S_Supply_TK_GUE_EP1","V3S_Supply_TK_GUE_EP1"],
	["Pickup_PK_TK_GUE_EP1","V3S_Supply_TK_GUE_EP1","V3S_TK_GUE_EP1"],
	["Pickup_PK_TK_GUE_EP1","V3S_TK_GUE_EP1","Offroad_SPG9_TK_GUE_EP1"],
	["Pickup_PK_TK_GUE_EP1","Ural_ZU23_TK_GUE_EP1","Pickup_PK_TK_GUE_EP1"],
	["Offroad_DSHKM_TK_GUE_EP1","V3S_Refuel_TK_GUE_EP1","V3S_TK_GUE_EP1","Offroad_DSHKM_TK_GUE_EP1"]
];
while {true} do {
	sleep (random 10);
	if (playersnumber west > 0) then {
		private ["_path","_convoy","_group","_start"];
		_path = _paths call BIS_fnc_selectRandom;
		_convoy = _convoys call BIS_fnc_selectRandom;
		_group = createGroup resistance;
		_start = (_path select 0) call RMM_fnc_getpos;
		{
			[[_start,50] call RMM_fnc_randPos, 0, _x, _group] call BIS_fnc_spawnVehicle;
		} foreach _convoy;
		_group setFormation "COLUMN";
		for "_i" from 1 to ((count _paths) - 1) do {
			_group addwaypoint [(_path select _i) call RMM_fnc_getpos, 0];
		};
		
		_group spawn {
			private "_count";
			_count = count (waypoints _this);
			player sidechat str [_group,(str currentwaypoint _this)];
			while {not isnull _this} do {
				player sidechat str [_group,(str currentwaypoint _this)];
				if ({alive _x} count (units _this) == 0) exitwith {deletegroup _this;};
				if (currentwaypoint _this == _count) exitwith {_this call RMM_fnc_deleteentity;};
				sleep 2;
			};
		};
	};
};