if (not isdedicated) then {
	if (not isnil {_this getvariable "logistics"}) then {
		_this call TK_fnc_addLogistics;
	};
	if (_this iskindof "Car") then {
		_this call TK_fnc_spareTyres;
	};
	if (not isnil {_this getvariable "construction"}) then {
		_this call TK_fnc_addBuild;
	};
	if (_this iskindof "Air") then {
		_this addeventhandler ["GetIn",{if (((_this select 1) == "driver") and ((_this select 1) == player)) then {_this spawn RMM_fnc_logbook_openLog}}];
	};
};