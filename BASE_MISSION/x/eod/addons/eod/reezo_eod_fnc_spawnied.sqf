// IED Detection and Disposal Mod
// 2011 by Reezo

if (!isServer) exitWith{};

private ["_soldier", "_rangeMin", "_rangeMax","_debug"];
_soldier = _this select 0;
_debug = true;

if ((getPos _soldier) select 2 > 5) exitWith {};

// spacer..
// spacer..

_rangeMin = (_this select 1) select 0;
_rangeMax = (_this select 1) select 1;

/*//Check for other IEDs in the area
private ["_near"];
_near = nearestObjects [_soldier, ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"], _rangeMax];

if (count _near > 0) exitWith {diag_log format ["IED exiting as other IEDs found %1",_near];}; //Exit if other IEDs are found
*/

//CHECK HOW MANY ROADS ARE IN THE AREA
private ["_nearRoads","_goodSpots","_nearRoads"];
_goodSpots = []; 
_nearRoads = (getPos _soldier) nearRoads _rangeMax;

//FIND SUITABLE SPOTS AT LEAST 2/3 OF THE SOLDIER POSITION
private ["_i"];
for "_i" from 0 to (count _nearRoads - 1) do {
	if ((getPos (_nearRoads select _i)) distance getPos _soldier > _rangeMin && (getPos (_nearRoads select _i)) distance getPos _soldier < _rangeMax) then {
		_goodSpots set [count _goodSpots,getPos (_nearRoads select _i)];
	};
};

_goodSpots = _goodSpots + ([getpos _soldier,false,true,true,_rangeMax] call tup_ied_fnc_placeIED);

if (_debug) then {diag_log format ["Found %1 goodspots for IED",count _goodspots];};

if (count _goodSpots == 0) exitWith {if (_debug) then {diag_log "IED exiting as no suitable positions found.";};}; //Exit if no good spots are found

private ["_IEDpos","_IEDskins","_IED"];

//PICK A PLACE AND MAKE SURE NOONE IS NEAR IT
_IEDpos = _goodSpots select (floor (random (count _goodSpots)));
_IEDpos = [_IEDpos select 0, _IEDpos select 1, 0];
if (_debug) then {diag_log format ["IED position = %1",_IEDpos];};
private ["_nearBodies"];
_nearBodies = _IEDpos nearEntities [["Man","Car","Motorcycle","Tank"],11];
if (count _nearBodies > 0) exitWith {if (_debug) then {diag_log format ["IED exiting as near objects found %1",_nearBodies];};}; //Exit if bodies are near (this way the IED does not auto-explode on spawn)

//IF IT IS ALL GOOD, SPAWN THE IED
_soldier setVariable ["reezo_eod_avail",false];
_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];
_IED = createVehicle [_IEDskins select (floor (random (count _IEDskins))),_IEDpos, [], 5 + random 5, "NONE"];
_IED setDir (random 360);

if (_debug) then {
	diag_log format ["MSO-%1 EOD IED: arming IED at %2 of %3",time, position _IED, typeOf _IED];
};

if (true) exitWith{ nul0 = [_soldier, _IED, _rangeMax] execVM "x\eod\addons\eod\IED_postServerInit.sqf" };