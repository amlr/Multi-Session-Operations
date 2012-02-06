// Remove IED
private ["_ieds","_IEDskins","_location","_size","_IEDplaced","_nodel"];

if !(isServer) exitWith {diag_log "RemoveIED Not running on server!";};

_location = _this select 0;
_size = _this select 1;
_IEDplaced = round ((_size / 50) * (tup_ied_threat / 100));
_ieds = [];

if ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 1)) then {
	_ieds = nearestobjects [_location,["reezo_eod_iedarea"],_size];
} else {
	_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];
	_ieds = (nearestobjects [_location, _IEDskins, _size]);
};

_nodel = 0;

for "_j" from 0 to ((count _ieds) -1) do {
	private ["_IED"];
	_IED = _ieds select _j;
	if (count (nearestobjects [ _IED, ["Car"], 4]) == 0) then {
		// delete trigger too if non-eod IED
		if (!(isClass(configFile>>"CfgPatches">>"reezo_eod")) || ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 0))) then {
			deletevehicle (_IED getvariable "Trigger");
		};
		deletevehicle _IED;
	} else {
		_nodel = _nodel + 1;
	};
};


diag_log format ["Deleted %1 IEDs of %2 placed", (count _ieds) - _nodel, _IEDplaced];
