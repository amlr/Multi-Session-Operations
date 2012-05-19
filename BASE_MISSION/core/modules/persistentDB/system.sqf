/* 
 * Filename:
 * system.sqf 
 *
 * Description:
 * PDB scripts
 * 
 * Created by [KH]Jman
 * Creation date: 23/11/2010
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */

// ====================================================================================
//	PERSISTENT DB FUNCTIONS
// ====================================================================================

	PDB_FNC_SERVER_LOADERSTATUS = {
			_serverData = _this select 0;
			  if ((ENV_dedicated)  && (pdb_serverError != 1)) then { 
			  	diag_log["PersistentDB: PDB_FNC_SERVER_LOADERSTATUS: ", _serverData];
			  	startLoadingScreen [_serverData, "PDB_loadingScreen"];
			  	 };
	};
// ====================================================================================

	PDB_FNC_SERVER_LOADERERROR = {
				_serverData = _this select 0;			
				  if ((ENV_dedicated) && (pdb_serverError != 1)) then { 
				  	pdb_serverError = 1;
				  	diag_log["PersistentDB: PDB_FNC_SERVER_LOADERERROR: ", _serverData];
				  	startLoadingScreen [_serverData, "PDB_loadingScreen"];
				  	for [{_a=0},{_a < 5000},{_a=_a+1}] do {};
				  	[player] execVM "core\modules\persistentDB\serverConnectionError.sqf";
				  	 };
	};
// ====================================================================================

	PDB_FNC_CLIENT_LOADERSTATUS = {
			  _player = _this select 0;
			  _serverData = _this select 1;
			  if ((ENV_dedicated)  && (pdb_clientError != 1)) then { 
			  	if (player != _player) exitWith { }; // Im not the player so I shouldn't continue
			  	diag_log["PersistentDB: PDB_FNC_CLIENT_LOADERSTATUS: ", _serverData];
			  	startLoadingScreen [_serverData, "PDB_loadingScreen"];
			  	 };
	};
// ====================================================================================

	PDB_FNC_CLIENT_LOADERERROR = {
			_player = _this select 0;
			_serverData = _this select 1;
  			if ((ENV_dedicated) && (pdb_clientError != 1)) then { 
		  	pdb_clientError = 1;
		  	if (player != _player) exitWith { }; // Im not the player so I shouldn't continue
		  	diag_log["PersistentDB: PDB_FNC_CLIENT_LOADERERROR: ", _serverData];
		  	startLoadingScreen [_serverData, "PDB_loadingScreen"];
		  	for [{_a=0},{_a < 5000},{_a=_a+1}] do {};
		  	[player] execVM "core\modules\persistentDB\clientConnectionError.sqf";
		  	 };
	};
