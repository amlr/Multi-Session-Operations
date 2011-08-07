#include <crbprofiler.hpp>

//#squint filter Unknown variable MSO_FACTIONS
//#squint filter Unknown variable mso_core_fnc_initLocations
//#squint filter Unknown variable mso_core_fnc_selectRandomBias
//#squint filter Unknown variable mso_core_fnc_randomGroup
//#squint filter Unknown variable mso_core_fnc_createComposition
//#squint filter Unknown variable mso_core_fnc_createCompositionE
//#squint filter Careful - string searches using 'in' are case-sensitive
//#squint filter Unknown variable mso_core_fnc_addLoopHandler
//#squint filter Unknown variable mso_core_fnc_removeLoopHandler

if(!isServer) exitWith{};

private ["_debug","_d","_camp","_flag"];
_debug = false;
if(isNil "rmm_ep_intensity")then{rmm_ep_intensity = 1;};
rmm_ep_intensity = switch(rmm_ep_intensity) do {
	case 0: {
		1;
	};
	case 1: {
		1.5;
	};
	case 2: {
		3;
	};
	case 3: {
		1000;
	};
};

ep_dist = 2000;
ep_groups = [];
ep_total = 0;
ep_campprob = 0.25;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

diag_log format["MSO-%1 Enemy Population initLocations %2", time, count CRB_LOCS];
if(_debug) then {hint format["MSO-%1 Enemy Population initLocations %2", time, count CRB_LOCS];};

BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf";

fPlayersInside = {
        private["_pos","_dist"];
        _pos = _this select 0;
        _dist = _this select 1;
        ({_pos distance _x < _dist} count ([] call BIS_fnc_listPlayers) > 0);
};

