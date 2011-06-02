#include <crbprofiler.hpp>

// Simple Guard Post Script 1.0
// by Tophe of Östgöta Ops
//
// Usage with default values:
// nul = [this] execVM "GuardPost.sqf"
//
// Optional settings:
// nul = [unit, range in degrees, behaviour, stance (up/down/middle/auto), look up/down, min delay] execVM "GuardPost.sqf"
//
// Default values:
// nul = [this, 360, "SAFE", "AUTO", false, 1] execVM "GuardPost.sqf"
//
// For feedback and support - check thread in the BIS forums. 
// http://forums.bistudio.com/showthread.php?p=1681721
private ["_range","_unit","_beh","_stance","_height","_delay","_enemy","_startdir"];
if (!isServer) exitWith {};

_unit = _this select 0;
_range = if (count _this > 1) then {_this select 1} else {240};
_beh = if (count _this > 2) then {_this select 2} else {"SAFE"};
_stance = if (count _this > 3) then {_this select 3} else {"AUTO"};
_height = if (count _this > 4) then {_this select 4} else {false};
_delay = if (count _this > 5) then {_this select 5} else {1}; 

_enemy = if (side _unit == east) then {west} else {east};
_startdir = getDir _unit;

if (_range < 0) then {_range = 0};
if (_range > 360) then {_range = 360};

if (_beh == "CARELESS" || _beh == "SAFE" || _beh == "AWARE" || _beh == "COMBAT" || _beh == "STEALTH") 
then 
{_unit setBehaviour _beh} else {_unit setBehaviour "SAFE"};

_unit setUnitPos _stance;

[{
	CRBPROFILERSTART("GuardPost")

        private ["_left","_right","_dir","_zaxis","_pos","_params","_handle","_unit","_startdir","_range","_height","_enemy","_delay"];
        _params = _this select 0;
        _handle = _this select 1;
        _unit = _params select 0;
        _startdir = _params select 1;
        _range = _params select 2;
        _height = _params select 3;
        _enemy = _params select 4;
        _delay = _params select 5;
        
        if(!alive _unit) exitWith {
                [_handle] call mso_core_fnc_removeLoopHandler;
        };
        
        // Start scanning 
        // Pause if unit is engaging
        if(
                _unit getVariable ["GuardPosWait", 0] < time &&
                {if (side _x == _enemy) then {_unit knowsAbout _x > 1.4}} count AllUnits == 0
        ) then {
                _left = _startdir - (_range/2);
                _right = _startdir + (_range/2);
                
                if (_left > _right) then {
                        _left = _startdir - (_range/2);
                        _right = _startdir + (_range/2);
                }; 
                
                _left = round _left;
                _right = round _right;
                
                _dir = (random (_right - _left)) + _left;
                if (_dir < 0) then {_dir = _dir + 360}; 
                
                _pos = position _unit;
                if (_height) then {_zaxis = random 20};
                if (!_height) then {_zaxis = _pos select 2};
                _pos = [(_pos select 0) + 50*sin _dir, (_pos select 1) + 50*cos _dir, _zaxis];
                
                _unit doWatch _pos;
                
                _unit setVariable ["GuardPosWait", (random 10) + _delay + time];
        };
	CRBPROFILERSTOP
}, 3, [_unit, _startdir, _range, _height, _enemy, _delay]] call mso_core_fnc_addLoopHandler;
