#include <crbprofiler.hpp>

if (isnil "ZORAmaxgrps") then {ZORAmaxgrps = 1};
if (isnil "ZORAmindist") then {ZORAmindist = 1500};
if (ZORAmaxgrps == 0) exitwith {diag_log format["MSO-%1 ZORA exiting...", time];};

// Exit if not HC and not a server
if(isnil "ZORALocality") then {ZORALocality = 0;};
if (
	switch (ZORALocality) do {
	        case 0: {!isServer};
        	case 1: {!isHC};
	}
) exitWith{};

private ["_logicZora"];
_logicZora = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
if (isnil 'BIS_Zora_mainscope') then {
        BIS_Zora_MainScope = _logicZora;
	private ["_ok"];
//		_ok = [_logicZora] execVM "ca\modules\zora\data\scripts\main.sqf"
	_ok = [_logicZora] execVM "enemy\modules\rmm_zora\zora.sqf"
};

waitUntil{!isNil "BIS_Zora_Mainscope"};

#define NIGHT_POSSIBILITY 0.2 //Percentage (0.2 == 20%)

BIS_Zora_Mainscope setVariable ["debug",false];
BIS_Zora_Mainscope setvariable ["bordersize",10000];
BIS_Zora_Mainscope setvariable ["factionlist",MSO_FACTIONS];
BIS_Zora_Mainscope setvariable ["search_radius",500];
BIS_Zora_Mainscope setvariable ["maxgroups",ZORAmaxgrps];
BIS_Zora_Mainscope setvariable ["mindist",ZORAmindist];
BIS_Zora_Mainscope setvariable ["maxdist", ZORAmindist * 2.5];

[] spawn {
        private ["_mx","_fnc_status","_waittime"];
	_waittime = 0;
	BIS_Zora_pause = true;

        _fnc_status = {
                if (BIS_Zora_Mainscope getvariable "debug") then {
                        hint format["ZORA Pause: %1\nMaxGroups: %2", BIS_Zora_pause, BIS_Zora_mainscope getvariable "maxgroups"];
                };
        };
        

	waitUntil {
		CRBPROFILERSTART("RMM ZORA")

		_waittime = 60 * (30 + random 90); // wait between 30 min to 2hr
                /*
                if (count playableUnits > 0) then {
                        _mx = floor( (sqrt (count playableUnits)) + random 1);
                        if(_mx > 5) then {_mx = 5;};
                        BIS_Zora_mainscope setvariable ["maxgroups", _mx];
                };
                */
                if ((random 1 > NIGHT_POSSIBILITY) && (daytime < 5 || daytime > 18)) then {
                        BIS_Zora_pause = true;
                        call _fnc_status;
                } else {
                        if(BIS_Zora_pause) then {
                                BIS_Zora_pause = false;
                                call _fnc_status;
	                        _waittime = 340 * ZORAmaxgrps; // 340s comes from zora.fsm _time2Wait
                        } else {
                                BIS_Zora_pause = true;
                                call _fnc_status;
                        };
                };

		CRBPROFILERSTOP
		sleep _waittime;
                false;
        };
};
