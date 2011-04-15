
//#squint filter Unknown variable mso_core_fnc_initStat

#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

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
        };
};
if(count MSO_FACTIONS == 0) then {MSO_FACTIONS = ["BIS_TK_GUE"];};

#ifdef CRB_CONVOYS
"Convoys" call mso_core_fnc_initStat;
execNow "enemy\modules\crb_convoys\main.sqf";
#endif

#ifdef RMM_ZORA
"ZORA" call mso_core_fnc_initStat;
execNow "enemy\modules\zora\main.sqf";
#endif

#ifdef RMM_ENEMYPOP
"Enemy Populate" call mso_core_fnc_initStat;
execNow "enemy\modules\rmm_enemypop\main.sqf";
#endif

#ifdef CRB_TERRORISTS
"Terrorist Cells" call mso_core_fnc_initStat;
execNow "enemy\modules\crb_terrorists\main.sqf";
#endif