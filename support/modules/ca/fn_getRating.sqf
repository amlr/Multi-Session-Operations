private ["_sum"];
_sum = 0;
{
	_sum = _sum + (rating _x);
} foreach (units _this);
_sum;