// ====================================================================================
	
	PDB_FNC_ACTIVATEPLAYER = {
		   _player = _this select 0;
		   _pname = _this select 1;
			_seen = _this select 2;
			
		   if (player != _player) exitWith { }; // Im not the player so I shouldn't continue
			if (pdb_date_enabled) then {
				if ((count MISSIONDATE) == 5)  then {
						diag_log["PersistentDB: MISSIONDATE: ", MISSIONDATE];
						setdate MISSIONDATE;
				};
			};
			if  (ENV_dedicated) then { 	player setVariable ["loader", "Standby entering game"]; startLoadingScreen [(player getVariable "loader"), "PDB_loadingScreen"]; };	
		   diag_log["PersistentDB: ACTIVATE PLAYER"];		  
		   endLoadingScreen;
		   player allowdamage true;
		   
		   if (pdb_ace_enabled) then {["ace_sys_ruck_changed", {call PDB_FNC_PLAYER_RUCK}] call CBA_fnc_addEventhandler; };
		   if (pdb_ace_enabled) then { player addweapon "ace_map"; };
		   
		 
		   	   if (pdb_ace_enabled) then {				
		   	   	// set the ace ruck variables now so that they can be saved to the DB even if the 'ace_sys_ruck_changed' has not been fired before the player decides to exit.
					_thisWeaponsList = [player] call ACE_fnc_RuckWeaponsList;
					_thisWeaponsList = str(_thisWeaponsList);
					_thisWeaponsList = [_thisWeaponsList, "[", ""] call CBA_fnc_replace; 
					_thisWeaponsList = [_thisWeaponsList, "]", ""] call CBA_fnc_replace; 
					_thisWeaponsList = [_thisWeaponsList, ",", "|"] call CBA_fnc_replace;
					player setVariable ["WEAPON", _thisWeaponsList, true];
					
					_thisMagazinesList = [player] call ACE_fnc_RuckMagazinesList;
					_thisMagazinesList = str(_thisMagazinesList);
					_thisMagazinesList = [_thisMagazinesList, "[", ""] call CBA_fnc_replace; 
					_thisMagazinesList = [_thisMagazinesList, "]", ""] call CBA_fnc_replace; 
					_thisMagazinesList = [_thisMagazinesList, ",", "|"] call CBA_fnc_replace;   	
					player setVariable ["MAGAZINE", _thisMagazinesList, true];
					
					_thiswob = [player] call ACE_fnc_WeaponOnBackName;
					_lengthThiswob = [_thiswob] call CBA_fnc_strLen;
						if (_lengthThiswob > 0) then {
							 player setVariable ["WOB", _thiswob, true];
						};
				};
			
			 
			diag_log["PersistentDB: PLAYER READY: ", name player];

			diag_log["PersistentDB: PLAYER CONNECTED"];
			[pdb_shortmissionName ,  pdb_author] spawn BIS_fnc_infoText;
			diag_log ["PersistentDB: _seen: ",  _seen, typeName _seen];
			
			if (!_seen) then { 
				
			initText = "<br/>"+pdb_fullmissionName+"<br/><br/>Welcome<t color='#ffff00' size='1.0' shadow='1' shadowColor='#000000' align='center'> "
			+name player+"</t><br/>Your details have been entered into the database.<br/><br/>";
			hintSilent parseText (initText);
			
		//		player sideChat format["Welcome %1, your details have been entered into the database",  name player];
				 diag_log ["PersistentDB: New player: ",  (name player), typeName  (name player)];
				 } 
				else { 
					
			initText = "<br/>"+pdb_fullmissionName+"<br/><br/>Welcome back<t color='#ffff00' size='1.0' shadow='1' shadowColor='#000000' align='center'> "
			+name player+"</t><br/>Your details have been retrieved from the database.<br/><br/>";
			hintSilent parseText (initText);
			
				_pdbPrompt = createDialog "pdbTeleportPrompt";
				noesckey = (findDisplay 1599) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 
			
			//		 player sideChat format["Welcome back %1, your details have been retrieved from the database",  name player];
					  diag_log ["PersistentDB: Existing player: ",  (name player), typeName  (name player)]; 
					 };
		};	
// ====================================================================================

	PDB_FNC_PLAYER_RUCK = {
		// [_amount,_type,_class]
		_amount = _this select 0;	 //_amount - int, negative or positive count
		_type = _this select 1;       // _type - int, 0 for WOB, 1 for weapon, 2 for magazine
		_class = _this select 2;      //_class - string, class name
		_thisRuckPlayer = player;
		_thisRuckPuid = getPlayerUID player;
		/*
		diag_log ["START PDB_FNC_PLAYER_RUCK"];
		diag_log ["_amount:", _amount, typeName _amount];
		diag_log ["_type:", _type, typeName _type];
		diag_log ["_class:", _class, typeName _class];
		diag_log ["_thisRuckPlayer:", _thisRuckPlayer, typeName _thisRuckPlayer];
		diag_log ["_thisRuckPuid:", _thisRuckPuid, typeName _thisRuckPuid];
		diag_log ["END PDB_FNC_PLAYER_RUCK"];
		*/

		_WeaponsList = [];
		_MagazinesList = [];
		
			switch (_type) do
			{
	   			 case 1:  // weapon
			   {
			   	 _WeaponsList = [_thisRuckPlayer] call ACE_fnc_RuckWeaponsList;
			 //  	 diag_log["_WeaponsList: ", _WeaponsList, typename _WeaponsList];
			   };
			   case 2:  // magazine
			   {	
			   	_MagazinesList = [_thisRuckPlayer] call ACE_fnc_RuckMagazinesList;
		    //   diag_log["_MagazinesList: ", _MagazinesList, typename _MagazinesList];
			   };
			};
			
			_wob = [player] call ACE_fnc_WeaponOnBackName;
		

		PDB_PLAYER_RUCK_UPDATE = [player, _amount, _type,_class, _thisRuckPuid,_WeaponsList,_MagazinesList,_wob];
	   publicVariable "PDB_PLAYER_RUCK_UPDATE";
	  // diag_log["PersistentDB: PDB_PLAYER_RUCK_UPDATE"];
	};

