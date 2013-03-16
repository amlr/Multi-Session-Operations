private ["_start","_civcount","_player1","_player2","_flag","_groups","_grp","_players"];

if(!isServer) exitWith {};
if(!isDedicated) exitWith {["Init","Dedicated Server Multi Player Test"] call fn_fail;};

format["Ambient Civilians Test - Dedicated Server (%1 allMissionObjects)", count allMissionObjects ""] call fn_log;

// Two players to simulate MP environment
waitUntil{count playableUnits >= 3};

_start = count allUnits;
_groups = allGroups;
_players = playableUnits - headlessClients;

_player1 = _players select 0;
_player2 = _players select 1;

waitUntil{time > 0};

"Waiting for ALICE init" call fn_log;
waitUntil{!isNil "bis_alice_mainscope"};

"Moving player 1 in" call fn_log;
_player1 call fn_enterArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + 1};
sleep 30;
_grp = (allGroups - _groups) select 0;
["P1 Enter Area 1", _start + (count units _grp), count allUnits] call fn_areaTest;
if(local _player1) then {
        ["P1 Enter Area - local to server", _start + _civcount, {local _x} count allUnits] call fn_areaTest;
} else {
        ["P1 Enter Area - local to server", 0, {local _x} count allUnits] call fn_areaTest;
};
"Success" call fn_log;
sleep 1;

"Moving player 1 out" call fn_log;
_player1 call fn_exitArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits == _start};
sleep 15;
["P1 Exit Area 1", _start, count allUnits] call fn_areaTest;
"Success" call fn_log;
sleep 1;

"Moving player 2 in" call fn_log;
_player2 call fn_enterArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + (count units _grp)};
sleep 30;
["P2 Enter Area 1", _start + (count units _grp), count allUnits] call fn_areaTest;
if(local _player2) then {
        ["P2 Enter Area - local to server", _start + _civcount, {local _x} count allUnits] call fn_areaTest;
} else {
        ["P2 Enter Area - local to server", 0, {local _x} count allUnits] call fn_areaTest;
};
"Success" call fn_log;
sleep 1;

"Moving player 1 in" call fn_log;
_player1 call fn_enterArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + (count units _grp)};
sleep 15;
["P1 Enter Area 2", _start + (count units _grp), count allUnits] call fn_areaTest;
if(local _player1) then {
        ["P1 Enter Area - local to server", _start + _civcount, {local _x} count allUnits] call fn_areaTest;
} else {
        ["P1 Enter Area - local to server", 0, {local _x} count allUnits] call fn_areaTest;
};
"Success" call fn_log;
sleep 1;

"Moving player 2 out" call fn_log;
_player2 call fn_exitArea;
sleep 15;
["P2 Exit Area 1", _start + (count units _grp), count allUnits] call fn_areaTest;
if(local _player2) then {
        ["P2 Enter Area - local to server", _start + _civcount, {local _x} count allUnits] call fn_areaTest;
} else {
        ["P2 Enter Area - local to server", 0, {local _x} count allUnits] call fn_areaTest;
};
"Success" call fn_log;
sleep 1;

_flag = true;

while{{local _x} count allUnits != 0 || _flag} do {
        
        "Moving player 1 out" call fn_log;
        _player1 call fn_exitArea;
        waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits == _start};
        sleep 15;
        ["P1 Exit Area 2", _start, count allUnits] call fn_areaTest;
        "Success" call fn_log;
        sleep 1;
        
        "Moving player 1 in" call fn_log;
        _player1 call fn_enterArea;
        waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + (count units _grp)};
        sleep 30;
        ["P1 Enter Area 3", _start + (count units _grp), count allUnits] call fn_areaTest;
        if(local _player1) then {
                ["P1 Enter Area - local to server", _start + _civcount, {local _x} count allUnits] call fn_areaTest;
        } else {
                ["P1 Enter Area - local to server", 0, {local _x} count allUnits] call fn_areaTest;
        };
        "Success" call fn_log;
        sleep 1;
        
        _flag = false;
        
};

"Moving player 2 in" call fn_log;
_player2 call fn_enterArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + (count units _grp)};
sleep 15;
["P2 Enter Area 2", _start + (count units _grp), count allUnits] call fn_areaTest;
if(local _player2) then {
        ["P2 Enter Area - local to server", _start + _civcount, {local _x} count allUnits] call fn_areaTest;
} else {
        ["P2 Enter Area - local to server", 0, {local _x} count allUnits] call fn_areaTest;
};
"Success" call fn_log;
sleep 1;

[nil, _player2, "loc",rENDMISSION,"END1"] call RE;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + (count units _grp)};
sleep 15;
["P2 Disconnected", _start + (count units _grp), count allUnits] call fn_areaTest;
format["Local to server (%2 of %1)", count allUnits, {local _x} count allUnits] call fn_log;
"Success" call fn_log;
sleep 1;

"Moving player 1 out" call fn_log;
_player1 call fn_exitArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits == _start - 1};
sleep 15;
["P1 Exit Area 3", _start - 1, count allUnits] call fn_areaTest;
format["Success - Test Completed (%1 allMissionObjects)", count allMissionObjects ""] call fn_log;
sleep 15;

TEST_SUCCESS = true;
publicVariable "TEST_SUCCESS";
forceEnd;
