#include <modules\modules.hpp>

#ifndef execNow
	#define execNow call compile preprocessfilelinenumbers
#endif

MSO_FACTIONS = [];
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

private ["_crb_mapclick","_fnc_status"];
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

mso_menuname = "Multi-Session Operations";
mso_interaction_key = if (!isNil "ace_sys_interaction_key_self") then {
	ace_sys_interaction_key_self
} else {
	[221,[false,false,false]]
};
mso_fnc_hasRadio = if (!isNil "ACE_fnc_hasRadio") then {
	{if(player call ACE_fnc_hasRadio) then {true} else {hint "You require a radio.";false;};}
} else {
	{if(player hasWeapon "itemRadio") then {true} else {hint "You require a radio.";false;};}
};

BIS_MENU_GroupCommunication = [
	//--- Name, context sensitive
	["User menu",false]
	//--- Item name, shortcut, -5 (do not change), expression, show, enable
];

fnc_updateMenu = {
	private["_name","_exp"];
	_name = _this select 0;
	_exp = _this select 1;
	BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
		[_name,[count BIS_MENU_GroupCommunication + 1],"",-5,[["expression",_exp]],"1","1"]
	];
};	

_fnc_status = {
	private["_stage"];
	_stage = _this;
	
	if (isServer && isNil "CRB_INIT_STATUS") then {
		CRB_INIT_STATUS = [];
		publicVariable "CRB_INIT_STATUS";
	};
	waitUntil{!isNil "CRB_INIT_STATUS"};

	if (isServer) then {
		CRB_INIT_STATUS = CRB_INIT_STATUS + [_stage];
		publicVariable "CRB_INIT_STATUS";
	};

	waitUntil{_stage in CRB_INIT_STATUS};
	player sideChat format["Initialising: %1", _stage];
};

"Custom Locations(" + worldName + ")" call _fnc_status;
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
       	CRB_LOCS = [] call CRB_fnc_initLocations;
};

"Mission Parameters" call _fnc_status;
if (!isNil "paramsArray") then {
	for "_i" from 0 to ((count paramsArray)-1) do {
		missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
	};
};

"Player" call _fnc_status;
execNow "scripts\init_player.sqf";

setViewDistance 2000;
setTerrainGrid 25;

MSO_R_Admin = true;
MSO_R_Leader = true;
MSO_R_Officer = true;
MSO_R_Air = true;
MSO_R_Crew = true;

#ifdef RMM_MP_RIGHTS
	"MP Rights" call _fnc_status;
	execNow "modules\mp_rights\main.sqf";
#endif

//player globalChat "Initialise First Aid Fix";
//[] execVM "scripts\firstaidfix.sqf";

#ifdef RMM_DEBUG
	"Debug" call _fnc_status;
	execNow "modules\debug\main.sqf";
#endif
#ifdef RMM_NOMAD
	"NOMAD" call _fnc_status;
	execNow "modules\nomad\main.sqf";
#endif
#ifdef CRB_CIVILIANS
	"Ambient Civilians" call _fnc_status;
	execNow "modules\civilians\main.sqf";
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
	execNow "modules\aar\main.sqf";
#endif
#ifdef RMM_CAS
	"Close Air Support" call _fnc_status;
	execNow "modules\cas\main.sqf";
#endif
#ifdef RMM_CASEVAC
	"CASEVAC" call _fnc_status;
	execNow "modules\casevac\main.sqf";
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
#ifdef GC_PACK_COW
	"Gen Carver's Pack Cow" call _fnc_status;
	execNow "modules\gc_pack_cow\main.sqf";
#endif
#ifdef RMM_JIPMARKERS
	"JIP Markers" call _fnc_status;
	execNow "modules\jipmarkers\main.sqf";
#endif
#ifdef RMM_LOGISTICS
	"Logistics" call _fnc_status;
	execNow "modules\logistics\main.sqf";
#endif
#ifdef RMM_NOTEBOOK
	"Notebook" call _fnc_status;
	execNow "modules\notebook\main.sqf";
#endif
#ifdef R3F_LOGISTICS
	"R3F Logistics" call _fnc_status;
	execNow "modules\R3F_logistics\init.sqf";
#endif
#ifdef RMM_SETTINGS
	"View Distance Settings" call _fnc_status;
	execNow "modules\settings\main.sqf";	
#endif
#ifdef RMM_TASKS
	"JIP Tasks" call _fnc_status;
	execNow "modules\tasks\main.sqf";	
#endif
#ifdef RMM_TYRES
	"Tyre Changing" call _fnc_status;
	execNow "modules\tyres\main.sqf";
#endif
#ifdef RMM_WEATHER
	"Weather" call _fnc_status;
	execNow "modules\weather\main.sqf";
#endif
#ifdef CRB_DOGS
	"Dogs" call _fnc_status;
	["WEST"] execNow "modules\dogs\main.sqf";
#endif
#ifdef RMM_CONVOYS
	"Convoys" call _fnc_status;
	execNow "modules\convoys\main.sqf";
#endif
#ifdef RMM_ZORA
	"ZORA" call _fnc_status;
	execNow "modules\zora\main.sqf";
#endif
#ifdef RMM_ENEMYPOP
	"Enemy Populate" call _fnc_status;
	execNow "modules\enemypop\main.sqf";
#endif

"Completed" call _fnc_status;
sleep 5;

"AAW INKO Fix" call _fnc_status;
// AAW INKO Fix
waitUntil{!isNil "inko_disposable_ammo_player" && !isNil "inko_disposable_ammo_ai"};
{terminate _x;} foreach [inko_disposable_ammo_player,inko_disposable_ammo_ai];
inko_disposable_throw = {};
inko_disposable_fired = {};
inko_disposable_oa = false;

hint "Change your View Distance Settings using the 0-8 Communications menu.";
