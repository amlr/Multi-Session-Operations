private ["_result","_debug"];
_debug = false;
_result = nil;

if (_debug) then {
	//diag_log format["Running conversion function... on %1 type %2", _origvar, typeName _origvar];
};

switch(typeName _this) do {
        case "BOOL": {
                private["_b"];
                _b = if(_this) then {1} else {0};
                _result = format["%1:%2",typeName _this, _b];
	};
        default {
                _result = format["%1:%2",typeName _this, _this];
        };
};
_result;
/*	
if (_action == "write") then {

	if (typename _origvar == "OBJECT") then {
		_var = str(_origvar);
	};

	if (typename _origvar == "ARRAY") then {
		_var = str(_origvar);
		// Check for nested array
		if ([_var, "[["] call CBA_fnc_find != -1) then {
			_var = [_var, "[[", "["] call CBA_fnc_replace; 
			_var = [_var, "]]", "]"] call CBA_fnc_replace; 
			_var = [_var, ",", "|"] call CBA_fnc_replace; 
		} else {
			_var = [_var, "[", ""] call CBA_fnc_replace; 
			_var = [_var, "]", ""] call CBA_fnc_replace; 
			_var = [_var, ",", "|"] call CBA_fnc_replace; 
		};
		if ([_var] call CBA_fnc_strLen < 2) then {_var = "";};
	};
	
	if (typename _origvar == "SIDE") then {
		_var = str(_origvar);
	};
	
	if (typename _origvar == "BOOL") then {
		_var = str(_origvar);
		if (isNil _var) then {_var = "false";};
	};
	
	if (typename _origvar == "SCALAR") then {
		_var =  str(_origvar);
		if ([_var,","] call CBA_fnc_find !=-1) then {
			_var = [_var,",","."] call CBA_fnc_replace;
		};
	};
	
	if (pdb_log_enabled) then {
		//diag_log format["Converted %1 (%2) to %3 (%4) for DB", _origvar, typeName _origvar, _var, typeName _var];
	};
};
*/
