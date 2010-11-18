if(!isServer) exitWith{};

_debug = false;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
	CRB_LOCS = [] call CRB_fnc_initLocations;
};

//		_grp call TK_fnc_takibani;

private "_groups";
_fnc_randomGroup = compile preprocessFileLineNumbers "crB_scripts\crB_randomGroup.sqf";
_groups = [];
sleep 120;

{
	private "_group";
	_group = grpNull;
	if (type _x == "Hill") then {
		_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,2,1,0]] call BIS_fnc_selectRandomWeighted;
		_pos = [_x,500] call CBA_fnc_randPos;
		_group = [_pos, _type, "BIS_TK"] call _fnc_randomGroup;
		(leader _group) setBehaviour "AWARE";
		_group setSpeedMode "LIMITED";
		_group setFormation "STAG COLUMN";
		[_group,_group,800,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
		_groups set [count _groups, _group];
	};
	if (type _x == "FlatArea") then {
		if (random 1 > 0.3) then {
			_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[10,6,2,1]] call BIS_fnc_selectRandomWeighted;
			_pos = [_x,800] call CBA_fnc_randPos;
			_group = [_pos, _type, "BIS_TK"] call _fnc_randomGroup;
			(leader _group) setBehaviour "COMBAT";
			_group setSpeedMode "LIMITED";
			_group setFormation "DIAMOND";
			[_group,_group,800,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [240,400,560]] call CBA_fnc_taskPatrol;
			_groups set [count _groups, _group];
		};
	};
	if (type _x == "FlatAreaCitySmall") then {
		if (random 1 > 0.9) then {
			_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[3,2,0,0]] call BIS_fnc_selectRandomWeighted;
			_pos = [_x,400] call CBA_fnc_randPos;
			_group = [_pos, _type, "BIS_TK"] call _fnc_randomGroup;
			if(random 1 > 0.5) then {
				(leader _group) setBehaviour "COMBAT";
				_group setSpeedMode "LIMITED";
				_group setFormation "DIAMOND";
				[_group,_group,400,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [360,520,680]] call CBA_fnc_taskPatrol;
			} else {
				(leader _group) setBehaviour "CARELESS";
			};
			_groups set [count _groups, _group];
		};
	};
	if (type _x in ["VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]) then {
		if (random 1 > 0.98) then {
			_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,4,2,1]] call BIS_fnc_selectRandomWeighted;
			_pos = [_x,300] call CBA_fnc_randPos;
			_group = [_pos, _type, "BIS_TK"] call _fnc_randomGroup;
			if(random 1 > 0.5) then {			
				(leader _group) setBehaviour "STEALTH";
				_group setSpeedMode "LIMITED";
				_group setFormation "DIAMOND";
				[_group,_group,100,4 + random 4, "MOVE", "STEALTH", "RED", "LIMITED", "DIAMOND", "", [480,800,1120]] call CBA_fnc_taskPatrol;
			} else {
				(leader _group) setBehaviour "CARELESS";
			};
			_groups set [count _groups, _group];
		};
	};
	if (count _groups > 36) then {
		private "_logic";
		_logic = (createGroup sideLogic) createUnit ["Logic",[0,0,0],[],0,"NONE"];
		{
			if (not isnull _x) then {
				_logic synchronizeObjectsAdd [leader _x];
			};
		} foreach _groups;
		[_logic] execfsm "fsm\freezer.fsm";
//		waituntil {count allunits < 150};
		_groups = [];
	};
} foreach CRB_LOCS;

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
