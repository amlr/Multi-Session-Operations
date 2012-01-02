private ["_veh","_grp","_vehtype","_priority","_enemy","_patient","_equip","_startpos","_center","_mapsize","_chance","_debug","_armveh","_armvehtype","_speed","_behav","_cargo","_gunship","_invalid"];

_debug = false;

RMM_casevac_return = false;

_chance = 0;

PAPABEAR = [West,"HQ"];

// Check that all lines were submitted
for "_x" from 0 to 7 do
{
	if (lbCurSel _x < 0) then {
		_invalid = true;
	};
};

if (_invalid) exitWith {PAPABEAR sideChat format ["%1 this is PAPA BEAR. Invalid Request. Over.", group player];};

PAPABEAR sideChat format ["%1 this is PAPA BEAR. Request Received. Over.", group player];

// Get center of map
_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

// Calculate size of map
_mapsize = ((_center select 0) * 2);

// Set CASEVAC request variables
_cargo = (call (RMM_casevac_lines select 4)) select (lbCurSel 4);
switch(_cargo) do 
{
    case "1": {
        _cargo = 1;
    };
    case "4": {
        _cargo = 4;
    };
	case "7": {
        _cargo = 7;
    };
	case "12": {
        _cargo = 12;
    };
   case "16": {
        _cargo = 16;
    };
	case "23": {
        _cargo = 23;
    };
};

_grp = group player;
_priority = (call (RMM_casevac_lines select 2)) select (lbCurSel 2);
_patient = (call (RMM_casevac_lines select 7)) select (lbCurSel 7);
_enemy = (call (RMM_casevac_lines select 5)) select (lbCurSel 5);
_equip = (call (RMM_casevac_lines select 3)) select (lbCurSel 3);

// Set startpos

	
// Work out odds of CASEVAC attending and set response parameters
switch(_priority) do 
{
    case "Urgent": {
        _chance = _chance + 0.25;
		_startpos = [markerpos "hospital", 0, 50, 15, 0, 0, 0] call BIS_fnc_findSafePos;
		RMM_casevac_speed = "FULL";
    };
    case "Urgent Surgical": {
        _chance = _chance + 0.35;
		_startpos = [markerpos "hospital", 0, 50, 15, 0, 0, 0] call BIS_fnc_findSafePos; // Could change to be within 2000m of players
		RMM_casevac_speed = "FULL";
		RMM_casevac_behav = "CARELESS";
    };
    case "Priority": {
        _chance = _chance + 0.25;
		_startpos = [_mapsize, RMM_casevac_flyinheight, _debug, format ["CASEVAC-%1",time], "ColorGreen", "Dot"] call mso_core_fnc_randomEdgePos;
		RMM_casevac_speed = "NORMAL";
		RMM_casevac_behav = "SAFE";
    };
    case "Routine": {
        _chance = _chance + 0.15;
		_startpos = [_mapsize, RMM_casevac_flyinheight, _debug, format ["CASEVAC-%1",time], "ColorGreen", "Dot"] call mso_core_fnc_randomEdgePos;
		RMM_casevac_speed = "NORMAL";
		RMM_casevac_behav = "AWARE";
    };
	case "Convenience": {
        _chance = _chance + 0.1;
		_startpos = [_mapsize, RMM_casevac_flyinheight, _debug, format ["CASEVAC-%1",time], "ColorGreen", "Dot"] call mso_core_fnc_randomEdgePos;
		RMM_casevac_speed = "NORMAL";
		RMM_casevac_behav = "AWARE";
    };
};

switch(_patient) do 
{
    case "BLUFOR Mil": {
        _chance = _chance + 0.3;
		RMM_casevac_speed = "FULL";
		RMM_casevac_behav = "CARELESS";
    };
    case "BLUFOR Civ": {
        _chance = _chance + 0.25;
		RMM_casevac_speed = "FULL";
    };
    case "Mil": {
        _chance = _chance + 0.2;
    };
    case "OPFOR": {
        _chance = _chance - 0.2;
    };
};

switch(_enemy) do 
{
    case "No Enemy": {
        _chance = _chance + 0.3;
		RMM_casevac_behav = "SAFE";
    };
    case "Possible Enemy": {
        _chance = _chance + 0.2;
		RMM_casevac_behav = "AWARE";
    };
    case "Enemy": {
        _chance = _chance + 0.1;
		RMM_casevac_behav = "COMBAT";
    };
    case "Heavy Enemy": {
        _chance = _chance - 0.2;
		RMM_casevac_behav = "STEALTH";
    };
};
	
