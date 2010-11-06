private ["_list"];
_list = nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["FlatArea","Hill","FlatAreaCitySmall","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"], 20000];

{createLocation ["Airport",_x,1,1]} foreach [[8223.19,2061.85,0],[5930.27,11448.6,0]];
{createLocation ["Hill",_x,1,1]} foreach [[8920.66,714.553,0],[10319.4,1218.97,0],[12581.9,2178.44,0],[11685.9,991.194,0],[11618.2,4436.46,0],[11028.5,4835.42,0],[2452.82,1939.11,0],[647.538,1643.94,0],[10225.3,8232.91,0],[11674.3,6853.18,0],[12789,7618.6,0],[12184.7,6021.2,0],[1275.98,9420.36,0],[513.379,11028.7,0],[1113.06,8122.78,0],[2371.7,6577.14,0],[1060.01,6651.81,0],[4536.94,7755.62,0],[2295.62,9966.96,0],[2570.21,3192.34,0],[252.362,3600.79,0],[246.873,4723.34,0],[1339.24,4838.62,0],[239.294,8757.12,0],[12642.3,8997.8,0],[12576.9,12244.5,0],[7286.22,7497.08,0]];
{createLocation ["CityCenter",_x,1,1]} foreach [[12313.5,11114.6,0],[10399.5,10995.1,0],[4170.93,10750.5,0],[5699.74,9955.47,0],[5952.89,10510.5,0],[6798.94,8916.04,0],[3232.02,3590.37,0],[3558.18,1298.96,0],[11835,2606.36,0],[6825.74,12253.1,0],[3558.18,1298.96,0],[1994.64,363.664,0],[375.252,2820.15,0],[1007.07,3141.99,0],[1491.9,3587.9,0],[2512.47,5097.5,0],[12318.6,10355.2,0],[6496.12,2108.43,0],[8999.51,1875.36,0]];
{createLocation ["VegetationBroadleaf",_x,1,1]} foreach [[9640.95,6525.55,0],[10520.5,11069.6,0],[11911.9,11404.1,0],[6560.22,8974.16,0],[6779.77,6447.93,0],[4720.27,6736.85,0],[1438.47,6471.23,0],[1792.54,7291.65,0],[1114.61,6998.03,0],[1427.67,7865.95,0],[3327.58,8157.63,0],[2817.08,7842,0],[3398.73,10150.9,0],[3754.9,10505.1,0],[4122.55,10924.5,0],[2099.97,11448.4,0],[1929.8,10896.7,0],[1295.79,10482.3,0],[771.562,10471.3,0],[1449.49,11152,0],[1636.12,11700.9,0],[4611.67,12356,0],[6060.86,10697.6,0],[5819.05,10129.8,0],[5540.54,9490.73,0],[5880.46,8095.92,0],[5899.95,6356.44,0],[5105.43,5415.11,0],[4153.31,4450.04,0],[3213.64,3635.48,0],[4155.61,2329.04,0],[6787.2,1170.57,0],[7256.12,1237.37,0],[7490.13,1797.91,0],[9947.27,2324.41,0],[11123.1,2416.85,0],[11989.9,2868.59,0],[9527.37,3125.18,0],[8554.62,2993.05,0],[7855.69,3268.79,0],[9372.79,4572.87,0],[8917.63,4224.71,0],[1002.54,3143.03,0],[919.325,4241.86,0],[2718.33,871.307,0],[5043.3,860.979,0],[5873.79,1441.81,0],[5872.73,5710.01,0],[9290.46,10049.5,0],[9300.97,9215.94,0],[9311.09,12159,0],[11603.3,10190.1,0],[12600.1,11069.8,0],[12324.8,11113.6,0]];

_func_groupSpawn = {
	private ["_max","_idx","_grp"];
	_max = 0; _idx = 0;
	for "_i" from 0 to (count (_this select 0) - 1) do {
		private ["_rand"];
		_rand = random (_this select 0 select _i);
		if (_rand > _max) then {
			_max = _rand;
			_idx = _i;
		};
	};
	_grp = [_this select 1, resistance, [TK_GUE_Group,TK_GUE_GroupWeapons,TK_GUE_Patrol,TK_GUE_ATTeam,TK_GUE_AATeam,TK_GUE_SniperTeam,TK_GUE_Technicals,TK_GUE_MotorizedPatrol,TK_GUE_MotorizedGroup,TK_GUE_MechanizedPatrol,TK_GUE_MechanizedGroup,TK_GUE_T34Platoon,TK_GUE_T55Section] select _idx] call BIS_fnc_SpawnGroup;
	if (_idx < 3) then {
		_grp call TK_fnc_takibani;
	};
	_grp;
};

