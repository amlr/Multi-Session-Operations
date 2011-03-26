if(!isServer) exitWith{};

private["_debug","_d"];
_debug = false;
ep_dist = 2000;
ep_groups = [];
ep_total = 0;
_dist = 1000;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

diag_log format["MSO-%1 Enemy Population initLocations %2", time, count CRB_LOCS];
if(_debug) then {hint format["MSO-%1 Enemy Population initLocations %2", time, count CRB_LOCS];};

_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","FlatAreaCitySmall","CityCenter","Airport"];
_military = ["HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"];
_names = ["NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"];
_hills = ["Hill","ViewPoint","RockArea","BorderCrossing","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];

//		_group call TK_fnc_takibani;

CRB_fnc_randomGroup = compile preprocessFileLineNumbers "scripts\crB_scripts\crB_randomGroup.sqf";
BIN_fnc_taskDefend = compile preprocessFileLineNumbers "scripts\BIN_taskDefend.sqf";

fPlayersInside = {
	private["_pos","_dist"];
	_pos = _this select 0;
	_dist = _this select 1;
	({_pos distance _x < _dist} count ([] call BIS_fnc_listPlayers));
};

{
	private ["_group","_type","_pos"];
	_group = grpNull;
	_type = "";
	_pos = [];

	if(([position _x, _dist] call fPlayersInside) == 0) then {
		if (type _x == "Hill") then {
			if (random 1 > 0.33) then {
				ep_total = ep_total + 1;
				_d = 500;
				_pos = [position _x, 0, _d / 2 + random _d, 1, 0, 25, 0] call bis_fnc_findSafePos;
				_flag = random 1;
				if(_flag < 0.25) then {
					_camp = [];
					if("RU" in MSO_FACTIONS) then {
						_camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
					};
					if("INS" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_ins1","camp_ins2"];
					};
					if("GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["MediumTentCamp_napa","SmallTentCamp2_napa","SmallTentCamp_napa"];
					};
					if("BIS_TK" in MSO_FACTIONS) then {
						_camp = _camp + ["anti-air_tk1","camp_tk1","camp_tk2","firebase_tk1","heli_park_tk1","mediumtentcamp2_tk","mediumtentcamp3_tk","mediumtentcamp_tk","radar_site_tk1"];
					};
					if("BIS_TK_INS" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_militia1","camp_militia2"];
					};
					if("BIS_TK_GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["MediumTentCamp_local","SmallTentCamp2_local","SmallTentCamp_local"];
					};
					if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8"];
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createComposition.sqf";
					};
					if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8"];
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createCompositionE.sqf";
					};
					_camp = _camp call BIS_fnc_selectRandom;
					_pos = [_pos, 10, 50, 1, 0, 10, 0] call bis_fnc_findSafePos;
					[_camp, random 360, _pos] call f_builder;
				};

				[_pos, _flag] spawn {
					private["_pos","_flag","_group"];
					_pos = _this select 0;
					_flag = _this select 1;
					_group = nil;
					waitUntil{([_pos, ep_dist] call fPlayersInside) > 0};
					while{isNil "_group"} do {
						_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[12,6,3,1]] call CRB_fnc_selectRandomBias;
						_group = [_pos, _type, MSO_FACTIONS] call CRB_fnc_randomGroup;
					};
					(leader _group) setBehaviour "AWARE";
					_group setSpeedMode "LIMITED";
					_group setFormation "STAG COLUMN";
					if(_flag > 0.5 || count units _group <= 2) then {
						[_group,_group,800,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
					} else {
						if(_type == "Infantry") then {
							leader _group setPos _pos;
							[_group] call BIN_fnc_taskDefend;
						} else {
							[_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
							_grp2 = grpNull;
							while{count units _grp2 <= 2} do {
								{deleteVehicle _x} count units _grp2;
								_grp2 = [_pos, "Infantry", MSO_FACTIONS] call CRB_fnc_randomGroup;
							};
							[_grp2] call BIN_fnc_taskDefend;
							ep_groups set [count ep_groups, _grp2];
						};
					};
					ep_groups set [count ep_groups, _group];
				};
			};
		};
		if (type _x in ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"]) then {
			if (random 1 > 0.6) then {
				ep_total = ep_total + 1;
				_d = 800;
				_pos = [position _x, 0, _d / 2 + random _d, 1, 0, 25, 0] call bis_fnc_findSafePos;			
				_flag = random 1;
				if(_flag < 0.25) then {
					_camp = [];
					if("RU" in MSO_FACTIONS) then {
						_camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1","fuel_dump_ru1","vehicle_park_ru1","weapon_store_ru1"];
					};
					if("BIS_TK" in MSO_FACTIONS) then {
						_camp = _camp + ["anti-air_tk1","camp_tk1","camp_tk2","firebase_tk1","heli_park_tk1","mediumtentcamp2_tk","mediumtentcamp3_tk","mediumtentcamp_tk","radar_site_tk1","fuel_dump_tk1","vehicle_park_tk1","weapon_store_tk1"];
					};
					if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createComposition.sqf";
					};
					if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createCompositionE.sqf";
					};
					if("RU" in MSO_FACTIONS && type _x == "Airport") then {
						_camp = ["airplane_park_ru1"];
					};
					if("BIS_TK" in MSO_FACTIONS && type _x == "Airport") then {
						_camp = ["airplane_park_tk1"];
					};
					_camp = _camp call BIS_fnc_selectRandom;
					_pos = [_pos, 10, 50, 1, 0, 10, 0] call bis_fnc_findSafePos;
					[_camp, random 360, _pos] call f_builder;
				};

				[_pos, _flag] spawn {
					private["_pos","_flag","_group"];
					_pos = _this select 0;
					_flag = _this select 1;
					_group = nil;
					waitUntil{([_pos, ep_dist] call fPlayersInside) > 0};
					while{isNil "_group"} do {
						_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,6,3,1]] call CRB_fnc_selectRandomBias;
						_group = [_pos, _type, MSO_FACTIONS] call CRB_fnc_randomGroup;
					};
					(leader _group) setBehaviour "COMBAT";
					_group setSpeedMode "LIMITED";
					_group setFormation "DIAMOND";
					if(_flag > 0.5 || count units _group <= 2) then {
						[_group,_group,800,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [240,400,560]] call CBA_fnc_taskPatrol;
					} else {
						if(_type == "Infantry") then {
							leader _group setPos _pos;
							[_group] call BIN_fnc_taskDefend;
						} else {
							[_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
							_grp2 = grpNull;
							while{count units _grp2 <= 2} do {
								{deleteVehicle _x} count units _grp2;
								_grp2 = [_pos, "Infantry", MSO_FACTIONS] call CRB_fnc_randomGroup;
							};
							[_grp2] call BIN_fnc_taskDefend;
							ep_groups set [count ep_groups, _grp2];
						};
					};
				};
				ep_groups set [count ep_groups, _group];
			};
		};
		if (type _x in ["FlatArea", "FlatAreaCity","FlatAreaCitySmall","CityCenter","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"]) then {
			if (random 1 > 0.9) then {
				ep_total = ep_total + 1;
				_d = 400;
				_pos = [position _x, 0,  _d / 2 + random _d, 1, 0, 25, 0] call bis_fnc_findSafePos;			
				_flag = random 1;
				if(_flag < 0.25) then {
					_camp = [];
					if("RU" in MSO_FACTIONS) then {
						_camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
					};
					if("INS" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_ins1","camp_ins2"];
					};
					if("GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["MediumTentCamp_napa","SmallTentCamp2_napa","SmallTentCamp_napa"];
					};
					if("BIS_TK" in MSO_FACTIONS) then {
						_camp = _camp + ["anti-air_tk1","camp_tk1","camp_tk2","firebase_tk1","heli_park_tk1","mediumtentcamp2_tk","mediumtentcamp3_tk","mediumtentcamp_tk","radar_site_tk1"];
					};
					if("BIS_TK_INS" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_militia1","camp_militia2"];
					};
					if("BIS_TK_GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["MediumTentCamp_local","SmallTentCamp2_local","SmallTentCamp_local"];
					};
					if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createComposition.sqf";
					};
					if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createCompositionE.sqf";
					};
					_camp = _camp call BIS_fnc_selectRandom;
					_pos = [_pos, 10, 50, 1, 0, 10, 0] call bis_fnc_findSafePos;
					[_camp, random 360, _pos] call f_builder;
				};

				[_pos, _flag] spawn {
					private["_pos","_flag","_group"];
					_pos = _this select 0;
					_flag = _this select 1;
					_group = nil;
					waitUntil{([_pos, ep_dist] call fPlayersInside) > 0};
					while{isNil "_group"} do {
						_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[3,2,1,0]] call CRB_fnc_selectRandomBias;
						_group = [_pos, _type, MSO_FACTIONS] call CRB_fnc_randomGroup;
					};
					(leader _group) setBehaviour "COMBAT";
					_group setSpeedMode "LIMITED";
					_group setFormation "DIAMOND";
					if(_flag > 0.5 || count units _group <= 2) then {
						[_group,_group,400,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [360,520,680]] call CBA_fnc_taskPatrol;
					} else {
						if(_type == "Infantry") then {
							leader _group setPos _pos;
							[_group] call BIN_fnc_taskDefend;
						} else {
							[_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
							_grp2 = grpNull;
							while{count units _grp2 <= 2} do {
								{deleteVehicle _x} count units _grp2;
								_grp2 = [_pos, "Infantry", MSO_FACTIONS] call CRB_fnc_randomGroup;
							};
							[_grp2] call BIN_fnc_taskDefend;
							ep_groups set [count ep_groups, _grp2];
						};
						ep_groups set [count ep_groups, _group];
					};
				};
			};
		};
		if (type _x in ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]) then {
			if (random 1 > 0.95) then {
				ep_total = ep_total + 1;
				_d = 300;
				_pos = [position _x, 0,  _d / 2 + random _d, 1, 0, 25, 0] call bis_fnc_findSafePos;
				_flag = random 1;
				if(_flag < 0.25) then {
					_camp = [];
					if("RU" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_ru1","camp_ru2"];
					};
					if("INS" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_ins1","camp_ins2"];
					};
					if("GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["MediumTentCamp_napa","SmallTentCamp2_napa","SmallTentCamp_napa"];
					};
					if("BIS_TK" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_tk1","camp_tk2"];
					};
					if("BIS_TK_INS" in MSO_FACTIONS) then {
						_camp = _camp + ["camp_militia1","camp_militia2"];
					};
					if("BIS_TK_GUE" in MSO_FACTIONS) then {
						_camp = _camp + ["MediumTentCamp_local","SmallTentCamp2_local","SmallTentCamp_local"];
					};
					if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS) then {
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createComposition.sqf";
					};
					if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
						f_builder = compile preprocessfilelinenumbers "scripts\crB_scripts\crB_createCompositionE.sqf";
					};
					_camp = _camp call BIS_fnc_selectRandom;
					_pos = [_pos, 10, 50, 1, 0, 10, 0] call bis_fnc_findSafePos;
					[_camp, random 360, _pos] call f_builder;
				};

				[_pos, _flag] spawn {
					private["_pos","_flag","_group"];
					_pos = _this select 0;
					_flag = _this select 1;
					_group = nil;
					waitUntil{([_pos, ep_dist] call fPlayersInside) > 0};
					while{isNil "_group"} do {
						_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[12,6,3,1]] call CRB_fnc_selectRandomBias;
						_group = [_pos, _type, MSO_FACTIONS] call CRB_fnc_randomGroup;
					};
					(leader _group) setBehaviour "STEALTH";
					_group setSpeedMode "LIMITED";
					_group setFormation "DIAMOND";
					if(_flag > 0.5 || count units _group <= 2) then {
						[_group,_group,100,4 + random 4, "MOVE", "STEALTH", "RED", "LIMITED", "DIAMOND", "", [480,800,1120]] call CBA_fnc_taskPatrol;
					} else {
						if(_type == "Infantry") then {
							leader _group setPos _pos;
							[_group] call BIN_fnc_taskDefend;
						} else {
							[_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
							_grp2 = grpNull;
							while{count units _grp2 <= 2} do {
								{deleteVehicle _x} count units _grp2;
								_grp2 = [_pos, "Infantry", MSO_FACTIONS] call CRB_fnc_randomGroup;
							};
							[_grp2] call BIN_fnc_taskDefend;
							ep_groups set [count ep_groups, _grp2];
						};
					};
					ep_groups set [count ep_groups, _group];
				};
			};
		};
	};
	if (count _pos != 0) then {
		if(ep_total mod 10 == 0) then {
			diag_log format["MSO-%1 Enemy Population # %2", time, ep_total];
			if(_debug) then {hint format["MSO-%1 Enemy Population # %2", time, ep_total];};
		};
		if(_debug) then {
			private["_t","_m"];
			_t = format["op%1",floor(random 10000)];
			if(isNil "_type") then {_type = "";};
			_m = [_t, _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _type, "GLOBAL"] call CBA_fnc_createMarker;
			[_m, true] call CBA_fnc_setMarkerPersistent;
		};
	};
} foreach CRB_LOCS;

diag_log format["MSO-%1 Enemy Population # %2", time, ep_total];
if(_debug)then{hint format["MSO-%1 Enemy Population # %2", time, ep_total];};