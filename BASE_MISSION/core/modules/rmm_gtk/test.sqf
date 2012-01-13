private ["_origpos","_pos","_grp","_result"];
diag_log format["MSO-%1 Test Group Tracker Start", time];

_origpos = position player;
_result = true;

waituntil {!isnil "BIS_fnc_init"};

// Create civilians group outside of range
diag_log format["MSO-%1 Test Group Tracker Create civilians group outside of range", time];
_pos = player modelToWorld [0, 150];
_grp = [_pos, civilian, (configFile >> "CfgGroups" >> "Civilian" >> "CIV" >> "Infantry" >> "CIV_Crowd")] call BIS_fnc_spawnGroup;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Creating group outside of range - %2", time, (count units _grp > 0)];
[[_grp], 100, "DEBUG", 1] call compile preprocessFileLineNumbers "core\modules\rmm_gtk\main.sqf";
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Caching group when outside of range - %2", time, (_grp getVariable "rmm_gtk_cached")];

_pos = player modelToWorld [0, 100];
player setPosATL _pos;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Uncaching group when inside of range - %2", time, (IsNil {_grp getVariable "rmm_gtk_cached"})];
player setPosATL _origpos;
_grp call CBA_fnc_deleteEntity;
sleep 1;

// Create civilians group within range
diag_log format["MSO-%1 Test Group Tracker Create civilians group within range", time];
_pos = player modelToWorld [0, 50];
_grp = [_pos, civilian, (configFile >> "CfgGroups" >> "Civilian" >> "CIV" >> "Infantry" >> "CIV_Crowd")] call BIS_fnc_spawnGroup;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Creating group within range - %2", time, (count units _grp > 0)];
[[_grp], 100, "DEBUG", 1] call compile preprocessFileLineNumbers "core\modules\rmm_gtk\main.sqf";
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Uncaching group within range - %2", time, (IsNil {_grp getVariable "rmm_gtk_cached"})];

_pos = player modelToWorld [0, -100];
player setPosATL _pos;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Caching group outside of range - %2", time, (_grp getVariable "rmm_gtk_cached")];
player setPosATL _origpos;
_grp call CBA_fnc_deleteEntity;

// Create civilians group outside of range with exclude set to true
diag_log format["MSO-%1 Test Group TrackerCreate civilians group outside of range with exclude set to true", time];
_pos = player modelToWorld [0, 150];
_grp = [_pos, civilian, (configFile >> "CfgGroups" >> "Civilian" >> "CIV" >> "Infantry" >> "CIV_Crowd")] call BIS_fnc_spawnGroup;
_grp setVariable ["rmm_gtk_exclude", true];
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Creating group outside of range - %2", time, (count units _grp > 0)];
[[_grp], 100, "DEBUG", 1] call compile preprocessFileLineNumbers "core\modules\rmm_gtk\main.sqf";
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Group excluded - %2", time, (_grp getVariable "rmm_gtk_exclude")];
diag_log format["MSO-%1 Test Group Tracker - Uncaching group when outside  of range - %2", time, (IsNil {_grp getVariable "rmm_gtk_cached"})];

_pos = player modelToWorld [0, 100];
player setPosATL _pos;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Uncaching group when inside of range - %2", time, (IsNil {_grp getVariable "rmm_gtk_cached"})];
player setPosATL _origpos;

// Create civilians group outside of range with exclude set to false
diag_log format["MSO-%1 Test Group TrackerCreate civilians group outside of range with exclude set to false", time];_grp setVariable ["rmm_gtk_exclude", false];
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Group exclude = false - %2", time, !(_grp getVariable "rmm_gtk_exclude")];
diag_log format["MSO-%1 Test Group Tracker - Caching group outside of range - %2", time, (_grp getVariable "rmm_gtk_cached")];

_pos = player modelToWorld [0, 100];
player setPosATL _pos;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Uncaching group when inside of range - %2", time, (IsNil {_grp getVariable "rmm_gtk_cached"})];
player setPosATL _origpos;

// Create civilians group outside of range with exclude set to nil
diag_log format["MSO-%1 Test Group TrackerCreate civilians group outside of range with exclude set to nil", time];_grp setVariable ["rmm_gtk_exclude", nil];
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Group exclude = nil - %2", time, (IsNil {_grp getVariable "rmm_gtk_exclude"})];
diag_log format["MSO-%1 Test Group Tracker - Caching group outside of range - %2", time, (_grp getVariable "rmm_gtk_cached")];

_pos = player modelToWorld [0, 100];
player setPosATL _pos;
sleep 1;
diag_log format["MSO-%1 Test Group Tracker - Uncaching group when inside of range - %2", time, (IsNil {_grp getVariable "rmm_gtk_cached"})];
player setPosATL _origpos;

_grp call CBA_fnc_deleteEntity;

/*
diag_log format["MSO-%1 Test Group Tracker - Creating group outside of range - %2", time, count _units];

_timeout = time + 600;

while{time < _timeout && {!isNull _x} count _units > 0} do {
	sleep 5;
};

if ({isNull _x} count _units > 0) then {
	diag_log format["MSO-%1 Test Successful Garbage Collector", time];
	true;
} else {
	diag_log format["MSO-%1 Test ***Failed*** Garbage Collector", time];
	false;
};
*/