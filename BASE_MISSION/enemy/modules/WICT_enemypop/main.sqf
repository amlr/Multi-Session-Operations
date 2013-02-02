#include <crbprofiler.hpp>

//#squint filter Unknown variable MSO_FACTIONS
//#squint filter Unknown variable mso_core_fnc_initLocations
//#squint filter Unknown variable mso_core_fnc_selectRandomBias
//#squint filter Unknown variable mso_core_fnc_randomGroup
//#squint filter Unknown variable mso_core_fnc_createComposition
//#squint filter Unknown variable mso_core_fnc_createCompositionE
//#squint filter Careful - string searches using 'in' are case-sensitive


private ["_debug","_d","_camp","_flag","_WICTM","_WICTMN","_skip","_WICT_composition","_pos_WICTAP","_forEachIndex","_baselocations03","_baselocations06","_baselocations08","_baselocations09","_debugmarker"];
if(!isServer) exitWith{};

if(isNil "WICT_wict_header")then{WICT_wict_header = 1;};
if (WICT_wict_header == 0) exitWith{};

WICT_PATH = "enemy\modules\WICT_enemypop\";

_debug = debug_mso;

if(isNil "wict_ep_intensity")then{wict_ep_intensity = 1;};
wict_ep_intensity = switch(wict_ep_intensity) do {
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

if (isNil "wict_debugmodule") then {wict_debugmodule = 0};
_debugmarker = 	switch(wict_debugmodule) do {
        case 0: {
                "empty"
        };
        case 1: {
                "mil_circle";
        };
        case 2: {
                "mil_circle"
        };
};

if(isNil "wict_ep_campprob")then{wict_ep_campprob = 1};
wict_ep_campprob = switch(wict_ep_campprob) do {
        case 0: {
                0.25;
        };
        case 1: {
                0.5;
        };
        case 2: {
                0.8;
        };
        case 3: {
                1;
        };
};

ep_dist = 2000;
ep_groups = [];
ep_total = 0;
//wict_ep_campprob = 1;
WICTMC = 0;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

diag_log format["MSO-%1 WICT Population initLocations %2", time, count CRB_LOCS];
if(_debug) then {hint format["MSO-%1 WICT Population initLocations %2", time, count CRB_LOCS];};

BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf";

fPlayersInside = {
        private["_pos_WICT","_dist"];
        _pos_WICT = _this select 0;
        _dist = _this select 1;
        ({_pos_WICT distance _x < _dist} count ([] call BIS_fnc_listPlayers) > 0);
};

if(isNil "wict_baselocations")then{wict_baselocations = 0};

{
        private ["_group","_pos_WICT","_type"];
        _group = grpNull;
        _type = "";
        _pos_WICT = [];
        _skip = false;
        
        if (_forEachIndex % wict_ep_intensity < 1) then {
                _skip = true;
        };
        
        
        _baselocations03 = switch(wict_baselocations) do {
                
                // even
                case 0: {
                        ["Hill"];
                };
                //towns
                case 1: {
                        ["Hill","CityCenter", "City","FlatAreaCity","FlatAreaCitySmall","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"];
                };
                //countryside
                case 2: {
                        ["StrongpointArea"];
                };
                
        };
        
        _baselocations06 = switch(wict_baselocations) do {
                case 0: {
                        ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"];
                };
                case 1: {
                        ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"];
                };
                case 2: {
                        ["StrongpointArea"];
                };
                
        };
        
        _baselocations08 = switch(wict_baselocations) do {
                case 0: {
                        ["FlatArea","CityCenter","FlatAreaCity","FlatAreaCitySmall","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"];
                };
                case 1: {
                        ["FlatArea","NameMarine"];
                };
                case 2: {
                        ["StrongpointArea"];
                };
                
        };
        
        _baselocations09 = switch(wict_baselocations) do {
                case 0: {
                        ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
                };
                case 1: {
                        ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
                };
                case 2: {
                        ["StrongpointArea"];
                };
                
        };
        
        
        
        
        
        if(!([position _x, ep_dist] call fPlayersInside) && !_skip) then {
                if (type _x in _baselocations03) then {
                        if (random 1 > 0.33) then {
                                _d = 20;
                                _pos_WICT = [position _x, 0, _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                                _flag = random 1;
                                if(_flag < wict_ep_campprob) then {
                                        _camp = [];
                                        if("RU" in MSO_FACTIONS) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
                                        };
                                        if("INS" in MSO_FACTIONS) then {
                                                _camp = _camp + ["camp_ins1","camp_ins2"];
                                        };
                                        if("GUE" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
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
                                        if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS || "cwr2_ru" in MSO_FACTIONS || "cwr2_fia" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8"];
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
                                        if (count _camp == 0) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if (count _camp > 0) then {
                                                _camp = _camp call BIS_fnc_selectRandom;
                                                _pos_WICT = [_pos_WICT, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                //[_camp, random 360, _pos_WICT] call f_builder;
                                                _WICT_composition = [_pos_WICT, random 360, ["ru"]] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf"));
                                                
                                                call compile format ["_WICTMN = 'lightvehicles_%1'",WICTMC];
                                                _WICTM = createMarker [_WICTMN, _pos_WICT];
                                                _WICTM setMarkerShape "ICON";
                                                _WICTMN setMarkerType _debugmarker;
                                                _WICTMN setMarkerColor "ColorRed";
                                                WICTMC = WICTMC + 1;
                                                
                                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[4,3,2,1]] call mso_core_fnc_selectRandomBias;
                                                
                                                [_pos_WICT, _flag, _type] spawn {
                                                        private ["_pos_WICT","_pos2_WICT","_flag","_group","_type"];
                                                        _pos_WICT = _this select 0;
                                                        _flag = _this select 1;
                                                        _type= _this select 2;
                                                        waitUntil{sleep 3;([_pos_WICT, ep_dist] call fPlayersInside)};
                                                        _group = nil;
                                                        _pos2_WICT = [_pos_WICT, 10, 20, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                        
                                                        while{isNil "_group"} do {
                                                                _group = [_pos2_WICT, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        
                                                        (leader _group) setBehaviour "AWARE";
                                                        _group setSpeedMode "LIMITED";
                                                        _group setFormation "STAG COLUMN";
                                                        [_group] call BIN_fnc_taskDefend;
                                                        
                                                        ep_groups set [count ep_groups, _group];
                                                };
                                        };
                                };
                        };
                };
                if (type _x in _baselocations06) then {
                        if (random 1 > 0.6) then {
                                ep_total = ep_total + 1;
                                _d = 20;
                                _pos_WICT = [position _x, 0, _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;			
                                _flag = random 1;
                                if(_flag < wict_ep_campprob) then {
                                        _camp = [];
                                        if("RU" in MSO_FACTIONS) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1","fuel_dump_ru1","vehicle_park_ru1","weapon_store_ru1"];
                                        };
                                        if("BIS_TK" in MSO_FACTIONS) then {
                                                _camp = _camp + ["anti-air_tk1","camp_tk1","camp_tk2","firebase_tk1","heli_park_tk1","mediumtentcamp2_tk","mediumtentcamp3_tk","mediumtentcamp_tk","radar_site_tk1","fuel_dump_tk1","vehicle_park_tk1","weapon_store_tk1"];
                                        };
                                        if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS || "cwr2_ru" in MSO_FACTIONS || "cwr2_fia" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
                                        if("RU" in MSO_FACTIONS && type _x == "Airport") then {
                                                _camp = ["airplane_park_ru1"];
                                                
                                                _pos_WICTAP = [_pos_WICT, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                call compile format ["_WICTMN = 'airCavalry_%1'",WICTMC];
                                                _WICTM = createMarker [_WICTMN, _pos_WICTAP];
                                                _WICTM setMarkerShape "ICON";
                                                _WICTMN setMarkerType _debugmarker;
                                                _WICTMN setMarkerColor "ColorRed";
                                                WICTMC = WICTMC + 1;
                                                
                                        };
                                        if("BIS_TK" in MSO_FACTIONS && type _x == "Airport") then {
                                                _camp = ["airplane_park_tk1"];
                                        };
                                        if (count _camp == 0) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        _camp = _camp call BIS_fnc_selectRandom;
                                        _pos_WICT = [_pos_WICT, 10, 20, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                        //[_camp, random 360, _pos_WICT] call f_builder;
                                        _WICT_composition = [_pos_WICT, random 360, ["ru"]] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf"));
                                        
                                        call compile format ["_WICTMN = 'mediumVehicles_%1'",WICTMC];
                                        _WICTM = createMarker [_WICTMN, _pos_WICT];
                                        _WICTM setMarkerShape "ICON";
                                        _WICTMN setMarkerType _debugmarker;
                                        _WICTMN setMarkerColor "ColorRed";
                                        WICTMC = WICTMC + 1;
                                        
                                        _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[4,3,2,1]] call mso_core_fnc_selectRandomBias;
                                        
                                        [_pos_WICT, _flag, _type] spawn {
                                                private ["_pos_WICT","_pos2_WICT","_flag","_group","_type"];
                                                _pos_WICT = _this select 0;
                                                _flag = _this select 1;
                                                _type= _this select 2;
                                                waitUntil{sleep 3;([_pos_WICT, ep_dist] call fPlayersInside)};
                                                _group = nil;
                                                _pos2_WICT = [_pos_WICT, 10, 20, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                
                                                while{isNil "_group"} do {
                                                        _group = [_pos2_WICT, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                };
                                                
                                                (leader _group) setBehaviour "AWARE";
                                                _group setSpeedMode "LIMITED";
                                                _group setFormation "STAG COLUMN";
                                                [_group] call BIN_fnc_taskDefend;
                                                
                                                ep_groups set [count ep_groups, _group];
                                        };
                                };
                        };
                };
                if (type _x in _baselocations08) then {
                        if (random 1 > 0.8) then {
                                ep_total = ep_total + 1;
                                _d = 20;
                                _pos_WICT = [position _x, 0,  _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;			
                                _flag = random 1;
                                if(_flag < wict_ep_campprob) then {
                                        _camp = [];
                                        if("RU" in MSO_FACTIONS) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
                                        };
                                        if("INS" in MSO_FACTIONS) then {
                                                _camp = _camp + ["camp_ins1","camp_ins2"];
                                        };
                                        if("GUE" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
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
                                        if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS || "cwr2_ru" in MSO_FACTIONS || "cwr2_fia" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                _camp = _camp + ["bunkerMedium01","bunkerMedium02","bunkerMedium03","bunkerMedium04","bunkerSmall01","guardpost4","guardpost5","guardpost6","guardpost7","guardpost8","citybase01","cityBase02","cityBase03","cityBase04"];
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
                                        if (count _camp == 0) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if (count _camp > 0) then {
                                                _camp = _camp call BIS_fnc_selectRandom;
                                                _pos_WICT = [_pos_WICT, 10, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                //[_camp, random 360, _pos_WICT] call f_builder;
                                                _WICT_composition = [_pos_WICT, random 360, ["ru"]] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf"));
                                                
                                                call compile format ["_WICTMN = 'heavyArmor_%1'",WICTMC];
                                                _WICTM = createMarker [_WICTMN, _pos_WICT];
                                                _WICTM setMarkerShape "ICON";
                                                _WICTMN setMarkerType _debugmarker;
                                                _WICTMN setMarkerColor "ColorRed";
                                                WICTMC = WICTMC + 1;
                                                
                                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[4,3,2,1]] call mso_core_fnc_selectRandomBias;
                                                
                                                [_pos_WICT, _flag, _type] spawn {
                                                        private ["_pos_WICT","_pos2_WICT","_flag","_group","_type"];
                                                        _pos_WICT = _this select 0;
                                                        _flag = _this select 1;
                                                        _type= _this select 2;
                                                        waitUntil{sleep 3;([_pos_WICT, ep_dist] call fPlayersInside)};
                                                        _group = nil;
                                                        _pos2_WICT = [_pos_WICT, 10, 20, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                        
                                                        while{isNil "_group"} do {
                                                                _group = [_pos2_WICT, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        
                                                        (leader _group) setBehaviour "AWARE";
                                                        _group setSpeedMode "LIMITED";
                                                        _group setFormation "STAG COLUMN";
                                                        [_group] call BIN_fnc_taskDefend;
                                                        
                                                        ep_groups set [count ep_groups, _group];
                                                };
                                        };
                                };
                        };
                };
                if (type _x in _baselocations09) then {
                        if (random 1 > 0.9) then {
                                ep_total = ep_total + 1;
                                _d = 20;
                                _pos_WICT = [position _x, 0,  _d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                                _flag = random 1;
                                if(_flag < wict_ep_campprob) then {
                                        _camp = [];
                                        if("RU" in MSO_FACTIONS) then {
                                                _camp = _camp + ["camp_ru1","camp_ru2"];
                                        };
                                        if("INS" in MSO_FACTIONS) then {
                                                _camp = _camp + ["camp_ins1","camp_ins2"];
                                        };
                                        if("GUE" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
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
                                        if("RU" in MSO_FACTIONS || "INS" in MSO_FACTIONS || "GUE" in MSO_FACTIONS || "cwr2_ru" in MSO_FACTIONS || "cwr2_fia" in MSO_FACTIONS || "tigerianne" in MSO_FACTIONS) then {
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {
                                                f_builder = mso_core_fnc_createCompositionE;
                                        };
                                        if (count _camp == 0) then {
                                                _camp = _camp + ["anti-air_ru1","camp_ru1","camp_ru2","firebase_ru1","heli_park_ru1","mediumtentcamp2_ru","mediumtentcamp3_ru","mediumtentcamp_ru","radar_site_ru1"];
                                                f_builder = mso_core_fnc_createComposition;
                                        };
                                        if (count _camp > 0) then {
                                                _camp = _camp call BIS_fnc_selectRandom;
                                                _pos_WICT = [_pos_WICT, 10, 20, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                //[_camp, random 360, _pos_WICT] call f_builder;
                                                _WICT_composition = [_pos_WICT, random 360, ["ru"]] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf"));
                                                
                                                call compile format ["_WICTMN = 'lightvehicles_%1'",WICTMC];
                                                _WICTM = createMarker [_WICTMN, _pos_WICT];
                                                _WICTM setMarkerShape "ICON";
                                                _WICTMN setMarkerType _debugmarker;
                                                _WICTMN setMarkerColor "ColorRed";
                                                WICTMC = WICTMC + 1;
                                                
                                                _type = [["Infantry", "Motorized", "Mechanized", "Armored"],[4,3,2,1]] call mso_core_fnc_selectRandomBias;
                                                
                                                [_pos_WICT, _flag, _type] spawn {
                                                        private ["_pos_WICT","_pos2_WICT","_flag","_group","_type"];
                                                        _pos_WICT = _this select 0;
                                                        _flag = _this select 1;
                                                        _type= _this select 2;
                                                        waitUntil{sleep 3;([_pos_WICT, ep_dist] call fPlayersInside)};
                                                        _group = nil;
                                                        _pos2_WICT = [_pos_WICT, 10, 20, 10, 0, 5, 0] call bis_fnc_findSafePos;
                                                        
                                                        while{isNil "_group"} do {
                                                                _group = [_pos2_WICT, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
                                                        };
                                                        
                                                        (leader _group) setBehaviour "AWARE";
                                                        _group setSpeedMode "LIMITED";
                                                        _group setFormation "STAG COLUMN";
                                                        [_group] call BIN_fnc_taskDefend;
                                                        
                                                        ep_groups set [count ep_groups, _group];
                                                };
                                        };
                                };
                        };
                };
        };
        if (count _pos_WICT != 0) then {
                if(ep_total mod 10 == 0) then {
                        diag_log format["MSO-%1 WICT Bases # %2", time, WICTMC];
                        if(_debug) then {hint format["MSO-%1 WICT Bases # %2", time, WICTMC];};
                };
                /*
                if(_debug) then {
                        private["_t","_m"];
                        _t = format["op%1",floor(random 10000)];
                        if(isNil "_type") then {_type = "";};
                        _m = [_t, _pos_WICT, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _type, "GLOBAL"] call CBA_fnc_createMarker;
                };
                */
        };
} foreach CRB_LOCS;

[0,[],{[] call compile preprocessFileLineNumbers "enemy\modules\WICT_enemypop\init.sqf";}] call mso_core_fnc_ExMP;

diag_log format["MSO-%1 WICT bases # %2", time, WICTMC];
if(_debug)then{hint format["MSO-%1 WICT bases # %2", time, WICTMC];};
