#include <modules.hpp>

#define execNow call compile preprocessfilelinenumbers

MSO_FACTIONS = [];
CRB_LOCS = [];
if(!isNil "faction_BIS_TK") then {
	if(faction_BIS_TK == 1) then {
		MSO_FACTIONS = MSO_FACTIONS + ["BIS_TK"];
	};
};
if(!isNil "faction_BIS_TK_INS") then {
	if(faction_BIS_TK_INS == 1) then {
		MSO_FACTIONS = MSO_FACTIONS + ["BIS_TK_INS"];
	};
};
if(!isNil "faction_BIS_TK_GUE") then {
	if(faction_BIS_TK_GUE == 1) then {
		MSO_FACTIONS = MSO_FACTIONS + ["BIS_TK_GUE"];
	};
};
if(count MSO_FACTIONS == 0) then {MSO_FACTIONS = ["BIS_TK_GUE"];};

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

private ["_crb_mapclick","_fnc_status","_fnc_updateMenu"];
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

"CRB_init_status" addPublicVariableEventHandler {
	private["_stage"];
	_stage = _this select 1;
//	titleText [format["Initialising: %1", _this select 0], "PLAIN DOWN", 0.5];
	[playerSide, "Base"] sideChat format["Initialising: %1", _stage];
};

_fnc_status = {
	private["_stage"];
	_stage = _this;

	if (isServer) then {
		if(isNil "CRB_init_status") then {
			CRB_init_status = "Starting";
			publicVariable "CRB_init_status";
		};
	};
	waitUntil{!isNil "CRB_init_status"};

	if (isServer) then {
		CRB_init_status = _stage;
		publicVariable "CRB_init_status";
		[playerSide, "Base"] sideChat format["Initialising: %1", _stage];
	};
};

"Missions" call _fnc_status;
waitUntil{!isNil "CRB_init_status"};
[playerSide, "Base"] sideChat format["Initialising: %1", CRB_init_status];

"BIS Functions" call _fnc_status;
waituntil {not isnil "BIS_fnc_init"};

"Locations" call _fnc_status;
if(isServer) then {
	CRB_LOCS = [] call CRB_fnc_initLocations;
};

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

_fnc_updateMenu = {
	_name = _this select 0;
	_exp = _this select 1;
	BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
		[_name,[count BIS_MENU_GroupCommunication + 1],"",-5,[["expression",_exp]],"1","1"]
	];
};	

"Player" call _fnc_status;
MSO_R_Admin = false;
MSO_R_Leader = false;
MSO_R_Officer = false;
MSO_R_Air = false;
MSO_R_Crew = false;
if (not isdedicated) then {
	execNow "scripts\init_player.sqf";
};

//player globalChat "Initialise First Aid Fix";
//[] execVM "scripts\firstaidfix.sqf";

setViewDistance 2000;
setTerrainGrid 25;

#ifdef RMM_DEBUG
"Debug" call _fnc_status;
if (MSO_R_Admin) then {
	["Debug","createDialog ""RMM_ui_debug"""] call _fnc_updateMenu;
};
#endif
#ifdef RMM_NOMAD
	"NOMAD" call _fnc_status;
	execNow "modules\nomad\main.sqf";
#endif
#ifdef RMM_REVIVE
	"Revive" call _fnc_status;
	waitUntil{!isnil "revive_fnc_init"};
	if (!isDedicated) then {
		player call revive_fnc_init;
	};
	revive_test call revive_fnc_init;
	revive_test setDamage 0.6;
	revive_test call revive_fnc_unconscious;
#endif
#ifdef RMM_AAR
"After Action Reports" call _fnc_status;
if (MSO_R_Leader) then {
	execNow "modules\aar\main.sqf";
	["AAR","createDialog ""RMM_ui_aar"""] call _fnc_updateMenu;
};
#endif
#ifdef RMM_CAS
"Close Air Support" call _fnc_status;
if (MSO_R_Leader) then {
	execNow "modules\cas\main.sqf";
	["CAS","createDialog ""RMM_ui_cas"""] call _fnc_updateMenu;
};
#endif
#ifdef RMM_CASEVAC
"CASEVAC" call _fnc_status;
if (MSO_R_Leader) then {
	execNow "modules\casevac\main.sqf";
	["CASEVAC","createDialog ""RMM_ui_casevac"""] call _fnc_updateMenu;
};
#endif
#ifdef RMM_CNSTRCT
	"Construction" call _fnc_status;
	execNow "modules\cnstrct\main.sqf";
#endif
#ifdef RMM_CTP
	"Call To Prayer" call _fnc_status;
	execNow "modules\ctp\main.sqf";
#endif
#ifdef CRB_FLIPPABLE
	"Flippable Vehicles" call _fnc_status;
	execNow "modules\flippable\main.sqf";
#endif
#ifdef RMM_JIPMARKERS
"JIP Markers" call _fnc_status;
execNow "modules\jipmarkers\main.sqf";
if (MSO_R_Leader) then {
	_crb_mapclick = _crb_mapclick + "if (!_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";
	onMapSingleClick _crb_mapclick;
};
#endif
#ifdef RMM_LOGISTICS
	"Logistics" call _fnc_status;
	execNow "modules\logistics\main.sqf";
#endif
#ifdef R3F_LOGISTICS
	"R3F Logicstics" call _fnc_status;
	execNow "R3F_ARTY_AND_LOG\init.sqf";
#endif
#ifdef RMM_SETTINGS
	"View Distance Settings" call _fnc_status;
	["Settings","createDialog ""RMM_ui_settings"""] call _fnc_updateMenu;
#endif
#ifdef RMM_TASKS
"JIP Tasks" call _fnc_status;
execNow "modules\tasks\main.sqf";	
if (MSO_R_Leader) then {
	_crb_mapclick = _crb_mapclick + "if (_shift && _alt) then {RMM_task_position = _pos; createDialog ""RMM_ui_tasks"";};";
	onMapSingleClick _crb_mapclick;
};
#endif
#ifdef RMM_TYRES
	"Tyre Changing" call _fnc_status;
	execNow "modules\tyres\main.sqf";
#endif
#ifdef RMM_WEATHER
	"Weather" call _fnc_status;
	execNow "modules\weather\main.sqf";
#endif
#ifdef CRB_CIVILIANS
	"Ambient Civilians" call _fnc_status;
	execNow "modules\civilians\main.sqf";
#endif
#ifdef CRB_DOGS
	"Dogs" call _fnc_status;
	execNow "modules\dogs\main.sqf";
#endif
#ifdef RMM_CONVOYS
	"Convoys" call _fnc_status;
	execNow "modules\convoys\main.sqf";
#endif
#ifdef RMM_ENEMYPOP
	"Enemy Populate" call _fnc_status;
	execNow "modules\enemypop\main.sqf";
#endif
#ifdef RMM_ZORA
	"ZORA" call _fnc_status;
	execNow "modules\zora\main.sqf";
#endif

"Completed" call _fnc_status;
sleep 5;

hint "Change your View Distance Settings using the 0-8 Communications menu.";
