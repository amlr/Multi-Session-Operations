private ["_new","_best"];
_new = grpNull;
_best = (_this getvariable "commander") call ca_fnc_getRating;
{
    if (((_x call ca_fnc_getRating) > _best) && ({isplayer _x} count (units _x) == 0)) then {
        _new = _x;
    };
} foreach (_this getvariable "groups");

if (not isnull _new) then {
    _this setvariable ["commander", _new];
    [2,_new,{_this sidechat format["%1 to all callsigns, %1 is taking command. Out.",_this];}] call RMM_fnc_ExMP;
};