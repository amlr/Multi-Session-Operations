{
	if (lifestate _x != "alive") then {
		dogetout _x;
		_x action ["eject", vehicle _x];
	};
} foreach crew (_this select 0);
(_this select 0) removeaction (_this select 2);