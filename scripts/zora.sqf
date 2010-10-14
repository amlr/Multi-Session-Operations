if (not isserver) exitwith {};

while {true} do {
	sleep (sleep (random 3600));
	if ((1 > random 0.2) && (daytime < 6 || daytime > 18)) then {
		BIS_Zora_pause = true;
	} else {
		BIS_Zora_pause = not BIS_Zora_pause;
	};
};