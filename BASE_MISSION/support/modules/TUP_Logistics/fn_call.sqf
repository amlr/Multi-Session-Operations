private ["_debug","_invalid","_tup_logistics_delivery","_destpos"];

_debug = debug_mso;
tup_logistics_destpos = position player;

PAPABEAR = [West,"HQ"];

// Check that an order was requested
if (count tup_logistics_order == 0) then {
	_invalid = true;
};

if (_invalid) exitWith {PAPABEAR sideChat format ["%1 this is PAPA BEAR. Invalid Request. Over.", group player];};

onMapSingleClick {
       tup_logistics_destpos = _pos;
        onMapSingleClick "";
        openMap false;
		logprocText = "<br/>Multi-Session Operations<br/><br/><t color='#ffff00' size='1.0' shadow='1' shadowColor='#000000' align='center'>Logistics Request</t><br/><br/>" + name player + " your order is now being processed.<br/><br/>";
		hint parseText (logprocText);
		[-1, {PAPABEAR sideChat _this}, format ["%1 this is PAPA BEAR. Logistics Request Received from %2 and being processed. Over.", group player, name player]] call CBA_fnc_globalExecute;
		_tup_logistics_delivery = lbCurSel 11;
		// Send request to Server
		TUP_LOGISTICS_REQUEST = [tup_logistics_destpos, tup_logistics_order, _tup_logistics_delivery, player];
		PublicVariableServer "TUP_LOGISTICS_REQUEST";
};


logText = "<br/>Multi-Session Operations<br/><br/><t color='#ffff00' size='1.0' shadow='1' shadowColor='#000000' align='center'>Logistics Request</t><br/><br/>Click on Map to choose delivery location. Aircraft require a runway or helipad within 500m.<br/><br/>";
hint parseText (logText);
openmap true;

