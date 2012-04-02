private ["_callsign","_time","_veh"];
_callsign = ceil (random 9);
_veh = _this select 0;
sleep random 20;
_veh sideChat format ["%1 This is RAVEN %2. We are on station in 2 minutes. We have 15 minutes playtime. Over.", group player, _callsign];
_time = time + RMM_cas_missiontime + random 120;
waituntil {sleep 5; time > _time || !alive _veh};
if (alive _veh) then {
	waituntil {sleep 5;{isplayer _x} count (crew _veh) == 0};
	(crew _veh) join (createGroup (side (driver _veh)));
	{
		_x setskill 0;
		_x disableai "TARGET";
		_x disableai "AUTOTARGET";
	} foreach (units (group _veh));
	(group _veh) addwaypoint [[-1000,-1000,1000],0];
	_veh sideChat format ["%1 This is RAVEN %2. We are bingo fuel and RTB, over and out.", group player, _callsign];
	sleep (RMM_cas_missiontime * 0.2);
	_veh call CBA_fnc_deleteEntity;
} else {
	PAPABEAR sideChat format ["%1 This is HQ. RAVEN %2 has been damaged, possibly shot down. CAS mission aborted. Over.", group player, _callsign];
};