if (RMM_cas_lastTime + RMM_cas_frequency < time) then {
	RMM_cas_lastTime = time;
	RMM_cas_lastDaytime = daytime;
	publicvariable "RMM_cas_lastTime";
	private ["_veh","_selection"];
	_selection = (call (RMM_cas_lines select 2)) select (lbCurSel 2);
	
	If ( _selection == "C130J" || _selection == "MQ9PredatorB") then {
		If (_selection == "C130J") then {
			// Call AI AC130
			_nul = execVM "support\modules\rmm_cas\LDL_ac130\Actions\ac130_action_map_AI.sqf";
		} else {
			// Call AI UAV
			_nul = execVM "support\modules\rmm_cas\LDL_ac130\Actions\uav_action_map.sqf";
		};
	} else {
	
		_veh = ([[-1000,-1000,1000], 0, _selection, group player] call BIS_fnc_spawnVehicle) select 0;
		[2,_veh,{_this flyinheight RMM_cas_flyinheight;}] call RMM_fnc_ExMP;
		hint format ["%1 requested to %2 by %3", (call (RMM_cas_lines select 2)) select (lbCurSel 2), (call (RMM_cas_lines select 0)) select (lbCurSel 0), (call (RMM_cas_lines select 1)) select (lbCurSel 1)];
		[2,_veh,{_this lockdriver true;}] call mso_core_fnc_ExMP;
			
		// Spawn CAS mission
		[2,_veh,{
			_this spawn {
				private "_callsign";
				_callsign = ceil (random 9);
				_this sideChat format ["%1 This is RAVEN %2. We are on station in 2 minutes. We have 15 minutes playtime. Over.", group player, _callsign];
				sleep (RMM_cas_missiontime + random 70);
				if (alive _this) then {
					waituntil {sleep 5;{isplayer _x} count (crew _this) == 0};
					(crew _this) join (createGroup (side (driver _this)));
					{
						_x setskill 0;
						_x disableai "TARGET";
						_x disableai "AUTOTARGET";
					} foreach (units (group _this));
					(group _this) addwaypoint [[-1000,-1000,1000],0];
					_this sideChat format ["%1 This RAVEN %2. We are bingo fuel and RTB, over and out.", group player, _callsign];
					sleep (RMM_cas_missiontime * 0.2);
					_this call CBA_fnc_deleteEntity;
				} else {
					PAPABEAR sideChat format ["%1 This is HQ. RAVEN %2 has been damaged, possibly shot down. CAS mission aborted. Over.", group player, _callsign];
				};
			};
		}] call mso_core_fnc_ExMP;
	};
} else {
	hint format["CAS not available until %1", [RMM_cas_lastDaytime + (RMM_cas_frequency / 60 / 60)] call BIS_fnc_timeToString];
};