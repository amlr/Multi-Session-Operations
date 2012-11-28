#include <crbprofiler.hpp>

if (isnil "ZORAmaxgrps") then {ZORAmaxgrps = 3};
if (isnil "ZORAmindist") then {ZORAmindist = 750};

if (!(isserver) or (ZORAmaxgrps == 0)) exitwith {diag_log format["MSO-%1 ZORA exiting...", time];};

private ["_logicZora"];
_logicZora = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
if (isnil 'BIS_Zora_mainscope') then {
        BIS_Zora_MainScope = _logicZora;
        if (isServer) then {
                private ["_ok"];
                //		_ok = [_logicZora] execVM "ca\modules\zora\data\scripts\main.sqf"
                _ok = [_logicZora] execVM "enemy\modules\rmm_zora\zora.sqf"
        };
};

waitUntil{!isNil "BIS_Zora_Mainscope"};

#define NIGHT_POSSIBILITY 0.2 //Percentage (0.2 == 20%)

BIS_Zora_Mainscope setVariable ["debug",false];
BIS_Zora_Mainscope setvariable ["bordersize",10000];
BIS_Zora_Mainscope setvariable ["factionlist",MSO_FACTIONS];
BIS_Zora_Mainscope setvariable ["search_radius",300];
BIS_Zora_Mainscope setvariable ["maxgroups",ZORAmaxgrps];
BIS_Zora_Mainscope setvariable ["mindist",ZORAmindist];
BIS_Zora_Mainscope setvariable ["maxdist", 2000];

[] spawn {
        private ["_mx","_fnc_status","_waittime"];
	_waittime = 0;
	BIS_Zora_pause = true;

        _fnc_status = {
                if (BIS_Zora_Mainscope getvariable "debug") then {
                        hint format["ZORA Pause: %1\nMaxGroups: %2", BIS_Zora_pause, BIS_Zora_mainscope getvariable "maxgroups"];
                };
        };
        

	while {true} do {
		CRBPROFILERSTART("RMM ZORA")

                _waittime = 60;
                if (count playableUnits > 0) then {
                        _mx = floor( (sqrt (count playableUnits)) + random 1);
                        if(_mx > 5) then {_mx = 5;};
                        BIS_Zora_mainscope setvariable ["maxgroups", _mx];
                };
                if ((random 1 > NIGHT_POSSIBILITY) && (daytime < 5 || daytime > 18)) then {
                        BIS_Zora_pause = true;
                        call _fnc_status;
                        _waittime = (60 * 60) + ((random 60) * 60);
                } else {
                        if(BIS_Zora_pause) then {
                                call _fnc_status;
                                _waittime = ((random 60) * 10);
                                BIS_Zora_pause = false;
                        } else {
                                call _fnc_status;
                                _waittime = ((random 60) * 10);
                                BIS_Zora_pause = true;
                        };
                };

		CRBPROFILERSTOP
		sleep _waittime;
        };
};
