private ["_debug","_request","_pos"];

_debug = debug_mso;

_pos = _this select 0;
_request = _this select 1;

diag_log format["MSO-%1 Tup_Logistics: Starting delivery of %2 to %3", time, _request, _pos];

// Function to para drop object from vehicle
DoDrop = {
		private ["_Object","_Transporter","_num"];
		_Object = _this select 0;
		_Transporter = _this select 1;
		_num = _this select 2;

		//// Animate ramp
		sleep 1;
		_Transporter animate ["ramp_top", 1];
		_Transporter animate ["ramp_bottom", 1];

		//// Detach object (drop)
		sleep 2;
		
		for "_i" from 1 to _num do {
			private ["_obj","_Parachute","_Marker","_markertype"];
			_obj = _Object createvehicle (position _Transporter);
			_obj attachTo [_Transporter,[0,-21,0]];
			sleep 0.1;
			deTach _obj;
			_obj setPos [(getPos _obj select 0),(getPos _obj select 1),(getPos _obj select 2)-6];

			//// Create parachute and smoke
			sleep 2;
			_Parachute = "ParachuteBigWest" createVehicle position _obj;
			_Parachute setPos (getPos _obj);
			if ((daytime < 17) && (daytime > 7)) then {
				_markertype = "SmokeShellBlue";
			} else {
				_markertype = "NVG_TargetC";
			};

			_Marker =  _markertype createVehicle position _obj;
			_Marker setPosATL (getPosATL _obj);
			_Marker attachTo [_obj,[0,0,1]];
			
			_obj attachTo [_Parachute,[0,0,-1.5]];
			
			if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: Dropping %2 at %3", time, typeof _obj, position _obj];};
			
			[_obj,_Parachute, _Marker] spawn {
				private ["_name","_obj","_id","_Parachute","_Marker"];
				
				_obj = _this select 0;
				_Parachute = _this select 1;
				_Marker = _this select 2;
				
				//// Wait until ground reached
				waitUntil {sleep 2; (getPosATL _obj select 2) < 4};
				detach _obj;
				detach _Marker;
				sleep 0.3;
				_obj setPosATL [(getPosATL _obj select 0),(getPosATL _obj select 1),0.1];
				_Marker setPosATL [(getPosATL _obj select 0) + 1,(getPosATL _obj select 1) + 1,0.1];
				
				//// Enable R3F
				_obj setVariable ["R3F_LOG_disabled", false];
				
				// Enable PDB saving 
				_id = 1000 + ceil(random(9000));
				_name = format["mso_log_%1",_id];
				_obj setVariable ["pdb_save_name", _name, true];
				
				//diag_log format["%1 position = %2", typeof _obj, getposATL _obj];
				
				if (debug_mso) then {
					private ["_objm"];
					_objm = [_name, position _obj, "Icon", [1,1], "TEXT:", "OBJ", "TYPE:", "Dot", "COLOR:", "ColorBlue", "GLOBAL"] call CBA_fnc_createMarker;
				};
				
				//// Delete parachute and smoke
				sleep 500;
				deleteVehicle _Marker;
				deleteVehicle _Parachute;
			};
		};

		//// Animate ramp again
		sleep 1;
		_Transporter animate ["ramp_top", 0];
		_Transporter animate ["ramp_bottom", 0];	

};

SpawnVehicle = {
	private ["_type","_crew","_pos","_dir","_startpos","_veh","_spawnDistance"];
	_type = _this select 0;
	_pos = _this select 1;
	
	_crew = creategroup WEST;

	_dir = random 360;
	_spawnDistance = 6000 + (random 1000);
	
	_startpos = [(_pos select 0) + (sin _dir)*_spawnDistance, (_pos select 1) + (cos _dir)*_spawnDistance, 800];

	_veh = ([_startpos, ceil(random 360), _type, _crew] call BIS_fnc_spawnVehicle) select 0;
	_veh FlyInHeight 350; 
	if (_debug) then {diag_log format["MSO-%1 Tup_Logistics: Spawning %2 at %3m from position", time, typeof _veh, _pos distance _veh];};
	_veh;
};


//Request might be just a single request, if so, put in array.
if (count _request == 2) then {
	_request = [_request];
};

// For each request, provision the items (paradrop initially)
{
	private ["_num","_object","_airport","_i"];
	// Check for Aircraft, Vehicle, Crates, Static, Support
	_num = _x select 0;
	_object = _x select 1;
	_airport = _pos;
	
	if (_debug) then {diag_log format["MSO-%1 Tup_Logistics: Delivering the following: %2 x %3 items", time, _num, _object];};
	
	switch (true) do {
        case ((_object iskindof "Plane") || (_object iskindof "Helicopter")): {
                		
				for "_i" from 1 to _num do {
					private ["_placeholder","_wp","_v","_grp","_name","_id"];
					_placeholder = "Can_small" createvehicle _pos;
					
					// Find nearest helipad
					if (_object iskindof "Helicopter") then {
						_airport = position (([["HeliH","HeliHRescue","HeliHCivil"], [_placeholder], 500, _debug,"ColorBlack","heliport"] call mso_core_fnc_findObjectsByType) call BIS_fnc_selectRandom);
					};
					
					_v = [_object,_pos] call spawnvehicle;
					_grp = group _v;
					_wp = _grp addwaypoint [_pos, 50];
					_wp setWaypointBehaviour "CARELESS";
					_wp setWaypointStatements ["true", "if(vehicle this iskindof ""Plane"")then{vehicle this action [""Land"", vehicle this]};"];
					_wp setWaypointCompletionRadius 1000;
					
					_wp = _grp addwaypoint [_airport, 0];
					_wp setWaypointType "GETOUT";
					_wp setWaypointStatements ["true", "{deletevehicle _x} foreach crew (vehicle this); deletegroup group (vehicle this);"];
					
					deletevehicle _placeholder;
					
					_id = 1000 + ceil(random(9000));
					_name = format["mso_log_%1",_id];
					_v setVariable ["pdb_save_name", _name, true];
				};
        };
		default {
				// Para drop initially
				// idea though would be to have selection of Paradrop, airlift, convoy
				private ["_wp","_v","_grp"];
				_v = ["C130J",_pos] call SpawnVehicle;
				_grp = group _v;
				_wp = _grp addwaypoint [_pos, 50];
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCompletionRadius 10;
				
				[_v,_num,_object,_pos] spawn {
					private ["_v","_object","_num","_grp","_pos","_wp"];
					_v = _this select 0;
					_num = _this select 1;
					_object = _this select 2;
					_pos = _this select 3;
					_grp = group _v;
					
					if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: Aircraft is on its way.", time];};
					
					waitUntil {sleep 2; (_v distance _pos < 2000) || !(_grp call CBA_fnc_isAlive)};
					_v FlyInHeight 250;
					waitUntil {sleep 2; (_v distance _pos < 500) || !(_grp call CBA_fnc_isAlive)};
					
					if (_grp call CBA_fnc_isAlive) then {
						[_object, _v, _num] call DoDrop;
					} else {
						diag_log format["MSO-%1 Tup_Logistics: Vehicle carrying %2 was destroyed.", time, _object];
					};
					
					_wp = _grp addwaypoint [[0,0,0], 50];
					_wp setWaypointBehaviour "CARELESS";
					_wp setWaypointCompletionRadius 10;
					sleep (30 + (random 100));
					
					deleteVehicle _v;
					deletegroup _grp;
				};
        };
    };
	
} foreach _request;


