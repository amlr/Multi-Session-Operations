private ["_list"];
_list = nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["FlatArea","Hill","FlatAreaCitySmall","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"], 20000];

#include <takistan_cfglocations.sqf>
#include <cfg_groups.sqf>

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