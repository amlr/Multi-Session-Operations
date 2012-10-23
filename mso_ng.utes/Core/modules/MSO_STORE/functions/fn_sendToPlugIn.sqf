private ["_cmd","_response"];
_cmd = _this select 0;

if (([_cmd] call CBA_fnc_strLen) < 16000) then {
	_response = "Arma2Net.Unmanaged" callExtension _cmd;
	_response = call compile _response;	
} else{
	diag_log format["SERVER MSG: Output is greater than 16kb - NOT sending: %1", _cmd];
	_response = [];
};

if (count _response > 0) then {
	_response = _response select 0;
};

_response;
