
//#squint filter Unknown variable mso_core_fnc_initStat

#include <modules\modules.hpp>
#include <msofactions_defaults.hpp>

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
if(!isNil "faction_CWR2_US") then {
        if(faction_CWR2_US == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["cwr2_us"];
        };
};
if(!isNil "faction_CWR2_RU") then {
        if(faction_CWR2_RU == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["cwr2_ru"];
        };
};
if(!isNil "faction_CWR2_FIA") then {
        if(faction_CWR2_FIA == 1) then {
                MSO_FACTIONS = MSO_FACTIONS + ["CWR2_FIA"];
        };
};

if(count MSO_FACTIONS == 0) then {

	MSO_FACTIONS = MSO_FACTIONS + ["RU"];
};

#ifdef CRB_CONVOYS
"Convoys" call mso_core_fnc_initStat;
execNow "enemy\modules\crb_convoys\main.sqf";
#endif

#ifdef RMM_ZORA
"ZORA" call mso_core_fnc_initStat;
execNow "enemy\modules\zora\main.sqf";
#endif

#ifdef CRB_TERRORISTS
"Terrorist Cells" call mso_core_fnc_initStat;
execNow "enemy\modules\crb_terrorists\main.sqf";
#endif

#ifdef SR5_IEDS
// MANDATORY!
"SR5 IEDs" call mso_core_fnc_initStat;
execNow "enemy\modules\SR5_IEDdetect\IEDdetect_init.sqf";

// AMBIENT BOMBERS (optional)
"SR5 Ambient Bombers" call mso_core_fnc_initStat;
0 = [500,10,50,30,[
	"Car",
	"Garbage_can",
	"Garbage_container",
	"Land_Misc_Garb_3_EP1",
	"Land_Misc_Garb_4_EP1",
	"Land_Misc_Garb_Heap_EP1",
	"Land_Misc_Rubble_EP1",
	"Misc_TyreHeap",
	"Misc_TyreHeapEP1",
	"Land_Misc_Garb_Square_EP1"
],0,50,50,25,50,WEST] execVM "enemy\modules\SR5_IEDdetect\IEDdetect_ambientBombers.sqf";

//AMBIENT PROXIMITY IEDs (optional)
"SR5 Ambient Proxy IEDs" call mso_core_fnc_initStat;
0 = [500,20,30,0,50,WEST] execVM "enemy\modules\SR5_IEDdetect\IEDdetect_ambientProxyIEDs.sqf";
#endif

#ifdef RMM_ENEMYPOP
"Enemy Populate" call mso_core_fnc_initStat;
execNow "enemy\modules\rmm_enemypop\main.sqf";
#endif

#ifdef WICT_ENEMYPOP
"WICT Populate" call mso_core_fnc_initStat;
execNow "enemy\modules\wict_enemypop\main.sqf";
#endif

