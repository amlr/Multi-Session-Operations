if !(isserver) exitwith {};
private ["_id"];

_nuke_rad_pos = _this select 0;

_id = floor(random 1000);

_markername = call compile format["""rad_zone_id_%1""",_id];
_markerobj = createMarker [_markername, _nuke_rad_pos];
_markername setMarkerShape "ELLIPSE";
_markername setMarkerType "Destroy";
_markername setMarkerColor "ColorOrange";
_markername setMarkerSize [1000,1000];
_markername setMarkerBrush "SOLID";
_markername setMarkerAlpha 0.3;

_markernameicon = call compile format["""rad_zone_icon_id_%1""",_id];
_markerobj1 = createMarker [_markernameicon, _nuke_rad_pos];
_markernameicon setMarkerShape "ICON";
_markernameicon setMarkerColor "ColorRed";
_markernameicon setMarkerType "Destroy";
_markernameicon setMarkerText "Nuclear Radiation";

_cnt = 0;
_ctm = 2;

while {_cnt < 14400} do {

_array = _nuke_rad_pos nearObjects ["Man", (1000 + floor(random 500))];
{_x setdammage ((getdammage _x) + 0.03)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Tank", (500)];
{_x setdammage ((getdammage _x) + 0.01)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Air", (500)];
{_x setdammage ((getdammage _x) + 0.01)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Ship", (500)];
{_x setdammage ((getdammage _x) + 0.01)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Car", (500)];
{_x setdammage ((getdammage _x) + 0.01)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Man", (500 + floor(random 200))];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Tank", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Air", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Ship", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

_array = _nuke_rad_pos nearObjects ["Car", (250)];
{_x setdammage ((getdammage _x) + 0.05)} forEach _array;
sleep 0.2;

sleep 8;

//if (_nuke_rad_pos distance player  < 250) then {hintsilent parseText "<t color='#ff3300' size='2.0' shadow='1' shadowColor='#000000' align='center'>RADIATION ZONE</t>"};

_cnt = _cnt + 10;
};

deletemarker _markername;
deletemarker _markernameicon;
nuke = true;
"colorCorrections" ppEffectEnable FALSE;