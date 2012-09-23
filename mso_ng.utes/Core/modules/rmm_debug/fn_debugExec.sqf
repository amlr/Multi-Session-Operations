//0, All
//1, Clients
//2, Server
//3, Local
private ["_locality","_params","_code"];

_locality = _this select 0;
_params = _this select 1;
_code = _this select 2;

//diag_log str [_this,((not isserver) and (_locality == 1)) , (_locality in [0,2])];
if (((not isserver) and (_locality == 2)) or (_locality in [0,1])) then {
        [_locality - 2, compile _code, compile _params] call CBA_fnc_globalExecute;
} else {
        if (isnil "_params") then {call compile _code} else {compile _params call compile _code};
};
