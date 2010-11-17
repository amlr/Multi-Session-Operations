#include <modules.hpp>

#define execNow call compile preprocessfilelinenumbers

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

_crb_mapclick = "";

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

_fnc_status = {
	titleText [format["Initialising: %1", _this select 0], "PLAIN DOWN", 0.5];
};

["BIS Functions"] call _fnc_status;
waituntil {not isnil "BIS_fnc_init"};


if (!isNil "paramsArray") then {
	for "_i" from 0 to ((count paramsArray)-1) do {
		missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
	};
};

BIS_MENU_GroupCommunication = [
	//--- Name, context sensitive
	["User menu",false]
	//--- Item name, shortcut, -5 (do not change), expression, show, enable
];

private "_trigger";
#ifdef RMM_AAR
	["After Action Reports"] call _fnc_status;
	execNow "modules\aar\main.sqf";
/*
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["HOTEL", "PRESENT", true];
	_trigger settriggertext "AAR";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_aar""",""];
*/
	BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
		["AAR",[4],"",-5,[["expression","createDialog ""RMM_ui_aar"""]],"1","1"]
	];
#endif
#ifdef RMM_CAS
	["View Distance Settings"] call _fnc_status;
	execNow "modules\cas\main.sqf";
/*	
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["FOXTROT", "PRESENT", true];
	_trigger settriggertext "AIRSUPREQ";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_cas""",""];
*/
	BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
		["CAS",[3],"",-5,[["expression","createDialog ""RMM_ui_cas"""]],"1","1"]
	];
#endif
#ifdef RMM_CASEVAC
	["CASEVAC"] call _fnc_status;
	execNow "modules\casevac\main.sqf";
	
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["GOLF", "PRESENT", true];
	_trigger settriggertext "CASEVAC";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_casevac""",""];
#endif
#ifdef CRB_CIVILIANS
	["Ambient Civilians"] call _fnc_status;
	execNow "modules\civilians\main.sqf";
#endif
#ifdef RMM_CNSTRCT
	["Construction"] call _fnc_status;
	execNow "modules\cnstrct\main.sqf";
#endif
#ifdef RMM_CONVOYS
	["Convoys"] call _fnc_status;
	execNow "modules\convoys\main.sqf";
#endif
#ifdef RMM_CTP
	["Call To Prayer"] call _fnc_status;
	execNow "modules\ctp\main.sqf";
#endif
#ifdef RMM_DEBUG
	["Debug"] call _fnc_status;
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["INDIA", "PRESENT", true];
	_trigger settriggertext "Debug";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_debug""",""];
#endif
#ifdef CRB_DOGS
	["Dogs"] call _fnc_status;
	execNow "modules\dogs\main.sqf";
#endif
#ifdef RMM_ENEMYPOP
	["Enemy Populate"] call _fnc_status;
	0 = [] execVM "modules\enemypop\main.sqf";
#endif
#ifdef RMM_JIPMARKERS
	["JIP Markers"] call _fnc_status;
	execNow "modules\jipmarkers\main.sqf";
	_crb_mapclick = _crb_mapclick + "if (_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";
	onMapSingleClick _crb_mapclick;
#endif
#ifdef RMM_LOGISTICS
	["Logistics"] call _fnc_status;
	execNow "modules\logistics\main.sqf";
#endif
#ifdef R3F_LOGISTICS
	["R3F Logicstics"] call _fnc_status;
	execNow "R3F_ARTY_AND_LOG\init.sqf";
#endif
#ifdef RMM_NOMAD
	["NOMAD"] call _fnc_status;
	execNow "modules\nomad\main.sqf";
#endif
#ifdef RMM_REVIVE
	["Revive"] call _fnc_status;
	waitUntil{!isnil "revive_fnc_init"};
	if (!isDedicated) then {
		player call revive_fnc_init;
	};
	revive_test call revive_fnc_init;
	revive_test setDamage 0.6;
	revive_test call revive_fnc_unconscious;
#endif
#ifdef RMM_SETTINGS
	["View Distance Settings"] call _fnc_status;
/*
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["DELTA", "PRESENT", true];
	_trigger settriggertext "Settings";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_settings""",""];
*/	
	BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
		["Settings",[2],"",-5,[["expression","createDialog ""RMM_ui_settings"""]],"1","1"]
	];
#endif
#ifdef RMM_TASKS
	["JIP Tasks"] call _fnc_status;
	execNow "modules\tasks\main.sqf";	
	_crb_mapclick = _crb_mapclick + "if (_alt) then {RMM_task_position = _pos; createDialog ""RMM_ui_tasks"";};";
	onMapSingleClick _crb_mapclick;
#endif
#ifdef RMM_TYRES
	["Tyre Changing"] call _fnc_status;
	execNow "modules\tyres\main.sqf";
#endif
#ifdef RMM_WEATHER
	["Weather"] call _fnc_status;
	execNow "modules\weather\main.sqf";
#endif
#ifdef RMM_ZORA
	["ZORA"] call _fnc_status;
	execNow "modules\zora\main.sqf";
#endif

["Completed"] call _fnc_status;
