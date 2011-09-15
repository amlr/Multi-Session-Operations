if(isNil "ambientEnvironment") then {ambientEnvironment = 1;};

if(isServer && ambientEnvironment == 1) then {
        private["_debug","_logicCiv","_logicVeh","_logicAni"];
        
        _debug = false;

	if(isNil "ambientCivs") then {ambientCivs = 1;};
	if(isNil "ambientVehs") then {ambientVehs = 1;};
	if(isNil "ambientAnimals") then {ambientAnimals = 1;};
 
        waitUntil{!isNil "BIS_fnc_init"};

        if(isNil "CRB_LOCS") then {
                CRB_LOCS = [] call mso_core_fnc_initLocations;
        };
        
        if (isnil 'BIS_alice_mainscope' && ambientCivs == 1) then {
	        _logicCiv = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
                BIS_alice_mainscope = _logicCiv;
                publicvariable 'BIS_alice_mainscope';
                private ["_ok"];
                if(_debug) then {
                        _logicCiv setvariable ["debug", true];
                };
                BIS_ALICE2_fnc_civilianSet = compile preprocessFileLineNumbers "ca\modules_e\alice2\data\scripts\fn_civilianSet.sqf";
                BIS_alice_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
                //		_ok = [_logicCiv] execVM "ca\modules\alice\data\scripts\main.sqf";
                _ok = [_logicCiv] execVM "ca\modules_e\alice2\data\scripts\main.sqf";
	        [] call compile preprocessfilelinenumbers "ambience\modules\crb_civilians\crB_AmbCivSetup.sqf";
        };
        
        if (isnil 'BIS_silvie_mainscope' && ambientVehs == 1) then {
	        _logicVeh = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
                BIS_silvie_mainscope = _logicVeh;
                publicvariable 'BIS_silvie_mainscope';
                private ["_ok"];
                if(_debug) then {
                        _logicVeh setvariable ["debug", true];
                };
                BIS_silvie_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
                _ok = [_logicVeh] execVM "ca\modules\silvie\data\scripts\main.sqf";
	        [] call compile preprocessfilelinenumbers "ambience\modules\crb_civilians\crB_AmbVehSetup.sqf";
        };
        
        if (isnil 'BIS_Animals_debug' && ambientAnimals == 1) then {
	        _logicAni = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
                BIS_Animals_debug = _debug;
                private ["_ok"];
                _ok = [_logicAni] execVM "CA\Modules\Animals\Data\scripts\init.sqf";
        };
};

switch(toLower(worldName)) do {
        case "zargabad": {
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\CIV_City.sqf";
        };
};
