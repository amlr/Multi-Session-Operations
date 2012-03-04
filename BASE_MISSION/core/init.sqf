#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

//Create the comms menu on all machines.
[] call BIS_fnc_commsMenuCreate; 

// Add briefing for MSO
_nul = [] execVM "core\scripts\briefing.sqf";

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

MSO_Loop_Funcs = [];
MSO_useCBA = false;

// Thanks to Nou for this code
[] spawn {
        if(!MSO_useCBA) then {
                if(!isDedicated) then {
                        waitUntil { player == player && alive player };
                };
                waitUntil {
		        private ["_f","_delta"];
                        {
                                if((count _x) > 0) then {
                                        _f = _x select 0;
                                        _delta = _x select 1;
                                        if(diag_tickTime >= _delta) then {
                                                [(_f select 2), _forEachIndex] call (_f select 0);
                                                _x set[1, diag_tickTime + (_f select 1)];
                                        };
                                };
                        } forEach MSO_Loop_Funcs;
                        false;
                };
        };
};

CRB_MAPCLICK = "";

"RMM_MPe" addPublicVariableEventHandler {
        private ["_data","_locality","_params","_code"];
        _data = _this select 1;
        _locality = _data select 0;
        _params = _data select 1;
        _code = _data select 2;
        
        if (switch (_locality) do {
                case 0 : {true};
                case 1 : {isserver};
                case 2 : {not isdedicated};
                default {false};
        }) then {
                if (isnil "_params") then {call _code} else {_params call _code};
        };
};

mso_menuname = "Multi-Session Operations";
mso_interaction_key = if (!isNil "ace_sys_interaction_key_self") then {
        ace_sys_interaction_key_self
} else {
        [221,[false,false,false]]
};

mso_fnc_hasRadio = if (!isNil "ACE_fnc_hasRadio") then {
        {if(player call ACE_fnc_hasRadio) then {true} else {hint "You require a radio.";false;};}
} else {
        {
		// Thanks Sickboy
		_hasRadio = false; 
		{
			if (getText(configFile >> "CfgWeapons" >> _x >> "simulation") == "ItemRadio") exitWith { _hasRadio = true };
		} forEach (weapons player);
		if(_hasRadio) then {true} else {hint "You require a radio.";false;};
	}
};

"Custom Locations(" + worldName + ")" call mso_core_fnc_initStat;
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

"Mission Parameters" call mso_core_fnc_initStat;
if (!isNil "paramsArray") then {
	diag_log format["MSO-%1 Mission Parameters", time];
        for "_i" from 0 to ((count paramsArray)-1) do {
                missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
		diag_log format["MSO-%1    %2 = %3", time, configName ((missionConfigFile/"Params") select _i), paramsArray select _i];
        };
};

"Player" call mso_core_fnc_initStat;
execNow "core\scripts\init_player.sqf";

#ifdef RMM_MP_RIGHTS
private ["_uid"];
if(isNil "mprightsDisable") then {mprightsDisable = 1;};
if(mprightsDisable == 1) then {
        "MP Rights disabled" call mso_core_fnc_initStat;
        _uid = getPlayerUID player;
        MSO_R_Admin = [_uid];
        MSO_R_Leader = [_uid];
        MSO_R_Officer = [_uid];
        MSO_R_Air = [_uid];
        MSO_R_Crew = [_uid];
} else {
        "MP Rights" call mso_core_fnc_initStat;
        execNow "core\modules\rmm_mp_rights\main.sqf";
};
#endif
if(isNil "mprightsDisable") then {
        "Default Rights" call mso_core_fnc_initStat;
        _uid = getPlayerUID player;
        MSO_R_Admin = [_uid];
        MSO_R_Leader = [_uid];
        MSO_R_Officer = [_uid];
        MSO_R_Air = [_uid];
        MSO_R_Crew = [_uid];
};

#ifdef RMM_DEBUG
"Debug" call mso_core_fnc_initStat;
execNow "core\modules\rmm_debug\main.sqf";
#endif

#ifdef RMM_NOMAD
"NOMAD" call mso_core_fnc_initStat;
execNow "core\modules\rmm_nomad\main.sqf";
#endif

#ifdef RMM_GTK
"Group Tracking" call mso_core_fnc_initStat;
execNow "core\modules\rmm_gtk\main.sqf";
#endif

"Weather" call mso_core_fnc_initStat;
#ifdef RMM_WEATHER
execNow "core\modules\rmm_weather\main.sqf";
#endif
#ifdef DRN_WEATHER
execNow "core\modules\DRN_weather\CommonLib.sqf";
[10, 60, 10, 60, true] execNow "core\modules\DRN_weather\DynamicWeatherEffects.sqf";
#endif

#ifdef RMM_SETTINGS
"View Distance Settings" call mso_core_fnc_initStat;
execNow "core\modules\rmm_settings\main.sqf";	
#else
if(isDedicated) then {
	setViewDistance 5000;
	setTerrainGrid 25;
} else {
	setViewDistance 2500;
	setTerrainGrid 50;
};
#endif

#ifdef SPYDER_ONU
"Spyder Object Network Updater" call mso_core_fnc_initStat;
execNow "core\modules\spyder_onu\main.sqf";
#endif

"Remove Destroyed Objects" call mso_core_fnc_initStat;
//--- Is Garbage collector running?
if (isnil "BIS_GC") then {
	BIS_GC = (group BIS_functions_mainscope) createUnit ["GarbageCollector", position BIS_functions_mainscope, [], 0, "NONE"];
};
if (isnil "BIS_GC_trashItFunc") then {
	BIS_GC_trashItFunc = compile preprocessFileLineNumbers "ca\modules\garbage_collector\data\scripts\trashIt.sqf";
};
waitUntil{!isNil "BIS_GC"};
BIS_GC setVariable ["auto", true];
