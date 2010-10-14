waituntil {not isnull player};
waituntil {getplayeruid player != ""};

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

private ["_uid","_string"];
_uid = getplayeruid player;
_string = format ["RMM_nomad_%1",_uid];

MSO_R = [];
MSO_R_Admin = false;
MSO_R_Leader = false;
MSO_R_Officer = false;
MSO_R_Air = false;
MSO_R_Crew = false;

private "_exit";
_exit = false;

#include <mso_signups.hpp>

if (MSO_R_Air) then {
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

//default weapons
if (isnil _string) then {
	removeallweapons player;
	player switchmove "";
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

if (MSO_R_Leader) then {
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["FOXTROT", "PRESENT", true];
	_trigger settriggertext "Close Air Support";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_cas""",""];
};