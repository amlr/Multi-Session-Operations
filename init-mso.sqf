#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

//http://community.bistudio.com/wiki/enableSaving

private ["_fnc_status","_uid"];
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
mso_fnc_hasRadio = if (!isNil "ACE_fnc_hasRadio") then {
        {if(player call ACE_fnc_hasRadio) then {true} else {hint "You require a radio.";false;};}
} else {
        {if(player hasWeapon "itemRadio") then {true} else {hint "You require a radio.";false;};}
};

BIS_MENU_GroupCommunication = [
        //--- Name, context sensitive
        ["User menu",false]
        //--- Item name, shortcut, -5 (do not change), expression, show, enable
];

fnc_updateMenu = {
        private["_name","_exp"];
        _name = _this select 0;
        _exp = _this select 1;
        BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
                [_name,[count BIS_MENU_GroupCommunication + 1],"",-5,[["expression",_exp]],"1","1"]
        ];
};	

_fnc_status = {
        private["_stage"];
        _stage = _this;
        
        if (isServer && isNil "CRB_INIT_STATUS") then {
                CRB_INIT_STATUS = [];
                publicVariable "CRB_INIT_STATUS";
        };
        waitUntil{!isNil "CRB_INIT_STATUS"};
        
        if (isServer) then {
                CRB_INIT_STATUS = CRB_INIT_STATUS + [_stage];
                publicVariable "CRB_INIT_STATUS";
        };
        
        waitUntil{_stage in CRB_INIT_STATUS};
        player sideChat format["Initialising: %1", _stage];
};

"Custom Locations(" + worldName + ")" call _fnc_status;
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

"Mission Parameters" call _fnc_status;
if (!isNil "paramsArray") then {
        for "_i" from 0 to ((count paramsArray)-1) do {
                missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
        };
};
MSO_FACTIONS = [];
if(!isNil "faction_RU") then {
        if(faction_RU == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["RU"];
        };
};
if(!isNil "faction_ACE_RU") then {
        if(faction_ACE_RU == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["ACE_VDV","ACE_GRU","ACE_MVD"];
        };
};
if(!isNil "faction_INS") then {
        if(faction_INS == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["INS"];
        };
};
if(!isNil "faction_GUE") then {
        if(faction_GUE == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["GUE"];
                playerSide setFriend [resistance, 0];
                resistance setFriend [playerSide, 0];
        };
};
if(!isNil "faction_BIS_TK") then {
        if(faction_BIS_TK == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["BIS_TK"];
        };
};
if(!isNil "faction_BIS_TK_INS") then {
        if(faction_BIS_TK_INS == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["BIS_TK_INS"];
        };
};
if(!isNil "faction_BIS_TK_GUE") then {
        if(faction_BIS_TK_GUE == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["BIS_TK_GUE"];
                playerSide setFriend [resistance, 0];
                resistance setFriend [playerSide, 0];
        };
};
if(count MSO_FACTIONS == 0) then {
        MSO_FACTIONS = ["BIS_TK_GUE"];
        playerSide setFriend [resistance, 0];
        resistance setFriend [playerSide, 0];
};

"Player" call _fnc_status;
execNow "scripts\init_player.sqf";

setViewDistance 2000;
setTerrainGrid 25;

#ifdef RMM_MP_RIGHTS
if(!isMultiplayer) then {mprightsDisable = 1;};
if(mprightsDisable == 1) then {
        "MP Rights disabled" call _fnc_status;
        _uid = getPlayerUID player;
        MSO_R_Admin = [_uid];
	MSO_R_Leader = [_uid];
        MSO_R_Officer = [_uid];
        MSO_R_Air = [_uid];
        MSO_R_Crew = [_uid];
} else {
        "MP Rights" call _fnc_status;
        execNow "modules\mp_rights\main.sqf";
};
#endif
if(isNil "mprightsDisable") then {
        "Default Rights" call _fnc_status;
        _uid = getPlayerUID player;
        MSO_R_Admin = [_uid];
        MSO_R_Leader = [_uid];
        MSO_R_Officer = [_uid];
        MSO_R_Air = [_uid];
        MSO_R_Crew = [_uid];
};

//player globalChat "Initialise First Aid Fix";
//[] execVM "scripts\firstaidfix.sqf";

