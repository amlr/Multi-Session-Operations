private ["_nukepos"];
_nukepos = _this select 0;

if (isserver) then {
    [_nukepos] execvm "scripts\nuke\nuke_damage_server.sqf";
};

if !(isserver) then {
    [_nukepos] execvm "scripts\nuke\nuke_explosion_client.sqf";
};