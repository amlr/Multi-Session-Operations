private ["_server_file","_update_rate"];
_server_file = "\MSO\rights_fnc.sqf"; //File path relative to ArmA2 directory
_update_rate = 90; //Minimum 30 seconds

// do not edit below this
if (isserver) then {
	MP_rights_check = {};
	publicvariable "MP_rights_check";
	
	[_server_file, _update_rate min 30] spawn {
		private ["_server_file","_update_rate"];
		_server_file = _this select 0;
		_update_rate = _this select 1;
		while {true} do {
			private "_code";
			_code = compile (loadFile _server_file);
			if (str _code != str MP_rights_check) then {
				MP_rights_check = _code;
				publicvariable "MP_rights_check";
				if (!isdedicated) then {
					(getplayeruid player) call MP_rights_check;
				};
			};
			sleep _update_rate;
		};
	};
} else {
	"MP_rights_check" addPublicVariableEventHandler {
		(getplayeruid player) call MP_rights_check;
	};
	if (!isnil "MP_rights_check") then {
		waituntil{getplayeruid player != ""};
		(getplayeruid player) call MP_rights_check;
	};
};