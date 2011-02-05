if(isServer) then {
	private["_debug"];
	_debug = false;

	waitUntil{!isNil "BIS_fnc_init"};
	if(isNil "CRB_LOCS") then {
        	CRB_LOCS = [] call CRB_fnc_initLocations;
	};

	_logicCiv = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_alice_mainscope') then {
		BIS_alice_mainscope = _logicCiv;
		publicvariable 'BIS_alice_mainscope';
		private ["_ok"];
		if(_debug) then {
			_logicCiv setvariable ["debug", true];
		};
		BIS_alice_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
		_ok = [_logicCiv] execVM "ca\modules_e\alice2\data\scripts\main.sqf";
	};
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";

	_logicVeh = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_silvie_mainscope') then {
		BIS_silvie_mainscope = _logicVeh;
		publicvariable 'BIS_silvie_mainscope';
		private ["_ok"];
		if(_debug) then {
			_logicVeh setvariable ["debug", true];
		};
		BIS_silvie_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
		_ok = [_logicVeh] execVM "ca\modules\silvie\data\scripts\main.sqf";
	};
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";

	_logicAni = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_Animals_debug') then {
		BIS_Animals_debug = _debug;
		private ["_ok"];
		_ok = [_logicAni] execVM "CA\Modules\Animals\Data\scripts\init.sqf";
	};
};

switch(toLower(worldName)) do {
	case "zargabad": {
		[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";
	};
	case "chernarus": {
		[] spawn compile preprocessfilelinenumbers "modules\civilians\ALICE2_houseEffects.sqf";
	};
	case "utes": {
		[] spawn compile preprocessfilelinenumbers "modules\civilians\ALICE2_houseEffects.sqf";
	};
};