// ====================================================================================
//  PERSISTENT DB PUBLIC VARIABLE HANDLERS
// ====================================================================================

	"PDB_PLAYER_RUCK_UPDATE" addPublicVariableEventHandler { 
			if (isServer) then {
				_data = _this select 1;
				_player = _data select 0;
				_thisAmount = _data select 1; 
				_thisType = _data select 2;
				_thisClass = _data select 3;
				_thisPuid = _data select 4;
				_thisWeaponsList = _data select 5;
				_thisMagazinesList = _data select 6;
				_thiswob =_data select 7;
				/*
				diag_log["PDB_PLAYER_RUCK_UPDATE: _player: ", _player];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thisAmount: ", _thisAmount];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thisType: ", _thisType];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thisClass: ", _thisClass];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thisPuid: ", _thisPuid];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thisWeaponsList: ", _thisWeaponsList];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thisMagazinesList: ", _thisMagazinesList];
				diag_log["PDB_PLAYER_RUCK_UPDATE: _thiswob: ", _thiswob];
				*/
		
			switch (_thisType) do
			{
			   case 0:  // WOB
			   {
			//   	diag_log["WOB"];
			 	if (_thisAmount == 1) then { _player setVariable ["WOB", _thisClass, true]; } else { _player setVariable ["WOB", "", true]; };
			   };
			   
			    case 1:  // weapon
			   {
			//   	diag_log["WEAPON"];
			   		_thisWeaponsList = str(_thisWeaponsList);
					_thisWeaponsList = [_thisWeaponsList, "[", ""] call CBA_fnc_replace; 
					_thisWeaponsList = [_thisWeaponsList, "]", ""] call CBA_fnc_replace; 
					_thisWeaponsList = [_thisWeaponsList, ",", "|"] call CBA_fnc_replace;
					_player setVariable ["WEAPON", _thisWeaponsList, true];
			   };
			    case 2:  // magazine
			   {	
			 //  	diag_log["MAGAZINE"];
			   		_thisMagazinesList = str(_thisMagazinesList);
					_thisMagazinesList = [_thisMagazinesList, "[", ""] call CBA_fnc_replace; 
					_thisMagazinesList = [_thisMagazinesList, "]", ""] call CBA_fnc_replace; 
					_thisMagazinesList = [_thisMagazinesList, ",", "|"] call CBA_fnc_replace;   	
					_player setVariable ["MAGAZINE", _thisMagazinesList, true];
			   };
			};
			// fix for 'inhands"
			_lengthThiswob = [_thiswob] call CBA_fnc_strLen;
			if (_lengthThiswob > 0) then {
				 _player setVariable ["WOB", _thiswob, true];
			};
			
			};
		};
