#define execNow call compile preprocessfilelinenumbers

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

waituntil {not isnil "BIS_fnc_init"};

//["Receiving",3] call RMM_fnc_failSafeLS;

execNow "scripts\cfg_groups.sqf";

if (isserver) then {
	execNow "scripts\cfg_locations.sqf";
	//execNow "scripts\init_server.sqf";
	execNow "scripts\farp.sqf";
};
if (not isdedicated) then {
	execNow "briefing.sqf";
	execNow "tasks.sqf";
	
	execvm "scripts\calltoprayer.sqf";
	execNow "scripts\init_player.sqf";
	execFSM "fsm\playersurrender.fsm";
};

// http://www.ofpec.com/forum/index.php?topic=34033.0;all
// refers to params by name to remove array order errors
if (isserver) then {
	for [{_i = 0},{_i < count(paramsArray)},{_i = _i + 1}] do {
		call compile format ["PARAMS_%1 = %2;",(configName ((missionConfigFile >> "Params") select _i)),(paramsArray select _i)];
	};
};

execNow "modules\nomad\main.sqf";

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

//endLoadingScreen;