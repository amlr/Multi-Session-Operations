if !(isserver) exitwith {};
private ["_nukepos"];

_nukepos = _this select 0;

_cnt = 0;
_ctm = 2;

while {_cnt < 7200} do {

_array = _nukepos nearObjects ["Man", (1000)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Tank", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Air", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Ship", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Car", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Man", (1000)];
{_x setdammage ((getdammage _x) + 0.1)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Tank", (500)];
{_x setdammage ((getdammage _x) + 0.01)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Air", (500)];
{_x setdammage ((getdammage _x) + 0.02)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Ship", (500)];
{_x setdammage ((getdammage _x) + 0.02)} forEach _array;
sleep 0.2;

_array = _nukepos nearObjects ["Car", (500)];
{_x setdammage ((getdammage _x) + 0.02)} forEach _array;
sleep 0.2;

sleep 8;

//if (_nukepos distance player  < 250) then {hintsilent parseText "<t color='#ff3300' size='2.0' shadow='1' shadowColor='#000000' align='center'>RADIATION ZONE</t>"};

_array = nil;
_cnt = _cnt + 10;
};

deletemarker "areaee";
_nukepos = nil;
nuke = true;
"colorCorrections" ppEffectEnable FALSE;