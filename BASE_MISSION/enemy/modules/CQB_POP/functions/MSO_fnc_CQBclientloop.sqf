    	private ["_debug","_idx","_loopcounter","_localEnemyCount","_pU"];

        waituntil {!(isnil "CQBpositionsReg") && !(isnil "CQBpositionsStrat")};
		CQBpositionsRegLocal = CQBpositionsReg;
		CQBpositionsStratLocal = CQBpositionsStrat;
        CQBpositionsLocal = CQBpositionsRegLocal + CQBpositionsStratLocal;
		{(_x select 0) setVariable ["reg", true, false]} foreach CQBpositionsRegLocal;
        {(_x select 0) setVariable ["strat", true, false]} foreach CQBpositionsStratLocal;
        CQBgroupsLocal = [];
        
		_debug = _this select 0;
		
		while {true} do {
            	sleep 1;
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
                        if (count playableUnits < 1) then {_pU = 1;} else { _pU = count playableUnits;};
                        _CQBcnt = 0;
                        {
                            _CQBgr = nil; _CQBgr = (leader _x) getvariable "PM";
                            if !(isnil "_cqbgr") then {_CQBcnt = _CQBcnt + 1};
                        } foreach allgroups; 

                        if (_CQBcnt < 55) then {
							CQBaicap = (150 / _pU);
                        } else {
                            CQBaicap = 0;
                        };
                    };
                    
                    if ((isnil "_suspend") && (isnil "_clear")) then {_activecount = _activecount + 1};
                    if (!(isnil "_suspend")) then {_suspendedcount = _suspendedcount + 1};
                    if (!(isnil "_clear")) then {_clearcount = _clearcount + 1};

                    if (((_x select 0) distance player < 800) && ((_x select 0) distance player > 100) && (((position player) select 2) < 5) && (({(local _x) && ((faction _x) in MSO_FACTIONS)} count allunits) < CQBaicap)) then {
                        
                        if (((_x select 0) distance player < 800) && (_activenow <= 5) && _strategic) then {
                        	if ((isnil "_suspend") && (isnil "_clear")) then {
                                _activenow = _activenow + 1;
                    			[(_pos),(_x select 0),1000] call MSO_fnc_CQBspawnRandomgroup;
                    		};
                        };
      
                        if (((_x select 0) distance player < 500) && (_activenow <= 5) && _regular) then {
                        	if ((isnil "_suspend") && (isnil "_clear")) then {
                                _activenow = _activenow + 1;
                    			[(_pos),(_x select 0),600] call MSO_fnc_CQBspawnRandomgroup;
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
		};