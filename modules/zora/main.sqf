if (not isserver) exitwith {};

waitUntil{!isNil "BIS_Zora_Mainscope"};

#define NIGHT_POSSIBILITY 0.2 //Percentage (0.2 == 20%)

BIS_Zora_Mainscope setVariable ["debug",true];
BIS_Zora_Mainscope setvariable ["bordersize",10000];
BIS_Zora_Mainscope setvariable ["factionlist",MSO_FACTIONS];
BIS_Zora_Mainscope setvariable ["search_radius",5000];
BIS_Zora_Mainscope setvariable ["maxgroups",1];
BIS_Zora_Mainscope setvariable ["mindist",1500];
BIS_Zora_Mainscope setvariable ["maxdist", 2500];

[] spawn {
	_fnc_status = {
		if (BIS_Zora_Mainscope getvariable "debug") then {
			hint format["ZORA Pause: %1\nMaxGroups: %2", BIS_Zora_pause, BIS_Zora_mainscope getvariable "maxgroups"];
		};
	};
			
	while {true} do {
		if (count playableUnits > 0) then {
			BIS_Zora_mainscope setvariable ["maxgroups",round (((8+random 4) / (count playableUnits)) min 5) max 1];
		};
		if ((random 1 > NIGHT_POSSIBILITY) && (daytime < 5 || daytime > 18)) then {
			BIS_Zora_pause = true;
			call _fnc_status;
			sleep (60 * 60) + (random 60 * 60);
		} else {
			if(BIS_Zora_pause) then {
				call _fnc_status;
				sleep (random 60 * 60);
				BIS_Zora_pause = false;
			} else {
				call _fnc_status;
				sleep (random 60 * 60);
				BIS_Zora_pause = true;
			};
		};
	};
};