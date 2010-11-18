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
		CRB_SPAWNPOINTS = [[2057.5239,362.24213],[7418.6284,44.116211],[11943.901,2565.1956],[10968.563,6296.1953],[11443.324,8196.7363],[12640.246,9830.0742],[12749.133,10970.265],[11057.035,12744.979],[9163.8604,12728.431],[7149.5513,12744.669],[4560.1128,12736.298],[2461.167,12747.017],[1908.5356,12610.614],[883.67908,10455.702],[33.667603,7077.9468],[96.891769,5524.3794],[242.14958,2836.0496]];
	};
};
CRB_CONVOYLOCS = CRB_LOCS;
/*
{
	if(type _x == "BorderCrossing") then {
		CRB_SPAWNPOINTS = CRB_SPAWNPOINTS + [_x];
	} else {
		CRB_CONVOYLOCS = CRB_CONVOYLOCS + [_x];
	};		
} forEach CRB_LOCS;
*/

// BIS_TK
CRB_TK_VEH = ["MAZ_543_SCUD_TK_EP1","SUV_TK_EP1","UAZ_Unarmed_TK_EP1","BMP2_HQ_TK_EP1"];
CRB_TK_SUP = ["UralReammo_TK_EP1","UralRefuel_TK_EP1","UralRepair_TK_EP1","UralSalvage_TK_EP1","UralSupply_TK_EP1","V3S_Open_TK_EP1","V3S_TK_EP1","M113Ambul_TK_EP1"];
CRB_TK_ARM = ["GRAD_TK_EP1","LandRover_MG_TK_EP1","LandRover_SPG9_TK_EP1","Ural_ZU23_TK_EP1","M113_TK_EP1","ZSU_TK_EP1"];

if (_debug) then {
	hint str count CRB_CONVOYLOCS;
	{
		_t = format["l%1",random 10000];
		_m = createMarker [_t, position _x];
		_m setMarkerType "Dot";
	} forEach CRB_CONVOYLOCS;
	{
		_t = format["x%1",random 10000];
		_m = createMarker [_t, _x];
		_m setMarkerType "Destroy";
	} forEach CRB_SPAWNPOINTS;
};
_numconvoys = floor((count CRB_CONVOYLOCS) / 100);

for "_j" from 1 to _numconvoys do {
	[_debug, _j] spawn {
		_debug = _this select 0;
		_j = _this select 1;
		if(!_debug) then {sleep (180 * _j);};
		
		_timeout = if(_debug) then {[30, 30, 30];} else {[30, 120, 300];};
		while{true} do {
			_sleep = if(_debug) then {random 30;} else {random 300;};

			_startpos = ([CRB_SPAWNPOINTS,[3,1,1,1]] call BIS_fnc_selectRandomWeighted);
			_destpos = position (CRB_CONVOYLOCS call BIS_fnc_selectRandom);
			_endpos = ([CRB_SPAWNPOINTS,[3,1,1,1]] call BIS_fnc_selectRandomWeighted);
			
			_j = floor(random 10000);
			if (_debug) then {
				_t = format["s%1",_j];
				_m = createMarker [_t, _startpos];
				_m setMarkerType "Start";
				_m setMarkerText _t;

				_t = format["d%1",_j];
				_m = createMarker [_t, _destpos];
				_m setMarkerType "Pickup";
				_m setMarkerText _t;

				_t = format["e%1",_j];
				_m = createMarker [_t, _endpos];
				_m setMarkerType "End";
				_m setMarkerText _t;
			};

			_front = [["Motorized","Mechanized","Armored"],[3,2,1]] call BIS_fnc_selectRandomWeighted;
			_grp = [_startpos, _front, "BIS_TK"] call compile preprocessFileLineNumbers "crB_scripts\crB_randomGroup.sqf";
			
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
			
			__wp = grp addwaypoint [_endpos, 0];
			_wp setWaypointTimeout _timeout;
			
			_wp = _grp addwaypoint [_destpos, 0];
			_wp setWaypointTimeout _timeout;
	
			_wp = _grp addwaypoint [_startpos, 0];
			_wp setWaypointTimeout _timeout;
	
			_wp = _grp addwaypoint [_startpos, 0];
			_wp setWaypointType "CYCLE";
			
			waitUntil{!(_grp call CBA_fnc_isAlive)};
			deletegroup _grp;
			_sleep = if(_debug) then {30;} else {random 300;};
			sleep _sleep;
		};
	};
};
