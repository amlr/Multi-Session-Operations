_nukepos = _this select 0;

[0,[],{
    [_nukepos] execvm "scripts\nuke\nuke_init_all.sqf";
}] call mso_core_fnc_ExMP;