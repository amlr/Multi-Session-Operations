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
	(_this select 0) spawn {
		waituntil {alive player};
		removeallweapons player;
		removeallitems player;
		player switchmove "";
		player setskill 0;
		{player disableAI _x} foreach ["move","anim","target","autotarget"];
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
