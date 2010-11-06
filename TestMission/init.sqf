#include <modules.hpp>

#define execNow call compile preprocessfilelinenumbers

enableSaving [false, false];

waituntil {not isnil "BIS_fnc_init"};

if (!isNil "paramsArray") then {
	for "_i" from 0 to ((count paramsArray)-1) do {
		missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
	};
};

//execNow "modules\jipmarkers\main.sqf";
#ifdef RMM_LOGISTICS
	execNow "modules\logistics\main.sqf";
#endif
#ifdef RMM_NOMAD
	execNow "modules\nomad\main.sqf";
#endif
#ifdef RMM_SETTINGS
	execNow "modules\settings\main.sqf";
#endif
#ifdef RMM_CNSTRCT
	execNow "modules\cnstrct\main.sqf";
#endif
#ifdef RMM_JIPMARKERS
	execNow "modules\jipmarkers\main.sqf";
	onMapSingleClick "if (_shift) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";}";
#endif
#ifdef RMM_TASKS
	execNow "modules\tasks\main.sqf";	
	onMapSingleClick "if (_alt) then {RMM_task_position = _pos; createDialog ""RMM_ui_tasks"";}";
#endif
#ifdef RMM_REVIVE
waitUntil{!isnil "revive_fnc_init"};
revive_test call revive_fnc_init;
revive_test setDamage 0.6;
revive_test call revive_fnc_unconscious;
#endif

#ifdef RMM_TYRES
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
#endif

private "_trigger";
#ifdef RMM_SETTINGS
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["DELTA", "PRESENT", true];
	_trigger settriggertext "Settings";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_settings""",""];
#endif
#ifdef RMM_CAS
	execNow "modules\cas\main.sqf";
	
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["FOXTROT", "PRESENT", true];
	_trigger settriggertext "AIRSUPREQ";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_cas""",""];
#endif
#ifdef RMM_CASEVAC
	execNow "modules\casevac\main.sqf";
	
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["GOLF", "PRESENT", true];
	_trigger settriggertext "CASEVAC";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_casevac""",""];
#endif
#ifdef RMM_AAR
	execNow "modules\aar\main.sqf";
	
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["HOTEL", "PRESENT", true];
	_trigger settriggertext "AAR";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_aar""",""];
#endif

_trigger = createtrigger ["emptydetector", [0,0]];
_trigger settriggeractivation ["INDIA", "PRESENT", true];
_trigger settriggertext "Debug";
_trigger settriggertype "none";
_trigger settriggerstatements ["this","createDialog ""RMM_ui_debug""",""];