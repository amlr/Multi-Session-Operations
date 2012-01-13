private ["_groups","_range","_type","_sleep","_array","_forEachIndex","_functions","_fnc_init"];
_range = 1000;
_type = "";
_sleep = 1;

// Check if from the Editor or scripted
if (tolower(typename _this) == "object") then {
        _groups = synchronizedObjects _this;
        _range = _this getvariable ["range", _range];
        _type = _this getvariable ["type", _type];
        _sleep = _this getvariable ["sleep", _sleep];
} else {
        _groups = _this select 0;
        if (count _this > 0) then {
                _range = _this select 1;
        };
        if (count _this > 1) then {
                _type = _this select 2;
        };
        if (count _this > 2) then {
                _sleep = _this select 3;
        };
};

// Check if all items are group objects
{
        if (tolower(typename _x) != "group") then {
                _groups set [_forEachIndex, group _x];
        };
} foreach _groups;

// If there is init code, execute now
_functions = _type call {
        #include <config.sqf>
};
_fnc_init = _functions select 0;
if(!isNil "_fnc_init") then {
        _array = _groups call _fnc_init;
} else {
        _array = _groups;
};

[_array, _range, _type, _sleep] spawn {
        private ["_array","_range","_type","_sleep","_functions","_fnc_sync","_fnc_active","_fnc_inactive"];
        _array = _this select 0;
        _range = _this select 1;
        _type = _this select 2;
        _sleep = _this select 3;
        
        _functions = _type call {
                #include <config.sqf>
        };
        
        _fnc_sync = _functions select 1;
        _fnc_cache = _functions select 2;
        _fnc_uncache = _functions select 3;
        
        while {count _array > 0} do {
                {
                        _x call _fnc_sync;

			// Is group deleted?
                        if (isnull _x) then {
                                _array = _array - [_x];
                        } else {
                                _exclude = _x getvariable "rmm_gtk_exclude";
                                if (isNil "_exclude") then {_exclude = false;};

                                _cached = _x getvariable "rmm_gtk_cached";
                                if (isNil "_cached") then {_cached = false;};

				// Is group excluded from processing?
                                if (!_exclude) then {
					// Is group cached?
                                        if (_cached) then {
						// Any player within range?
                                                if ([_x, _range] call CBA_fnc_nearPlayer) then {
                                                        _x setvariable ["rmm_gtk_cached", nil];
                                                        _x call _fnc_uncache;
                                                };
                                        } else {
						// All players outside 1.1 * range?
                                                if !([_x, _range * 1.1] call CBA_fnc_nearPlayer) then {
                                                        _x setvariable ["rmm_gtk_cached", true];
                                                        _x call _fnc_cache;
                                                };
                                        };
                                };
                        };
                } foreach _array;

                sleep _sleep;
        };
};

_array;