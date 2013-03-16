private ["_start","_groups","_grp"];

if(isMultiplayer) exitWith {["Init","Single Player Test"] call fn_fail;};

format["Ambient Civilians Test - Single Player (%1 allMissionObjects)", count allMissionObjects ""] call fn_log;

_start = count allUnits;
_groups = allGroups;

waitUntil{time > 0};

"Waiting for ALICE init" call fn_log;
waitUntil{!isNil "bis_alice_mainscope"};

"Moving player in" call fn_log;
player call fn_enterArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + 1};
sleep 30;
_grp = (allGroups - _groups) select 0;
["Enter Area 1st", _start + (count units _grp), count allUnits] call fn_areaTest;
"Success" call fn_log;
sleep 1;

"Moving player out" call fn_log;
player call fn_exitArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits == _start};
sleep 15;
["Exit Area 1st", _start, count allUnits] call fn_areaTest;
"Success" call fn_log;
sleep 1;

"Moving player in" call fn_log;
player call fn_enterArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits >= _start + (count units _grp)};
sleep 30;
["Enter Area 1st", _start + (count units _grp), count allUnits] call fn_areaTest;
"Success" call fn_log;
sleep 1;

"Moving player out" call fn_log;
player call fn_exitArea;
waitUntil{sleep 3; format["Waiting for ALICE population (%1)", count allUnits] call fn_log; count allUnits == _start};
sleep 15;
["Exit Area 2nd", _start, count allUnits] call fn_areaTest;
format["Success - Test Completed (%1 allMissionObjects)", count allMissionObjects ""] call fn_log;
sleep 15;

TEST_SUCCESS = true;
publicVariable "TEST_SUCCESS";
forceEnd;