private "_groups";
_groups = [];
{
	private "_group";
	_group = grpNull;
	if (type _x == "Hill") then {
		for "_i" from 0 to random 4 do {
			_group = [[
				4,//TK_GUE_Group(8x),
				4,//TK_GUE_GroupWeapons(6x),
				4,//TK_GUE_Patrol(5*),
				3,//TK_GUE_ATTeam(4*),
				1,//TK_GUE_AATeam(3*),
				1,//TK_GUE_SniperTeam(2*),
				1,//TK_GUE_Technicals (2*Technicals),
				0,//TK_GUE_MotorizedPatrol (BTR40),
				0,//TK_GUE_MotorizedGroup (Ural w/Inf),
				1,//TK_GUE_MechanizedPatrol (BDRM2),
				0,//TK_GUE_MechanizedGroup (2*BTR40),
				0,//TK_GUE_T34Platoon(4*T34s),
				0//TK_GUE_T55Section(2*T55s)
			],[_x,500] call CBA_fnc_randPos] call _func_groupSpawn;
			(leader _group) setBehaviour "AWARE";
			_group setSpeedMode "LIMITED";
			_group setFormation "STAG COLUMN";
			[_group,_group,800,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
			_groups set [count _groups, _group];
		};
	};
	if (type _x == "FlatArea") then {
		if (random 1 > 0.3) then {
			_group = [[
				2,//TK_GUE_Group(8x),
				2,//TK_GUE_GroupWeapons(6x),
				6,//TK_GUE_Patrol(5*),
				5,//TK_GUE_ATTeam(4*),
				1,//TK_GUE_AATeam(3*),
				2,//TK_GUE_SniperTeam(2*),
				4,//TK_GUE_Technicals (2*Technicals),
				2,//TK_GUE_MotorizedPatrol (BTR40),
				1,//TK_GUE_MotorizedGroup (Ural w/Inf),
				1,//TK_GUE_MechanizedPatrol (BDRM2),
				1,//TK_GUE_MechanizedGroup (2*BTR40),
				1,//TK_GUE_T34Platoon(4*T34s),
				3//TK_GUE_T55Section(2*T55s)
			],[_x,800] call CBA_fnc_randPos] call _func_groupSpawn;
			(leader _group) setBehaviour "COMBAT";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			[_group,_group,800,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [240,400,560]] call CBA_fnc_taskPatrol;
			_groups set [count _groups, _group];
		};
	};
	if (type _x == "FlatAreaCitySmall") then {
		if (random 1 > 0.9) then {
			_group = [[
				0,//TK_GUE_Group(8x),
				0,//TK_GUE_GroupWeapons(6x),
				3,//TK_GUE_Patrol(5*),
				4,//TK_GUE_ATTeam(4*),
				0,//TK_GUE_AATeam(3*),
				0,//TK_GUE_SniperTeam(2*),
				2,//TK_GUE_Technicals (2*Technicals),
				0,//TK_GUE_MotorizedPatrol (BTR40),
				1,//TK_GUE_MotorizedGroup (Ural w/Inf),
				0,//TK_GUE_MechanizedPatrol (BDRM2),
				0,//TK_GUE_MechanizedGroup (2*BTR40),
				0,//TK_GUE_T34Platoon(4*T34s),
				0//TK_GUE_T55Section(2*T55s)
			],[_x,400] call CBA_fnc_randPos] call _func_groupSpawn;
			(leader _group) setBehaviour "COMBAT";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			[_group,_group,400,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [360,520,680]] call CBA_fnc_taskPatrol;
			_groups set [count _groups, _group];
		};
	};
	if (type _x in ["VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]) then {
		if (random 1 > 0.98) then {
			_group = [[
				3,//TK_GUE_Group(8x),
				4,//TK_GUE_GroupWeapons(6x),
				1,//TK_GUE_Patrol(5*),
				2,//TK_GUE_ATTeam(4*),
				0,//TK_GUE_AATeam(3*),
				0,//TK_GUE_SniperTeam(2*),
				0,//TK_GUE_Technicals (2*Technicals),
				0,//TK_GUE_MotorizedPatrol (BTR40),
				0,//TK_GUE_MotorizedGroup (Ural w/Inf),
				0,//TK_GUE_MechanizedPatrol (BDRM2),
				0,//TK_GUE_MechanizedGroup (2*BTR40),
				0,//TK_GUE_T34Platoon(4*T34s),
				0//TK_GUE_T55Section(2*T55s)
			],[_x,300] call CBA_fnc_randPos] call _func_groupSpawn;
			(leader _group) setBehaviour "STEALTH";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			[_group,_group,100,4 + random 4, "MOVE", "STEALTH", "RED", "LIMITED", "DIAMOND", "", [480,800,1120]] call CBA_fnc_taskPatrol;
			_groups set [count _groups, _group];
		};
	};
	if (count _groups > 72) then {
		private "_logic";
		_logic = (createGroup sideLogic) createUnit ["Logic",[0,0,0],[],0,"NONE"];
		{
			if (not isnull _x) then {
				_logic synchronizeObjectsAdd [leader _x];
			};
		} foreach _groups;
		[_logic] execfsm "fsm\freezer.fsm";
		waituntil {count allgroups < 44};
		_groups = [];
	};
} foreach _list;

if (count _groups > 0) then {
	private "_logic";
	_logic = (createGroup sideLogic) createUnit ["Logic",[0,0,0],[],0,"NONE"];
	{
		if (not isnull _x) then {
			_logic synchronizeObjectsAdd [leader _x];
		};
	} foreach _groups;
	[_logic] execfsm "fsm\freezer.fsm";
};