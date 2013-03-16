scriptName "Zora\data\scripts\functions\setZones.sqf";
/*
	File: setParams.sqf
	Author: Karel Moricky

	Description:
	Change ZoRA zones during mission.
	Set param to -1 to have it unchanged.

	Parameter(s):
	_this select 0: zone trigger ID
	_this select 1: new pos [x,y]
	_this select 2: new size [rel x,rel y]
	_this select 3: new direction
	_this select 4: new shape (ellipse - false, rectangle - true)
*/

_id = _this select 0;
_pos = _this select 1;
_size = _this select 2;
_dir = _this select 3;
_shape = _this select 4;

_debug = BIS_zora_mainscope getvariable "debug";

//--- Get triggers
_triglist = BIS_Zora_MainScope getvariable "triglist";
_triglistdead = BIS_Zora_MainScope getvariable "triglistdead";
_trigger = _triglist select _id;
_triggerdead = _triglistdead select _id;

//--- Old values
_bordersize = BIS_zora_mainscope getvariable "bordersize";
_tposX = position _trigger select 0;
_tposY = position _trigger select 1;
_tsizeX = triggerarea _trigger select 0;
_tsizeY = triggerarea _trigger select 1;
_tdir = triggerarea _trigger select 2;
_tshape = triggerarea _trigger select 3;

//hint str(_trigger);

//--- New values
if (typename _pos == "ARRAY") then {
	_tposX = _pos select 0;
	_tposY = _pos select 1;
};
if (typename _size == "ARRAY") then {
	_tsizeX = _size select 0;
	_tsizeY = _size select 1;
};
if (typename _dir == "SCALAR") then {
	if (_tdir != -1) then {
		_tdir = _dir;
	};
};
if (typename _shape == "BOOL") then {
	_tshape = _shape;
};

//--- Set new values
_trigger setpos [_tposX,_tposY];
_trigger settriggerarea [_tsizeX,_tsizeY,_tdir,_tshape];
_triggerdead setpos [_tposX,_tposY];
_triggerdead settriggerarea [_tsizeX + _bordersize,_tsizeY + _bordersize,_tdir,_tshape];
//hint str _trigger;

if (_debug) then {
	_markershape = if (_tshape) then {"RECTANGLE"} else {"ELLIPSE"};
	_markerx1 = format ["BIS_zora_zone_%1",_id];
	_markerx1 setmarkerpos [_tposX,_tposY];
	_markerx1 setmarkersize [_tsizeX,_tsizeY];
	_markerx1 setmarkerdir _tdir;
	_markerx1 setmarkershape _markershape;
	_markerx2 = format ["BIS_zora_zonedead_%1",_id];
	_markerx2 setmarkerpos [_tposX,_tposY];
	_markerx2 setmarkersize [_tsizeX + _bordersize,_tsizeY + _bordersize];
	_markerx2 setmarkerdir _tdir;
	_markerx2 setmarkershape _markershape;
};