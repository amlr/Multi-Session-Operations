if (!isServer) exitWith{};

private ["_pos","_size","_sx","_sy","_marker","_grp","_wp"];
_pos = getMarkerPos "ai_area";
_size = getMarkerSize "ai_area";
_sx = _size select 0;
_sy = _size select 1;
_pos = [(_pos select 0) + random (_sx * 2) - _sx, (_pos select 1) + random (_sy * 2) - _sy];
_grp = [_pos, civilian, (configFile >> "CfgGroups" >> "Civilian" >> "CIV" >> "Infantry") select 1] call BIS_fnc_spawnGroup;
_wp = _grp addWaypoint [_pos, 0];
_wp setWaypointType "DISMISS";
_marker = createMarkerLocal [str random 10000, _pos];
_marker setMarkerType "Dot";

hintSilent format["AI Count: %1", count allUnits];