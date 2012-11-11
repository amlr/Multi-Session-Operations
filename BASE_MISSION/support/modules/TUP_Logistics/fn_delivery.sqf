private ["_debug","_request","_pos","_delivery","_prefDel","_player"];

// Run server side
// Receives requests from players
// Organises delivery of items
// Common types are bundled and delivered by the same vehicle
// Aircraft are always delivered to runways and helipads
// Vehicles can be delivered by para drop, airlift (sling) or convoy
// If delivery not selected Vehicles are delivered via convoy
// Crates & StaticWeapons can be delivered via any method
// If no delivery set they are delivered via guided para drop, if more than 4 crates, then airlift crates in container, if airlift not available, 5 crates in a vehicle
// Defense supplies - paradrop, airlift
// 

_debug = debug_mso;

_pos = _this select 0;
_request = _this select 1;
_prefDel = _this select 2;
_player = _this select 3;

//make sure pos is at ground level
_pos = [_pos select 0, _pos select 1, 0];

diag_log format["MSO-%1 Tup_Logistics: Starting delivery of %2 to %3", time, _request, _pos];

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
    if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: Spawning %2 at %3m from position", time, typeof _veh, _pos distance _veh];};
    _veh;
};


// Turn request into set of deliveries
_delivery = [_request] call logistics_fnc_bundleDelivery;

// For each delivery, provision the items
{
    private ["_num","_object","_airport","_i"];
    // Check for Aircraft, Vehicle, Crates, Static, Support
    _request = _x;
    _airport = _pos;
    _object = _x select 0;
    
    if (_debug) then {
        diag_log format["MSO-%1 Tup_Logistics: Delivering the following: %2", time, _request];
    };
    
    switch (true) do 
    {
        case ((_object iskindof "Plane") || (_object iskindof "Helicopter")): 
        {
            // Aircraft and Helicopters are always delivered to helipads or runways
            
            private ["_placeholder","_wp","_v","_grp","_name","_id","_msgObject"];
            _msgObject = getText(configFile >> 'CfgVehicles' >> _object >> 'displayname');
			
            // Find nearest helipad
            if ((_object iskindof "Helicopter") || (_object == "MV22")) then 
            {
                _placeholder = "Can_small" createvehicle _pos;
                _airport = position (([["HeliH","HeliHRescue","HeliHCivil"], [_placeholder], 500, _debug,"ColorBlack","heliport"] call mso_core_fnc_findObjectsByType) call BIS_fnc_selectRandom);
				deletevehicle _placeholder;
            };
			if (_debug) then {
				diag_log format["MSO-%1 Tup_Logistics: Airport/Helipad: %2", time, _airport];
			};
			
            if (!isNil "_airport") then 
            {
                _v = [_object,_pos] call spawnvehicle;
                _grp = group _v;
                _wp = _grp addwaypoint [_pos, 0];
                _wp setWaypointBehaviour "CARELESS";
                _wp setWaypointStatements ["true", "if((vehicle this iskindof ""Plane"") && !(typeof (vehicle this)== 'MV22'))then{vehicle this action [""Land"", vehicle this]};"];
                _wp setWaypointCompletionRadius 1000;
                
                _wp = _grp addwaypoint [_airport, 0];
                _wp setWaypointType "GETOUT";
                _wp setWaypointTimeout [15,30,60];
                _wp setWaypointStatements ["true", "{deletevehicle _x} foreach crew (vehicle this); deletegroup group (vehicle this);"];
                
                _id = 1000 + ceil(random(9000));
                _name = format["mso_log_%1",_id];
                _v setVariable ["pdb_save_name", _name, true];	
				[-1, {PAPABEAR sideChat _this}, format ["%1 this is PAPA BEAR. %2 is on its way to %3 and will land at the nearest helipad or runway.", group _player, _msgObject, _airport]] call CBA_fnc_globalExecute;
				
				//Check to see if killed or landed
				_v addEventHandler ["killed", 
											{
												[-1, {PAPABEAR sideChat _this}, 
													format ["%1 this is PAPA BEAR. We regret to inform you the %2 you ordered has been destroyed.", group (_this select 0), getText(configFile >> 'CfgVehicles' >> typeof (_this select 0) >> 'displayname')]] call CBA_fnc_globalExecute;
											}
										];
				_v addEventHandler ["LandedStopped", 
											{
												[-1, {PAPABEAR sideChat _this}, 
													format ["%1 this is PAPA BEAR. The %2 you ordered has landed at %3", group (_this select 0), getText(configFile >> 'CfgVehicles' >> typeof (_this select 0) >> 'displayname'), position (_this select 0)]] call CBA_fnc_globalExecute; 
													(_this select 0) removeAllEventHandlers "LandedStopped";
											}
										];
				
            } else {
                // Tell group that order cannot be delivered due to no local airport/helipad           
				[-1, {PAPABEAR sideChat _this}, format ["%1 this is PAPA BEAR. %2 delivery aborted as there is no runway or helipad within 500m of delivery location.", group _player, _msgObject]] call CBA_fnc_globalExecute;
            };	
        };
        default {
            // Para drop initially
            // idea though would be to have selection of Paradrop, airlift, convoy
            
            // Create vehicles for delivery
            private ["_wp","_v","_grp"];
            _v = ["C130J",_pos] call SpawnVehicle;
            _grp = group _v;
            _wp = _grp addwaypoint [_pos, 50];
            _wp setWaypointBehaviour "CARELESS";
            _wp setWaypointCompletionRadius 10;
            
            [_v,_request,_pos, _player] spawn {
                private ["_v","_request","_grp","_pos","_wp","_player"];
                _v = _this select 0;
                _request = _this select 1;
                _pos = _this select 2;
                _grp = group _v;
				_player = _this select 3;
                
                if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: Aircraft is on its way.", time];};
                
                waitUntil {sleep 5; (_v distance _pos < 2000) || !(_grp call CBA_fnc_isAlive)};
                _veh FlyInHeight (150 + (random 100)); 
				if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: Aircraft is 2km away.", time];};
                waitUntil {sleep 1; (_v distance _pos < 500) || !(_grp call CBA_fnc_isAlive)};
                if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: Aircraft is 500m away.", time];};
                if (_grp call CBA_fnc_isAlive) then {
					if (debug_mso) then {diag_log format["MSO-%1 Tup_Logistics: calling dodrop", time];};
                    [_request, _v] call logistics_fnc_DoDrop;
					[-1, {PAPABEAR sideChat _this}, format ["%1 this is PAPA BEAR. %2 items were dropped near position %3. Over.", group _player, count _request, position _v]] call CBA_fnc_globalExecute;
                } else {
					_msgObject = getText(configFile >> 'CfgVehicles' >> typeof _v >> 'displayname');
					[-1, {PAPABEAR sideChat _this}, format ["%1 this is PAPA BEAR. %2 carrying %3 items has disappeared off our radar, likely shotdown or crashed. Over.", group _player, _msgObject, count _request]] call CBA_fnc_globalExecute;
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
} foreach _delivery;


