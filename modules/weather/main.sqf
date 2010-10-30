weather_days = 10;
//weather_weights = [];

if (not isserver) then {
	"RMM_w" addpublicvariableeventhandler {(_this select 1) call weather_fnc_sync;};
	RMM_w call weather_fnc_sync;
} else {

	if (isnil "RMM_w") then {
		RMM_w = [
			overcast, //new overcast% (0-1)
			fog, //new fog% (0-1)
			overcast, //prior overcast% (0-1)
			fog, //prior fog% (0-1)
			0  //transition time (seconds)
		];
		publicvariable "RMM_w";
	};
};