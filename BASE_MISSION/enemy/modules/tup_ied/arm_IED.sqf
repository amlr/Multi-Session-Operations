// Create trigger for IED detonation
private ["_IED","_trg","_type","_shell","_proximity","_debug"];

if !(isServer) exitWith {diag_log "ArmIED Not running on server!";};
_debug = false;

_IED = _this select 0;
_type = _this select 1;

if (count _this > 2) then {
	_shell = _this select 2;
} else {
	_shell = [["Grenade","Sh_82_HE","Sh_105_HE","Sh_120_HE","Sh_125_HE"],[4,8,2,1,1]] call mso_core_fnc_selectRandomBias;
};

_proximity = 1 + round(random 7);

if (_debug) then {
	diag_log format ["MSO-%1 IED: arming IED at %2 of %3 as %4 with proximity of %5",time, position _IED,_type,_shell,_proximity];
};

_trg = createTrigger["EmptyDetector", getPos _IED]; 
_trg setTriggerArea[_proximity,_proximity,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerStatements[format ["this && ({vehicle _x in thisList} count ([] call BIS_fnc_listPlayers) > 0)",_type], format["boom = '%1' createVehicle position thisTrigger;",_shell], ""]; 

_IED setvariable ["Trigger", _trg];

if !(typeof _IED == _type) then {
	// Attach trigger to moving vehicle/person
	_trg attachTo [_IED,[0,0,0]];
};