diag_log format["MSO-%1 PDB EP Population: starting to load functions...", time];
if (isnil "BIN_fnc_taskDefend") then {BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf"};
if (isnil "BIN_fnc_taskPatrol") then {BIN_fnc_taskPatrol = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskPatrol.sqf"};
if (isnil "BIN_fnc_taskSweep") then {BIN_fnc_taskSweep = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskSweep.sqf"};
if (isnil "MSO_fnc_depinitlocs") then {MSO_fnc_depinitlocs = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\MSO_fnc_depinitlocs.sqf"};
if (isnil "DEP_MainLoop") then {DEP_MainLoop = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_MainLoop.sqf"};
if (isnil "MSO_fnc_getrandomgrouptype") then {MSO_fnc_getrandomgrouptype = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\MSO_fnc_getrandomgrouptype.sqf"};
if (isnil "mso_fnc_selectcamptype") then {MSO_fnc_selectcamptype = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\mso_fnc_selectcamptype.sqf"};
if (isnil "rmm_ep_getFlatArea") then {rmm_ep_getFlatArea = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\rmm_ep_getFlatArea.sqf"};
if (isnil "fPlayersInside") then {fPlayersInside = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\fPlayersInside.sqf"};
diag_log format["MSO-%1 PDB EP Population: loaded functions...", time];

f_builder = mso_core_fnc_createComposition;

if !(isserver) exitwith {};

_debug = debug_mso;
if(isNil "rmm_ep_intensity")then{rmm_ep_intensity = 3;};
if(isNil "rmm_ep_spawn_dist")then{rmm_ep_spawn_dist = 2000;};
if(isNil "rmm_ep_safe_zone")then{rmm_ep_safe_zone = 2000;};
if(isNil "rmm_ep_inf")then{rmm_ep_inf = 4;};
if(isNil "rmm_ep_mot")then{rmm_ep_mot = 3;};
if(isNil "rmm_ep_mec")then{rmm_ep_mec = 2;};
if(isNil "rmm_ep_arm")then{rmm_ep_arm = 1;};
if(isNil "rmm_ep_aa")then{rmm_ep_aa = 2;};

if(rmm_ep_intensity == 0) exitWith{diag_log format ["MSO-%1 Enemy Populator Disabled - Exiting.",time];};

ep_groups = [];
ep_locations = [];
ep_total = 0;
ep_campprob = 0.25;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

[] call MSO_fnc_depinitlocs;

{
    private ["_obj","_pos","_grpt","_grpt","_camp","_grpt2","_AA","_RB","_cleared"];
    
    //Using "DEP_locs"-array for quick access [[_obj,[_pos select 0,_pos select 1,_pos select 2]],[_obj,[_pos select 0,_pos select 1,_pos select 2]],...]
    _obj = _x select 0; // Placeholder Object (string), must be created on missionstart
    _pos = _x select 1; // Position Array (array)
	_grpt = _x select 0 getvariable "DEP_GrpType"; if (isnil "_grpt") then {_grpt = false}; //Type of Group (string)
	_camp = _x select 0 getvariable "DEP_Camp"; if (isnil "_camp") then {_camp = false}; //Type of Camp (string)
    _grpt2 = _x select 0 getvariable "DEP_GrpType2"; if (isnil "_grpt2") then {_grpt2 = false}; // Type of Campguards (string)
	_AA = _x select 0 getvariable "DEP_AA"; if (isnil "_AA") then {_AA = false}; // AA Flag (bool)
	_RB = _x select 0 getvariable "DEP_RB"; if (isnil "DEP_RB") then {_RB = false}; // RB Flag (bool)
    _cleared = _x select 0 getvariable "c"; if (isnil "_cleared") then {_cleared = nil}; // cleared position (bool)
    
    [_pos,_grpt,_camp,_grpt2,_AA,_RB,_obj] spawn DEP_MainLoop;
} foreach DEP_locs;