waitUntil{!isNil "BIS_fnc_init"};

_this addAction ["Check forecast",  CBA_fnc_actionargument_path, [_this,{[_this] call weather_fnc_forecast}]];
