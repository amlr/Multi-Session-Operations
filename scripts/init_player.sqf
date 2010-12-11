waituntil {not isnull player};
waituntil {!isMultiplayer || getplayeruid player != ""};

////////////////////////////////////////////////////////////
// Respawn Handling
////////////////////////////////////////////////////////////

private ["_uid","_string"];
_uid = getplayeruid player;

player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];

player addeventhandler ["killed", {
	player setVariable ["respawn", [
		magazines player,
		weapons player,
		typeof (unitbackpack player),
		getmagazinecargo (unitbackpack player),
		getweaponcargo (unitbackpack player)
	], true];

	diag_log format["Killed: %1", player getVariable "respawn"];

	removeallweapons player; removeallitems player;
	removebackpack player;

}];

player addeventhandler ["respawn", {
	diag_log format["Respawn: %1", player getVariable "respawn"];
	private["_obj", "_mags","_weps","_bp","_bpm","_bpw"];
	_obj = player getVariable "respawn";
	_mags = _obj select 0;
	_weps = _obj select 1;
	_bp = _obj select 2;

	{player removeweapon _x;} foreach ((weapons player) + (items player));
	{player removemagazine _x;} foreach (magazines player);

	{player addmagazine _x;} foreach _mags;
	{player addweapon _x;} foreach _weps;
	player selectweapon (primaryweapon player);
	if (_bp != "") then {
		_bpm = _obj select 3;
		_bpw = _obj select 4;

		player addbackpack _bp;
		clearweaponcargo (unitbackpack player);
		clearmagazinecargo (unitbackpack player);

		for "_i" from 0 to ((count (_bpm select 0))-1) do {
			(unitbackpack player) addmagazinecargo [(_bpm select 0) select _i,(_bpm select 1) select _i];
		};
		for "_i" from 0 to ((count (_bpw select 0))-1) do {
			(unitbackpack player) addweaponcargo [(_bpw select 0) select _i,(_bpw select 1) select _i];
		};
	};
}];

////////////////////////////////////////////////////////////
// Specialty Handling
////////////////////////////////////////////////////////////

MSO_R = [];
MSO_R_Admin = false;
MSO_R_Leader = false;
MSO_R_Officer = false;
MSO_R_Air = false;
MSO_R_Crew = false;

private "_exit";
_exit = false;


{
	if (_uid == (_x select 0)) exitwith {
		MSO_R = _x select 2;
		MSO_R_Admin = "admin" in MSO_R;
		MSO_R_Leader = (_x select 1) in ["CORPORAL","SERGEANT","LIEUTENANT"] || MSO_R_Admin;
		MSO_R_Officer = (_x select 1) == "LIEUTENANT" || MSO_R_Admin;
		MSO_R_Air = ("pilot" in MSO_R) || MSO_R_Admin;
		MSO_R_Crew = ("crew" in MSO_R) || MSO_R_Admin;
	};
	if (!isMultiPlayer) exitWith {
		MSO_R_Admin = true;
		MSO_R_Leader = true;
		MSO_R_Officer = true;
		MSO_R_Air = true;
		MSO_R_Crew = true;
	};
} foreach [
	["822401", 		"CORPORAL",		["crew"]],	//Ryan
	["1022977",		"PRIVATE",		["crew"]],	//Glenn
	["1062145", 	"CORPORAL",		["crew"]], 	//Antipop
	["1019521", 	"PRIVATE",		["pilot"]], //Innomadic
	["1065345", 	"CORPORAL",		["pilot"]], //Tank
	["3048774",		"LIEUTENANT",	["admin"]], //Rommel
	["3076038",		"LIEUTENANT",	["admin"]], //Wolffy.au
	["3165254", 	"SERGEANT",		["pilot","crew"]], //Swordsman
	["1965894", 	"CORPORAL",		["crew"]], //Chappy
	["3165446", 	"CORPORAL",		["crew"]], //Delta 51
	["3158150", 	"CORPORAL",		["pilot","crew"]], //Floydii
	["1048961", 	"CORPORAL",		["crew"]] //Swedge
	//[getplayeruid player, rank player, []] //careful, if pubbers around? Need discussion on limits of this first maybe
];

MSO_R_Leader = (rank player) in ["CORPORAL","SERGEANT","LIEUTENANT"] || MSO_R_Leader;
MSO_R_Officer = (rank player) == "LIEUTENANT" || MSO_R_Officer;
//MSO_R_Air = (player isKindOf "pilot") || MSO_R_Air;
//MSO_R_Crew = (player isKindOf "crew") ||MSO_R_Crew;

if (MSO_R_Air and ((getMarkerpos "farp") distance [0,0,0] > 0)) then { //ensure marker exists
	"farp" setmarkertypelocal "Faction_BritishArmedForces_BAF";
};

{
	if (_x iskindof "Air") then {
		if (not MSO_R_Air) then {
			_x lockdriver true;
		};
	};
	if (_x iskindof "Tank") then {
		if (not MSO_R_Crew) then {
			_x lockdriver true;
		};
	};
} foreach vehicles;
