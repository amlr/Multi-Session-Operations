#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

//player globalChat "Initialise First Aid Fix";
//[] execVM "scripts\firstaidfix.sqf";

#ifdef RMM_REVIVE
"Revive" call mso_core_fnc_initStat;
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
"After Action Reports" call mso_core_fnc_initStat;
execNow "support\modules\aar\main.sqf";
#endif

#ifdef RMM_CAS
"Close Air Support" call mso_core_fnc_initStat;
execNow "support\modules\cas\main.sqf";
#endif

#ifdef RMM_CASEVAC
"CASEVAC" call mso_core_fnc_initStat;
execNow "support\modules\casevac\main.sqf";
#endif

#ifdef RMM_CNSTRCT
"Construction" call mso_core_fnc_initStat;
execNow "support\modules\cnstrct\main.sqf";
#endif

#ifdef CRB_FLIPPABLE
"Flippable Vehicles" call mso_core_fnc_initStat;
execNow "support\modules\flippable\main.sqf";
#endif

#ifdef GC_PACK_COW
"Gen Carver's Pack Cow" call mso_core_fnc_initStat;
execNow "support\modules\gc_pack_cow\main.sqf";
#endif

#ifdef RMM_JIPMARKERS
"JIP Markers" call mso_core_fnc_initStat;
execNow "support\modules\jipmarkers\main.sqf";
#endif

#ifdef RMM_LOGISTICS
"Logistics" call mso_core_fnc_initStat;
execNow "support\modules\logistics\main.sqf";
#endif

#ifdef RMM_NOTEBOOK
"Notebook" call mso_core_fnc_initStat;
execNow "support\modules\notebook\main.sqf";
#endif

#ifdef R3F_LOGISTICS
"R3F Logistics" call mso_core_fnc_initStat;
execNow "support\modules\R3F_logistics\init.sqf";
#endif

#ifdef RMM_TASKS
"JIP Tasks" call mso_core_fnc_initStat;
execNow "support\modules\tasks\main.sqf";	
#endif

#ifdef RMM_TYRES
"Tyre Changing" call mso_core_fnc_initStat;
execNow "support\modules\tyres\main.sqf";
#endif

// AAW INKO Fix
//"AAW INKO Fix" call mso_core_fnc_initStat;
//AAWinf_HelmChangeAnyWhere = true; 
//execNow "scripts\ace_aaw_fix.sqf";