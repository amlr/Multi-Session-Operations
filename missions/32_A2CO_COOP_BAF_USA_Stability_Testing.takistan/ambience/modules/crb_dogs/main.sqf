#include <crbprofiler.hpp>

private ["_debug","_types","_dogs","_side","_maxdist"];
if (!isServer) exitWith{};

if(isNil "ambientDogs")then{ambientDogs = 1;};
if (ambientDogs == 0) exitWith{};

_debug = debug_mso;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

_types = ["FlatArea","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","ViewPoint","Hill"];
_maxdist = 100;
_dogs = [];
_side = east;
if(count _this > 0) then {
        _side = _this select 0;
};

{
        if(type _x in _types) then {
                if (random 1 > 0.8) then {
                        private["_name","_dx","_dy","_pos","_trg","_m"];
                        _name = format["dogs_%1", floor(random 1000)];
                        
                        // randomise wild dog positions
                        _pos = position _x;
                        _pos = [_pos, 0, _maxdist, 1, 0, 50, 0] call bis_fnc_findSafePos;
                        _dogs set [count _dogs, _name];
						
						if(_debug) then {
							diag_log format["MSO-%1 Dog Packs: created %2 at %3", time, _name, _pos];
                        };
                                              
                        [_name, _pos, _side, _maxdist, _debug] spawn {
                                CRBPROFILERSTART("Wild dogs")
                                
                                private ["_pos","_name","_debug","_grp","_maxdist","_leader","_wait","_side"];
                                _name = _this select 0;
                                _pos = _this select 1;
                                _side = _this select 2;
                                _maxdist = _this select 3;
                                _debug = _this select 4;

                                _wait = 0;
                                						
                                while{true} do {
                                        if({_pos distance _x < 800} count ([] call BIS_fnc_listPlayers) > 0) then {
                                                if(isNil "_grp") then {
                                                        _grp = createGroup _side;
                                                        if(_debug) then {
                                                                player globalChat format["Dogs: spawning %1",  _name];
																["m_" + _name, _pos,  "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "colorKhaki", "TEXT:", _name,  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                                                        };
                                                        diag_log format["MSO-%1 Dog Packs spawning %2 at %3", time, _name, _pos];
                                                        [_pos, _grp] call dogs_fnc_wilddogs;
                                                } else {
                                                        _leader = leader _grp;
                                                        if(_debug && alive _leader)then{
                                                                format["m_%1", _name] setMarkerPos position _leader;
                                                        };
                                                };
                                        }  else {
                                                if(!isNil "_grp") then {
                                                        if(count(units _grp) > 0) then {
                                                                if(_debug) then {player globalChat format["Destroying %1", _name];};
                                                                diag_log format["MSO-%1 Dog Packs destroying %2", time, _name];
                                                                {deleteVehicle _x} foreach units _grp;
                                                                deleteGroup _grp;
	                                                    };
														[format["m_%1", _name]] call CBA_fnc_deleteEntity;
                                                };
                                                
                                                if (_wait < time) then {
                                                        private["_oldpos"];
                                                        _oldpos = _pos;
                                                        _pos = [_pos, _maxdist] call CBA_fnc_randPos;
                                                        _wait = time + (_oldpos distance _pos) * 1.5;
                                                        if(_debug) then {
                                                               // diag_log format["MSO-%1 Dog Packs Moving %1", _name];
                                                                format["m_%1",_name] setMarkerPos _pos;
                                                        };
                                                };
                                        };
                                        
                                        CRBPROFILERSTOP
                                        sleep 3;
                                };
                        };
                };
        };
} forEach CRB_LOCS;

diag_log format["MSO-%1 Dog Packs # %2", time, count _dogs];
if(_debug) then {hint format["MSO-%1 Dog Packs # %2", time, count _dogs];};