// ====================================================================================
   "PDB_PLAYER_HANDLER" addPublicVariableEventHandler {
		if (PDB_PLAYER_HANDLED) exitWith {}; // I am already initialized! Is there some other player with the same name or what?
		_data = _this select 1;
			if (name player == _data select 1) then {
				

				// parse the data

				_thisid = _data select 0;     								//  returned player id
				_thispname = _data select 1;   								//  returned player name held at index 1 
				_thispuid = _data select 2;  								//  returned player uid
				_thispscore = _data select 3;  								//  returned player score
				_thisposition = _data select 4; 							//  returned player position
				_thisMissionid = _data select 5; 							// return mission id
				_thispdamage = _data select 6; 								// returned player damage
				_this_pdamage_head_hit = _data select 7; 					// returned player head_hit damage
				_this_pdamage_body = _data select 8; 						// returned player body damage
				_this_pdamage_hands = _data select 9; 						// returned player hands damage
				_this_pdamage_legs = _data select 10; 						// returned player legs damage
				_thispdirection = _data select 11; 							// returned player direction
				_thispstance = _data select 12; 							// returned player stance
				_thispside = _data select 13; 							// returned player side
				_thispvehicle = _data select 14; 							// returned players vehicle
				_thispseat = _data select 15; 							// returned players vehicle seat
				_thisweapons = _data select 16;  							// returned player weapons
				_thismagazines = _data select 17;  							// returned player magazines
				
				_thisaceweapononback = _data select 18; 					// returned ace weapon on back
				_thisaceruckweapons = _data select 19; 					// returned ace ruck weapons
				_thisaceruckmagazines = _data select 20; 					// returned ace ruck magazines
				
				_thisptype = _data select 21;							// returned type
				_thisprating = _data select 22;							// returned rating
				_thispviewdistance = _data select 23;					// viewdistance
				_thispterraindetail = _data select 24;					// terrain details
				_thisprank = _data select 25;							// rank
				_thispshotsfired = _data select 26;						// shots fired
				_thispenemykills = _data select 27;						// enemy kills
				_thispcivkills = _data select 28;						// civ kills
				_thisplifestate = _data select 29;						// lifestate

				
			//	[player, _thispname] call FNC_INITPLAYER;
				
		//		player sideChat format["Welcome back %1", _thispname];
				
				
				diag_log ["PersistentDB: _thispdamage:", _thispdamage, typeName _thispdamage];
				diag_log ["PersistentDB: _this_pdamage_head_hit:", _this_pdamage_head_hit, typeName _this_pdamage_head_hit];
				diag_log ["PersistentDB: _this_pdamage_body:", _this_pdamage_body, typeName _this_pdamage_body];
				diag_log ["PersistentDB: _this_pdamage_hands:", _this_pdamage_hands, typeName _this_pdamage_hands];
				diag_log ["PersistentDB: _this_pdamage_legs:", _this_pdamage_legs, typeName _this_pdamage_legs];
				diag_log ["PersistentDB: _thisPosition:", _thisPosition, typeName _thisPosition];
				 if (pdb_weapons_enabled) then {
					diag_log ["PersistentDB: _thisweapons:", _thisweapons, typeName _thisweapons];
					diag_log ["PersistentDB: _thismagazines:", _thismagazines, typeName _thismagazines];
				};
				diag_log ["PersistentDB: _thispdirection:", _thispdirection, typeName _thispdirection];
				diag_log ["PersistentDB: _thispstance:", _thispstance, typeName _thispstance];
				diag_log ["PersistentDB: _thispside:", _thispside, typeName _thispside];
				diag_log ["PersistentDB: _thispvehicle:", _thispvehicle, typeName _thispvehicle];
				diag_log ["PersistentDB: _thispseat:", _thispseat, typeName _thispseat];
				 if (pdb_ace_enabled) then {
					diag_log ["PersistentDB: _thisaceweapononback:", _thisaceweapononback, typeName _thisaceweapononback];
					diag_log ["PersistentDB: _thisaceruckweapons:", _thisaceruckweapons, typeName _thisaceruckweapons];
					diag_log ["PersistentDB: _thisaceruckmagazines:", _thisaceruckmagazines, typeName _thisaceruckmagazines];
				};
				
				if (_thispdamage != -1) then {
				   	if (pdb_ace_enabled) then {
					 	[player, _thispdamage] call ace_sys_wounds_fnc_addDamage;
					};
						player setDamage _thispdamage;
			 		// sideChat format["Player, %1 overall damage restored to %2", _thispname, _thispdamage];
				};
	
				if (_this_pdamage_head_hit != -1) then {	
					if (pdb_ace_enabled) then {
						[player,0,_this_pdamage_head_hit] call ace_sys_wounds_fnc_setHit;  
					};
					player setHit ["head_hit", _this_pdamage_head_hit];
			//		player sideChat format["Player, %1 head damage restored to %2", _thispname, _this_pdamage_head_hit];
				};
				
				if (_this_pdamage_body != -1) then {	
				    if (pdb_ace_enabled) then {
						[player,1,_this_pdamage_body] call ace_sys_wounds_fnc_setHit;  
					};
					player setHit ["body", _this_pdamage_body];
			//		player sideChat format["Player, %1 body damage restored to %2", _thispname, _this_pdamage_body];
				};
				
				if (_this_pdamage_hands != -1) then {	
					if (pdb_ace_enabled) then {
						[player,2,_this_pdamage_hands] call ace_sys_wounds_fnc_setHit;  
					};
					player setHit ["hands", _this_pdamage_hands];
			//		player sideChat format["Player, %1 hand damage restored to %2", _thispname, _this_pdamage_hands];
				};
				
				if (_this_pdamage_legs != -1) then {	
					 if (pdb_ace_enabled) then {
						[player,3,_this_pdamage_legs] call ace_sys_wounds_fnc_setHit;  
					};
					player setHit ["legs", _this_pdamage_legs];
				//	player sideChat format["Player, %1 leg damage restored to %2", _thispname, _this_pdamage_legs];
				};


				if ((count _thisweapons) >0) then {
					 if (pdb_weapons_enabled) then {
						   _backpack = typeOf unitBackpack player;
						   _backpackmags = getMagazineCargo unitBackpack player;
						   _backpackweap = getWeaponCargo unitBackpack player;
						   
							removeAllItems player;
							removeAllWeapons player;
							
							if ((count _thismagazines) >0) then {
								{player addMagazine _x } forEach _thismagazines;
							};
							
							{player addWeapon _x } forEach _thisweapons;
			     	
							if (primaryWeapon player != "") then {
									player selectWeapon (primaryWeapon player);
									_muzzles = getArray(configFile>>"cfgWeapons" >> primaryWeapon player >> "muzzles"); // Fix for weapons with grenade launcher
									player selectWeapon (_muzzles select 0);
									reload player;
							};
									if(_backpack != "") then {
										removeBackpack player;
										player addBackpack _backpack; clearWeaponCargo (unitBackpack player); clearMagazineCargo (unitBackpack player);
		
										for "_i" from 0 to (count (_backpackmags select 0) - 1) do {
											(unitBackpack player) addMagazineCargo [(_backpackmags select 0) select _i,(_backpackmags select 1) select _i];
										};
										for "_i" from 0 to (count (_backpackweap select 0) - 1) do {
											(unitBackpack player) addWeaponCargo [(_backpackweap select 0) select _i,(_backpackweap select 1) select _i];
										};
									};
						};
			//		player sideChat format["Player, %1 weapons restored", _thispname];
					
					
			 if (pdb_ace_enabled) then {
						if (_thisaceweapononback != "") then {	
						_success = [player, _thisaceweapononback] call ACE_fnc_PutWeaponOnBack;
					   //	player sideChat format["Player, %1 ace wob restored to %2", _thispname, _thisaceweapononback];
						};
						
						// clear ruck - fix for medic supplies preloaded.
						[player, "BTH"] call ACE_fnc_RemoveGear;
						
						if ((count _thisaceruckweapons) >0) then {
		
			  						 for [{_r=0},{_r < (count _thisaceruckweapons)},{_r=_r+2}] do 
						        	{
						        	//	diag_log["_thisaceruckweapons select _r: ", _thisaceruckweapons select _r];
						        			_success = [player, _thisaceruckweapons select _r, _thisaceruckweapons select _r+1] call ACE_fnc_PackWeapon;
						        	};
					   //	player sideChat format["Player, %1 ace ruck weapons restored to %2", _thispname, _thisaceruckweapons];
						};
						
						
						if ((count _thisaceruckmagazines) >0) then {
		
		 						for [{_z=0},{_z < (count _thisaceruckmagazines)},{_z=_z+2}] do 
						        	{
						        	//	diag_log["_thisaceruckweapons select _z: ", _thisaceruckmagazines select _z];
						        			_success = [player, _thisaceruckmagazines select _z, _thisaceruckmagazines select _z+1] call ACE_fnc_PackMagazine;
						        	};
					   //	player sideChat format["Player, %1 ace ruck magazines restored to %2", _thispname, _thisaceruckmagazines];
						};
			};
				
				
				};
					
				player setVariable ["_thisPosition", _thisPosition, false]; 
				player setVariable ["_thispside", _thispside, false]; 
				player setVariable ["_thispdirection", _thispdirection, false]; 
				player setVariable ["_thispstance", _thispstance, false]; 
				player setVariable ["_thispvehicle", _thispvehicle, false]; 
				player setVariable ["_thispseat", _thispseat, false]; 
				
				player setVariable ["_thisptype", _thisptype, false];							
				player addrating (-(rating player) + _thisprating);					
				setviewdistance _thispviewdistance;	
                setterraingrid ((-10 * _thispterraindetail + 50) max 1);
                terraindetail = _thispterraindetail;			
				player setunitrank _thisprank;					
				player setVariable ["_thispshotsfired", _thispshotsfired, false];				
				player setVariable ["_thispenemykills", _thispenemykills, false];				
				player setVariable ["_thispcivkills", _thispcivkills, false];
				if (tolower(_thisplifestate) == "unconscious") then {
                        player setUnconscious true;
                };		
			
				PDB_PLAYER_HANDLED = true; // Flag to set that I am initialized.
			};
	};
	
