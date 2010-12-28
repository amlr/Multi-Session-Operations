if(!isServer) exitWith{};

private["_debug","_groups","_fnc_randomGroup","_d"];
_debug = false;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

if(_debug)then{hint "EnemyPop: initLocations";};

_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","FlatAreaCitySmall","CityCenter","Airport"];
_military = ["HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"];
_names = ["NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"];
_hills = ["Hill","ViewPoint","RockArea","BorderCrossing","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];

//		_group call TK_fnc_takibani;

_fnc_randomGroup = compile preprocessFileLineNumbers "scripts\crB_scripts\crB_randomGroup.sqf";
_groups = [];
_total = 0;
{
	private ["_group","_type","_pos"];
	_group = grpNull;
	_type = "";
	_pos = [];
	if (type _x == "Hill") then {
		_d = 500;
		_pos = [position _x, 0, _d / 2 + random _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
		_group = nil;
		while{isNil "_group"} do {
			_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[12,6,3,1]] call CRB_fnc_selectRandomBias;
			_group = [_pos, _type, MSO_FACTIONS] call _fnc_randomGroup;
		};
		(leader _group) setBehaviour "AWARE";
		_group setSpeedMode "LIMITED";
		_group setFormation "STAG COLUMN";
		if(random 1 > 0.5) then {
			[_group,_group,800,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
		} else {
			[_group,_group,800] call CBA_fnc_taskDefend;
		};
		_groups set [count _groups, _group];
	};
	if (type _x in ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"]) then {
		if (random 1 > 0.5) then {
			_d = 800;
			_pos = [position _x, 0, _d / 2 + random _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
			_group = nil;
			while{isNil "_group"} do {
				_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,6,3,1]] call CRB_fnc_selectRandomBias;
				_group = [_pos, _type, MSO_FACTIONS] call _fnc_randomGroup;
			};
			_group = _group;
			(leader _group) setBehaviour "COMBAT";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			if(random 1 > 0.5) then {
				[_group,_group,800,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [240,400,560]] call CBA_fnc_taskPatrol;
			} else {
				[_group,_group,800] call CBA_fnc_taskDefend;
			};
			_groups set [count _groups, _group];
		};
	};
	if (type _x in ["FlatArea", "FlatAreaCity","FlatAreaCitySmall","CityCenter","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"]) then {
		if (random 1 > 0.85) then {
			_d = 400;
			_pos = [position _x, 0,  _d / 2 + random _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
			_group = nil;
			while{isNil "_group"} do {
				_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[3,2,1,0]] call CRB_fnc_selectRandomBias;
				_group = [_pos, _type, MSO_FACTIONS] call _fnc_randomGroup;
			};
			_group = _group;
			(leader _group) setBehaviour "COMBAT";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			if(random 1 > 0.5) then {
				[_group,_group,400,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [360,520,680]] call CBA_fnc_taskPatrol;
			} else {
				[_group,_group,400] call CBA_fnc_taskDefend;
			};
			_groups set [count _groups, _group];
		};
	};
	if (type _x in ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]) then {
		if (random 1 > 0.9) then {
			_d = 300;
			_pos = [position _x, 0,  _d / 2 + random _d, 1, 0, 50, 0] call bis_fnc_findSafePos;
			_group = nil;
			while{isNil "_group"} do {
				_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[12,6,3,1]] call CRB_fnc_selectRandomBias;
				_group = [_pos, _type, MSO_FACTIONS] call _fnc_randomGroup;
			};
			_group = _group;
			(leader _group) setBehaviour "STEALTH";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			if(random 1 > 0.5) then {			
				[_group,_group,100,4 + random 4, "MOVE", "STEALTH", "RED", "LIMITED", "DIAMOND", "", [480,800,1120]] call CBA_fnc_taskPatrol;
			} else {
				[_group,_group,100] call CBA_fnc_taskDefend;
			};
			_groups set [count _groups, _group];
		};
	};
	if (_debug && count _pos != 0) then {
		private["_t","_m"];
		_t = format["op%1",floor(random 10000)];
		_m = [_t, _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _type, "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
	};

	if (count _groups > 72) then {
		private ["_logic"];
		_logic = (createGroup sideLogic) createUnit ["Logic",[0,0,0],[],0,"NONE"];
		{
			if (not isnull _x) then {
				_logic synchronizeObjectsAdd [leader _x];
			};
		} foreach _groups;
		[_logic] execfsm "fsm\freezer.fsm";
		sleep 30;
//		waituntil {count allunits < 150};
		_total = _total + count _groups;
		_groups = [];
	};
} foreach CRB_LOCS;

if (count _groups > 0) then {
	private ["_logic"];
	_logic = (createGroup sideLogic) createUnit ["Logic",[0,0,0],[],0,"NONE"];
	{
		if (not isnull _x) then {
			_logic synchronizeObjectsAdd [leader _x];
		};
	} foreach _groups;
	[_logic] execfsm "fsm\freezer.fsm";
	_total = _total + count _groups;
};

diag_log format["MSO-%1 Enemy Population # %2", time, _total];