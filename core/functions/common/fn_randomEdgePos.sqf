private ["_mapsize","_height","_debug","_name","_color","_icon","_edgepos","_edge"];
_mapsize = _this select 0;
_height = _this select 1;
_debug = _this select 2;
_name = _this select 3;
_color = _this select 4;
_icon = _this select 5;

_edgepos = [];

_edge = round(random 3);
switch (_edge) do 
{
		case 0: {x = (random _mapsize)-10; y = _mapsize;}; // top edge
		case 1: {x = _mapsize; y = (random _mapsize)-10;}; // right edge
		case 2: {x = (random _mapsize); y = 10;}; // bottom edge
		case 3: {x = 10; y = (random _mapsize);}; // left edge
};
z = _height;

_edgepos = [x,y,z];

if (_debug) then 
{

		private["_t"];
		_t = format["%1", floor(random 10000)];
		_m = [_t, _edgepos, "Icon", [0.5,0.5], "TYPE:", _icon, "TEXT:", _name, "COLOR:", _color, "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
};

_edgepos;