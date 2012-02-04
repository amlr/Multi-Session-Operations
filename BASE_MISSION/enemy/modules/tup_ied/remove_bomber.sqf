// Remove Ambient Bomber
private ["_suic","_location"];

if !(isServer) exitWith {diag_log "RemoveBomber Not running on server!";};

_location = _this select 0;

	if (isClass(configFile>>"CfgPatches">>"reezo_eod")) then {
		_suic = nearestobject [_location,"reezo_eod_suicarea"];
		diag_log format ["Deleting %1", _suic];
		deletevehicle _suic;
	} else {
		// Ambient bomber is deleted automatically when time runs out or dies
	};
	
