// Original script by Tom Nedry
// Panzergrenadierbataillon 417
// http://www.pzgrenbtl417.eu/

private ["_nearestTargets","_type","_pos","_dir"];
_nearestTargets = nearestObjects [position _this, ["Land_LHD_elev_R"], 20];
myElevator = _nearestTargets select 0;
_type = typeOf myElevator;
_pos = getPosASL myElevator;
_dir = direction myElevator;
deleteCollection myElevator;

if (isServer) then {
	myElevator = _type createvehicleLocal _pos;
	myElevator setDir _dir;
	myElevator setPosASL _pos;
	publicVariable "myElevator";

	myElevatorStatus = 0;
	publicVariable "myElevatorStatus";
	//nul = [] execVM "scripts\tn_createLiftLhd.sqf";
} else {
	_type = typeOf myElevator;
	_pos = getPosASL myElevator;
	_dir = direction myElevator;
	myElevator = _type createvehicleLocal _pos;
	myElevator setDir _dir;
	myElevator setPosASL _pos;
};

waitUntil{!isNil "myElevatorStatus"};
