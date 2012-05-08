		private ["_positionslocal","_suspendedpositions","_debug","_idx","_loopcounter"];
		
		waituntil {!isnil "CQBpositions"};
		CQBpositionsLocal = CQBpositions;
		CQBsuspendedposLocal = [];
        CQBgroupsLocal = [];
        CQBclearedpos = [];
		_debug = _this select 0;
		
		while {true} do {
			{        
				if ((_x distance player < 400) && (((position player) select 2) < 5)) then {
					[_x] spawn MSO_fnc_CQBspawnRandomgroup;
					CQBsuspendedposLocal set [count CQBsuspendedposLocal, _x];
				
					_idx = [CQBpositionsLocal, _x] call BIS_fnc_arrayFindDeep;
					_idx = _idx select 0;
					CQBpositionsLocal set [_idx, ">REMOVE<"];
					CQBpositionsLocal = CQBpositionsLocal - [">REMOVE<"];
				};
			} foreach CQBpositionsLocal;
			sleep 5;
        	{
            	if (count (units _x) == 0) then {
		   			if (_debug) then {
              	 		diag_log format["MSO-%1 CQB Population: Garbage collecter deleting Group %2...", time, _x];
		   				diag_log format["MSO-%1 CQB Population: Count %2 local AI in %4 CQB-groups (%3 total AI overall)...", time, {local _x} count allUnits, count allUnits, count CQBgroupsLocal];
                        diag_log format["MSO-%1 CQB Population: %2 total | %3 suspended |%4 cleared positions...", time, count CQBpositionsLocal, count CQBsuspendedposLocal, count CQBclearedpos];
           			};
            	    CQBgroupsLocal = CQBgroupsLocal - [_x];
           		    deletegroup _x;
                };
        	} foreach CQBgroupsLocal;
		};