#include <crbprofiler.hpp>

#include "script_component.hpp"

#include "XEH_pre_init.sqf"
#include "XEH_post_init.sqf"

_debug = false;
jcache_stats = "";

// player debug stuff
if(!isDedicated && _debug) then {
	[] spawn FUNC(showDebugMarkers);
};

if(!isDedicated) then {
	if (isNull player) then {
		waitUntil {!(isNull player)};
		player setVariable ["jwac_isJip", true, false];
	} else {
		player setVariable ["jwac_isJip", false, false];
	};
};

if(isServer) then {
        diag_log format["MSO-%1 JCaching (%2) Starting", time,"SERVER"];

	// setup jcache units
	#define JCACHE_RANGE_INFANTRY 		1000
	#define JCACHE_RANGE_VEHICLE 		1500
	#define JCACHE_RANGE_AIRCRAFT 		2000
	
	waitUntil{typeName allGroups == "ARRAY"};
	waitUntil{typeName allUnits == "ARRAY"};
	waitUntil{typeName playableUnits == "ARRAY"};

        [{
                CRBPROFILERSTART("JCaching server")
                
                private ["_params","_debug"];
                _params = _this select 0;
                _debug = _params select 0;
                {
			if(!((leader _x) getVariable [QUOTE(GVAR(isLeader)), false])) then {
				[leader _x, [JCACHE_RANGE_INFANTRY, JCACHE_RANGE_VEHICLE, JCACHE_RANGE_AIRCRAFT] ] call jayai_sys_cache_fnc_addGroup;
			};
                } forEach allGroups;
                

                if(jcache_stats != format["Groups: %1 All/Active/Deactivated Unit Count: %2/%3/%4", (count GVAR(masterGroupList)), (count allUnits), ((count allUnits) - GVAR(deactivatedCount)), GVAR(deactivatedCount) ]) then {
                        jcache_stats = format["Groups: %1 All/Active/Deactivated Unit Count: %2/%3/%4", (count GVAR(masterGroupList)), (count allUnits), ((count allUnits) - GVAR(deactivatedCount)), GVAR(deactivatedCount) ];
                        diag_log format["MSO-%1 JCaching (%2) # %3", time,"SERVER", jcache_stats];
                };
                
                CRBPROFILERSTOP
        }, 1, [_debug]] call mso_core_fnc_addLoopHandler;
};

