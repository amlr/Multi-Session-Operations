private ["_taskname","_description","_destination"];
_taskname = _this select 0;
_description = _this select 1;
_destination = _this select 2;

private "_task";
_task = player createsimpletask [_taskname];
_task setsimpletaskdescription _description;
_task setsimpletaskdestination _destination;
_task settaskstate "created";

missionnamespace setvariable [_taskname,_task];

_task
