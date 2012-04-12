// Create trigger for IED detonation
private ["_IED","_trg","_type","_shell","_proximity","_debug"];

if !(isServer) exitWith {diag_log "ArmIED Not running on server!";};
_debug = debug_mso;

_IED = _this select 0;
_type = _this select 1;

if (count _this > 2) then {
	_shell = _this select 2;
} else {
	_shell = [["Grenade","Sh_82_HE","Sh_105_HE","Sh_120_HE","Sh_125_HE"],[4,8,2,1,1]] call mso_core_fnc_selectRandomBias;
};

_proximity = 2 + floor(random 10);

if (_debug) then {
	diag_log format ["MSO-%1 IED: arming IED at %2 of %3 as %4 with proximity of %5",time, getposATL _IED,_type,_shell,_proximity];
	//Mark IED position
	_t = format["ied_r%1", random 10000];
	_tcrm = [_t, position _IED, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
	_IED setvariable ["Marker", _tcrm];
};

_trg = createTrigger["EmptyDetector", getposATL _IED]; 
_trg setTriggerArea[_proximity,_proximity,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL  vehicle _x) select 2 < 8)} count ([] call BIS_fnc_listPlayers) > 0)", format["_bomb = nearestObject [getposATL (thisTrigger), '%1']; boom = '%2' createVehicle getposATL _bomb;",_type,_shell], ""]; 

_IED setvariable ["Trigger", _trg];

if !(typeof _IED == _type) then {
	// Attach trigger to moving vehicle/person
	_trg attachTo [_IED,[0,0,-0.5]];
};