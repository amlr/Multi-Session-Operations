if !(isserver) exitwith {};

private ["_array","_buildings","_center"];
_nukepos = _this select 0;

[_nukepos, 800, 1138, [], true] call bis_fnc_destroyCity; //compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";

sleep 0.9;
_array = _nukepos nearObjects ["Thing", 800];
sleep 0.1;
{_x setdammage 1} forEach _array;
sleep 0.1;
_array = _nukepos nearObjects ["Static", 800];
sleep 0.1;
{_x setdammage 1} forEach _array;
sleep 0.1;
_array = _nukepos nearObjects ["Strategic", 800];
sleep 0.1;
{_x setdammage 1} forEach _array;
sleep 0.1;
_array = _nukepos nearObjects ["NonStrategic", 800];
sleep 0.1;
{_x setdammage 1} forEach _array;
sleep 0.1;
_array = _nukepos nearObjects ["All", 1000];
sleep 0.1;
{_x setdammage 0.8} forEach _array;
sleep 0.1;
_array = _nukepos nearObjects ["Man", 1500];
{_x setdammage 0.4} forEach _array;
sleep 0.1;
//

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

[_nukepos] execvm "scripts\nuke\nuke_radzone_server.sqf";

/*
[_nukepos, 40] spawn
	{
		for "_i" from 1 to 3 do 
		{
			Sleep 2;
			[_this select 0, _this select 1, _i] spawn echo_nuke_fnc_fallout;
		};
	};
*/
