private ["_nearestTargets","_type","_pos","_dir"];
_nearestTargets = nearestObjects [position _this, ["Land_LHD_elev_R"], 20];
myElevator = _nearestTargets select 0;
_type = typeOf myElevator;
_pos = getPosASL myElevator;
_dir = direction myElevator;
deleteCollection myElevator;

if (isServer) then {
	myElevator = _type createvehicle _pos;
	myElevator setDir _dir;
	myElevator setPosASL _pos;
	publicVariable "myElevator";

	myElevatorStatus = 0;
	publicVariable "myElevatorStatus";
	//nul = [] execVM "scripts\tn_createLiftLhd.sqf";
};

waitUntil{!isNil "myElevatorStatus"};