[] call compile preprocessFileLineNumbers "Init-MSO.sqf";

[0, 180] execVM "scripts\crB_scripts\crB_HideCorpses.sqf";

execVM "scripts\crB_scripts\crB_staticRearm.sqf";

if(isServer) then {
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
