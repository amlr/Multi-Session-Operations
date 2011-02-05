private ["_x0", "_y0", "_x1", "_y1", "_t0", "_t1"];
_x0 = _this select 0;
_y0 = _this select 1;
_x1 = (_this select 2) max 0.01;
_y1 = (_this select 3) max 0.01;
_t0 = _this select 4;
_t1 = (_this select 5) max 3600;

diag_log format["MSO-%1 Weather Sync: x0=%2 y0=%3 x1=%4 y1=%5 t0=%6 t1=%7", time, _x0, _y0, _x1, _y1, _t0, _t1];

//Linear interpolation
0 setovercast (_x0 + (time - _t0) * ((_x1 - _x0)/(_t1 - _t0)));
0 setfog (_y0 + (time - _t0) * ((_y1 - _y0)/(_t1 - _t0)));

(_t1 - time) setovercast _x1;
//temp until BIS lift their game, no transition of fog
//0 setfog _y1;
(_t1 - time) setfog _y1;
