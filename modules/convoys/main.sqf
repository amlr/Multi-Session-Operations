if(!isServer) exitWith{};

private["_debug","_strategic","_spawnpoints","_convoydest","_numconvoys","_j"];
_debug = false;
	
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","Airport"];
_spawnpoints = [];
_convoydest = [];
{
	private["_t","_m"];
	if(type _x == "BorderCrossing") then {
		_spawnpoints = _spawnpoints + [position _x];
	};
	if(type _x in _strategic) then {
		_convoydest = _convoydest + [position _x];
		if (_debug) then {
			_t = format["convoy_d%1", floor(random 10000)];
			_m = [_t, position _x, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorOrange", "GLOBAL"] call CBA_fnc_createMarker;
			[_m, true] call CBA_fnc_setMarkerPersistent;
		};
	};
} forEach CRB_LOCS;

if (_debug) then {
	private["_t","_m"];
	{
		_t = format["convoy_s%1", floor(random 10000)];
		_m = [_t, _x, "Icon", [1,1], "TYPE:", "Destroy", "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
	} forEach _spawnpoints;
};

_numconvoys = floor((count _convoydest) / 50);
diag_log format["MSO-%1 Convoy: destinations(%2) spawns(%3) convoys(%4)", time, count _convoydest, count _spawnpoints, _numconvoys];

for "_j" from 1 to _numconvoys do {
	[_j, _spawnpoints, _convoydest, _debug] spawn {
		private["_timeout","_sleep","_startpos","_destpos","_endpos","_grp","_front","_facs","_wp"];
		_j = _this select 0;
		_spawnpoints = _this select 1;
		_convoydest = _this select 2;
		_debug = _this select 3;
		
		_timeout = if(_debug) then {[30, 30, 30];} else {[30, 120, 300];};
		while{true} do {
			_startpos = (_spawnpoints call BIS_fnc_selectRandom);
			_startpos = [_startpos, 0, 50, 10, 0, 10, 0] call BIS_fnc_findSafePos;
			_destpos = (_convoydest call BIS_fnc_selectRandom);
			_destpos = [_destpos , 0, 50, 10, 0, 10, 0] call BIS_fnc_findSafePos;
			_endpos = (_spawnpoints call BIS_fnc_selectRandom);
			_endpos = [_endpos, 0, 50, 10, 0, 10, 0] call BIS_fnc_findSafePos;
			_grp = nil;
			_front = "";
			while{isNil "_grp"} do {
				_front = [["Motorized","Mechanized","Armored"],[6,3,1]] call CRB_fnc_selectRandomBias;
				_facs = MSO_FACTIONS;
				_grp = [_startpos, _front, _facs] call compile preprocessFileLineNumbers "scripts\crB_scripts\crB_randomGroup.sqf";
			};
			diag_log format["MSO-%1 Convoy: #%2 %3 %4 %5 %6", time, _j, _startpos, _destpos, _endpos, _front];

			switch(_front) do {
				case "Motorized": {
					for "_i" from 0 to floor(random 2) do {
						[[_startpos, 100] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
					};
				};
				case "Mechanized": {
					for "_i" from 0 to (1 + floor(random 2)) do {
						[[_startpos, 100] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
					};
					if(random 1 > 0.5) then {[[_startpos, 100] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;};
				};
				case "Armored": {
					for "_i" from 0 to (2 + floor(random 1)) do {
						[[_startpos, 100] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
					};
					[[_startpos, 100] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
				};
			};
				
			_grp setFormation "FILE";
			_grp setSpeedMode "LIMITED";
			_grp setBehaviour "SAFE";
			
			_wp = _grp addwaypoint [_destpos, 0];
			_wp setWaypointTimeout _timeout;
			
			_wp = _grp addwaypoint [_endpos, 0];
			_wp setWaypointTimeout _timeout;
			
			_wp = _grp addwaypoint [_destpos, 0];
			_wp setWaypointTimeout _timeout;
	
			_wp = _grp addwaypoint [_startpos, 0];
			_wp setWaypointTimeout _timeout;
	
			_wp = _grp addwaypoint [_startpos, 0];
			_wp setWaypointType "CYCLE";
			
			_cid = floor(random 10000);
			_t = format["s%1",_cid];
			_m = [_t, _startpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Start", "COLOR:", "ColorGreen", "GLOBAL"] call CBA_fnc_createMarker;
			[_m, true] call CBA_fnc_setMarkerPersistent;
		
			_t = format["d%1",_cid];
			_m = [_t, _destpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Pickup", "COLOR:", "ColorYellow", "GLOBAL"] call CBA_fnc_createMarker;
			[_m, true] call CBA_fnc_setMarkerPersistent;
		
			_t = format["e%1",_cid];
			_m = [_t, _endpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "End", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
			[_m, true] call CBA_fnc_setMarkerPersistent;
		
			waitUntil{!(_grp call CBA_fnc_isAlive)};

			deletegroup _grp;
			_t = format["s%1",_cid];
			deleteMarker _t;

			_t = format["d%1",_cid];
			deleteMarker _t;

			_t = format["e%1",_cid];
			deleteMarker _t;

			_sleep = if(_debug) then {30;} else {random 300;};
			sleep _sleep;
		};
	};
};

diag_log format["MSO-%1 Convoys # %2", time, _numconvoys];