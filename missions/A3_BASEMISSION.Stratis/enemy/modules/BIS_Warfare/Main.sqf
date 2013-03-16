private ["_VictoryTime","_VictoryScore","_VictoryTowns","_CapturableTowns","_FasterTime","_MinStartingDistance","_MiscSettings","_NeutralOpposition","_SideColorScheme","_StartTime","_Support","_TownSpawnRange","_TownSpawnTime","_GameMode","_LimitedWarfare"];

if(isNil "CRB_LOCS") then {
	CRB_LOCS = [] call mso_core_fnc_initLocations;
};

if(isNil "paramsArray") then {
	_VictoryTime = -1;
	_VictoryScore = -1;
	_VictoryTowns = -1;
	_CapturableTowns = -1;
	_FasterTime = 0;
	_MinStartingDistance = 2500;
	_MiscSettings = 2;
	_NeutralOpposition = 0;
	_SideColorScheme = 0;
	_StartTime = -1;
	_Support = 4;
	_TownSpawnRange = 0;
	_TownSpawnTime = 0;
	_GameMode = 1;
	_LimitedWarfare = 0;
	paramsArray = [
		_VictoryTime,
		_VictoryScore,
		_VictoryTowns,
		_CapturableTowns,
		_FasterTime,
		_MinStartingDistance,
		_MiscSettings,
		_NeutralOpposition,
		_SideColorScheme,
		_StartTime,
		_Support,
		_TownSpawnRange,
		_TownSpawnTime,
		_GameMode,
		_LimitedWarfare
	];
};

