waituntil {not isnull player};
waituntil {getplayeruid player != ""};

player call revive_fnc_init;

onMapSingleClick "if (_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";
RMM_jipmarkers_types = ["mil_objective","mil_marker","mil_flag","mil_ambush","mil_destroy","mil_start","mil_end","mil_pickup","mil_join","mil_warning","mil_unknown"];

player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];

player addeventhandler ["killed", {
	(_this select 0) spawn {
		waituntil {alive player};
		removeallweapons player;
		removeallitems player;
		player switchmove "";
		player setskill 0;
		{player disableAI _x} foreach ["move","anim","target","autotarget"];
	};
}];

//custom weapons per signups
private ["_uid","_string","_default"];
_uid = getplayeruid player;
_string = format ["RMM_nomad_%1",_uid];
_default = ["itemwatch","itemmap","itemcompass","itemradio"];

MSO_R = [];
MSO_R_Admin = false;
MSO_R_Leader = false;
MSO_R_Officer = false;
MSO_R_Air = false;
MSO_R_Tank = false;

{
	_x call TK_fnc_vehicle;
} foreach vehicles;

private "_exit";
_exit = false;
{
	if (_uid == (_x select 0)) exitwith {
		MSO_R = _x select 2;
		MSO_R_Admin = "admin" in MSO_R;
		MSO_R_Leader = (_x select 1) in ["CORPORAL","LIEUTENANT"];
		MSO_R_Officer = (_x select 1) == "LIEUTENANT";
		MSO_R_Air = ("pilot" in MSO_R) || MSO_R_Admin;
		MSO_R_Tank = ("crew" in MSO_R) || MSO_R_Admin;
	};
} foreach [
	["822401", 		"CORPORAL",		["crew"]],	//Ryan
	["1022977",		"PRIVATE",		["crew"]],	//Glenn
	["1062145", 	"CORPORAL",		["crew"]], 	//Antipop
	["1019521", 	"PRIVATE",		["pilot"]], //Innomadic
	["1065345", 	"CORPORAL",		["pilot"]], //Tank
	["3048774",		"LIEUTENANT",	["admin"]], //Rommel
];

//default weapons
if (isnil _string) then {
	removeallweapons player;
	player addBackpack "BAF_AssaultPack_RifleAmmo";
};

//settings dialog
private "_trigger";
_trigger = createtrigger ["emptydetector", [0,0]];
_trigger settriggeractivation ["DELTA", "PRESENT", true];
_trigger settriggertext "Settings";
_trigger settriggerstatements ["this","createDialog ""RMM_ui_settings""",""];

if (MSO_R_Admin) then {
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["ECHO", "PRESENT", true];
	_trigger settriggertext "Debug";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_debug""",""];
};