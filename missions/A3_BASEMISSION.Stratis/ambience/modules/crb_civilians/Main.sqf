
private ["_debug","_logicVeh","_logicAni","_spawnAI"];

_debug = debug_mso;

if(isNil "ambientCivs") then {ambientCivs = 1;};
if(isNil "ambientVehs") then {ambientVehs = 1;};
if(isNil "ambientAnimals") then {ambientAnimals = 1;};
if(isnil "ambientLocality") then {ambientLocality = 0;};
_spawnAI = false;
switch (ambientLocality) do {
        case 0: {_spawnAI = isServer};
        default {_spawnAI = isHC};
};

waitUntil{!isNil "BIS_fnc_init"};

if(isServer && isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

if (ambientCivs == 1 ) then {
        
        if(_spawnAI) then {
			if(isNil "BIS_alice_mainscope") then {
				BIS_alice_mainscope = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
            };
            BIS_alice_mainscope setVariable ["townlist",(BIS_functions_mainscope getVariable "locations")];
            BIS_ALICE2_fnc_civilianSet = compile preprocessFileLineNumbers "ca\modules_e\alice2\data\scripts\fn_civilianSet.sqf";
            [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\crB_AmbCivSetup.sqf";
            [BIS_alice_mainscope] call compile preprocessFileLineNumbers "ca\modules_e\alice2\data\scripts\main.sqf";
            publicVariable "BIS_alice_mainscope";
        };
        
        waitUntil {!isNil "BIS_alice_mainscope"};
        
        if !(isServer) then {
        	BIS_alice_mainscope setVariable ["AliceLogic",true,true];
        };
        
		if(_debug) then {
			BIS_alice_mainscope setVariable ["debug", true];
		};
        
        if	(
                ((!isDedicated && !isHC) || // client
                (!isDedicated && isServer) || // hosted server
                !isMultiplayer) // single player
        	) then {
			BIS_ALICE_fnc_houseEffects = compile preprocessFileLineNumbers "CA\modules\Alice\data\scripts\fnc_houseEffects.sqf";
			[] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\ALICE2_houseEffects.sqf";
		};
};

if(_spawnAI) then {
        if (isNil "BIS_silvie_mainscope" && ambientVehs == 1) then {
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
        
        if (isNil "BIS_Animals_debug" && ambientAnimals == 1) then {
                _logicAni = (createGroup sideLogic) createUnit ["LOGIC", [0,0,0], [], 0, "NONE"];
                BIS_Animals_debug = _debug;
                private ["_ok"];
                _ok = [_logicAni] execVM "CA\Modules\Animals\Data\scripts\init.sqf";
        };
};

if !(AmbientLocality == 0) then {
	if (isDedicated && ambientCivs == 1) then {
				[] spawn {
	                private ["_ALICE_logic_group"];
		        	while {true} do {
	                    sleep (900 + (random 60));
			            {
			                if (local _x && {_x getvariable "AliceLogic"}) then {
	                            diag_log format["Cleaning abandoned ALICE Logic %1 from Server",_x];
	                            _ALICE_logic_group = group _x;
			                    deletevehicle _x;
	                            deletegroup _ALICE_logic_group;
			                };
	                    } foreach (allmissionobjects "LOGIC");
	            };
	       };
	};
};

switch(toLower(worldName)) do {
        case "zargabad": {
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\CIV_City.sqf";
        };
};
