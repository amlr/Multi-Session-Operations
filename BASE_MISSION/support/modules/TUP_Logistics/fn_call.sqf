private ["_debug","_invalid"];

_debug = debug_mso;

PAPABEAR = [West,"HQ"];

// Check that an order was requested
if (count tup_logistics_order == 0) then {
	_invalid = true;
};

if (_invalid) exitWith {PAPABEAR sideChat format ["%1 this is PAPA BEAR. Invalid Request. Over.", group player];};

PAPABEAR sideChat format ["%1 this is PAPA BEAR. Request Received. Over.", group player];

// Send request to Server
TUP_LOGISTICS_REQUEST = [position player, tup_logistics_order];
PublicVariableServer "TUP_LOGISTICS_REQUEST";