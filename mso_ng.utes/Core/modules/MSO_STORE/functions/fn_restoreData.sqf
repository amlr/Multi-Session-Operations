
private ["_debug","_result", "_type", "_data"];
_debug = false;

_result = [_this, ":"] call CBA_fnc_split;
_type = _result select 0;
_data = _result select 1;

if (_debug) then {
        //diag_log format["Running conversion function... on %1 type %2", _origvar, typeName _origvar];
};

switch(_type) do {
        case "STRING": {
                _result = _data;
        };
        case "TEXT": {
                _result = text _data;
        };
        case "BOOL": {
                private["_b"];
                _b = if(parseNumber _data == 0) then {false} else {true};
                _result = _b;
        };
        case "SCALAR": {
                _result = parseNumber _data;
        };        
};
_result;

/*
if (_action == "read") then {
        
        if ([_origvar, "|"] call CBA_fnc_find != -1) then {		// If string was array convert to array
        _var = [_origvar, "|", ","] call CBA_fnc_replace;
        _var = "[" + _var + "]";
        _var = call compile _var;
} else {
        if ((parseNumber _origvar == 0) && ([_origvar] call CBA_fnc_strLen > 1)) then {	// Check to see if string was originally a string. This will not work properly if an attribute is a 1 character letter or if string is a set of numbers
        _var = _origvar;
} else {
        if (_origvar == "") then {
                _var = "";
        } else {
                _var =  parseNumber _origvar; // If not array or string, must be number.
        };
};
};

if (pdb_log_enabled) then {
        //diag_log format["Converted %1 (%2) to %3 (%4) for SQF", _origvar, typeName _origvar, _var, typeName _var];
};
};
*/