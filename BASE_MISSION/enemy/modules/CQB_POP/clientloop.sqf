		private ["_positionslocal","_suspendedpositions","_debug","_idx","_loopcounter"];
		
		waituntil {!isnil "CQBpositions"};
		CQBpositionsLocal = CQBpositions;
		CQBsuspendedposLocal = [];
        CQBgroupsLocal = [];
        CQBclearedpos = [];
		_debug = _this select 0;
		
		while {true} do {
                _activecount = 0;
                _suspendedcount = 0;
                _clearcount = 0;
        		{
                    _clear = (_x select 0) getVariable "cleared";
                    _suspend = (_x select 0) getVariable "suspended";
                    _pos = position (_x select 0);
                    
                    if ((isnil "_suspend") && (isnil "_clear")) then {_activecount = _activecount + 1};
                    if (!(isnil "_suspend")) then {_suspendedcount = _suspendedcount + 1};
                    if (!(isnil "_clear")) then {_clearcount = _clearcount + 1};
	
                    if (((_x select 0) distance player < 400) && (((position player) select 2) < 5)) then {
                        if ((isnil "_suspend") && (isnil "_clear")) then {
                    		[(_pos),(_x select 0)] spawn MSO_fnc_CQBspawnRandomgroup;
                        	(_x select 0) setVariable ["suspended", true];
                    	};
                    };
				} foreach CQBpositionsLocal;
			sleep 5;
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
 