// Simple script to set up triggers at each location to spawn IED and Suicide Bombers

#include <crbprofiler.hpp>

private ["_debug"];

_debug = false;

if (isNil "tup_ied_header")then{tup_ied_header = 1;};
if ((!isServer) || (tup_ied_header == 0)) exitWith{};

if (isNil "tup_ied_threat")then{tup_ied_threat = 50;};
if (isNil "tup_suic_threat")then{tup_suic_threat = 20;};

{
	private ["_fate","_pos","_trg","_twn"];
	// Set up Bombers and IEDs at each location (except any player starting location)
	_pos = position _x;
	_twn = (nearestLocations [_pos, ["NameCityCapital","NameCity","NameVillage","Strategic","VegetationVineyard","NameLocal"], 50]) select 0;
	_size = (size _twn) select 0;
	diag_log format ["town is %1 at %2. %3m in size and type %4", text _twn, position _twn, _size, type _twn];
	if ({position _x in _twn} count ([] call BIS_fnc_listPlayers) == 0) then {		
		_fate = random 100;
		if (_fate < tup_suicide_threat) then {
			// Place Suicide Bomber trigger
			_trg = createTrigger["EmptyDetector",getPos _twn]; 
			_trg setTriggerArea[_size+100,_size+100,0,false];
			_trg setTriggerActivation["WEST","PRESENT",true];
			_trg setTriggerStatements["this && ({vehicle _x in thisList} count ([] call BIS_fnc_listPlayers) > 0)", format ["null = [getpos (thisTrigger), thisList, %1] execvm 'enemy\modules\tup_ied\Ambient_Bomber.sqf';",_size], "null = [getpos (thisTrigger)] execvm 'enemy\modules\tup_ied\Remove_Bomber.sqf';"]; 
		
			 if (_debug) then {
				diag_log format ["MSO-%1 Suicide Bomber Trigger: created at %2 (%3)", time, text _twn, mapgridposition _x];
			};
		};

		if (_fate < tup_ied_threat) then {
			// Place IED trigger
			_trg = createTrigger["EmptyDetector",getPos _twn]; 
			_trg setTriggerArea[_size+100, _size+100,0,false];
			_trg setTriggerActivation["WEST","PRESENT",true];
			_trg setTriggerStatements["this && ({vehicle _x in thisList} count ([] call BIS_fnc_listPlayers) > 0)", format ["null = [getpos (thisTrigger),%1] execvm 'enemy\modules\tup_ied\Ambient_IED.sqf';",_size], format ["null = [getpos (thisTrigger),%1] execvm 'enemy\modules\tup_ied\Remove_IED.sqf';",_size]];

			if (_debug) then {
				diag_log format ["MSO-%1 IED Trigger: created at %2 (%3)", time, text _twn, mapgridposition _x];
			};
		};
	};
} foreach (bis_functions_mainscope getvariable "locations");



