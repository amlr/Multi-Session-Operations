private ["_posElevNowZ","_posElevNow"];
_posElevNow = getPosASL myElevator;
_posElevNowZ = _posElevNow select 2;

while {_posElevNowZ > -15 && myElevatorStatus == 0} do {
	_posElevNowZ = _posElevNowZ - 0.025;
	myElevator setPosASL [_posElevNow select 0, _posElevNow select 1, _posElevNowZ];
	sleep 0.1;
};
myElevatorStatus = 1;
publicVariable "myElevatorStatus";
