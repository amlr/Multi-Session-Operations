if (!isServer) exitWith{};

private ["_pos","_size","_sx","_sy","_marker","_grp","_wp"];
_pos = getMarkerPos "ai_area";
_size = getMarkerSize "ai_area";
_sx = _size select 0;
_sy = _size select 1;
_pos = [(_pos select 0) + random _sx - (_sx / 2), (_pos select 1) + random _sy - (_sy / 2)];
_grp = [_pos, civilian, (configFile >> "CfgGroups" >> "Civilian" >> "BIS_TK_CIV" >> "Infantry") select 1] call BIS_fnc_spawnGroup;
if(isNil "ONEGRP") then {
        ONEGRP = _grp;

	while {(count (waypoints ONEGRP)) > 0} do {
        	deleteWaypoint ((waypoints ONEGRP) select 0);
	};

	_wp = ONEGRP addWaypoint [_pos, 0];
	_wp setWaypointType "DISMISS";
} else {
        (units _grp) join ONEGRP;
};
_marker = createMarkerLocal [str random 10000, _pos];
_marker setMarkerType "Dot";

hintSilent format["AI Count: %1(%2)", count allUnits, count waypoints ONEGRP];