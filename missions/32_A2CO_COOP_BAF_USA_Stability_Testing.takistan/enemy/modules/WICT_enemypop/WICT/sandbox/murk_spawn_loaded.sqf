// Murklor script for loaded groups

if(isServer) then 
{

// ----------------  Parameters  -------------------- //

_unitArray = (_this select 0) select  0;
_side = (_this select 0) select  1; //diag_log _side;
_waypointsArray = (_this select 0) select  2;
_trigger = (_this select 0) select  3; //diag_log _trigger;
_spawntype = (_this select 0) select  4; //diag_log _spawntype;
_spawnlives = (_this select 0) select  5;
_spawndelay = (_this select 0) select  6;
_initString = (_this select 0) select  7;
_bodyRemove = (_this select 0) select  8;

_unitGroup = "";

// -----------------  Functions  -------------------- //

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_returnConfigEntry as its needed for turrets and shortened a bit
_fnc_returnConfigEntry = {
	private ["_config", "_entryName","_entry", "_value"];
	_config = _this select 0;
	_entryName = _this select 1;
	_entry = _config >> _entryName;
	//If the entry is not found and we are not yet at the config root, explore the class' parent.
	if (((configName (_config >> _entryName)) == "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
		[inheritsFrom _config, _entryName] call _fnc_returnConfigEntry;
	}
	else { if (isNumber _entry) then { _value = getNumber _entry; } else { if (isText _entry) then { _value = getText _entry; }; }; };
	//Make sure returning 'nil' works.
	if (isNil "_value") exitWith {nil};
	_value;
};
	
// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_fnc_returnVehicleTurrets and shortened a bit
_fnc_returnVehicleTurrets = {
	private ["_entry","_turrets", "_turretIndex"];
	_entry = _this select 0;
	_turrets = [];
	_turretIndex = 0;
	//Explore all turrets and sub-turrets recursively.
	for "_i" from 0 to ((count _entry) - 1) do {
		private ["_subEntry"];
		_subEntry = _entry select _i;
		if (isClass _subEntry) then {
			private ["_hasGunner"];
			_hasGunner = [_subEntry, "hasGunner"] call _fnc_returnConfigEntry;
			//Make sure the entry was found.
			if (!(isNil "_hasGunner")) then {
				if (_hasGunner == 1) then {
					_turrets set [count _turrets, _turretIndex];		
					//Include sub-turrets, if present.
					if (isClass (_subEntry >> "Turrets")) then { _turrets = _turrets + [[_subEntry >> "Turrets"] call _fnc_returnVehicleTurrets]; } 
					else { _turrets = _turrets + [[]]; };
				};
			};
			_turretIndex = _turretIndex + 1;
		};
	};
	_turrets;
};

_fnc_moveInTurrets = {	
	private ["_turrets","_path","_i"];
	_turrets = _this select 0;
	_path = _this select 1;
	_currentCrewMember = _this select 2;
	_crew = _this select 3;
	_spawnUnit = _this select 4;
	_i = 0;     
	while {_i < (count _turrets)} do { 
		 _turretIndex = _turrets select _i;
		_thisTurret = _path + [_turretIndex];
		(_crew select _currentCrewMember) moveInTurret [_spawnUnit, _thisTurret]; _currentCrewMember = _currentCrewMember + 1;
		//Spawn units into subturrets.
		[_turrets select (_i + 1), _thisTurret, _currentCrewmember, _crew, _spawnUnit] call _fnc_moveInTurrets;
		_i = _i + 2;
	};
};

_fnc_spawnUnit = {
	// We need to pass the old group so we can copy waypoints from it, the rest we already know
	_oldGroup = _this select 0;
	_newGroup = createGroup (_this select 1);
	_waypointsArray = _this select 2;
	// If the old group doesnt have any units in it its a spawned group rather than respawned
	if (typeName _oldGroup != "STRING") then { if ( count (units _oldGroup) == 0) then { deleteGroup _oldGroup; };};
	{
		_spawnUnit = Object;
		_unitType = _x select 0; _unitPos  = _x select 1; _unitDir  = _x select 2;
		_unitName = _x select 3; _unitSkill = _x select 4; _unitRank = _x select 5;
		_unitWeapons = _x select 6; _unitMagazines = _x select 7; _unitCrew = _x select 8;
		// Check if the unit has a crew, if so we know its a vehicle
		if (count _unitCrew > 0) then { 
			if (_unitPos select 2 >= 10) then { 
				_spawnUnit = createVehicle [_unitType,_unitPos, [], 0, "FLY"]; 
				_spawnUnit setVelocity [50 * (sin _unitDir), 50 * (cos _unitDir), 0];
			}
			else { _spawnUnit = _unitType createVehicle _unitPos; };
			// Create the entire crew
			_crew = [];
     			{ _unit = _newGroup createUnit [_x, getPos _spawnUnit, [], 0, "NONE"]; _crew set [count _crew, _unit]; } forEach _unitCrew;
	      	// We assume that all vehicles have a driver, the first one of the crew
			(_crew select 0) moveInDriver _spawnUnit;
			// Count the turrets and move the men inside	      	
	      	_turrets = [configFile >> "CfgVehicles" >> _unitType >> "turrets"] call _fnc_returnVehicleTurrets;
	      	[_turrets, [], 1, _crew, _spawnUnit] call _fnc_moveInTurrets; 	      	
		}
		// Otherwise its infantry
		else { 
			_spawnUnit = _newGroup createUnit [_unitType,_unitPos, [], 0, "NONE"]; 
			removeAllWeapons _spawnUnit;
			{_spawnUnit removeMagazine _x} forEach magazines _spawnUnit;
			removeAllItems _spawnUnit;
			{_spawnUnit addMagazine _x} forEach _unitMagazines;
			{_spawnUnit addWeapon _x} forEach _unitWeapons;
			_spawnUnit selectWeapon (primaryWeapon _spawnUnit);
		};
		// Set all the things common to the spawned unit
		_spawnUnit setDir _unitDir;
		_spawnUnit setSkill _unitSkill;
		_spawnUnit setUnitRank _unitRank;
		if (_spawntype == "once" OR _spawntype == "repeated") then { 
			_spawnUnit setVehicleVarName _unitName;
			if (vehiclevarname _spawnUnit != "") then { _spawnUnit setVehicleInit format["%1=this;",_unitName]; processInitCommands; };
		};
	} forEach _unitArray;
	
	private ["_i"]; _i = 0;

	//Let's return them their waypoints
	{
		//diag_log format ["All data : %1",_x];
		_wp = _newGroup addWaypoint [(_x select 0),0,_i];
		[_newGroup, _i] setWaypointHousePosition (_x select 1);	
		[_newGroup, _i] setWaypointBehaviour (_x select 2);
		[_newGroup, _i] setWaypointCombatMode (_x select 3);
		[_newGroup, _i] setWaypointCompletionRadius (_x select 4);
		[_newGroup, _i] setWaypointDescription (_x select 5);
		[_newGroup, _i] setWaypointFormation (_x select 6);
		[_newGroup, _i] setWaypointScript (_x select 7);
		[_newGroup, _i] showWaypoint (_x select 8);
		[_newGroup, _i] setWaypointSpeed (_x select 9);
		[_newGroup, _i] setWaypointStatements (_x select 10);
		[_newGroup, _i] setWaypointTimeout (_x select 11);
		[_newGroup, _i] setWaypointType (_x select 12);
		
		_i = _i + 1;
		
	} forEach _waypointsArray;
	
	// Setting the leaders init and the groups body removal time
	(vehicle (leader _newGroup)) setVehicleInit _initString; processInitCommands;
	// Run the cleanup function for this group
	[_newGroup, _bodyRemove] execVM (WICT_PATH + "WICT\removeBody.sqf");
	
	// Have to return the new group
	_newGroup;
};

//diag_log format ["Number of groups : %1",(count allGroups)];

// --------------  Waiting period  ------------------ //
waitUntil { _trigger == catch_trigger };

// ---------------  Spawn Modes  ------------------- //
// REPEAT MODE, i.e. basic respawn based on lives
if (_spawntype == "repeated") then {
	while { _spawnlives > 0 } do {
		_unitGroup = [_unitGroup,_side,_waypointsArray] call _fnc_spawnUnit;
		_spawnLives = _spawnLives - 1;
		_unitsGroup = units _unitGroup;	
		while { ({alive _x} count _unitsGroup) > 0 } do { sleep 2; };
		sleep _spawndelay;
	};
};

// WAVE MODE, this is fairly simple, just sleep a while then respawn. Spawnlives in this case is number of waves
if (_spawntype == "wave") then {
	while { _spawnlives > 0 } do {
		_unitGroup = [_unitGroup,_side,_waypointsArray] call _fnc_spawnUnit;
		_spawnLives = _spawnLives - 1;
		sleep _spawndelay;
	};
};

// RESET MODE, sleep a while then set the variable to false (even if you set it like 50 times over). Spawn lives is used to tick how many times its possible to reset.
if (_spawntype == "reset") then {
	while { _spawnlives > 0 } do {
		_unitGroup = [_unitGroup,_side,_waypointsArray] call _fnc_spawnUnit;
		_spawnLives = _spawnLives - 1;
		sleep 15;
		catch_trigger = "none";
		waitUntil {_trigger == catch_trigger};
	};
};

// ONCE MODE
if (_spawntype == "once") then { _unitGroup = [_unitGroup,_side,_waypointsArray] call _fnc_spawnUnit; };

};