#include <script_macros_core.hpp>
SCRIPT(sendToPlugIn);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_sendToPlugIn

Description:
Communicates with an external source

Parameters:
String - Text to be sent to externel source

Returns:
String - Returns a response error

Examples:
(begin example)
TODO
(end)

Author:
Tupolov
Peer Reviewed:
Wolffy.au 24 Oct 2012
---------------------------------------------------------------------------- */
private ["_cmd","_response"];
PARAMS_1(_cmd);

if (([_cmd] call CBA_fnc_strLen) < 16000) then {
	_response = "Arma2Net.Unmanaged" callExtension _cmd;
	_response = call compile _response;	
} else{
	format["SendToPlugIn - Output is greater than 16kb - NOT sending: %1", _cmd] call MSO_fnc_logger;
	_response = [];
};

if (count _response > 0) then {
	_response = _response select 0;
};

_response;
