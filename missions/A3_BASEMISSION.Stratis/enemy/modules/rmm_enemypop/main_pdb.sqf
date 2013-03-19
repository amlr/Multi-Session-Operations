#include <crbprofiler.hpp>

//#squint filter Unknown variable MSO_FACTIONS
//#squint filter Unknown variable mso_core_fnc_initLocations
//#squint filter Unknown variable mso_core_fnc_selectRandomBias
//#squint filter Unknown variable mso_core_fnc_randomGroup
//#squint filter Unknown variable mso_core_fnc_createComposition
//#squint filter Unknown variable mso_core_fnc_createCompositionE
//#squint filter Careful - string searches using 'in' are case-sensitive
private ["_debug"];

if (isnil "rmm_dynamic") then {rmm_dynamic = 1};
if (isNil "rmm_ep_spawn_dist") then {rmm_ep_spawn_dist = 2000;};
if (isNil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 2000;};
if (isNil "rmm_ep_inf") then {rmm_ep_inf = 4;};
if (isNil "rmm_ep_mot") then {rmm_ep_mot = 3;};
if (isNil "rmm_ep_sup") then {rmm_ep_sup = 2;};
if (isNil "rmm_ep_arm") then {rmm_ep_arm = 1;};
if (isNil "rmm_ep_aa") then {rmm_ep_aa = 2;};
if (isNil "rmm_ep_arty") then {rmm_ep_arty = 9;};
if (isNil "DEP_ACTIVE_LOCS") then {DEP_ACTIVE_LOCS = 40;};
if (isNil "DEP_LOC_DENSITY") then {DEP_LOC_DENSITY = 1000;};
if (isNil "mpdb_locations_enabled") then {pdb_locations_enabled = false;};
ARTILLERIES = [];
_debug = debug_mso;

if (isnil "rmm_locality") then {rmm_locality = 0};
switch (rmm_locality) do {
        case 0: {RMM_HC_active = false; DEP_clientside = false};
        case 1: {RMM_HC_active = true; DEP_clientside = true;};
        default {RMM_HC_active = false; DEP_clientside = false};
};

if (RMM_HC_active) then {
        if (isDedicated) then {KillServ = true};
        if (!(isDedicated) && {isHC}) then {KillClient = false} else {KillClient = true};
} else {
        if (isServer) then {KillServ = false} else {KillClient = true};
};

if(rmm_dynamic == 0) exitWith{diag_log format ["MSO-%1 Enemy Populator Disabled - Exiting.",time];};
if (isDedicated && {KillServ}) exitWith {KillServ = false; diag_log format ["MSO-%1 Killing DEP init on server - Exiting...",time]};
if (!(isServer) && {KillClient}) exitWith {KillClient = false; diag_log format ["MSO-%1 Killing DEP init on Client - Exiting...",time]};

