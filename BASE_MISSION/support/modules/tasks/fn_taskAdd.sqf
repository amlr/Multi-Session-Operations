private ["_taskname","_description","_destination","_playerSide"];
_taskname = _this select 0;
_description = _this select 1;
_destination = _this select 2;
_playerSide = if(count _this > 3) then {_this select 3;} else {playerSide;};


if (_playerSide == playerSide) then {
	private "_task";
	_task = player createsimpletask [_taskname];
	_task setsimpletaskdescription _description;
	_task setsimpletaskdestination _destination;
	_task settaskstate "created";
	missionnamespace setvariable [_taskname,_task];

	RMM_mytasks set [count RMM_mytasks, _task];
	_task;
};

