// Written by BON_IF
// Adapted by EightySix

if(!isServer) exitWith{};

if(isNil "mps_ambient_ins") then {mps_ambient_ins = false};

mps_ieds = ["Land_Misc_Garb_Heap_EP1","hiluxWreck","datsun01Wreck","datsun02Wreck","SKODAWreck","UAZWreck","BMP2Wreck","BRDMWreck"];

private ["_iedpos","_offset","_ied"];
_roads = ([0,0]) nearRoads 20000;
_iedpositions = [];

if(isNil "AMBIECOUNT") exitWith{};
	_count = AMBIECOUNT;

for "_i" from 1 to _count do {
	for "_searchcount" from 1 to 10000 do {
		_j = (count _roads - 1) min (round random (count _roads));
		_iedpos = _roads select _j;
		if(
			{_iedpos distance _x < 1000} count _iedpositions == 0 &&
			_iedpos distance (getMarkerPos format["respawn_%1",(SIDE_A select 0)]) > 1000 &&
			_iedpos distance (getMarkerPos format["respawn_%1",(SIDE_B select 0)]) > 1000
		) exitWith{};
		_iedpos = nil;
	};
	if(not isNil "_iedpos") then {
		_roads = _roads - [_iedpos];
		_iedpositions = _iedpositions + [_iedpos];
		_j = (count mps_ieds - 1) min (round random (count mps_ieds));
		_ied = (mps_ieds select _j) createVehicle [(position _iedpos) select 0,(position _iedpos) select 1, 0];
		if(random 2 > 1) then {_offset = [-7.5 - random 3,0,0]} else {_offset = [7.5 + random 3,0,0]};
		_ied setPosATL (_iedpos modelToWorld _offset);
		_ied setVariable ["mps_ied",true,true];
		_ied execFSM (mps_path+"fsm\mps_ied_sensor.fsm");

		if(random 3 > 2 && mps_ambient_ins) then {_grp = [position _ied,"INS",(2 + random 4),20,"standby"] call CREATE_OPFOR_SQUAD;};

		_iedpos = nil;
		_ied = nil;
	};
};

if(mps_debug) then {
	{ (createMarkerLocal [str round random 999999,position _x]) setMarkerTypeLocal "dot"; } foreach _iedpositions;
};
