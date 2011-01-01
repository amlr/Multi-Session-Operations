private ["_logic","_sender","_receiver","_group"];
_logic = _this select 0;
_sender = _this select 1;
_receiver = (_logic getvariable "groups") call BIS_fnc_selectRandom;

[2,_group,{_this sidechat format["%1 to all units, radio check. Over.",_this];}] call RMM_fnc_ExMP;

sleep (random 10);

[2,[_sender,_receiver],{(_this select 1) sidechat format["%1 this is %2, hearing you 5/5. Over.",_this];}] call RMM_fnc_ExMP;