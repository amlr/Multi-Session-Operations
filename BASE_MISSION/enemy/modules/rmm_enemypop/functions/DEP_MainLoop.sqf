
private ["_pos","_pos2","_grpt","_camp","_grpt2","_AA","_RB","_RBspawned","_obj","_group","_grp2Pos","_grp2","_debug","_cleared","_spawned","_AAspawned","_locunits","_groupPos","_posGrp2","_breakouttimer","_idx","_var","_temp"];
                                        
	_obj = _this select 0;
    _pos = _this select 1;
	_grpt = _this select 2;
	_camp = _this select 3; if !(typename _camp == "STRING") then {_camp = nil};
    _grpt2 = _this select 4; if !(typename _grpt2 == "ARRAY") then {_grpt2 = nil};
	_AA = _this select 5; if !(_AA) then {_AA = nil};
	_RB = _this select 6; if !(_RB) then {_RB = nil};
    _cleared = _this select 7;
                                      
    _debug = debug_mso;
    _spawned = false;
    _AAspawned = false;
    _RBspawned = false;
	
	// Function to convert group into appropriate format to spawn group
	DEP_convert_group = {
		private ["_grptemp","_var","_side"];
        _var = _this select 0;
		diag_log format ["group convert = %1 (%2)", _var select 0, typename (_var select 0)];
		if ((_var select 0) == "resistance") then {
			_side = "Guerrila";
		} else {
			_side = _var select 0;
		};
		diag_log format ["group converted = %1 (%2)", _var select 0, typename (_var select 0)];
		_grptemp =  (configFile >> "CfgGroups" >> _side >> (_var select 1) >> (_var select 2) >> (_var select 3));
		//diag_log format ["_grptemp created = %1", _grptemp];
		_grptemp;
	};
    
    if (_debug) then {diag_log format["MSO-%1 PDB EP Population: _obj %2 | _pos %3 | _grpt %4 | _camp %5 | _grpt2 %6 | _AA %7 | _RB %8 | _cleared %9", time, _obj, _pos, _grpt, _camp, _grpt2, _AA, _RB, _cleared]};
                                        
   	waitUntil {sleep 3; ([_pos, rmm_ep_spawn_dist] call fPlayersInside)};

   	_groupPos = nil;
   	_grp2Pos = nil;
   	_breakouttimer = 0;
    
    if(!(isnil "_camp")) then {[_camp, floor(random 360), _pos] call f_builder;};
                                                                                                                        
   	if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Starting While loop %2", time, _pos];};
	while {!(_cleared)} do {
		sleep 3; 
		if (([_pos, rmm_ep_spawn_dist] call fPlayersInside) && (!_spawned)) then {
		_spawned = true;
        _group = nil;
        if (isnil "_groupPos") then {_pos2 = [_pos, 0, 50, 10, 0, 5, 0] call bis_fnc_findSafePos;} else {_pos2 = _groupPos};
            diag_log format ["grpt = %1", _grpt];  
        	_group = [_pos2, call compile (_grpt select 0), [_grpt] call DEP_convert_group] call BIS_fnc_spawnGroup;
            if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Group created %2 (%3)", time, _pos, _group];};
            (leader _group) setBehaviour "AWARE";
            _group setSpeedMode "LIMITED";
            _group setFormation "STAG COLUMN";
            ep_groups set [count ep_groups, _group];
                                                
            if ((isnil "_camp") || count units _group <= 2) then {
            	[_group,_pos2,800,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;
            };
            if(!(isnil "_camp")) then {
            	[_group,_pos2,100,4 + random 6, "MOVE", "AWARE", "RED", "LIMITED", "STAG COLUMN", "if (dayTime < 18 or dayTime > 6) then {this setbehaviour ""STEALTH""}", [120,200,280]] call CBA_fnc_taskPatrol;

            	_grp2 = nil;
                _grp2 = [_pos, call compile (_grpt2 select 0), [_grpt2] call DEP_convert_group] call BIS_fnc_spawnGroup;
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Sub Group created %2 (%3)", time, _pos, _grp2];};
                [_grp2] call BIN_fnc_taskDefend;
                ep_groups set [count ep_groups, _grp2];
            };
                                                
            if (!(isnil "_AA") && !(_AAspawned)) then {
            	_AAspawned = true;
            	[_pos, "static", 1 + random 1] execVM "enemy\scripts\TUP_spawnAA.sqf";
            };
            
            if (!(isnil "_RB") && !(_RBspawned)) then {
                _RBspawned = true;
				_RBpos = [_group, _pos] call compile preprocessfilelinenumbers "enemy\scripts\TUP_deployRoadBlock.sqf";
                diag_log format["MSO-%1 PDB EP Population: Attempted to Deploy Road Block near %2", time, _RBpos];
            };
		};
                                        
                                     		_locunits = [];
                                     		if (count (units _group) > 0) then {{_locunits set [count _locunits, _x]} foreach units _group; if !(str(position (leader _group)) == "[0,0,0]") then {_groupPos = position (leader _group)}};
                                     		if (count (units _grp2) > 0) then {{_locunits set [count _locunits, _x]} foreach units _grp2; if !(str(position (leader _grp2)) == "[0,0,0]") then {_grp2Pos = position (leader _grp2)}};
                                        
                                    		if (!([_pos, rmm_ep_spawn_dist] call fPlayersInside) && (_spawned)) then {
                                        		if (_breakouttimer > 20) then {
                                                	if !(isnil "_group") then {
                                                		ep_groups = ep_groups - [_group];
                                                		while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
                                            			{deletevehicle (vehicle _x); deletevehicle _x} foreach units _group;
                                            			deletegroup _group;
                                                		if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Deleting group - player out of range %2 (%3)", time, _pos, _group];}; 
                                        			};
                                        			if !(isnil "_grp2") then {
                                                		ep_groups = ep_groups - [_grp2];
                                                		while {(count (waypoints (_grp2))) > 0} do {deleteWaypoint ((waypoints (_grp2)) select 0);};
                                            			{deletevehicle (vehicle _x); deletevehicle _x} foreach units _grp2;
                                            			deletegroup _grp2;
                                                		if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Deleting group - player out of range %2 (%3)", time, _pos, _group];};
                                        			};
                                                    _breakouttimer = 0;
                                        			_spawned = false;
                                            	} else {_breakouttimer = _breakouttimer + 3};
                                     		};

                                    		if ((count _locunits < 1) && (_spawned)) exitwith {
                                            	if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Position cleared - thread end... %2 (%3)", time, _pos, _group];};
                                        		if !(isnil "_group") then {
                                                	ep_groups = ep_groups - [_group];
                                                	while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
                                            		{deletevehicle (vehicle _x); deletevehicle _x} foreach units _group;
                                            		deletegroup _group;
                                                	if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Deleting group - Position cleared %2 (%3)", time, _pos, _group];}; 
                                        		};
                                        		if !(isnil "_grp2") then {
                                                	ep_groups = ep_groups - [_grp2];
                                                	while {(count (waypoints (_grp2))) > 0} do {deleteWaypoint ((waypoints (_grp2)) select 0);};
                                            		{deletevehicle (vehicle _x); deletevehicle _x} foreach units _grp2;
                                            		deletegroup _grp2;
                                                	if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Deleting group - Position cleared %2 (%3)", time, _pos, _group];};
                                        		};
                                                
                                        		_spawned = false;
                                        		_cleared = true;
                                                _obj setvariable ["c",true];
                                        	};
	};