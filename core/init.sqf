#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif


private ["_uid"];

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

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

BIS_MENU_GroupCommunication = [
        //--- Name, context sensitive
        ["User menu",false]
        //--- Item name, shortcut, -5 (do not change), expression, show, enable
];

"Mission Parameters" call mso_core_fnc_initStat;
if (!isNil "paramsArray") then {
        for "_i" from 0 to ((count paramsArray)-1) do {
                missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
        };
};

"Player" call mso_core_fnc_initStat;
execNow "core\scripts\init_player.sqf";

setViewDistance 2000;
setTerrainGrid 25;

#ifdef RMM_MP_RIGHTS
if(!isMultiplayer) then {mprightsDisable = 1;};
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
        execNow "core\modules\mp_rights\main.sqf";
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
execNow "core\modules\debug\main.sqf";
#endif

#ifdef RMM_WEATHER
"Weather" call mso_core_fnc_initStat;
execNow "core\modules\weather\main.sqf";
#endif

#ifdef RMM_NOMAD
"NOMAD" call mso_core_fnc_initStat;
execNow "core\modules\nomad\main.sqf";
#endif

#ifdef RMM_SETTINGS
"View Distance Settings" call mso_core_fnc_initStat;
execNow "core\modules\settings\main.sqf";	
#endif

#ifdef CEP_CACHE
"CEP AI Unit Caching" call mso_core_fnc_initStat;
execNow "core\modules\CEP_caching\main.sqf";
#endif

"Remove Destroyed Objects" call mso_core_fnc_initStat;
//--- Is Garbage collector running?
if (isnil "BIS_GC") then {BIS_GC = (group BIS_functions_mainscope) createUnit ["GarbageCollector", position BIS_functions_mainscope, [], 0, "NONE"]};
BIS_GC setVariable ["auto", true, true];