// ====================================================================================
//	PERSISTENT DB HANDLERS
// ====================================================================================	
	"PDB_ACTIVATEPLAYER" addPublicVariableEventHandler { (_this select 1) call PDB_FNC_ACTIVATEPLAYER };
    "PDB_SERVER_LOADERSTATUS" addPublicVariableEventHandler { (_this select 1) call PDB_FNC_SERVER_LOADERSTATUS };
    "PDB_SERVER_LOADERERROR" addPublicVariableEventHandler { (_this select 1) call PDB_FNC_SERVER_LOADERERROR };
    "PDB_CLIENT_LOADERSTATUS" addPublicVariableEventHandler { (_this select 1) call PDB_FNC_CLIENT_LOADERSTATUS };
    "PDB_CLIENT_LOADERERROR" addPublicVariableEventHandler { (_this select 1) call PDB_FNC_CLIENT_LOADERERROR };
// ====================================================================================	
	
	
	

// MISC FUNCTIONS
	reverseArray = {
		 private ["_r","_c"];
		 _r = [];
		 _c = (count _this select 0) -1;
		 {
		  _r set [_c,_x];
		  _c = _c -1 ;
		 } foreach _this select 0;
		 _r;
	};
// ====================================================================================	

	searchArray = { 
		// usage:  _key = [getPlayerUID player, CONNECTEDPLAYERS] call searchArray;
		private ["_needle","_haystack","_key","_notString","_i"];
		_needle = _this select 0;
		_haystack = _this select 1; 		
		_notString = _this select 2;
/*
		diag_log["_this: ", _this];
	    diag_log["_needle: ", _needle];
		diag_log["_haystack: ", _haystack];
		diag_log["_notString: ", _notString];
*/
		_key = -1;
		
			for [{_i=0},{_i < count _haystack},{_i=_i+1}] do 	
			{
				
		//	diag_log["loop: ", _i];	
			
			if (!_notString) then { 
				 _thisHaystack = _haystack select _i;
/* 
				diag_log["_notString: ", _notString];
				diag_log["_thisHaystack: ", _thisHaystack];	
				diag_log["_thisHaystack type: ", typeName _thisHaystack];				
				diag_log["_needle: ", _needle];
				diag_log["_needle type: ", typeName _needle];		 
*/
				if (_thisHaystack == _needle) then  {			
//		diag_log["PASS"];
				 _key = _i;
				};
				  } else { 
					_thisHaystack = (str(_haystack select _i)); 
/*
					diag_log["_notString: ", _notString];
					diag_log["_thisHaystack: ", _thisHaystack];	
					diag_log["_thisHaystack type: ", typeName _thisHaystack];				
					diag_log["_needle: ", _needle];
					diag_log["_needle type: ", typeName _needle];		
*/
				if (_thisHaystack == _needle) then  {			
	//	diag_log["PASS"];
				 _key = _i;
				};		
				};
			};
		_key;
	};
