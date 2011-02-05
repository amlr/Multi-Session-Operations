if(isServer) then {
	CRB_SERVERTW = [date, fog, overcast, rain];
	publicVariable "CRB_SERVERTW";
	onPlayerConnected {
		CRB_SERVERTW = [date, fog, overcast, rain];
		publicVariable "CRB_SERVERTW";
	};
} else {
	waitUntil{!isNil "CRB_SERVERTW"};
	waitUntil{typeName CRB_SERVERTW == "ARRAY"};
	_stime = CRB_SERVERTW select 0;
	_sfog = CRB_SERVERTW select 1;
	_sover = CRB_SERVERTW select 2;
	_srain = CRB_SERVERTW select 3;

	setDate _stime;
	0 setFog _sfog;
	0 setOvercast _sover;
	0 setRain _srain;
};

[300,500] call compile preprocessFileLineNumbers "scripts\crB_scripts\crB_HideCorpses.sqf";

[] call compile preprocessFileLineNumbers "Init-MSO.sqf";

execVM "scripts\crB_scripts\crB_staticRearm.sqf";

