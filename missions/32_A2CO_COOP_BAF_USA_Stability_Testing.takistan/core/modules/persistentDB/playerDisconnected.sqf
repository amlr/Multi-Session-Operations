/* 
 * Filename:
 * playerDisconnected.sqf 
 *
 * Description:
 * Called from init.sqf
 * Runs on server only
 * 
 * Created by [KH]Jman
 * Creation date: 17/10/2010
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */
 
// ====================================================================================
// INCLUDES
   #include "\x\cba\addons\main\script_mod.hpp"
	//http://dev-heaven.net/docs/cba/files/extended_eventhandlers/script_macros_common-hpp.html#DEBUG_MODE_FULL
	#define DEBUG_MODE_FULL
	#define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
	#include "\x\cba\addons\main\script_macros.hpp"
	#define COMPONENT arma2mysql
	#define PREFIX asff

// ====================================================================================
// MAIN
	_id = _this select 0; 
	_pname = _this select 1; 
	_puid  = _this select 2; 


	saveOnQuit = {	
	if (_pname != "__SERVER__") then {
		
		
		private["_found","_write","_databaseName","_procedureName","_parameters","_databaseProcedure","_retPipe","_result","_temp","_response","_return_response","_aceweapononback","_aceruckweapons","_aceruckmagazines","_pscore","_bypassed"];
			

		_player = objNull;
		{
			
			if (pdb_log_enabled) then {
					diag_log format["SERVER MSG: Loop. %1", getPlayerUID _x];
			};	
		
			if (getPlayerUID _x == _puid) exitWith {
			
				if (pdb_log_enabled) then {		
						diag_log format["SERVER MSG: Loop break. %1", getPlayerUID _x];
				};
		
			   _player = _x;
			};
		} forEach playableUnits; // Return a list of playable units (occupied by both AI or players) in a multiplayer game. 
		
		if !(isNull _player) then {	
			
			
//				 _player setVariable ["status", "disconnecting", true];

			
				if (CFG_ReturnKeysOnDeath == 1) then { [_player] call FNC_REMOVE_FROM_VEHICLE_KEYS_ARRAY;  };
				
		
// ====================================================================================	

 
if (pdb_globalScores_enabled) then {			
			_loadedPlayerScore = _player getVariable "loadedPlayerScore";                                                                         
		   diag_log ["_loadedPlayerScore: ", _loadedPlayerScore, typeName _loadedPlayerScore]; 
		 	_globalPlayerScore = _player getVariable "globalPlayerScore";																			
		 	diag_log ["_globalPlayerScore: ", _globalPlayerScore, typeName _globalPlayerScore];	
		 	 _otherScores = _globalPlayerScore -_loadedPlayerScore; 	
		 	_pscore = (score _player) - _otherScores;	   
		 } else {
		 	_pscore = score _player;
 };
		
			diag_log ["_pscore: ", _pscore, typeName _pscore]; 



// ====================================================================================			
		// add the player position (Element 3) into the player's array in the multi-d
		_thisposition = str(getPosASL _player);
		_thisposition = [_thisposition, "[", ""] call CBA_fnc_replace; 
		_thisposition = [_thisposition, "]", ""] call CBA_fnc_replace; 
		_thisposition = [_thisposition, ",", "|"] call CBA_fnc_replace; 
		
		_pposition = _thisposition;
	
// ====================================================================================		
		// add the player weapons
		
//	 diag_log ["weapons _player:", (weapons _player), typeName (weapons _player)];
				 
		_thisweapons = str(weapons _player);
		
//	diag_log ["_thisweapons:", _thisweapons, typeName _thisweapons];
	
		_thisweapons = [_thisweapons, "[", ""] call CBA_fnc_replace; 
		_thisweapons = [_thisweapons, "]", ""] call CBA_fnc_replace; 
		_thisweapons = [_thisweapons, ",", "|"] call CBA_fnc_replace; 
//	diag_log ["_thisweapons replaced:", _thisweapons, typeName _thisweapons];

		_pweapons = _thisweapons;
	
// ====================================================================================		
		// add the player magazines
		
		_thismagazines = str(magazines _player);
		_thismagazines = [_thismagazines, "[", ""] call CBA_fnc_replace; 
		_thismagazines = [_thismagazines, "]", ""] call CBA_fnc_replace; 
		_thismagazines = [_thismagazines, ",", "|"] call CBA_fnc_replace; 	
		
		_pmagazines = _thismagazines;
	
// ====================================================================================		
		// add the player damage 
		_thispdamage = str(getDammage _player);  //  _unit setDamage 0; fully healed or _unit setDamage 1; // kills, or anything in between. 
		
		_pdamage = _thispdamage;
	
// ====================================================================================
		// get the player's head_hit damage
		_p_head_hit_damage = _player getVariable "head_hit";
// ====================================================================================
		// get the player's body damage
		_p_body_damage = _player getVariable "body";
// ====================================================================================
		// get the player's hand damage
		_p_hands_damage = _player getVariable "hands";
// ====================================================================================
		// get the player's legs damage
		_p_legs_damage = _player getVariable "legs";
// ====================================================================================
		// add the player direction (Element 10) into the player's array in the multi-d
		_thisdirection = str(getDir _player);
			/*		
			if (pdb_log_enabled) then {	
				 	diag_log format["SERVER MSG: _thisdirection: %1", _thisdirection];
			};
			*/
		// get the player's position 
		_pdirection =_thisdirection;
			/*		
			if (pdb_log_enabled) then {
				 	diag_log = format["SERVER MSG: _pdirection: %1", _pdirection];
			};
			*/
// ====================================================================================
		// add the player stance state (Element 11) into the player's array in the multi-d
		_animState = animationState _player;
	//	diag_log ["_animState: ", _animState, typeName _animState]; 
		_animStateChars = toArray _animState;
		_animP = toString [_animStateChars select 5, _animStateChars select 6, _aniMStateChars select 7];
	//	diag_log ["_animP: ", _animP, typeName _animP]; 
			
		_thisstance = "";
		
					switch (_animP) do
					{
					   case "erc":
						{
							diag_log ["player is standing"];
							_thisstance = "Stand";
						};
					   case "knl":
						{
							diag_log ["player is kneeling"];
							_thisstance = "Crouch"; 
						};
					   case "pne":
						{
							diag_log ["player is prone"];
							_thisstance = "Lying";
						};
					};
					
		//	diag_log ["_thisstance:", _thisstance, typeName _thisstance];
		// get the player's stance state 
		_pstance = _thisstance;
		
	//		diag_log ["_pstance:", _pstance, typeName _pstance];

		// player side
		// get the player's side 
	//	_pside =  side _player;
			// get it from from the player var incase they are dead and thus return CIV or tk'd this session thus returns ENEMY
			_pside = _player getVariable "playerSide";

		diag_log ["pdb_ace_enabled:", pdb_ace_enabled, typeName pdb_ace_enabled];
		if (pdb_ace_enabled) then {
			 _aceweapononback = _player getVariable "WOB";
			 _aceruckweapons = _player getVariable "WEAPON";
			  diag_log ["_aceruckweapons:", _aceruckweapons, typeName _aceruckweapons];
			 _aceruckmagazines = _player getVariable "MAGAZINE";
			 diag_log ["_aceruckmagazines:", _aceruckmagazines, typeName _aceruckmagazines];

		};	 


			// Vehicle in which player is mounted.
			_pvehicle = '';	
			_pseat = '';
			
			if (vehicle _player != _player) then { 
				_result = [str(vehicle _player), "REMOTE", 0] call CBA_fnc_find;  // http://dev-heaven.net/docs/cba/files/strings/fnc_find-sqf.html
				if ( _result == -1 ) then {
					_pvehicle =  str(vehicle _player); 
					if (driver (vehicle _player) == _player) then { _pseat = "driver"; };
					if (gunner (vehicle _player) == _player) then { _pseat = "gunner"; };
					if (commander (vehicle _player) == _player) then { _pseat = "commander"; };
				};
			};
				
		_ptype = typeof _player;
		_prating = rating _player;
		_pviewdistance = _player getvariable "viewdistance";
		_pterraindetail = _player getvariable "pterraindetail";
		_prank = _player getvariable "prank";
		_pshotsfired = _player getVariable "_thispshotsfired";
		_penemykills = _player getVariable "_thispenemykills";
		_pcivkills = _player getVariable "_thispcivkills";
		_pfriendlykills = _player getVariable "_thispfriendlykills";
		_psuicides = _player getVariable "_thispsuicides";
		_plifestate = lifestate _player;
		_pdeaths = _player getVariable "_thispdeaths";
			
// ====================================================================================
// Save player data to db before exiting.


 			if (isnil "_pscore") then { _pscore = 0 };	
			 // convert back to string for db update
			_newscore = str(_pscore);	
			
//			_ppname =  "'" + _pname + "'";
			_missionid = (MISSIONDATA select 1);
//			_pposition =  "'" + _pposition + "'";
//			_pweapons =  "'" + _pweapons + "'";
//			_pmagazines =  "'" + _pmagazines + "'";
//			_pstance =  "'" + _pstance + "'";
//			_pside =  "'" + _pside + "'";
	
	
/*				
	if (pdb_ace_enabled) then {
	    _aceweapononback = [_aceweapononback, "'",""] call CBA_fnc_replace; 	
//	    _aceweapononback =  "'" + _aceweapononback + "'";
		_aceruckweapons = [_aceruckweapons, "'",""] call CBA_fnc_replace; 	
//	    _aceruckweapons =  "'" + _aceruckweapons + "'";
		_aceruckmagazines = [_aceruckmagazines, "'",""] call CBA_fnc_replace; 	
//	    _aceruckmagazines =  "'" + _aceruckmagazines + "'";
	};
*/


			 if (isNil "_pscore") then {  _pscore = "0"; };
			 if (isNil "_newscore") then {  _newscore = "0"; };
 			 if (isNil "_pdirection") then {  _pdirection = ""; };
 			 if (isNil "_pweapons") then {  _pweapons = ""; };
 			 if (isNil "_pmagazines") then {  _pmagazines = ""; };
 			 if (isNil "_pstance") then {  _pstance = "Stand"; };
 			 if (isNil "_pside") then {  _pside = ""; };
 			 if (isNil "_pvehicle") then {  _pvehicle = ""; };
 			 if (isNil "_pseat") then {  _pseat = ""; };
 			 
 			 if (isNil "_pdamage") then {  _pdamage = "0"; };
			 if (isNil "_p_head_hit_damage") then {  _p_head_hit_damage = "0"; };
			 if (isNil "_p_body_damage") then {  _p_body_damage = "0"; };
			 if (isNil "_p_hands_damage") then {  _p_hands_damage = "0"; };
			 if (isNil "_p_legs_damage") then {  _p_legs_damage = "0"; };
			 
			 if (isNil "_aceweapononback") then {  _aceweapononback = ""; };
			 if (isNil "_aceruckweapons") then {  _aceruckweapons = ""; };
			 if (isNil "_aceruckmagazines") then {  _aceruckmagazines = ""; };
			 
			 if (isNil "_pshotsfired") then {  _pshotsfired = "0"; };
			 if (isNil "_penemykills") then {  _penemykills = "0"; };
			 if (isNil "_pcivkills") then {  _pcivkills = "0"; };
			 if (isNil "_pviewdistance") then {  _pviewdistance = "0"; };
			 if (isNil "_pterraindetail") then {  _pterraindetail = "0"; };

/*
				diag_log ["_newscore: ", _newscore, typeName _newscore];
				diag_log ["_pposition: ", _pposition, typeName _pposition];
				diag_log ["_pdamage: ", _pdamage, typeName _pdamage];
				diag_log ["_p_head_hit_damage: ", _p_head_hit_damage, typeName _p_head_hit_damage];
				diag_log ["_p_body_damage: ", _p_body_damage, typeName _p_body_damage];
				diag_log ["_p_hands_damage: ", _p_hands_damage, typeName _p_hands_damage];
				diag_log ["_p_legs_damage: ", _p_legs_damage, typeName _p_legs_damage];
				diag_log ["_pdirection: ", _pdirection, typeName _pdirection];
				diag_log ["_pstance: ", _pstance, typeName _pstance];
				diag_log ["_pside: ", _pside, typeName _pside];
				diag_log ["_pvehicle: ", _pvehicle, typeName _pvehicle];
				diag_log ["_missionid: ", _missionid, typeName _missionid];
				diag_log ["_pseat: ", _pseat, typeName _pseat];
				diag_log ["_puid: ", _puid, typeName _puid];
				diag_log ["_pname: ", _pname, typeName _pname];
				diag_log ["_pweapons: ", _pweapons, typeName _pweapons];
				diag_log ["_pmagazines: ", _pmagazines, typeName _pmagazines];
				diag_log ["_aceweapononback: ", _aceweapononback, typeName _aceweapononback];
				diag_log ["_aceruckweapons: ", _aceruckweapons, typeName _aceruckweapons];
				diag_log ["_aceruckmagazines: ", _aceruckmagazines, typeName _aceruckmagazines];
*/			

// START save player's vanilla data
			 _procedureName = "UpdatePlayer"; 
			_parameters = format["[tsc=%1,tpos=%2,tdam=%3,tdhe=%4,tdbo=%5,tdha=%6,tdle=%7,tdir=%8,tsta=%9,tsid=%10,tveh=%11,tsea=%12,ttyp=%13,trat=%14,tvd=%15,ttd=%16,tran=%17,tfir=%18,tek=%19,tck=%20,tfk=%21,tsui=%22,tlif=%23,tdea=%24,tpid=%25,tna=%26,tmid=%27]",_newscore,_pposition,_pdamage,_p_head_hit_damage,_p_body_damage,_p_hands_damage,_p_legs_damage,_pdirection,_pstance,_pside,_pvehicle,_pseat, _ptype, _prating, _pviewdistance, _pterraindetail, _prank, _pshotsfired, _penemykills, _pcivkills,_pfriendlykills,_psuicides,_plifestate,_pdeaths,_puid,_pname,_missionid];

		if (pdb_log_enabled) then {
			 	diag_log format["SERVER MSG: SQL output: %1", _parameters];
		 };
		 
		 
		
		//		diag_log ("callExtension->Arma2NETMySQL: UpdatePlayer");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	

// END save player's vanilla data



		// START save player's vanilla weapons and ammo
		if (pdb_weapons_enabled) then {
								 _procedureName = "UpdatePlayerWeapons"; 
								_parameters = format["[twea=%1,tmag=%2,tpid=%3,tna=%4,tmid=%5]",_pweapons,_pmagazines,_puid,_pname,_missionid];


				 if (pdb_log_enabled) then {
						diag_log format["SERVER MSG: SQL output: %1", _parameters];
				 };
								
								
									
					//	diag_log ("callExtension->Arma2NETMySQL: UpdatePlayerWeapons");		
						_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	


		// END save player's vanilla weapons and ammo
		};



		// Gotta split this into another call since jayarmalib limits data throughput. :(
		if (pdb_ace_enabled) then {
		
			 _procedureName = "UpdatePlayerACE"; 
			_parameters = format["[tawb=%1,taw=%2,tarm=%3,tpid=%4,tna=%5,tmid=%6]",_aceweapononback,_aceruckweapons,_aceruckmagazines,_puid,_pname,_missionid];


			 if (pdb_log_enabled) then {
					diag_log format["SERVER MSG: SQL output: %1", _parameters];
			 };
		 
		 
		 	
		//	diag_log ("callExtension->Arma2NETMySQL: UpdatePlayerACE");		
			_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
		 
		};		
		
	
		} else {
			// player not found
				if (pdb_log_enabled) then {
				 	diag_log format["SERVER MSG: Player %1, not found in playableUnits!, frame Number: %2, Tick: %3, Time: %4", _pname, diag_frameno, diag_tickTime, time];
				};
		};
		
		} else {
			
	// __SERVER__ : 
	
			_missionid = (MISSIONDATA select 1);

if (pdb_landvehicles_enabled) then {

// START remove mission's current LandVehicles data				
				
		//		GVAR(arma2mysqlPipeHandle) = ["\\.\pipe\Arma2MySQLPipe"] call jayarma2lib_fnc_openpipe;
		//		for [{_a=0},{_a < 2000},{_a=_a+1}] do {};
		
				 _procedureName = "RemoveLandVehicles"; 
				_parameters = format["[tmid=%1]",_missionid];

					 if (pdb_log_enabled) then {
					 	diag_log format["SERVER MSG: SQL output: %1", _parameters];
					 };
					 
					 
					 
					
		//		diag_log ("callExtension->Arma2NETMySQL: RemoveLandVehicles");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	


// END remove mission's current LandVehicles data						
				

// START save mission's LandVehicles data
				
			 _procedureName = "InsertLandVehicles"; 

		
			// get LandVehicle data
		   _thisObject = objNull;
		   _landVehicles = [];
		   _landVehicleCount = 1;
		   _missionLandVehicles = "";
			 {
				  _thisObject = _x;

				  _vDir = [0,0,0];
				  _vUp = [0,0,0];
				  _vDam = 0;
				  _vPosition = [];
			//	  _thisVehicleData = [];
				   
				  _vObject = str(_thisObject);
				  _vPosition = str(getPosATL _thisObject); // setPosATL
				  _vDam = str(getDammage _thisObject); // setDammage
				  _vDir = str(vectorDir _thisObject); // setVectorDirAndUp
				  _vUp = str(vectorUp _thisObject); //   setVectorDirAndUp
				  _vFuel = str(fuel _thisObject);  // setFuel
				  _vLocked = str(locked _thisObject); // Lock  || setVehicleLock ?
				  _vWeaponCargo = str(getWeaponCargo _thisObject); // addWeaponCargo 
				  _vEngine = str(isEngineOn _thisObject); // engineOn
				  
				  
				  _vObject = [_vObject, ",", "|"] call CBA_fnc_replace; 
				  _vObject = [_vObject, ":", "?"] call CBA_fnc_replace; 	
				  _vPosition = [_vPosition, ",", "|"] call CBA_fnc_replace;
				  _vDir = [_vDir, ",", "|"] call CBA_fnc_replace;
				  _vUp = [_vUp, ",", "|"] call CBA_fnc_replace;
				  _vWeaponCargo = [_vWeaponCargo, ",", "|"] call CBA_fnc_replace; 	
				 
				  
				//  _thisVehicleData = [_vObject, _vPosition, _vDir, _vUp, _vDam, _vFuel, _vLocked, _vWeaponCargo, _vEngine];
				//  ["Landrover_1","[3609.58|3639.55|0]","[0.00802857|-0.999967|0.000906642]","[-7.34692e-006|0.000906612|0.999999]","0","1","false","[[]|[]]","false"]
				//  _landVehicles set [count _landVehicles, _thisVehicleData];
				
				_result = [_vObject, "REMOTE", 0] call CBA_fnc_find;  // http://dev-heaven.net/docs/cba/files/strings/fnc_find-sqf.html

				if ( _result == -1 ) then {
				
				
					_parameters = format["[tobj=%1,tpos=%2,tdir=%3,tup=%4,tdam=%5,tfue=%6,tlkd=%7,twcar=%8,teng=%9,tmid=%10,tintid=%11]",_vObject, _vPosition, _vDir, _vUp, _vDam, _vFuel, _vLocked, _vWeaponCargo, _vEngine,_missionid,_landVehicleCount];
					
					 if (pdb_log_enabled) then {
					 	diag_log format["SERVER MSG: SQL output: %1", _parameters];
					 };
					 
					 
 	
			//	diag_log ("callExtension->Arma2NETMySQL: InsertLandVehicles");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	

				
				_landVehicleCount =_landVehicleCount+1;
				};
			  
			 } 
		    forEach allMissionObjects "LandVehicle"; 
		    
// END save mission's LandVehicles data		

		    	//Stop and close pipe
//				[GVAR(arma2mysqlPipeHandle)] call jayarma2lib_fnc_closepipe;
//				GVAR(arma2mysqlPipeHandle) = nil;
//				diag_log ("InsertLandVehicles Pipe closed.");		
				
};


// START save the time and date
if (pdb_date_enabled) then {

	_date = str(date);
	_date = [_date, "[", ""] call CBA_fnc_replace; 
	_date = [_date, "]", ""] call CBA_fnc_replace; 
	_date = [_date, ",", "|"] call CBA_fnc_replace; 
	
//		GVAR(arma2mysqlPipeHandle) = ["\\.\pipe\Arma2MySQLPipe"] call jayarma2lib_fnc_openpipe;
//		for [{_a=0},{_a < 2000},{_a=_a+1}] do {};
	
	 _procedureName = "UpdateDate";
	_parameters = format["[tda=%1,tmid=%2]",_date,_missionid]; 
	
					 if (pdb_log_enabled) then {
					 	diag_log format["SERVER MSG: SQL output: %1", _parameters];
					 };
					 
					 
			//	diag_log ("callExtension->Arma2NETMySQL: UpdateDate");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	

					 
					
	
	
			    //Stop and close pipe
	//			[GVAR(arma2mysqlPipeHandle)] call jayarma2lib_fnc_closepipe;
	//			GVAR(arma2mysqlPipeHandle) = nil;
	//			diag_log ("UpdateDate Pipe closed.");		
	
	
//				 _player setVariable ["status", "idle", true];

};
// END save the time and date		
    
		    


			// __SERVER__ exit
				
			if (pdb_log_enabled) then {
				 	diag_log format["SERVER MSG: %1 exiting, frame Number: %2, Tick: %3, Time: %4", _pname, diag_frameno, diag_tickTime, time];
			};
		exit;	
		};
	};
// ====================================================================================
// MAIN	

			if (pdb_log_enabled) then {
				 	diag_log format["SERVER MSG: Player %1, is leaving the server, frame Number: %2, Tick: %3, Time: %4", _pname, diag_frameno, diag_tickTime, time];
			};
	
	 call saveOnQuit;



// ====================================================================================