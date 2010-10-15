#define execNow call compile preprocessfilelinenumbers

//http://community.bistudio.com/wiki/startLoadingScreen
startLoadingScreen ["", "RscDisplayLoadMission"];

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

waituntil {not isnil "BIS_fnc_init"};

["",10] call RMM_fnc_failSafeLS;

// ====================================================================================
// Mission Scripts

if (!isNil "paramsArray") then {
	for "_i" from 0 to ((count paramsArray)-1) do {
		missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
	};
};

if (isserver) then {
	execVM "scripts\zora.sqf";
	//execNow "scripts\init_server.sqf";
};
if (not isdedicated) then {
	execNow "briefing.sqf";
	execNow "tasks.sqf";
	
	execvm "scripts\calltoprayer.sqf";
	execNow "scripts\init_player.sqf";
};

// ====================================================================================
// Modules

execNow "modules\cas\main.sqf";
execNow "modules\casevac\main.sqf";
execNow "modules\cnstrct\main.sqf";
execNow "modules\jipmarkers\main.sqf";
execNow "modules\logistics\main.sqf";
execNow "modules\nomad\main.sqf";
execNow "modules\tyres\main.sqf";

"RMM_MPe" addPublicVariableEventHandler {
	private ["_data","_locality","_params","_code"];
	_data = _this select 1;
	_locality = _data select 0;
	_params = _data select 1;
	_code = _data select 2;

	if (switch (_locality) do {
		case 0 : {true};
		case 1 : {isserver};
		case 2 : {not isdedicated};
		default {false};
	}) then {
		if (isnil "_params") then {call _code} else {_params call _code};
	};
};

endLoadingScreen;