{
        private ["_group","_pos","_type"];
        _group = grpNull;
        _type = "";
        _pos = [];
	_skip = false;

	if (_forEachIndex % rmm_ep_intensity < 1) then {
		_skip = true;
	};
        
        if(!([position _x, ep_dist] call fPlayersInside) && !_skip) then {
                if (type _x == "Hill") then {
                        if (random 1 > 0.33) then {
                                ep_total = ep_total + 1;
                                _d = 500;
                                _pos = [position _x, 0, _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                                _flag = random 1;
                                if(_flag < ep_campprob) then {
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
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8"];
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
					if (count _camp > 0) then {
	                                        _camp = _camp call BIS_fnc_selectRandom;
        	                                _pos = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                	                        [_camp, random 360, _pos] call f_builder;
					};
                                };
                                
                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[4,3,2,1]] call mso_core_fnc_selectRandomBias;
                                
                                [{
					CRBPROFILERSTART("RMM EnemyPop Hill")

                                        private ["_pos","_pos2","_flag","_group","_grp2","_type","_params","_handle"];
                                        _params = _this select 0;
                                        _handle = _this select 1;
                                        _pos = _params select 0;
                                        _flag = _params select 1;
                                        _type= _params select 2;
                                        if(([_pos, ep_dist] call fPlayersInside)) then {
                                                [_handle] call mso_core_fnc_removeLoopHandler;
                                                _group = nil;
                                                _pos2 = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                while{isNil "_group"} do {
                                                        _group = [_pos2, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                };
                                                (leader _group) setBehaviour "AWARE";
                                                _group setSpeedMode "LIMITED";
                                                _group setFormation "STAG COLUMN";
                                                if(_flag >= ep_campprob || count units _group <= 2) then {
                                                        [_group,_group,800,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
                                                };
                                                if(_flag < ep_campprob && _type == "Infantry") then {
                                                        leader _group setPos _pos;
                                                        [_group] call BIN_fnc_taskDefend;
                                                };
                                                if(_flag < ep_campprob && _type != "Infantry") then {
                                                        [_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
                                                        _grp2 = grpNull;
                                                        while{count units _grp2 <= 2} do {
                                                                {deleteVehicle _x} count units _grp2;
                                                                _grp2 = [_pos, "Infantry", MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        [_grp2] call BIN_fnc_taskDefend;
                                                        ep_groups set [count ep_groups, _grp2];
                                                };
                                                ep_groups set [count ep_groups, _group];
                                        };
					CRBPROFILERSTOP
                                }, 3, [_pos, _flag, _type]] call mso_core_fnc_addLoopHandler;
                        };
                };
                if (type _x in ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"]) then {
                        if (random 1 > 0.6) then {
                                ep_total = ep_total + 1;
                                _d = 800;
                                _pos = [position _x, 0, _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;			
                                _flag = random 1;
                                if(_flag < ep_campprob) then {
                                        _camp = [];
                                        if("RU" in MSO_FACTIONS) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1","fuel_dump_ru1","vehicle_park_ru1","weapon_store_ru1"];
                                        };
                                        if("BIS_TK" in MSO_FACTIONS) then {
                                                _camp = _camp + ["anti-air_tk1","camp_tk1","camp_tk2","firebase_tk1","heli_park_tk1","mediumtentcamp2_tk","mediumtentcamp3_tk","mediumtentcamp_tk","radar_site_tk1","fuel_dump_tk1","vehicle_park_tk1","weapon_store_tk1"];
                                        };
                                        if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
                                        if("RU" in MSO_FACTIONS && type _x == "Airport") then {
                                                _camp = ["airplane_park_ru1"];
                                        };
                                        if("BIS_TK" in MSO_FACTIONS && type _x == "Airport") then {
                                                _camp = ["airplane_park_tk1"];
                                        };
                                        _camp = _camp call BIS_fnc_selectRandom;
                                        _pos = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                        [_camp, random 360, _pos] call f_builder;
                                };
                                
                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,6,3,1]] call mso_core_fnc_selectRandomBias;
                                
                                [{
					CRBPROFILERSTART("RMM EnemyPop Strategic")

                                        private ["_pos","_pos2","_flag","_group","_grp2","_type","_params","_handle"];
                                        _params = _this select 0;
                                        _handle = _this select 1;
                                        _pos = _params select 0;
                                        _flag = _params select 1;
                                        _type= _params select 2;
                                        if(([_pos, ep_dist] call fPlayersInside)) then {
                                                [_handle] call mso_core_fnc_removeLoopHandler;
                                                _group = nil;
                                                _pos2 = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                while{isNil "_group"} do {
                                                        _group = [_pos2, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                };
                                                (leader _group) setBehaviour "COMBAT";
                                                _group setSpeedMode "LIMITED";
                                                _group setFormation "DIAMOND";
                                                if(_flag >= ep_campprob || count units _group <= 2) then {
                                                        [_group,_group,800,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [240,400,560]] call CBA_fnc_taskPatrol;
                                                };
                                                if(_flag < ep_campprob && _type == "Infantry") then {
                                                        leader _group setPos _pos;
                                                        [_group] call BIN_fnc_taskDefend;
                                                };
                                                if(_flag < ep_campprob && _type != "Infantry") then {
                                                        [_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
                                                        _grp2 = grpNull;
                                                        while{count units _grp2 <= 2} do {
                                                                {deleteVehicle _x} count units _grp2;
                                                                _grp2 = [_pos, "Infantry", MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        [_grp2] call BIN_fnc_taskDefend;
                                                        ep_groups set [count ep_groups, _grp2];
                                                };
                                        };
                                        ep_groups set [count ep_groups, _group];
					CRBPROFILERSTOP
                                }, 3, [_pos, _flag, _type]] call mso_core_fnc_addLoopHandler;
                        };
                };
                if (type _x in ["FlatArea", "FlatAreaCity","FlatAreaCitySmall","CityCenter","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"]) then {
                        if (random 1 > 0.8) then {
                                ep_total = ep_total + 1;
                                _d = 400;
                                _pos = [position _x, 0,  _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;			
                                _flag = random 1;
                                if(_flag < ep_campprob) then {
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
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
					if (count _camp > 0) then {
	                                        _camp = _camp call BIS_fnc_selectRandom;
        	                                _pos = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                	                        [_camp, random 360, _pos] call f_builder;
					};
                                };
                                
                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[4,3,2,1]] call mso_core_fnc_selectRandomBias;
                                
                                [{
					CRBPROFILERSTART("RMM EnemyPop FlatArea")

                                        private ["_pos","_pos2","_flag","_group","_grp2","_type","_params","_handle"];
                                        _params = _this select 0;
                                        _handle = _this select 1;
                                        _pos = _params select 0;
                                        _flag = _params select 1;
                                        _type= _params select 2;
                                        if(([_pos, ep_dist] call fPlayersInside)) then {
                                                [_handle] call mso_core_fnc_removeLoopHandler;
                                                _group = nil;
                                                _pos2 = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                while{isNil "_group"} do {
                                                        _group = [_pos2, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                };
                                                (leader _group) setBehaviour "COMBAT";
                                                _group setSpeedMode "LIMITED";
                                                _group setFormation "DIAMOND";
                                                if(_flag >= ep_campprob || count units _group <= 2) then {
                                                        [_group,_group,400,4 + random 4, "MOVE", "COMBAT", "RED", "LIMITED", "DIAMOND", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [360,520,680]] call CBA_fnc_taskPatrol;
                                                };
                                                if(_flag < ep_campprob && _type == "Infantry") then {
                                                        leader _group setPos _pos;
                                                        [_group] call BIN_fnc_taskDefend;
                                                };
                                                if(_flag < ep_campprob && _type != "Infantry") then {
                                                        [_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
                                                        _grp2 = grpNull;
                                                        while{count units _grp2 <= 2} do {
                                                                {deleteVehicle _x} count units _grp2;
                                                                _grp2 = [_pos, "Infantry", MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        [_grp2] call BIN_fnc_taskDefend;
                                                        ep_groups set [count ep_groups, _grp2];
                                                };
                                        };
                                        ep_groups set [count ep_groups, _group];
					CRBPROFILERSTOP
                                }, 3, [_pos, _flag, _type]] call mso_core_fnc_addLoopHandler;
                        };
                };
                if (type _x in ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]) then {
                        if (random 1 > 0.9) then {
                                ep_total = ep_total + 1;
                                _d = 300;
                                _pos = [position _x, 0,  _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                                _flag = random 1;
                                if(_flag < ep_campprob) then {
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
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
					if (count _camp > 0) then {
	                                        _camp = _camp call BIS_fnc_selectRandom;
        	                                _pos = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                	                        [_camp, random 360, _pos] call f_builder;
					};
                                };
                                
                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,6,3,1]] call mso_core_fnc_selectRandomBias;
                                
                                [{
					CRBPROFILERSTART("RMM EnemyPop ViewPoint")

                                        private ["_pos","_pos2","_flag","_group","_grp2","_type","_params","_handle"];
                                        _params = _this select 0;
                                        _handle = _this select 1;
                                        _pos = _params select 0;
                                        _flag = _params select 1;
                                        _type= _params select 2;
                                        if(([_pos, ep_dist] call fPlayersInside)) then {
                                                [_handle] call mso_core_fnc_removeLoopHandler;
                                                _group = nil;
                                                _pos2 = [_pos, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                while{isNil "_group"} do {
                                                        _group = [_pos2, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                };
                                                (leader _group) setBehaviour "STEALTH";
                                                _group setSpeedMode "LIMITED";
                                                _group setFormation "DIAMOND";
                                                if(_flag >= ep_campprob || count units _group <= 2) then {
                                                        [_group,_group,100,4 + random 4, "MOVE", "STEALTH", "RED", "LIMITED", "DIAMOND", "", [480,800,1120]] call CBA_fnc_taskPatrol;
                                                };
                                                if(_flag < ep_campprob && _type == "Infantry") then {
                                                        leader _group setPos _pos;
                                                        [_group] call BIN_fnc_taskDefend;
                                                };
                                                if(_flag < ep_campprob && _type != "Infantry") then {
                                                        [_group,_group,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
                                                        _grp2 = grpNull;
                                                        while{count units _grp2 <= 2} do {
                                                                {deleteVehicle _x} count units _grp2;
                                                                _grp2 = [_pos, "Infantry", MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        [_grp2] call BIN_fnc_taskDefend;
                                                        ep_groups set [count ep_groups, _grp2];
                                                };
                                        };
                                        ep_groups set [count ep_groups, _group];
					CRBPROFILERSTOP
                                }, 3, [_pos, _flag, _type]] call mso_core_fnc_addLoopHandler;
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
                        _m = [_t, _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _type, "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                };
        };
} foreach CRB_LOCS;

diag_log format["MSO-%1 Enemy Population # %2", time, ep_total];
if(_debug)then{hint format["MSO-%1 Enemy Population # %2", time, ep_total];};