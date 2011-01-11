if (isserver) then {
	RMM_w = [
		overcast, //oldovercast% (0-1)
		fog, //old fog% (0-1)
		overcast, //new overcast% (0-1)
		fog, //new fog% (0-1)
		time, // start
		time // finish
	];
	publicvariable "RMM_w";
	[] spawn {
		while {true} do {
			if (time > (RMM_w select 5)) then {
				RMM_w = [RMM_w select 2, RMM_w select 3, random 1, 0, time, time + 3600];
				RMM_w call weather_fnc_sync;
				publicvariable "RMM_w";
			};
			sleep (((RMM_w select 5) - time) max 1);
		};
	};
};

if (!isserver) then {
	"RMM_w" addpublicvariableeventhandler {(_this select 1) call weather_fnc_sync;};
	if (!isnil "RMM_w") then {
		RMM_w call weather_fnc_sync;
	};
};