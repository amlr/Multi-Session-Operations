#include <script_macros_core.hpp>
SCRIPT(convertData);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_convertData

Description:
Converts ARMA2 data types, map objects, and created vehicles into JSON type strings

Parameters:
Any - Any data type or object

Returns:
String - Returns JSON type string in the format "DATATYPE:VALUE"

Examples:
(begin example)
// An array of different data types
_result = [true, 123.456, resistance] call MSO_fnc_convertData
// returns ARRAY:["BOOL:1","SCALAR:123.456","SIDE:GUER"]

// An map placed house
_result = _myhouse call MSO_fnc_convertData
// returns OBJECT:["#CBA_HASH#",["Category","typeOf","position","direction"],["Building","Land_HouseV_1I4",[4396.92,3170.78,0.197453],211.415],any]
(end)

Author:
Tupolov
Wolffy.au
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_result","_debug"];
_debug = false;
_result = nil;

if(isNil "_this") exitWith {
        if (_debug) then {
                "ConvertData <null> type" call MSO_fnc_logger;
        };
        "nil";
};

if (_debug) then {
        format["ConvertData %1:%2", typeName _this, _this] call MSO_fnc_logger;
};

switch(typeName _this) do {
        case "BOOL": {
                private["_tmp"];
                _tmp = if(_this) then {1} else {0};
                _result = format["%1:%2",typeName _this, _tmp];
        };
        case "ARRAY": {
                private["_tmp"];
                _tmp = [];
                {
                        private["_v"];
                        _v = _x call MSO_fnc_convertData;
                        if(
                                (typeName _x == "ARRAY") ||
                                {typeName _x == "OBJECT"}
                        ) then {
                                _v = [_v, """", """"""] call CBA_fnc_replace;
                        };
                        _tmp set [count _tmp, _v];
                } forEach _this;
                _result = format["%1:%2",typeName _this, _tmp];
        };
        case "OBJECT": {
                private["_tmp"];
                _tmp = [] call CBA_fnc_hashCreate;
                if(_this isKindOf "Building") then {
                        [_tmp, "Category", "Building"] call CBA_fnc_hashSet;
                };
                [_tmp, "typeOf", typeOf _this] call CBA_fnc_hashSet;
                [_tmp, "position", position _this] call CBA_fnc_hashSet;
                [_tmp, "direction", direction _this] call CBA_fnc_hashSet;
                _result = format["%1:%2",typeName _this, _tmp];
        };
        default {
                _result = format["%1:%2",typeName _this, _this];
        };
};
_result;
