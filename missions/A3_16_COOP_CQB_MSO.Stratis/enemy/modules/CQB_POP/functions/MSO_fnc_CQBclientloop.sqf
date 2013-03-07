    	private ["_debug","_idx","_loopcounter","_localEnemyCount","_pU"];
		
        _debug = _this select 0;

        waituntil {!(isnil "CQBpositionsReg") && !(isnil "CQBpositionsStrat")};
        CQBpositionsRegLocal = CQBpositionsReg;
		CQBpositionsStratLocal = CQBpositionsStrat;
        CQBpositionsLocal = CQBpositionsRegLocal + CQBpositionsStratLocal;
		{(_x select 0) setVariable ["reg", true, false]} foreach CQBpositionsRegLocal;
        {(_x select 0) setVariable ["strat", true, false]} foreach CQBpositionsStratLocal;
		_CQBspawnrangeReg = CQBspawnrange;
		_CQBspawnrangeStrat = (CQBspawnrange * 1.6); if (_CQBspawnrangeStrat > 1200) then {_CQBspawnrangeStrat = 1200};
		_despawnReg = (_CQBspawnrangeReg * 1.25);
		_despawnStrat = (_CQBspawnrangeStrat * 1.25);
        CQBgroupsLocal = [];
        
        if (_debug) then {
    		diag_log format["MSO-%1 CQB Population: Total positions found %2", time, count CQBpositionsLocal];
    
    		_i = 0;
			for "_i" from 0 to ((count CQBpositionsRegLocal) - 1) do {
         		_t = format["rp%1",_i];
    			_m = [_t, position ((CQBpositionsRegLocal select _i) select 0), "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorRed"] call CBA_fnc_createMarker;
    		};
            
            _i = 0;
			for "_i" from 0 to ((count CQBpositionsStratLocal) - 1) do {
         		_t = format["sp%1",_i];
    			_m = [_t, position ((CQBpositionsStratLocal select _i) select 0), "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorGreen"] call CBA_fnc_createMarker;
    		};
		};
		
		waituntil {
            	sleep 2;
                _activecount = 0;
                _suspendedcount = 0;
                _clearcount = 0;
        		{
                    _strategic = (_x select 0) getVariable "strat";
                    _regular = (_x select 0) getVariable "reg";
                    _clear = (_x select 0) getVariable "c";
                    _suspend = (_x select 0) getVariable "s";
                    _pos = position (_x select 0);
                    _activenow = 0;
                    
                    if (CQB_AUTO) then {
                        _pU = {_pos distance _x < _CQBspawnrangeStrat} count ([] call BIS_fnc_listPlayers);
                        if (_pU < 1) then {_pU = 1};
                        _CQBlocCnt = 0;
                        _CQBglobCnt = 0;
                        {
                            _CQBgr = nil; _CQBgr = (leader _x) getvariable "PM";
                            if !(isnil "_cqbgr") then {
                                _CQBglobCnt = _CQBglobCnt + 1;
                                if (local leader _x) then {_CQBlocCnt = _CQBlocCnt + 1};
                            };
                        } foreach allgroups;
                        
                        _CQBavgGr = _CQBglobCnt / _pU;

                        if ((_CQBlocCnt <= _CQBavgGr) && (_CQBglobCnt <= CQBmaxgrps)) then {
							CQBaicap = (count allunits / _pU);
                        } else {
                            CQBaicap = 0;
                        };
                    };
                    
                    if ((isnil "_suspend") && (isnil "_clear")) then {_activecount = _activecount + 1};
                    if (!(isnil "_suspend")) then {_suspendedcount = _suspendedcount + 1};
                    if (!(isnil "_clear")) then {_clearcount = _clearcount + 1};

                    if ((({(local _x) && ((faction _x) in MSO_FACTIONS)} count allunits) < CQBaicap) && ([position (_x select 0), _CQBspawnrangeStrat] call CQB_PlayersGroundCheck)) then {

                        if (((_activenow <= 8) && _regular) && ([position (_x select 0), _CQBspawnrangeReg] call CQB_PlayersGroundCheck)) then {
                        	if ((isnil "_suspend") && (isnil "_clear")) then {
                                _activenow = _activenow + 1;
                    			[(_pos),(_x select 0),_despawnReg] call MSO_fnc_CQBspawnRandomgroup;
                    		};
                        };                        
                        
                        if (((_activenow <= 8) && _strategic) && ([position (_x select 0), _CQBspawnrangeStrat] call CQB_PlayersGroundCheck)) then {
                        	if ((isnil "_suspend") && (isnil "_clear")) then {
                                _activenow = _activenow + 1;
                    			[(_pos),(_x select 0),_despawnStrat] call MSO_fnc_CQBspawnRandomgroup;
                    		};
                        };

                    };
				} foreach CQBpositionsLocal;
                
        	{
            	if (count (units _x) == 0) then {
		   			if (_debug) then {diag_log format["MSO-%1 CQB Population: Garbage collecter deleting Group %2...", time, _x]};
            	    CQBgroupsLocal = CQBgroupsLocal - [_x];
           		    deletegroup _x;
                };
        	} foreach CQBgroupsLocal;
            if (_debug) then {
                diag_log format["MSO-%1 CQB Population: %2 total | %3 suspended |%4 cleared positions...", time, _activecount, _suspendedcount, _clearcount];
                diag_log format["MSO-%1 CQB Population: Count %2 local AI in %4 CQB-groups (%3 total AI overall)...", time, {local _x} count allUnits, count allUnits, count CQBgroupsLocal];
            };
			false;
        };