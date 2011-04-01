if (!isServer) exitWith{};

private["_debug","_types","_d","_tarea","_dogs", "_side"];
_debug = true;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_ambience_fnc_initLocations;
};

_types = ["FlatArea","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
_d = 100;
_tarea = 500;
_dogs = [];
_side = "WEST";
if(count _this > 0) then {
        _side = _this select 0;
};

{
        if(type _x in _types) then {
                if (random 1 > 0.9) then {
                        private["_name","_dx","_dy","_pos","_trg","_m"];
                        _name = format["wdtrg_%1", floor(random 10000)];
                        if(_debug) then {
                                diag_log format["MSO-%1 Dog Packs: createTrigger %2", time, _name];
                                hint format["MSO-%1 Dog Packs: createTrigger %2", time, _name];
                        };
                        
                        // randomise wild dog positions
                        _pos = position _x;
                        _pos = [_pos, 0, _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
                        _trg = createTrigger["EmptyDetector", _pos];
                        call compile format["%1 = _trg;", _name];
                        _trg setTriggerActivation [_side, "PRESENT", true];
                        _trg setTriggerArea [_tarea, _tarea, 0, false];
                        _trg setTriggerStatements ["isServer && this", format["wdgrp_%1 = [%1, thislist] call dogs_fnc_wilddogs;", _name], format["{deleteVehicle _x} foreach units wdgrp_%1; [wdgrp_%1 getVariable ""handle""] call CBA_fnc_removePerFrameHandler; deleteGroup wdgrp_%1;", _name]];
                        
                        if (_debug) then {
                                hint format["Dogs: creating m_%1",  _name];
                                ["m_" + _name, _pos, "ELLIPSE", [_tarea,_tarea], "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                                ["tm_" + _name, _pos,  "Icon", [1,1], "TYPE:", "Dot", "TEXT:", "Wilddogs",  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                        };
                        _dogs = _dogs + [[_name, _trg]];
                };
        };
} forEach CRB_LOCS;


[{
        private ["_dogs","_pos","_d","_name","_trg","_debug", "_params"];
        _params = _this select 0;
        _dogs = _params select 0;
        _d = _params select 1;
        _debug = _params select 2;
        
        {
                _name = _x select 0;
                _trg = _x select 1;
                // randomise wild dog positions
                _pos = position _trg;
                _pos = [_pos, 0, _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
                _trg setPos _pos;
                if(_debug)then{
                        hint format["Dogs: moving %1 to %2", _name, _pos];
                        format["m_%1", _name] setMarkerPos _pos;
                        format["tm_%1", _name] setMarkerPos _pos;
                };
        } foreach _dogs;
        
}, random 60 * 45, [_dogs, _d, _debug]] call CBA_fnc_addPerFrameHandler;

diag_log format["MSO-%1 Dog Packs # %2", time, count _dogs];
if(_debug) then {hint format["MSO-%1 Dog Packs # %2", time, count _dogs];};
