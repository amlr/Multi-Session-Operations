#define execNow call compile preprocessfilelinenumbers

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

waituntil {not isnil "BIS_fnc_init"};

["Receiving"] call RMM_fnc_failSafeLS;

execNow "scripts\cfg_groups.sqf";

if (isserver) then {
	execNow "scripts\cfg_locations.sqf";
	execNow "scripts\init_server.sqf";
};
if (not isdedicated) then {
	execvm "scripts\calltoprayer.sqf";
	execNow "briefing.sqf";
	execNow "tasks.sqf";
	execNow "scripts\init_player.sqf";
	execFSM "fsm\playersurrender.fsm";
};
execNow "modules\nomad\init.sqf";

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