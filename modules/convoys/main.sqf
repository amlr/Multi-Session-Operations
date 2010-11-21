if(!isServer) exitWith{};

_debug = false;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
	CRB_LOCS = [] call CRB_fnc_initLocations;
};

CRB_SPAWNPOINTS = [];
switch(worldName) do {		
	case "Zargabad": {
		CRB_SPAWNPOINTS = [[3430,8130],[2900,50],[3150,50],[5030,50]];
	};
	case "Takistan": {
		CRB_SPAWNPOINTS = [[2057,362],[7418,44],[11943,2565],[10968,6296],[11443,8196],[12640,9830],[12749,10970],[11057,12744],[9163,12728],[7149,12744],[4560,12736],[2461,12747],[1908,12610],[883,10455],[33,7077],[96,5524],[242,2836]];
	};
};
_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","Airport"];
CRB_CONVOYLOCS = [];
{
	if(type _x in _strategic) then {
		CRB_CONVOYLOCS = CRB_CONVOYLOCS + [position _x];
	};		
} forEach CRB_LOCS;

// BIS_TK
CRB_TK_VEH = ["MAZ_543_SCUD_TK_EP1","SUV_TK_EP1","UAZ_Unarmed_TK_EP1","BMP2_HQ_TK_EP1"];
CRB_TK_SUP = ["UralReammo_TK_EP1","UralRefuel_TK_EP1","UralRepair_TK_EP1","UralSalvage_TK_EP1","UralSupply_TK_EP1","V3S_Open_TK_EP1","V3S_TK_EP1","M113Ambul_TK_EP1"];
CRB_TK_ARM = ["GRAD_TK_EP1","LandRover_MG_TK_EP1","LandRover_SPG9_TK_EP1","Ural_ZU23_TK_EP1","M113_TK_EP1","ZSU_TK_EP1"];

if (_debug) then {
	{
		_t = format["l%1",random 10000];
		_m = [_t, _x, "Icon", [1,1], "TYPE:", "Dot", "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
	} forEach CRB_CONVOYLOCS;

	{
		_t = format["x%1",random 10000];
		_m = [_t, _x, "Icon", [1,1], "TYPE:", "Destroy", "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
	} forEach CRB_SPAWNPOINTS;
};
_numconvoys = floor((count CRB_CONVOYLOCS) / 50);

for "_j" from 1 to _numconvoys do {
	[_debug] spawn {
		_debug = _this select 0;
		
		_timeout = if(_debug) then {[30, 30, 30];} else {[30, 120, 300];};
		while{true} do {
			_sleep = if(_debug) then {random 30;} else {random 300;};

			_startpos = (CRB_SPAWNPOINTS call BIS_fnc_selectRandom);
			_destpos = (CRB_CONVOYLOCS call BIS_fnc_selectRandom);
			_endpos = (CRB_SPAWNPOINTS call BIS_fnc_selectRandom);

			_grp = nil;
			_front = "";
			while{isNil "_grp"} do {
				_front = [["Motorized","Mechanized","Armored"],[6,3,1]] call CRB_fnc_selectRandomBias;
				_facs = MSO_FACTIONS;
				_grp = [_startpos, _front, _facs] call compile preprocessFileLineNumbers "crB_scripts\crB_randomGroup.sqf";
			};

			switch(_front) do {
				case "Motorized": {
					for "_i" from 0 to floor(random 2) do {
						[[_startpos, 100] call CBA_fnc_randPos, 0, (CRB_TK_VEH + CRB_TK_SUP) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
					};
				};
				case "Mechanized": {
					for "_i" from 0 to (1 + floor(random 2)) do {
						[[_startpos, 100] call CBA_fnc_randPos, 0, CRB_TK_SUP call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
					};
					if(random 1 > 0.5) then {[[_startpos, 100] call CBA_fnc_randPos, 0, CRB_TK_ARM call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;};
				};
				case "Armored": {
					for "_i" from 0 to (2 + floor(random 1)) do {
						[[_startpos, 100] call CBA_fnc_randPos, 0, (CRB_TK_VEH + CRB_TK_SUP) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
					};
					[[_startpos, 100] call CBA_fnc_randPos, 0, CRB_TK_ARM call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
				};
			};
				
			_grp setFormation "FILE";
			_grp setSpeedMode "NORMAL";
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
