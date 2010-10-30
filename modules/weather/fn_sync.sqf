MSO_fnc_weather_sync = {
	0 setovercast (_this select 2);
	0 setfog (_this select 3);

	private "_time";
	_time = 0 max ((_this select 4) - time);

	_time setovercast (_this select 0);
	_time setfog (_this select 1);
};