// ====================================================================================
	searchMultiDimensionalArray = { 
		// usage:  _key = [ARRAY, 0, 1, "Jman"] call searchMultiDimensionalArray;
		// if not found returns -1
		private ["_array","_element","_lstsize","_i","_entry","_nestedvalue","_index","_locinarray","_start","_JayArma2lib_log"];
		_array      = _this select 0;  // the multi-d
		_start      = _this select 1;  // key number of the multi-d to start searching from
		_locinarray = _this select 2;  // element location in array to look
		_element    = _this select 3;  // value to search for

		_index    = -1;
		_lstsize  = count _array;
		_i        = _start;

		while {(_i < _lstsize)} do {
		  _entry = _array Select _i;
		   _nestedvalue = _entry Select _locinarray;
		   
		  //	diag_log["_nestedvalue: ", _nestedvalue];
		  //	diag_log["_element: ", _element];
		   
		  if (_nestedvalue == _element) then {
			_index=_i;
			_i = _lstsize;
		  };
		  _i=_i+1;
		};
		_index;
	};
	// ====================================================================================
	searchMultiDimensionalArrayWhere = { 
		// (TWO where ELEMENTS)
		// usage:  _key = [ARRAY, 0, 2, 7, 1, "'" + _puid + "'", _missionid, "'" + _pname + "'"] call searchMultiDimensionalArrayWhere;
		// if not found returns -1
		private ["_array","_element","_where","_andwhere","_lstsize","_i","_entry","_nestedvalue","_nestedvalueWhere","_nestedvalueAndWhere","_index","_locinarray","_locinarrayWhere","_locinarrayAndWhere","_start","_JayArma2lib_log"];
		_array = _this select 0;  // the multi-d
		_start = _this select 1;  // key number of the multi-d to start searching from
		_locinarray = _this select 2;  // element location in array to look
		_locinarrayWhere = _this select 3;  // where element location in array to look
		_locinarrayAndWhere = _this select 4;  // and where element location in array to look
		_element = _this select 5;  // value to search for
		_where = _this select 6;  // value of where element
		_andwhere = _this select 7;  // value of and where element

		
		_where = [_where, "'", ""] call CBA_fnc_replace; 
		
	//	diag_log ["_element:", _element, typeName _element];
	//	diag_log ["_where:", _where, typeName _where];
	//	diag_log ["_andwhere:", _andwhere, typeName _andwhere]; 

		_index    = -1;
		_lstsize  = count _array;
		_i        = _start;

		while { (_i < _lstsize) } do {
			
		   _entry = _array Select _i;
		   _nestedvalue = _entry select _locinarray;
		   _nestedvalueWhere = _entry select _locinarrayWhere;
		   _nestedvalueAndWhere = _entry select _locinarrayAndWhere;
		   
		   
	
		  if (((_nestedvalue == _element) && (_nestedvalueWhere == _where) &&  (_nestedvalueAndWhere == _andwhere))) then {
			_index=_i;
			_i = _lstsize;
		  };
		  _i=_i+1;
		};
		_index;
	};
// ====================================================================================	