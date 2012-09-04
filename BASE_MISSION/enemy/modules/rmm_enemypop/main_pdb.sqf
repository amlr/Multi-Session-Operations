if !(isserver) exitwith {diag_log format ["MSO-%1 Enemy Populator running on client - Exiting.",time];};

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

// Initialize DEP_LOCS array
DEP_LOCS = [];

[] spawn {

	if (persistentDBHeader == 1) then {
		waitUntil{!isNil "PDB_DEP_positionsloaded"};
		if (debug) then {
			diag_log format["Loaded PDB DEP, %1, %2", DEP_LOCS, count DEP_LOCS];
		};
	};
	
	if(count DEP_LOCS < 1) then {
			[] call MSO_fnc_depinitlocs;
	};
			
	{
		private ["_obj","_pos","_grpt","_grpt","_camp","_grpt2","_AA","_RB","_cleared"];
		
		//Dataset
		//Using "DEP_locs"-array for quick access [[_obj,[_pos select 0,_pos select 1,_pos select 2]],[_obj,[_pos select 0,_pos select 1,_pos select 2]],...]
		_obj = _x select 0; // Placeholder Object (string), must be created on missionstart
		_pos = position (_x select 0); // Position Array (array)
		_grpt = ((_x select 0) getvariable "groupType") select 0; if (isnil "_grpt") then {_grpt = false}; //Type of Group (array [side,grouptype])
		_camp = ((_x select 0) getvariable "type") select 0; if (isnil "_camp") then {_camp = false}; //Type of Camp (string)
		_grpt2 = ((_x select 0) getvariable "groupType") select 1; if (isnil "_grpt2") then {_grpt2 = false}; // Type of Campguards (array [side,grouptype])
		_AA = ((_x select 0) getvariable "type") select 1; if (isnil "_AA") then {_AA = false}; // AA Flag (bool)
		if (count ((_x select 0) getvariable "type") > 2) then {
			_RB = ((_x select 0) getvariable "type") select 2; if (isnil "_RB") then {_RB = false}; // RB Flag (bool)
		};
		_cleared = _x select 0 getvariable "c"; if (isnil "_cleared") then {_cleared = false}; // cleared position (bool)
		
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
		
		//Markers in Debug
		if (_debug) then {
			private["_t","_m"];
			_t = format["ep%1",floor(random 10000)];
			_m = [_t, _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", str(_grpt select 1), "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
		};    

		[_obj,_pos,_grpt,_camp,_grpt2,_AA,_RB,_cleared] spawn DEP_MainLoop;
	} foreach DEP_LOCS;
};
