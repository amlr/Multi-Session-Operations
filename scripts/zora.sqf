if (not isserver) exitwith {};

#define NIGHT_POSSIBILITY 0.2 //Percentage (0.2 == 20%)

waituntil {not isnil "BIS_Zora_pause"};
while {true} do {
	if ((random 1 > NIGHT_POSSIBILITY) && (daytime < 5 || daytime > 18)) then {
		BIS_Zora_pause = true;
	} else {
		BIS_Zora_pause = not BIS_Zora_pause;
	};
	if (playersnumber west > 0) then {
		BIS_Zora_mainscope setvariable ["maxgroups",round (((8+random 4) / (playersnumber west)) min 5) max 1];
	};
	if (BIS_Zora_Mainscope getvariable "debug") then {
		hint format["ZORA Pause: %1\nMaxGroups: %2", BIS_Zora_pause, BIS_Zora_mainscope getvariable "maxgroups"];
	};
	sleep (random 7200);
};