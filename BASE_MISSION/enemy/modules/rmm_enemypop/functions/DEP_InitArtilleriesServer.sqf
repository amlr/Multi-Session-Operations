private ["_Arty","_debug","_obj"];
if (isnil "DEP_InitArtyBattery") then {DEP_InitArtyBattery = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\DEP_InitArtyBattery.sqf"};

_debug = debug_mso;
_LogCenter = createCenter sideLogic;

{
    _obj = _x select 0;
    _Arty = (_obj getvariable "type") select 3; if (isnil "_Arty") then {_Arty = false};
    
    if (_Arty) then {
      [_x select 0] call DEP_InitArtyBattery;
    };
} foreach DEP_LOCS;

if (_debug) then {diag_log format["MSO-%1 PDB EP Population: %2 Artilleries collected", time, count ARTILLERIES]};
