
private ["_debug","_result","_type","_data","_split"];
_debug = false;

_split = false;
_type = [];
_data = [];
// Split the JSON type and data
{
        // find the ":" seperator
        if(_x == 58 && !_split) then {
                _split = true;
        } else {
                if(!_split) then {
                        _type set [count _type, _x];
                } else {
                        _data set [count _data, _x];
                };
        };
} foreach (toArray _this);
_type = toString _type;
_data = toString _data;

if (_debug) then {
        //diag_log format["Running conversion function... on %1 type %2", _origvar, typeName _origvar];
};

// Address each data type accordingly
_result = nil;
switch(_type) do {
        case "STRING": {
                _result = _data;
        };
        case "TEXT": {
                _result = text _data;
        };
        case "BOOL": {
                private["_tmp"];
                _tmp = if(parseNumber _data == 0) then {false} else {true};
                _result = _tmp;
        };
        case "SCALAR": {
                _result = parseNumber _data;
        };
        case "SIDE": {
                _result = switch(_data) do {
                        case "WEST": {west;};
                        case "EAST": {east;};
                        case "GUER": {resistance;};
                        case "CIV": {civilian;};
                        case "LOGIC": {sideLogic;};
                };
        };
        case "ARRAY": {
                private["_tmp"];
                _data = [_data, "any", "nil"] call CBA_fnc_replace;
                _tmp = call compile _data;
                _result = [];
                {
                        _result set [count _result, _x call MSO_fnc_restoreData];
                } forEach _tmp;
        };
        case "OBJECT": {
                private["_tmp","_category","_type","_pos","_dir","_found"];
                _data = [_data, "any", "nil"] call CBA_fnc_replace;
                _tmp = call compile _data;
                _category = [_tmp, "Category"] call CBA_fnc_hashGet;
                _type = [_tmp, "typeOf"] call CBA_fnc_hashGet;
                _pos = [_tmp, "position"] call CBA_fnc_hashGet;
                _dir = [_tmp, "direction"] call CBA_fnc_hashGet;
                _found = false;
                
                // Different OBJECT types have different requirements
                switch(_category) do {
                        case "Building": {
                                // Try to find if the building  exists on the map already
                                // and reference it
                                private["_house"];
                                _house = _pos nearestObject _type;
                                
                                if(
                                        (typeOf _house == _type) &&
                                        {str position _house == str _pos} &&
                                        // TODO: need to convert to string due to loss in resolution
                                        {str direction _house == str _dir}
                                ) then {
                                        _result = _house;
                                        _found = true;
                                };                                        
                        };
                };
                // If OBJECT doesn't exist already, create it
                if(!_found) then {
                        _result = createVehicle [_type, _pos, [], 0, "NONE"];
                        _result setPos _pos;
                        _result setDir _dir;
                };
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
