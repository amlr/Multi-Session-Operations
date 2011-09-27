#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

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

if(isNil "BIS_MENU_GroupCommunication") then {
	BIS_MENU_GroupCommunication = [
        	//--- Name, context sensitive
	        ["User menu",false]
	        //--- Item name, shortcut, -5 (do not change), expression, show, enable
	];
};

"Custom Locations(" + worldName + ")" call mso_core_fnc_initStat;
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

"Mission Parameters" call mso_core_fnc_initStat;
if (!isNil "paramsArray") then {
        for "_i" from 0 to ((count paramsArray)-1) do {
                missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
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

#ifdef RMM_NOMAD
"NOMAD" call mso_core_fnc_initStat;
execNow "core\modules\nomad\main.sqf";
#endif

#ifdef CEP_CACHE
"CEP AI Unit Caching" call mso_core_fnc_initStat;
execNow "core\modules\CEP_caching\main.sqf";
#endif

#ifdef NOU_CACHE
"Nou AI Unit Caching" call mso_core_fnc_initStat;
execNow "core\modules\Nou_caching\main.sqf";
#endif

#ifdef JCACHE
"Jaynus AI Unit Caching" call mso_core_fnc_initStat;
execNow "core\modules\jcache\init.sqf";
#endif

#ifdef RMM_WEATHER
"Weather" call mso_core_fnc_initStat;
execNow "core\modules\weather\main.sqf";
#endif

#ifdef RMM_SETTINGS
"View Distance Settings" call mso_core_fnc_initStat;
execNow "core\modules\settings\main.sqf";	
#else
if(isDedicated) then {
	setViewDistance 3000;
} else {
	setViewDistance 1500;
};
#endif
setTerrainGrid 25;

#ifdef SPYDER_ONU
"Spyder Object Network Updater" call mso_core_fnc_initStat;
execNow "core\modules\spyder_onu\main.sqf";
#endif

"Remove Destroyed Objects" call mso_core_fnc_initStat;
//--- Is Garbage collector running?
if (isnil "BIS_GC") then {
	private ["_ok","_logic"];
	createCenter sideLogic;
	_logic = (createGroup sideLogic) createUnit ["GarbageCollector", [0,0,0], [], 0, "NONE"];
};
waitUntil{!isNil "BIS_GC"};
BIS_GC setVariable ["auto", true, true];

