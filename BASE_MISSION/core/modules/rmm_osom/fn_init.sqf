private ["_ref","_groups","_array"];
_groups = _this;
_array = [];
{
        _ref = createlocation ["strategic", _x call CBA_fnc_getpos, 1, 1];
        _ref setside (side _x);
        _ref setvariable ["active", true];
        if (tolower(typename _x) == "group") then {
                _ref setvariable ["group", _x];
        } else {
                _ref setvariable ["group", group _x];
        };
        _ref setvariable ["forced", false];
        _array set [count _array,_ref];
} foreach _groups;

_array;