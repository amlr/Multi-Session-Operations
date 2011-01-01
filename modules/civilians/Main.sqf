if(isServer) then {
	private["_debug"];
	_debug = false;


	waitUntil{!isNil "BIS_fnc_init"};
	if(isNil "CRB_LOCS") then {
        	CRB_LOCS = [] call CRB_fnc_initLocations;
	};

	_logicAni = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_Animals_debug') then {
		private ["_ok"];
		BIS_Animals_debug = _debug;
		_ok = [_logicAni] execVM "CA\Modules\Animals\Data\scripts\init.sqf";
	};

	_logicVeh = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_silvie_mainscope') then {
		BIS_silvie_mainscope = _logicVeh;
		publicvariable 'BIS_silvie_mainscope';
		private ["_ok"];
		if(_debug) then {
			_logicVeh setvariable ["debug", true];
		};
		_logicVeh setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
		_ok = [_logicVeh] execVM "ca\modules\silvie\data\scripts\main.sqf";
	};
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";

	_logicCiv = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_alice_mainscope') then {
		BIS_alice_mainscope = _logicCiv;
		publicvariable 'BIS_alice_mainscope';
		private ["_ok"];
		if(_debug) then {
			_logicCiv setvariable ["debug", true];
		};
		_logicCiv setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
		_ok = [_logicCiv] execVM "ca\modules_e\alice2\data\scripts\main.sqf";
	};
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";

};

if(toLower(worldName) == "zargabad") then {
	[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";
};

