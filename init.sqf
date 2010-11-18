#include <modules.hpp>

#define execNow call compile preprocessfilelinenumbers

//http://community.bistudio.com/wiki/startLoadingScreen
//startLoadingScreen ["Receiving", "RscDisplayLoadMission"];

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

// Temp: JIP users complaining they were getting stuck on loading screen
//["Receiving",10] call RMM_fnc_failSafeLS;

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
//	titleText [format["Initialising: %1", _this select 0], "PLAIN DOWN", 0.5];
	[playerSide, "Base"] sideChat format["Initialising: %1", _this select 0];
};

["BIS Functions"] call _fnc_status;
waituntil {not isnil "BIS_fnc_init"};

if (!isNil "paramsArray") then {
	for "_i" from 0 to ((count paramsArray)-1) do {
		missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
	};
};

// ====================================================================================
// Mission Scripts

// ====================================================================================
// Modules
BIS_MENU_GroupCommunication = [
	//--- Name, context sensitive
	["User menu",false]
	//--- Item name, shortcut, -5 (do not change), expression, show, enable
];
_fnc_updateMenu = {
	_name = _this select 0;
	_exp = _this select 1;
	BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
		[_name,[count BIS_MENU_GroupCommunication + 1],"",-5,[["expression",_exp]],"1","1"]
	];
};	

MSO_R_Admin = false;
MSO_R_Leader = false;
MSO_R_Officer = false;
MSO_R_Air = false;
MSO_R_Crew = false;
if (not isdedicated) then {
	execNow "scripts\init_player.sqf";
	execNow "briefing.sqf";
	execNow "tasks.sqf";
};

private "_trigger";
#ifdef RMM_AAR
if (MSO_R_Leader) then {
	["After Action Reports"] call _fnc_status;
	execNow "modules\aar\main.sqf";
	["AAR","createDialog ""RMM_ui_aar"""] call _fnc_updateMenu;
};
#endif
#ifdef RMM_CAS
if (MSO_R_Leader) then {
	["Close Air Support"] call _fnc_status;
	execNow "modules\cas\main.sqf";
	["CAS","createDialog ""RMM_ui_cas"""] call _fnc_updateMenu;
};
#endif
#ifdef RMM_CASEVAC
if (MSO_R_Leader) then {
	["CASEVAC"] call _fnc_status;
	execNow "modules\casevac\main.sqf";
	["CASEVAC","createDialog ""RMM_ui_casevac"""] call _fnc_updateMenu;
};
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
if (MSO_R_Admin) then {
	["Debug"] call _fnc_status;
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["INDIA", "PRESENT", true];
	_trigger settriggertext "Debug";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_debug""",""];
};
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
if (MSO_R_Leader) then {
	["JIP Markers"] call _fnc_status;
	execNow "modules\jipmarkers\main.sqf";
	_crb_mapclick = _crb_mapclick + "if (_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";
	onMapSingleClick _crb_mapclick;
};
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
#endif
#ifdef RMM_SETTINGS
	["View Distance Settings"] call _fnc_status;
	["Settings","createDialog ""RMM_ui_settings"""] call _fnc_updateMenu;
#endif
#ifdef RMM_TASKS
if (MSO_R_Leader) then {
	["JIP Tasks"] call _fnc_status;
	execNow "modules\tasks\main.sqf";	
	_crb_mapclick = _crb_mapclick + "if (!_shift && _alt) then {RMM_task_position = _pos; createDialog ""RMM_ui_tasks"";};";
	onMapSingleClick _crb_mapclick;
};
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

["Complete"] call _fnc_status;
