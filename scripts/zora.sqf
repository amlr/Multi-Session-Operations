if (not isserver) exitwith {};

waituntil {not isnil "BIS_Zora_pause"};
while {true} do {
	if ((1 > random 0.2) && (daytime < 5 || daytime > 18)) then {
		BIS_Zora_pause = true;
	} else {
		BIS_Zora_pause = not BIS_Zora_pause;
	};
	if (playersnumber west > 0) then {
		BIS_Zora_mainscope setvariable ["maxgroups",round (((8+random 4) / (playersnumber west)) min 5) max 1];
	};
	sleep (random 3600);
};