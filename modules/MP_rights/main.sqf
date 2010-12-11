_server_file = "database\players.hpp"; //File path relative to ArmA2 directory
_update_rate = 45; //minimum 30 seconds

// do not edit below this

if (isserver) then {
	MP_rights_list = [];
	publicvariable "MP_rights_list";

	[_server_file, _update_rate min 30] spawn {
		_server_file = _this select 0;
		_update_rate = _this select 1;
		while {true} do {
			private "_contents";
			_contents = loadfile _server_file;
			if (_contents != MP_rights_list) then {
				MP_rights_list = _contents;
				publicvariable "MP_rights_list";
			}
			sleep _update_rate;
		};
	};
}: