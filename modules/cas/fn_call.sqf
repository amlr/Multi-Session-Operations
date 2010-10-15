if (RMM_cas_lastTime + RMM_cas_frequency < time) then {
	RMM_cas_lastTime = time;
	publicvariable "RMM_cas_lastTime";
	private "_veh";
	_veh = ([[-1000,-1000,1000], 0, RMM_cas_types select (lbCurSel 1), group player] call BIS_fnc_spawnVehicle) select 0;
	_veh flyinheight RMM_cas_flyinheight;
	[2,_veh,{_this lockdriver true;}] call RMM_fnc_ExMP;
	[1,_veh,{
		_this spawn {
			sleep RMM_cas_missiontime + random 70;
			if (alive _this) then {
				waituntil {{isplayer _x} count (crew _this) == 0};
				(crew _this) join (createGroup (side (driver _this)));
				{
					_x setskill 0;
					_x disableai "TARGET";
					_x disableai "AUTOTARGET";
				} foreach (units (group _this));
				(group _this) addwaypoint [[-1000,-1000,1000],0];
				sleep (RMM_cas_missiontime * 0.2);
				_this call RMM_fnc_deleteEntity;
			}
		}
	}] call RMM_fnc_ExMP;
} else {
	hint format["CAS not available until %1", [if(daytime < 21)then{daytime+3}else{daytime-21}] call BIS_fnc_timeToString];
};