
private["_debug","_logicCiv","_logicVeh","_logicAni"];

_debug = debug_mso;

if(isNil "ambientCivs") then {ambientCivs = 1;};
if(isNil "ambientVehs") then {ambientVehs = 1;};
if(isNil "ambientAnimals") then {ambientAnimals = 1;};

waitUntil{!isNil "BIS_fnc_init"};

if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

if(!isDedicated) then {
        if (isNil "BIS_alice_mainscope" && ambientCivs == 1) then {
                _logicCiv = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
                BIS_alice_mainscope = _logicCiv;
                private ["_ok"];
                if(_debug) then {
                        _logicCiv setVariable ["debug", true];
                };
                BIS_alice_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
                _ok = [_logicCiv] execVM "ca\modules_e\alice2\data\scripts\main.sqf";
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\crB_AmbCivSetup.sqf";
        };
        
        
        if (isNil 'BIS_silvie_mainscope' && ambientVehs == 1) then {
                _logicVeh = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
                BIS_silvie_mainscope = _logicVeh;
                private ["_ok"];
                if(_debug) then {
                        _logicVeh setVariable ["debug", true];
                };
                BIS_silvie_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
                _ok = [_logicVeh] execVM "ca\modules\silvie\data\scripts\main.sqf";
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\crB_AmbVehSetup.sqf";
        };
        
        if (isNil 'BIS_Animals_debug' && ambientAnimals == 1) then {
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
