private ["_x0", "_y0", "_x1", "_y1", "_t0", "_t1"];
_x0 = _this select 0;
_y0 = _this select 1;
_x1 = _this select 2;
_y1 = _this select 3;
_t0 = _this select 4;
_t1 = _this select 5;

//Linear interpolation
0 setovercast (_x0 + (time - _t0) * ((_x1 - _x0)/(_t1 - _t0) min 1));
0 setfog (_y0 + (time - _t0) * ((_y1 - _y0)/(_t1 - _t0) min 1));

//temp until BIS lift their game, no transition of fog
0 setfog _y1;
(_t1 - time) setovercast _x1;

//(_t1 - time) setfog _y1;