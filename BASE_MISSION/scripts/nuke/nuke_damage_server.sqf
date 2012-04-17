if !(isserver) exitwith {};

private ["_nukepos"];
_nukepos = _this select 0;

_array = _nukepos nearObjects ["All", 500];
sleep 0.1;
[_array] spawn {
	{_x setdammage 1.0;
	sleep 0.1;
	} forEach (_this select 0);
};

_buildings = nearestObjects [_nukepos,["Static"], 800]; 
{_x setDamage 1} foreach _buildings;
sleep 0.1;

_array = (nearestObjects [_nukepos,[], 100]) - ((_nukepos) nearObjects 800);
{DeleteCollection _x} forEach _array;
sleep 0.1;

_array = (nearestObjects [_nukepos,[], 200]) - ((_nukepos) nearObjects 1000);
{_x setdammage ((getdammage _x) + 1.0)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["All", 1000];
{_x setdammage ((getdammage _x) + 0.2)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Man", 1500];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Land", 1200];
{_x setdammage ((getdammage _x) + 0.3)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Ship", 1200];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Motorcycle", 1000];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Car", 1200];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Air", 1200];
{_x setdammage ((getdammage _x) + 0.5)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Tank", 1200];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Thing", 1000];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Static", 1000];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["Strategic", 1000];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = _nukepos nearObjects ["NonStrategic", 1000];
{_x setdammage ((getdammage _x) + 0.4)} forEach _array;
sleep 0.1;

_array = nil;

//radarea = "HeliHEmpty" createVehicle _nukepos;
[_nukepos] execvm "scripts\nuke\nuke_radzone_server.sqf";
