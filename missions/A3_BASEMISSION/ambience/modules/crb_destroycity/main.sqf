private ["_blacklist","_fire"];
if(isNil "destroyCityIntensity") then {destroyCityIntensity = 0;};
if(isNil "destroyCityFire") then {destroyCityFire = 1;};
if(destroyCityIntensity > 0) then {
        _blacklist = ((markerPos "respawn_guerrila") nearObjectS ["House", 50]) +
        ((markerPos "respawn_guerrila_1") nearObjects ["House", 50]) +
        ((markerPos "respawn_guerrila_2") nearObjects ["House", 50]) +
        ((markerPos "respawn_guerrila_3") nearObjects ["House", 50]) +
        ((markerPos "respawn_west") nearObjects ["House", 50]) +
        ((markerPos "respawn_east") nearObjects ["House", 50]);       

        waitUntil{!isNil "bis_functions_mainscope"};
        waitUntil{typeName (bis_functions_mainscope getVariable "locations") == "ARRAY"};

        {
                _fire = if(destroyCityFire == 1) then {true;} else {false;};
                [position _x, 250, 529, _blacklist, _fire] call compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";
                if(destroyCityIntensity > 1) then {
                        [position _x, 350, 889, _blacklist, _fire] call compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";
                };
                if(destroyCityIntensity > 2) then {
                        [position _x, 500, 1138, _blacklist, _fire] call compile preprocessFileLineNumbers "ambience\modules\crb_destroycity\fn_destroyCity.sqf";
                };
        } forEach (bis_functions_mainscope getVariable "locations");
};
