		// Function to convert group into appropriate format to spawn group
        private ["_grptemp","_var"];
        _var = _this select 0;
		if ((_var select 0) == "resistance") then {
			_var set [0,"Guerrila"];
		};
		_grptemp =  (configFile >> "CfgGroups" >> (_var select 0) >> (_var select 1) >> (_var select 2) >> (_var select 3));
		//diag_log format ["_grptemp created = %1", _grptemp];
		_grptemp;