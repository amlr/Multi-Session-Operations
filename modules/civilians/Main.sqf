if(isServer) then {

	waitUntil{!isNil "BIS_fnc_init"};
	if(isNil "CRB_LOCS") then {
      	CRB_LOCS = [] call CRB_fnc_initLocations;
	};

/*	private["_towns"];
	_towns = [];	{
		if(type _x in ["CityCenter"]) then {
			_towns = _towns + [_x];
		};
	} forEach CRB_LOCS;
*/
/*	_logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
	if (isnil 'BIS_alice_mainscope') then {
		BIS_alice_mainscope = _logic;
		publicvariable 'BIS_alice_mainscope';
		if (isServer) then {
			private ["_ok"];
			_ok = [_logic] execVM "ca\modules_e\alice2\data\scripts\main.sqf";
		};
	};
*/
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";
};

if(toLower(worldName) == "zargabad") then {
	[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";
};

