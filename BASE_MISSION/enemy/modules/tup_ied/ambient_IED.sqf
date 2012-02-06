// Ambient IED - create IED at location (could be EOD IED)
private ["_location","_twn","_debug","_numIEDs","_j","_size"];

if !(isServer) exitWith {diag_log "Ambient Bomber Not running on server!";};

_location = _this select 0;
_size = _this select 1;

_debug = false;
_numIEDs = round ((_size / 50) * (tup_ied_threat / 100));

diag_log format ["MSO-%1 IED: creating %2 IEDs at %3 (size %4)", time, _numIEDs, mapgridposition  _location, _size];

for "_j" from 1 to _numIEDs do {

	if ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 1)) then {
		("reezo_eod_iedarea" createUnit [_location, group BIS_functions_mainscope,
			format["this setVariable ['reezo_eod_range',[0,%1]];
			this setVariable ['reezo_eod_probability',1];
			this setVariable ['reezo_eod_interval',1];",_size], 
			0, ""]);
	} else {
		// Create non-eod IED
		private ["_IEDskins","_IED","_IEDpos","_pos","_posloc","_cen"];
		_cen = getArray(configFile >> "CfgWorlds" >> worldName >> "centerposition ");
		_posloc = [_location, true, true, true, _size] call tup_ied_fnc_placeIED;
		_pos = _posloc call BIS_fnc_selectRandom;
		_IEDpos = [_pos, 2, 10, 2, 0, 0, 0] call BIS_fnc_findSafePos;
		if (count (_IEDpos - _cen) > 0) then {
			_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];
			_IED = createVehicle [_IEDskins select (floor (random (count _IEDskins))),_IEDpos, [], 0, ""];
			[_IED, typeOf _IED] execvm "enemy\modules\tup_ied\arm_ied.sqf";
			_IED addeventhandler ["HandleDamage",{
				deletevehicle ((_this select 0) getvariable "Trigger");
				if (_debug) then {
					diag_log format ["MSO-%1 IED: %2 explodes due to damage by %3", time, (_this select 0), (_this select 3)];
				};
				"Sh_82_HE" createVehicle getposATL (_this select 0);
				deletevehicle (_this select 0);
			}];
		} else {
			if (_debug) then {
				diag_log format ["MSO-%1 IED: Invalid getposATL (%2) for IED. Skipping.", time, _IEDpos];
			};
		};
	};
};
