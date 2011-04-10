private ["_debug","_types","_dogs","_side","_grp","_maxdist"];
if (!isServer) exitWith{};

_debug = true;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

_types = ["FlatArea","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
_maxdist = 100;
_dogs = [];
_side = east;
if(count _this > 0) then {
        _side = _this select 0;
};

{
        if(type _x in _types) then {
                if (random 1 > 0.9) then {
                        private["_name","_dx","_dy","_pos","_trg","_m"];
                        _name = format["wilddogs_%1", floor(random 10000)];
                        if(_debug) then {
                                diag_log format["MSO-%1 Dog Packs: create %2", time, _name];
                                hint format["MSO-%1 Dog Packs: create %2", time, _name];
                        };
                        
                        // randomise wild dog positions
                        _pos = position _x;
                        _pos = [_pos, 0, _maxdist, 1, 0, 50, 0] call bis_fnc_findSafePos;
                        missionNamespace setVariable [_name, _pos];
                        _grp = createGroup _side;
                        _dogs set [count _dogs, _name];
                        
                        if (_debug) then {
                                ["m_" + _name, _pos,  "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _name,  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                        };
                        
                        [{
                                private ["_pos","_name","_debug","_params","_grp","_maxdist","_leader"];
                                _params = _this select 0;
                                _name = _params select 0;
                                _grp = _params select 1;
                                _maxdist = _params select 2;
                                _debug = _params select 3;
                                _leader = leader _grp;
                                if(isNil "_pos") then {
                                        _pos = missionNamespace getVariable _name;
                                };
                                
                                if({_pos distance _x < 800} count ([] call BIS_fnc_listPlayers) > 0) then {
                                        if(count(units _grp) == 0) then {
                                                if(_debug) then {
							player globalChat format["Dogs: creating %1",  _name];
						};
						diag_log format["MSO-%1 Dog Packs creating %2", time, _name];
                                                (units ([_pos, _grp] call dogs_fnc_wilddogs)) joinSilent _grp;
                                        };
                                        
                                        if(_debug && alive _leader)then{
                                                format["m_%1", _name] setMarkerPos position _leader;
                                        };
                                }  else {
                                        if(count(units _grp) > 0) then {
                                                if(_debug) then {player globalChat format["Destroying %1", _name];};
						diag_log format["MSO-%1 Dog Packs destroying %2", time, _name];
                                                {deleteVehicle _x} foreach units _grp;
                                                [_grp getVariable "handle"] call CBA_fnc_removePerFrameHandler;
                                        };
                                        
                                        if (_grp getVariable "wait" < time) then {
                                                private["_oldpos"];
                                                _oldpos = _pos;
                                                _pos = [_pos, _maxdist] call CBA_fnc_randPos;
                                                _grp setVariable ["wait", time + (_oldpos distance _pos) * 1.5, true];
                                                if(_debug) then {
                                                        player globalChat format["Moving %1", _name];
                                                        format["m_%1",_name] setMarkerPos _pos;
                                                };
                                        };
                                };
                                
                        }, 2, [_name, _grp, _maxdist, _debug]] call CBA_fnc_addPerFrameHandler;
                };
        };
} forEach CRB_LOCS;
diag_log format["MSO-%1 Dog Packs # %2", time, count _dogs];
if(_debug) then {hint format["MSO-%1 Dog Packs # %2", time, count _dogs];};
