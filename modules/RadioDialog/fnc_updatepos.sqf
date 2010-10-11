/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

_this set [0, round((_this select 0)/10)*10];
_this set [1, round((_this select 1)/10)*10];
_this set [2, 0];

GVAR(marker) setMarkerPosLocal _this;
GVAR(position) = _this;

//mod 100000 to get X/Y pos