if(!isServer) exitWith{};
private ["_pos","_side","_type","_i","_group","unit","_leader"];

_pos = _this select 0;
_side = _this select 1;
_type = _this select 2;

waitUntil {!isNil "bis_fnc_init"};

_group = creategroup _side;
switch(_type) do {
                                case "Infantry": {
                                		for "_i" from 0 to (4 + floor(random 2)) do {
                                            private ["_newpos"];
                                                _newpos = [(_pos select 0)+ floor(random 15),(_pos select 1)+ floor(random 15),0];
                                                _type = ([0, MSO_FACTIONS,"Man"] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;    
                                        		if (_i < 1) then {
                                                _leader = _group createUnit [_type,_newpos,[],0,"NONE"];
                                                };
                                                _unit = _group createUnit [_type,_newpos,[],0,"NONE"];
                                        };
                                };
                                case "Motorized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
                                                private ["_newpos"];
                                                _newpos = [(_pos select 0)+ floor(random 15),(_pos select 1)+ floor(random 15),0];
                                                _type = ([2, MSO_FACTIONS,"Car"] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
                                                if (_i < 1) then {
                                                _leader = [_newpos, 0, _type, _group] call BIS_fnc_spawnVehicle;
                                                };
                                                _unit = [_newpos, 0, _type, _group] call BIS_fnc_spawnVehicle;
                                        };
                                };
                                case "Mechanized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
                                                private ["_newpos"];
                                                _newpos = [(_pos select 0)+ floor(random 15),(_pos select 1)+ floor(random 15),0];
                                                _type = ([2, MSO_FACTIONS,"Car"] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
                                                if (_i < 1) then {
                                                _leader = [_newpos, 0, _type, _group] call BIS_fnc_spawnVehicle;
                                                };
                                                _unit = [_newpos, 0, _type, _group] call BIS_fnc_spawnVehicle;
                                        };
                                };
                                case "Armored": {
                                        for "_i" from 0 to (2 + floor(random 2)) do {
                                                private ["_newpos"];
                                                _newpos = [(_pos select 0)+ floor(random 15),(_pos select 1)+ floor(random 15),0];
                                                _type = ([0, MSO_FACTIONS,"Tank"] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
                                                if (_i < 1) then {
                                                _leader = [_newpos, 0, _type, _group] call BIS_fnc_spawnVehicle;
                                                };
                                                _unit = [_newpos, 0, _type, _group] call BIS_fnc_spawnVehicle;
                                        };
								};
                                default {
                                    for "_i" from 0 to (4 + floor(random 2)) do {
                                        private ["_newpos"];
                                        		_newpos = [(_pos select 0)+ floor(random 15),(_pos select 1)+ floor(random 15),0];
                                                _type = ([0, MSO_FACTIONS,"Man"] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;    
                                        		if (_i < 1) then {
                                                _leader = _group createUnit [_type,_pos,[],0,"NONE"];
                                                };
                                                _unit = _group createUnit [_type,_pos,[],0,"NONE"];
                                        };
                                };
                        };
                        
_leader = leader _group;
diag_log format["MSO-%1 group with name %4 and %2 units created at %3.", time, count units _group, _pos, _group];
_group;
                   