#ifdef RMM_DEBUG
"Debug" call _fnc_status;
execNow "modules\debug\main.sqf";
#endif
#ifdef RMM_WEATHER
"Weather" call _fnc_status;
execNow "modules\weather\main.sqf";
#endif
#ifdef RMM_NOMAD
"NOMAD" call _fnc_status;
execNow "modules\nomad\main.sqf";
#endif
#ifdef CRB_CIVILIANS
"Ambient Civilians" call _fnc_status;
execNow "modules\civilians\main.sqf";
#endif
#ifdef RMM_REVIVE
"Revive" call _fnc_status;
waitUntil{!isnil "revive_fnc_init"};
if (!isDedicated) then {
        player call revive_fnc_init;
};
if (!isNil "revive_test") then {
        revive_test call revive_fnc_init;
        revive_test setDamage 0.6;
        revive_test call revive_fnc_unconscious;
};
#endif
#ifdef RMM_AAR
"After Action Reports" call _fnc_status;
execNow "modules\aar\main.sqf";
#endif
#ifdef RMM_CAS
"Close Air Support" call _fnc_status;
execNow "modules\cas\main.sqf";
#endif
#ifdef RMM_CASEVAC
"CASEVAC" call _fnc_status;
execNow "modules\casevac\main.sqf";
#endif
#ifdef RMM_CNSTRCT
"Construction" call _fnc_status;
execNow "modules\cnstrct\main.sqf";
#endif
#ifdef RMM_CTP
"Call To Prayer" call _fnc_status;
execNow "modules\ctp\main.sqf";
#endif
#ifdef CRB_FLIPPABLE
"Flippable Vehicles" call _fnc_status;
execNow "modules\flippable\main.sqf";
#endif
#ifdef GC_PACK_COW
"Gen Carver's Pack Cow" call _fnc_status;
execNow "modules\gc_pack_cow\main.sqf";
#endif
#ifdef RMM_JIPMARKERS
"JIP Markers" call _fnc_status;
execNow "modules\jipmarkers\main.sqf";
#endif
#ifdef RMM_LOGISTICS
"Logistics" call _fnc_status;
execNow "modules\logistics\main.sqf";
#endif
#ifdef RMM_NOTEBOOK
"Notebook" call _fnc_status;
execNow "modules\notebook\main.sqf";
#endif
#ifdef R3F_LOGISTICS
"R3F Logistics" call _fnc_status;
execNow "modules\R3F_logistics\init.sqf";
#endif
#ifdef RMM_SETTINGS
"View Distance Settings" call _fnc_status;
execNow "modules\settings\main.sqf";	
#endif
#ifdef RMM_TASKS
"JIP Tasks" call _fnc_status;
execNow "modules\tasks\main.sqf";	
#endif
#ifdef RMM_TYRES
"Tyre Changing" call _fnc_status;
execNow "modules\tyres\main.sqf";
#endif
#ifdef CRB_CROWS
"Crows" call _fnc_status;
execNow "modules\crb_crows\main.sqf";
#endif
#ifdef CRB_FLIES
"Flies" call _fnc_status;
execNow "modules\crb_flies\main.sqf";
#endif
#ifdef CRB_SANDSTORM
"Sandstorms" call _fnc_status;
execNow "modules\crb_sandstorms\main.sqf";
#endif
#ifdef CEP_CACHE
"CEP AI Unit Caching" call _fnc_status;
execNow "modules\CEP_caching\main.sqf";
#endif
#ifdef CRB_DOGS
"Dogs" call _fnc_status;
["WEST"] execNow "modules\dogs\main.sqf";
#endif
#ifdef CRB_TERRORISTS
"Terrorist Cells" call _fnc_status;
execVM "modules\CRB_Terrorists\main.sqf";
execVM "modules\CRB_Terrorists\main.sqf";
execVM "modules\CRB_Terrorists\main.sqf";
#endif
#ifdef RMM_CONVOYS
"Convoys" call _fnc_status;
execNow "modules\convoys\main.sqf";
#endif
#ifdef RMM_ZORA
"ZORA" call _fnc_status;
execNow "modules\zora\main.sqf";
#endif
#ifdef RMM_ENEMYPOP
"Enemy Populate" call _fnc_status;
execNow "modules\enemypop\main.sqf";
#endif

// AAW INKO Fix
//"AAW INKO Fix" call _fnc_status;
//AAWinf_HelmChangeAnyWhere = true; 
//execNow "scripts\ace_aaw_fix.sqf";

"Remove Destroyed Objects" call _fnc_status;
[300,500] call compile preprocessFileLineNumbers "scripts\crB_scripts\crB_HideCorpses.sqf";

"Completed" call _fnc_status;
sleep 5;
execNow "scripts\intro.sqf";