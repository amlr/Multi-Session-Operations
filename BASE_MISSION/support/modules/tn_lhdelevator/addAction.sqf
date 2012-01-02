/*
waitUntil{!isNil "BIS_fnc_init"};

0 = _this execVM "support\modules\tn_lhdelevator\main.sqf";

_this addAction ["Elevator Down", CBA_fnc_actionargument_path, [_this,{[1,_this,{call lhdelev_fnc_moveElevatorDown;}] call mso_core_fnc_ExMP;}],-1,false,true,"","(myElevatorStatus != 1)"];
_this addAction ["Elevator Up", CBA_fnc_actionargument_path, [_this,{[1,_this,{call lhdelev_fnc_moveElevatorUp;}] call mso_core_fnc_ExMP;}],-1,false,true,"","(myElevatorStatus != 0)"];
_this addAction ["Elevator Stop", CBA_fnc_actionargument_path, [_this,{[1,_this,{call lhdelev_fnc_stopElevator;}] call mso_core_fnc_ExMP;}]];
*/