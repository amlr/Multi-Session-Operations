#include <modules.hpp>

#define execNow call compile preprocessfilelinenumbers

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

BIS_MENU_GroupCommunication = [
	//--- Name, context sensitive
	["User menu",false]
	//--- Item name, shortcut, -5 (do not change), expression, show, enable
];

_fnc_updateMenu = {
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
CRB_LOC_DIST = 20000;
switch(worldName) do {		
	case "Zargabad": {
		{createLocation ["BorderCrossing",_x,1,1]} foreach [[3430,8150,0],[2925,50,0],[3180,50,0],[5048,50,0]];
		CRB_LOC_DIST = 8000;
	};
	case "Takistan": {
		{createLocation ["Airport",_x,1,1]} foreach [[8223.19,2061.85,0],[5930.27,11448.6,0]];
		{createLocation ["Hill",_x,1,1]} foreach [[8920.66,714.553,0],[10319.4,1218.97,0],[12581.9,2178.44,0],[11685.9,991.194,0],[11618.2,4436.46,0],[11028.5,4835.42,0],[2452.82,1939.11,0],[647.538,1643.94,0],[10225.3,8232.91,0],[11674.3,6853.18,0],[12789,7618.6,0],[12184.7,6021.2,0],[1275.98,9420.36,0],[513.379,11028.7,0],[1113.06,8122.78,0],[2371.7,6577.14,0],[1060.01,6651.81,0],[4536.94,7755.62,0],[2295.62,9966.96,0],[2570.21,3192.34,0],[252.362,3600.79,0],[246.873,4723.34,0],[1339.24,4838.62,0],[239.294,8757.12,0],[12642.3,8997.8,0],[12576.9,12244.5,0],[7286.22,7497.08,0]];
		{createLocation ["CityCenter",_x,1,1]} foreach [[12313.5,11114.6,0],[10399.5,10995.1,0],[4170.93,10750.5,0],[5699.74,9955.47,0],[5952.89,10510.5,0],[6798.94,8916.04,0],[3232.02,3590.37,0],[3558.18,1298.96,0],[11835,2606.36,0],[6825.74,12253.1,0],[3558.18,1298.96,0],[1994.64,363.664,0],[375.252,2820.15,0],[1007.07,3141.99,0],[1491.9,3587.9,0],[2512.47,5097.5,0],[12318.6,10355.2,0],[6496.12,2108.43,0],[8999.51,1875.36,0]];
		{createLocation ["VegetationBroadleaf",_x,1,1]} foreach [[9640.95,6525.55,0],[10520.5,11069.6,0],[11911.9,11404.1,0],[6560.22,8974.16,0],[6779.77,6447.93,0],[4720.27,6736.85,0],[1438.47,6471.23,0],[1792.54,7291.65,0],[1114.61,6998.03,0],[1427.67,7865.95,0],[3327.58,8157.63,0],[2817.08,7842,0],[3398.73,10150.9,0],[3754.9,10505.1,0],[4122.55,10924.5,0],[2099.97,11448.4,0],[1929.8,10896.7,0],[1295.79,10482.3,0],[771.562,10471.3,0],[1449.49,11152,0],[1636.12,11700.9,0],[4611.67,12356,0],[6060.86,10697.6,0],[5819.05,10129.8,0],[5540.54,9490.73,0],[5880.46,8095.92,0],[5899.95,6356.44,0],[5105.43,5415.11,0],[4153.31,4450.04,0],[3213.64,3635.48,0],[4155.61,2329.04,0],[6787.2,1170.57,0],[7256.12,1237.37,0],[7490.13,1797.91,0],[9947.27,2324.41,0],[11123.1,2416.85,0],[11989.9,2868.59,0],[9527.37,3125.18,0],[8554.62,2993.05,0],[7855.69,3268.79,0],[9372.79,4572.87,0],[8917.63,4224.71,0],[1002.54,3143.03,0],[919.325,4241.86,0],[2718.33,871.307,0],[5043.3,860.979,0],[5873.79,1441.81,0],[5872.73,5710.01,0],[9290.46,10049.5,0],[9300.97,9215.94,0],[9311.09,12159,0],[11603.3,10190.1,0],[12600.1,11069.8,0],[12324.8,11113.6,0]];
		{createLocation ["BorderCrossing",_x,1,1]} foreach [[2057.5239,362.24213,0],[7418.6284,44.116211,0],[11943.901,2565.1956,0],[10968.563,6296.1953,0],[11443.324,8196.7363,0],[12640.246,9830.0742,0],[12749.133,10970.265,0],[11057.035,12744.979,0],[9163.8604,12728.431,0],[7149.5513,12744.669,0],[4560.1128,12736.298,0],[2461.167,12747.017,0],[1908.5356,12610.614,0],[883.67908,10455.702,0],[33.667603,7077.9468,0],[96.891769,5524.3794,0],[242.14958,2836.0496,0]];
		CRB_LOC_DIST = 16000;
	};
};

"Mission Parameters" call _fnc_status;
if (!isNil "paramsArray") then {
	for "_i" from 0 to ((count paramsArray)-1) do {
		missionNamespace setVariable [configName ((missionConfigFile/"Params") select _i),paramsArray select _i];
	};
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
