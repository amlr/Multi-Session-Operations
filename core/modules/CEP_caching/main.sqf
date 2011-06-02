#include <crbprofiler.hpp>

// _________________________________________________________________________________________________________________
// | Coop Essential Pack by -eutf-Myke                                                                             |
// |_______________________________________________________________________________________________________________|
// | Do not change this scrip!                                                                                     |
// |_______________________________________________________________________________________________________________|
// | cep initialization script                                                                                     |
// |_______________________________________________________________________________________________________________|
// Heavily modified by Wolffy.au
// Usage: _cep_init = [TriggerDistance] execVM "coop_essential\cep_init.sqf";


private ["_trigDist","_delay","_debug"];
if (!isServer) exitwith {};

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
cep_cached_grps = [];
cep_unit_count = 0;
cep_tls = 0;
cep_stats = "";

waitUntil{!isNil "bis_fnc_init"};
waitUntil{typeName allGroups == "ARRAY"};

[{
	CRBPROFILERSTART("CEP Caching")

        private ["_params","_trigDist","_delay","_debug","_disable"];
        _params = _this select 0;
        _trigDist = _params select 0;
        _delay = _params select 1;
        _debug = _params select 2;
        if(time > 0 && time < _delay ) exitWith{};
        {
                _disable = (group _x) getVariable "CEP_disableCache";
                _disable = if(isNil "_disable") then { false; } else {_disable;};
                if(!_disable) then {
                        (group _x) setVariable ["CEP_disableCache", true, true];
                        cep_cached_grps = cep_cached_grps -[group _x];
                };
        } forEach ([] call BIS_fnc_listPlayers);
        
        {
                _disable = _x getVariable "CEP_disableCache";
                _disable = if(isNil "_disable") then { false; } else {_disable;};
                if (!_disable && !(_x in cep_cached_grps)) then {
                        cep_cached_grps set [count cep_cached_grps, _x];
                        [_x, _trigDist] execFSM "core\modules\CEP_caching\crB_AICaching.fsm";
                };
        } forEach allGroups;
        
        {
                if (!(_x in allGroups)) then {
                        //	                        if(time > 0) then {sleep 30;};
                        cep_cached_grps = cep_cached_grps - [_x];
                };
        } forEach cep_cached_grps;
        
        if(cep_stats != format["%1/%2 Cached Groups %3/%4/%5 Active/Suspended/Cached Units", count cep_cached_grps, count allGroups, (count allUnits) - cep_tls, cep_tls, cep_unit_count]) then {
                cep_stats = format["%1/%2 Cached Groups %3/%4/%5 Active/Suspended/Cached Units", count cep_cached_grps, count allGroups, (count allUnits) - cep_tls, cep_tls, cep_unit_count];
                diag_log format["MSO-%1 CEP Caching # %2", time, cep_stats];
                if(_debug) then {hint format["MSO-%1 CEP Caching # %2", time, cep_stats];};
        };
	CRBPROFILERSTOP
}, 1, [_trigDist, _delay, _debug]] call mso_core_fnc_addLoopHandler;