// Check to see if the CASEVAC can be attended to
if ((random 1 < _chance) && !(RMM_casevac_active)) then 
{
	// Set casevac as active to prevent other calls for casevac
	RMM_casevac_active = true;
	
	// Create aircraft at startpos, based on helicopter chosen
	_vehtype = ([_cargo,faction player,"Helicopter"] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
	_veh = ([_startpos, 0, _vehtype, _grp] call BIS_fnc_spawnVehicle) select 0;
	
	// Hint details of CASEVAC
	hintcadet format ["%1 (Call Sign: PEDRO ONE) requested to %2 by %3 for %4 CASEVAC of %5 personnel. %6 are expected. LZ will be marked with %7. Equipment requested: %8.", _vehtype , (call (RMM_casevac_lines select 0)) select (lbCurSel 0), _grp, _priority, _patient, _enemy, (call (RMM_casevac_lines select 6)) select (lbCurSel 6), _equip];
		
	// Log CASEVAC
	diag_log format ["MSO-%9 CASEVAC: %1 requested to %2 by %3 for %4 CASEVAC of %5 personnel. %6 are expected. LZ will be marked with %7. Equipment requested: %8.", _vehtype , (call (RMM_casevac_lines select 0)) select (lbCurSel 0), _grp, _priority, _patient, _enemy, (call (RMM_casevac_lines select 6)) select (lbCurSel 6), _equip, time];
	
	// Confirm authorisation
	[] spawn {
		sleep (5+(random 5));
		PAPABEAR sideChat format ["%1 this is PAPA BEAR. Request Authorised. PEDRO dispatched. Over.", group player]; 
	};
	
	// Check if armed escort required, spawn
	if ((_enemy == "Heavy Enemy") || (_enemy == "Enemy" && ((random 1) > 0.5))) then 
	{
		_gunship = ["AH64D","BAF_Apache_AH1_D","AH1Z","AH64D_EP1","UH1Y","AW159_Lynx_BAF","AH6J_EP1"];
		_armvehtype = (_gunship) call BIS_fnc_selectRandom;
		_armveh = ([position _veh, 0, _armvehtype, group _veh] call BIS_fnc_spawnVehicle) select 0;
		diag_log format ["MSO-%1 CASEVAC: %2 providing armed escort", time, typeof _armveh];
		[2,_armveh,{_this flyinheight RMM_casevac_flyinheight - 100;}] call RMM_fnc_ExMP;
		[2,_armveh,{_this lockdriver true;}] call mso_core_fnc_ExMP;
		[2,_armveh,{
			_this spawn {			
				private ["_wp","_hospital","_destpos","_behav","_speed"];
				if (alive _this) then 
				{
					waitUntil {sleep 5;{isplayer _x} count (crew _this) == 0};
					(crew _this) join (createGroup (side (driver _this)));
					{
						_x setskill 0.8;
					} foreach (units (group _this));
					sleep 10;
					PAPABEAR sideChat format ["%1 this is PAPA BEAR. %2 will provide CAS for PEDRO. Over.", group player, typeof _this];
					_wp = (group _this) addwaypoint [position player,0];
					_wp setWaypointType "SAD";
					_wp setWaypointBehaviour RMM_casevac_behav;
					_wp setWaypointSpeed RMM_casevac_speed;
					
					waitUntil {sleep 3;(RMM_casevac_return) || !(alive _this)};
					_hospital = [markerpos "hospital", 0, 50, 15, 0, 0, 0] call BIS_fnc_findSafePos;
					_wp = (group _this) addwaypoint [_hospital,0];
					_wp setWaypointType "MOVE";
					_wp setWaypointBehaviour RMM_casevac_behav;
					_wp setWaypointSpeed RMM_casevac_speed;
					
					waitUntil {sleep 3;( _this distance _hospital < 200) || !(alive _this)};	
					(group _this) addwaypoint [[0,0,0],0];
					
					waitUntil {sleep 3;( _this distance player > 1500) || !(alive _this)};
					
					// Check for death of chopper
					if !(alive _this) then {
						hintcadet format ["CASEVAC: Armed Escort %1 has crashed!", typeof _this];
						diag_log format ["MSO-%2 CASEVAC: %1 has crashed!", typeof _this, time];
					};
					
					// Delete Chopper
					_this call CBA_fnc_deleteEntity;
				};
			};
		}] call mso_core_fnc_ExMP;
	};
	
	// Check for any additional equipment - WIP
	if (_equip != "None") then {
		// Load chopper with selected medical supplies
		// A2/OA - Field Hospital can be loaded in MSO
		// ACE - Medical supplies (chosen from CASEVAC drop down)?
	};
	
	// Set fly in height
	[2,_veh,{_this flyinheight RMM_casevac_flyinheight;}] call RMM_fnc_ExMP;	

	// Lock driver of helicopter
	[2,_veh,{_this lockdriver true;}] call mso_core_fnc_ExMP;

	// Spawn vehicle and crew, set waypoint, do casevac
	[2,_veh,{
		_this spawn {
			private ["_lz","_marker","_wp","_hospital","_landend","_wounded","_medic","_destpos","_behav","_speed","_units","_mwp"];

			if (alive _this) then 
			{
				//Ensure CASEVAC doesn't engage targets during rescue
				_this disableAI "TARGET";
				_this disableAI "AUTOTARGET";
				
				// Set LZ
				_lz = (call (RMM_casevac_lines select 0)) select (lbCurSel 0);
				
				// Set LZ marker
				_marker = (call (RMM_casevac_lines select 6)) select (lbCurSel 6);
				
				// Set endpos
				_hospital = [markerpos "hospital", 0, 50, 15, 0, 0, 0] call BIS_fnc_findSafePos;

				// Check no players are crew members?
				waitUntil {sleep 5;{isplayer _x} count (crew _this) == 0};
				(crew _this) join (createGroup (side (driver _this)));
				{
					_x setskill 0.8;
				} foreach (units (group _this));
				
				// Send Casevac to player's position or other location?
				_destpos = [position player, 0, 50, 15, 0, 0, 0] call BIS_fnc_findSafePos;
				_wp = (group _this) addwaypoint [_destpos,0];
				_wp setWaypointBehaviour RMM_casevac_behav;
				_wp setWaypointSpeed RMM_casevac_speed;
				
				// Check for LZ marker	
				waitUntil {sleep 3;( _this distance position player <= 600) || !(alive _this)};
				if (alive _this) then {_this sideChat format ["%1 this is Pedro One. 600 meters out. Over.", group player];};
				diag_log format ["MSO-%1 CASEVAC: Looking for LZ marker: %2", time, str _marker];
				if (str _marker != "Nothing") then {
					_this sideChat format ["%1 this is Pedro One. Mark LZ now. Over.", group player];
					//Check for LZ marker and land near it - WIP
				};
				
				// Setup Heli landing
				_landEnd = "HeliHEmpty" createVehicle _destpos;
				_this land "GET IN";
					
				// Wait for helicopter landing
				waitUntil {sleep 3;((position _this) select 2 <= 3) || !(alive _this)};
				
				if (alive _this) then 
				{
					_this sideChat format ["%1 this is Pedro One. Touchdown. Over.", group player];
					
					// Check for wounded (cannot stand) within 100m
					_wounded = [];
					_units = [_destpos, 100] call mso_core_fnc_getUnitsInArea;
					{
						if (!(canStand _x) && (faction _x == faction player)) then {
							_wounded = _wounded + [_x];
						};
					} foreach _units;
					
					if (count _wounded > 0) then {_this sideChat format ["%1 this is Pedro One. Load the %2 wounded. Over.", group player, count _wounded];};
					
					/*
					// Crewman go pickup each wounded person (not already in helicopter) and put in helicopter
					if (count _wounded > 0) then {
						_this sideChat format ["%1 this is Pedro One. I count %2 casualties requiring assistance. Sending one of my crewman to help. Over.", group player, count _wounded];
						if (count crew _this > 1) then {
							_medic = crew _this select 1;
						} else {
							_medic = driver _this;
						};
						
						diag_log format ["MSO-%1 CASEVAC: %2 is the medic", time, typeof _medic];
						
						{ //STILL WIP 
							if !(_x in _this) then {
								doGetOut _medic;
								
								_medic disableAI "TARGET";
								_medic disableAI "AUTOTARGET";
								
								diag_log format ["MSO-%1 CASEVAC: %2 moving to %3", time, typeof _medic, name _x];
								while {((_medic distance _x) > 3) && (alive _medic)} do
								{
									_medic moveTo (position _x);
								};
								
								private ["_pos_th"];
								_pos_th =  _x modelToWorld [0,0,0];

								dostop _medic;
								_medic doMove  [(_pos_th  select 0)-0.5*sin (getDir _x), (_pos_th  select 1)-0.5*cos (getDir _x), _pos_th  select 2];
								
								// Disable wounded player
								[0,_x,{_this playmove "ainjppnemstpsnonwrfldb_still"}] call mso_core_fnc_ExMP;
								sleep 0.1;
					
								// Check wounded
								//_medic playmove "AinvPknlMstpSnonWrflDr_medic4";
								//sleep 15;

								// Carry wounded
								_medic playmove "AcinPercMstpSrasWrflDnon";
								sleep 8;

								//attach wounded unit
								_x attachTo [_medic,  [-0,-0.1,-1.2], "RightShoulder"];
								sleep 0.1;
								
								//orientation
								[0,_x,{_this setdir 180}] call mso_core_fnc_ExMP;
								
								//unconscious unit assumes carrying posture
								[0,_x,{_this playmove "AinjPfalMstpSnonWrflDnon_carried_still"}] call mso_core_fnc_ExMP;
								sleep 0.1;
								
								diag_log format ["MSO-%1 CASEVAC: %2 carrying %3", time, typeof _medic, typeof _x];
												
								// Get medic moving
								_medic playmove "AcinPercMrunSrasWrflDf";
								_medic moveTo (position _this);
								
								diag_log format ["MSO-%1 CASEVAC: %2 moving to %3", time, typeof _medic, typeof _this];
								
								// Get AI to drag/carry wounded to copter
								
								while {((_medic distance _this) > 5) && (alive _medic)} do
								{
									_medic moveTo (position _this);
								};
								
								waitUntil {sleep 3;((_medic distance _this) < 10) || !(alive _medic)};
								//detach
								detach _x;
								detach _medic;

								_medic playaction "released";
								sleep 1;
							
								[0,_x,{_this playaction "agonystart"}] call mso_core_fnc_ExMP;
								sleep 3;
								
								_medic switchmove "";
													
								_x moveInCargo _this;
							};
						} foreach _wounded;
						
						_this sideChat format ["%1 this is Pedro One. Wounded are loaded. Over.", group player];
						
						[_medic] orderGetIn true;
						
					};*/
					
					// Waituntil wounded loaded then give the players 30 seconds to get in helicopter
					if (count _wounded > 0) then {
						waitUntil {sleep 3;{!(_x in _this)} count _wounded == 0};
						_this sideChat format ["%1 this is Pedro One. Wounded now onboard. Over.", group player];
					};
					
					if (alive _this) then {
						_this sideChat format ["%1 this is Pedro One. 30 seconds to dustoff. Over.", group player];
						sleep 30;
						deleteVehicle _landEnd;
					};
				};
				
				// Return to base
				_wp = (group _this) addwaypoint [_hospital,0];
				_wp setWaypointBehaviour RMM_casevac_behav;
				_wp setWaypointSpeed RMM_casevac_speed;
				RMM_casevac_return = true;
				waitUntil {sleep 3;( _this distance _hospital <= 500) || !(alive _this)};
				
				// Setup Heli landing
				_landEnd = "HeliHEmpty" createVehicle _hospital;
				_this land "GET OUT";
				
				waitUntil {sleep 3;((position _this) select 2 <= 3) || !(alive _this)};
				if (alive _this) then {
					
					_this sideChat format ["%1 this is Pedro One. Arrived at Field Hospital. Over.", group player];
					
					/*
					// Get Out, carry wounded to hospital
					if (count _wounded > 0) then {
						doGetOut _medic;
						{ //STILL WIP (medic animations/actions don't work)
							if (_x in _this) then {
								doGetOut _x;
								[0,_x,{_this switchmove "ainjppnemstpsnonwrfldb_still"}] call mso_core_fnc_ExMP;
								_medic moveTo position _x;
								waitUntil {sleep 3;(_medic distance _x < 3) || !(alive _medic)};
								_x attachto [_medic, [0.1, 1.01, 0]];
								sleep 0.1;
								//orientation
								[0,_x,{_this setdir 180}] call mso_core_fnc_ExMP;
								_medic moveTo _hospital;
								waitUntil {sleep 3;(_medic distance _hospital < 5) || !(alive _medic)};
								detach _x;
								detach _medic;
							};
						} foreach _wounded;
						[_medic] orderGetIn true;
						
					};*/
				
					// Wait for any players to getout
					waitUntil {sleep 5;{(_x in _this)} count _wounded == 0};
					_this sideChat format ["%1 this is Pedro One. Wounded have been moved to the field hospital. We are RTB. Over.", group player];
					waitUntil {sleep 5;{isplayer _x} count (crew _this) == 0};
					
					deleteVehicle _landEnd;
				};
				
				// Fly away
				(group _this) addwaypoint [[0,0,0],0];
				waitUntil {sleep 5;( _this distance player > 1500) || !(alive _this)};
				
				// Check for death of chopper
				if !(alive _this) then {
					hintcadet format ["CASEVAC: %1 has crashed!", typeof _this];
					diag_log format ["MSO-%2 CASEVAC: %1 has crashed!", typeof _this, time];
				};
				
				// Delete Chopper
				_this call CBA_fnc_deleteEntity;
				RMM_casevac_active = false;
			};
		};
	}] call mso_core_fnc_ExMP;
	
} else {
	[] spawn {
		sleep (5+(random 5));
		PAPABEAR sideChat format ["%1 this is PAPA BEAR. Request Not-Authorised. Sorry guys, we're real busy, try later. Over.", group player]; 
	};
    
};