diag_log format["MSO-%1 PDB EP Population: starting to load functions...", time];
if (isnil "BIN_fnc_taskDefend") then {BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf"};
if (isnil "BIN_fnc_taskPatrol") then {BIN_fnc_taskPatrol = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskPatrol.sqf"};
if (isnil "BIN_fnc_taskSweep") then {BIN_fnc_taskSweep = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskSweep.sqf"};
if (isnil "HH_fnc_taskDefend") then {HH_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\HH_taskDefend.sqf"};
if (isnil "TUP_fnc_deployRoadblock") then {TUP_fnc_deployRoadblock = compile preprocessFileLineNumbers "enemy\scripts\TUP_deployRoadBlock.sqf"};
if (isnil "TUP_fnc_deployAA") then {TUP_fnc_deployAA = compile preprocessFileLineNumbers "enemy\scripts\TUP_spawnAA.sqf"};
if (isnil "MSO_fnc_depinitlocs") then {MSO_fnc_depinitlocs = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\MSO_fnc_depinitlocs.sqf"};
if (isnil "DEP_MainLoop") then {DEP_MainLoop = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_MainLoop.sqf"};
if (isnil "MSO_fnc_getrandomgrouptype") then {MSO_fnc_getrandomgrouptype = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\MSO_fnc_getrandomgrouptype.sqf"};
if (isnil "mso_fnc_selectcamptype") then {MSO_fnc_selectcamptype = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\mso_fnc_selectcamptype.sqf"};
if (isnil "rmm_ep_getFlatArea") then {rmm_ep_getFlatArea = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\rmm_ep_getFlatArea.sqf"};
if (isnil "fPlayersInside") then {fPlayersInside = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\fPlayersInside.sqf"};
if (isnil "DEP_convert_group") then {DEP_convert_group = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_convert_group.sqf"};
if (isnil "DEP_Triggerloop") then {DEP_Triggerloop = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_Triggerloop.sqf"};
if (isnil "DEP_ArtyFOAI") then {DEP_ArtyFOAI = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_ArtyFOAI.sqf"};
if (isnil "DEP_InitArtyBattery") then {DEP_InitArtyBattery = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_InitArtyBattery.sqf"};
if (isnil "DEP_InitArtilleriesServer") then {DEP_InitArtilleriesServer = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_InitArtilleriesServer.sqf"};
diag_log format["MSO-%1 PDB EP Population: loaded functions...", time];

ep_groups = [];
ep_locations = [];
ep_total = 0;
ep_campprob = 0;

if (persistentDBHeader == 1 && {isHC}) then {
	// DEP
	if (rmm_locality > 0) then {
		diag_log format["MSO-%1 Headless Client: %2, waiting for PDB_DEP_positionsloaded...", time, player];
		waituntil {!(isnil "PDB_DEP_positionsloaded")};
	};	
};	

waitUntil{!isNil "BIS_fnc_init"};

// Array of used CO compositions (Fix for Camp-type error)
DEP_camptypes =
[
        "bunkerMedium01",
        "bunkerMedium02",
        "bunkerMedium03",
        "bunkerMedium04",
        "bunkerSmall01",
        "guardpost4",
        "guardpost5",
        "guardpost6",
        "guardpost7",
        "guardpost8",
        "citybase01",
        "cityBase02",
        "cityBase03",
        "cityBase04",
        "MediumTentCamp_local",
        "SmallTentCamp2_local",
        "SmallTentCamp_local",
        "camp_militia1",
        "camp_militia2",
        "anti-air_tk1",
        "camp_tk1",
        "camp_tk2",
        "firebase_tk1",
        "heli_park_tk1",
        "mediumtentcamp2_tk",
        "mediumtentcamp3_tk",
        "mediumtentcamp_tk",
        "radar_site_tk1"
];

private ["_debug"];
if (persistentDBHeader == 1) then {	
        waituntil {!(isnil "PDB_DEP_positionsloaded")};
};

if (isnil "DEP_LOCS") then {
        DEP_LOCS = [];
        [] call MSO_fnc_depinitlocs;
} else {
        if ((count DEP_LOCS) == 0) then {
                DEP_LOCS = [];
                [] call MSO_fnc_depinitlocs;
        };
};

{
        private ["_obj","_pos","_grpt","_grpt","_camp","_grpt2","_AA","_RB","_Arty","_LogicGroup","_artygroup"];
        
        //Dataset
        //Using "DEP_locs"-array for quick access [[_obj,[_pos select 0,_pos select 1,_pos select 2]],[_obj,[_pos select 0,_pos select 1,_pos select 2]],...]
        _obj = _x select 0; // Placeholder Object (string), must be created on missionstart
        _pos = position (_x select 0); // Position Array (array)
        _grpt = ((_x select 0) getvariable "groupType") select 0; if (isnil "_grpt") then {_grpt = false}; //Type of Group (array [side,grouptype])
        _camp = ((_x select 0) getvariable "type") select 0; if (isnil "_camp") then {_camp = false}; //Type of Camp (string)
        _grpt2 = ((_x select 0) getvariable "groupType") select 1; if (isnil "_grpt2") then {_grpt2 = false}; // Type of Campguards (array [side,grouptype])
        _AA = ((_x select 0) getvariable "type") select 1; if (isnil "_AA") then {_AA = false}; // AA Flag (bool)
        _RB = ((_x select 0) getvariable "type") select 2; if (isnil "_RB") then {_RB = false}; // RB Flag (bool)
        _Arty = ((_x select 0) getvariable "type") select 3; if (isnil "_Arty") then {_Arty = false}; // Arty Flag (bool)
        _debug = debug_mso;
                
        //Fix for PO2
        if (typename _camp == "STRING") then {
                ep_locations set [count ep_locations,["Camp",_pos]];
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 Camptype %2 at %3", time,_camp,_pos]};
        };
        if (_AA) then {
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 AAA at %2", time,_pos]};
                ep_locations set [count ep_locations,["AA",_pos]];
        };
        if (_RB) then {
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 Roadblock at %2", time,_pos]};
                ep_locations set [count ep_locations,["RB",_pos]];
        };
        if (_grpt select 2 == "Infantry") then {
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 Infantry at %2", time,_pos]};
                ep_locations set [count ep_locations,["Infantry",_pos]];
        };
        if (_grpt select 2 == "Motorized") then {
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 Motorized at %2", time,_pos]};
                ep_locations set [count ep_locations,["Motorized",_pos]];
        };
        if (_grpt select 2 == "Mechanized") then {
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 Mechanized at %2", time,_pos]};
                ep_locations set [count ep_locations,["Mechanized",_pos]];
        };
        if (_grpt select 2 == "Armored") then {
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: MSO-%1 Armored at %2", time,_pos]};
                ep_locations set [count ep_locations,["Armored",_pos]];
        };
   
        if (typename _camp == "STRING") then {
                if (_camp in DEP_camptypes) then {
                        //[_camp, floor(random 360), _pos] call mso_core_fnc_createCompositionE;
                } else {
                        //[_camp, floor(random 360), _pos] call mso_core_fnc_createComposition;
                };
                
                if (_AA) then {
                        [_pos, "static", 1 + random 1] call TUP_fnc_deployAA;
                };
                if (_RB) then {
                        _obj setvariable ["RBspawned",false];
                };
        };
        
        //Markers in Debug
        if (_debug) then {
                private["_t","_m"];
                _t = format["DEP%1",floor(random 100000)];
                _m = [_t, _pos, "Icon", [1,1], "TYPE:", "mil_dot", "TEXT:", str(_grpt select 2), "GLOBAL"] call CBA_fnc_createMarker;
        };
} foreach DEP_LOCS;
PublicVariableServer "ep_locations";

if !(rmm_ep_arty == 0) then {
	[0, {
	    	if (isnil "DEP_InitArtilleriesServer") then {DEP_InitArtilleriesServer = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_InitArtilleriesServer.sqf"};
	        [] call DEP_InitArtilleriesServer;
	    }, true
	] call CBA_fnc_globalExecute;
} else {
    if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Artillery batteries disabled!", time]};
};

[] spawn DEP_Triggerloop;
DEP_INIT_FINISHED = true; publicvariable "DEP_INIT_FINISHED";

// Output sidechat to inform admin that DEP has finished (as it is called after clicking continue on mapscreen)
[-1, {if (servercommandavailable "#kick") then {player sidechat _this}}, format["MSO DEP INIT FINISHED! Collected %1 enemy locations!",count DEP_LOCS]] call CBA_fnc_globalExecute;
