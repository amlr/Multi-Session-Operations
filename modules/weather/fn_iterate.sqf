private ["_n", "_p", "_o", "_f"];
_n = switch (true) do {
case (daytime > 18) : {3};
case (daytime > 12) : {2};
case (daytime > 6) : {1};
	default {0};
};
_p = 1 + floor(time / (24 * 60 * 60));
_o = _this select _p select 0 select _n;
_f = _this select _p select 1 select _n;
_o = _o + (random (_o * (20 / 100)) - random (_o * (20 / 100)));
_f = _f + (random (_f * (20 / 100)) - random (_f * (20 / 100)));
[overcast, fog, _o, _f, time + ((24 * 60 * 60) / 24)]