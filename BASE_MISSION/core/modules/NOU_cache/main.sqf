#include <crbprofiler.hpp>

private ["_trigDist","_debug","_delay"];

_debug = false;

_trigDist = if(_debug) then {100} else {1000};
if(isNil "_this") then {_this = [];};
if(count _this > 0) then {
        _trigDist = _this select 0;
};
_delay = 0;
if(count _this > 1) then {
        _delay = _this select 1;
};
sleep _delay;

nou_cached = 0;
nou_suspended = 0;
nou_stats = "";

Nou_cacheGroup = {
        CRBPROFILERSTART("Nou Caching cacheGroup")
        
        if(!(_this getVariable ["Cached", false])) then {
                _this setVariable ["Cached", true];
                {
                        private["_pos"];
                        if(vehicle _x == _x) then {
				_x disableAI "TARGET";
				_x disableAI "AUTOTARGET";
				_x disableAI "MOVE";
				_x disableAI "ANIM";
				_x disableAI "FSM";
		
                                _x enableSimulation false;
                                _x allowDamage false;
                                _pos = getPosATL _x;
                                _pos set [2, -2];
                                _x setPosATL _pos;
                                nou_cached = nou_cached + 1;
                        };
                } forEach units _this - [leader _this];
                publicVariable "nou_cached";
        };
        CRBPROFILERSTOP
};

Nou_uncacheGroup = {
        CRBPROFILERSTART("Nou Caching uncacheGroup")
        
        if(_this getVariable ["Cached",true]) then {
                _this setVariable ["Cached", false];
                {
                        private["_pos"];
                        if(vehicle _x == _x) then {
                                _x setPosATL (formationPosition _x);
                                _x allowDamage true;
                                _x enableSimulation true;

				_x enableAI "TARGET";
				_x enableAI "AUTOTARGET";
				_x enableAI "MOVE";
				_x enableAI "ANIM";
				_x enableAI "FSM";

                                if(nou_cached > 0) then {nou_cached = nou_cached - 1;};
                        };
                } forEach units _this - [leader _this];
                publicVariable "nou_cached";
        };
        CRBPROFILERSTOP
};

Nou_suspendGroup = {
        CRBPROFILERSTART("Nou Caching suspendGroup")
        
        if(!(_this getVariable ["Suspended", false])) then {
                _this setVariable ["Suspended", true];
                {
                        _x enableSimulation false;
                        nou_suspended = nou_suspended + 1;
                } forEach units _this - [leader _this];
        };
        CRBPROFILERSTOP
};

Nou_unsuspendGroup = {
        CRBPROFILERSTART("Nou Caching unsuspendGroup")
        
        if(_this getVariable ["Suspended", true]) then {
                _this setVariable ["Suspended", false];
                {
                        _x enableSimulation true;
                        if(nou_suspended > 0) then {nou_suspended = nou_suspended - 1;};
                } forEach units _this - [leader _this];
        };
        CRBPROFILERSTOP
};

Nou_closestUnit = {
        CRBPROFILERSTART("Nou Caching closestUnit")
        
        private["_units", "_unit", "_dist", "_udist"];
        _units = _this select 0;
        _unit = _this select 1;
        _dist = 10^5;
        
        {
                _udist = _x distance _unit;
                if (_udist < _dist) then {_dist = _udist;};
        } forEach _units;
        CRBPROFILERSTOP
        _dist;
};

Nou_triggerUnits = {
        CRBPROFILERSTART("Nou Caching triggerUnits")
        
        private ["_nou_leader","_trigUnits"];
        _nou_leader = _this select 0;
        _trigUnits = [];
        {
                if ((((side _x) getFriend (side _nou_leader)) <= 0.6)) then {
                        _trigUnits set [count _trigUnits, leader _x];
                };
        } forEach allGroups;
        _trigUnits = _trigUnits + ([] call BIS_fnc_listPlayers);
        CRBPROFILERSTOP
        _trigUnits;
};


waitUntil{!isNil "bis_fnc_init"};
waitUntil{typeName allGroups == "ARRAY"};
waitUntil{typeName allUnits == "ARRAY"};
waitUntil{typeName playableUnits == "ARRAY"};

if(!isServer) then {
        diag_log format["MSO-%1 Nou Caching (%2) Starting", time, name player];
        [{
                CRBPROFILERSTART("Nou Caching player")
                private ["_params","_nou_cache_dist","_debug"];
                
                _params = _this select 0;
                _nou_cache_dist = _params select 0;
                _debug = _params select 1;
                {
                        private["_closest"];
                        _closest = [units player, leader _x] call Nou_closestUnit;
                        if (_closest > (_nou_cache_dist * 1.1)) then {
                                _x call Nou_suspendGroup;
                        };
                        
                        if (_closest < _nou_cache_dist) then {
                                _x call Nou_unsuspendGroup;
                        };
                } forEach allGroups;
                
                if(nou_stats != format["%1 Groups %2/%3/%4 All/Suspended/Cached Units", count allGroups, count allUnits, nou_suspended, nou_cached]) then {
                        nou_stats = format["%1 Groups %2/%3/%4 All/Suspended/Cached Units", count allGroups, count allUnits, nou_suspended, nou_cached];
                        diag_log format["MSO-%1 Nou Caching (%2) # %3", time, name player, nou_stats];
                        if(_debug) then {hint format["MSO-%1 Nou Caching # %2", time, nou_stats];};
                };
                
                CRBPROFILERSTOP
        }, 1, [_trigDist, _debug]] call mso_core_fnc_addLoopHandler;
};

if(isServer) then {
        diag_log format["MSO-%1 Nou Caching (%2) Starting", time,"SERVER"];
        [{
                CRBPROFILERSTART("Nou Caching server")
                
                private ["_params","_nou_cache_dist","_debug"];
                
                _params = _this select 0;
                _nou_cache_dist = _params select 0;
                _debug = _params select 1;
                {
                        private["_closest"];
                        _closest = [([leader _x] call Nou_triggerUnits), leader _x] call Nou_closestUnit;
                        if (_closest > (_nou_cache_dist * 1.1)) then {
                                _x call Nou_cacheGroup;
                        };
                        
                        if (_closest < _nou_cache_dist) then {
                                _x call Nou_uncacheGroup;
                        };
                } forEach allGroups;
                
                if(nou_stats != format["%1 Groups %2/%3 Active/Cached Units", count allGroups, (count allUnits) - nou_cached, nou_cached]) then {
                        nou_stats = format["%1 Groups %2/%3 Active/Cached Units", count allGroups, (count allUnits) - nou_cached, nou_cached];
                        diag_log format["MSO-%1 Nou Caching (%2) # %3", time,"SERVER", nou_stats];
                        if(_debug) then {hint format["MSO-%1 Nou Caching # %2", time, nou_stats];};
                };
                
                CRBPROFILERSTOP
        }, 3, [_trigDist, _debug]] call mso_core_fnc_addLoopHandler;
};
