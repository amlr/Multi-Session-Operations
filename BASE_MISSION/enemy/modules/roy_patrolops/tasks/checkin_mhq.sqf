MPS_TASKCHECKIN = true;
Publicvariable "MPS_TASKCHECKIN";

sleep 1;
sleep random 2;

PAPABEAR = [West,"HQ"];

if (isnil "PO2_assigned") then {PO2_assigned = false};
if !(PO2_assigned) then {
	PAPABEAR sideChat format ["%1 this is PAPA BEAR. Request Authorised. Transmitting INTEL!", group player];
    PO2_assigned = true;
    Publicvariable "PO2_assigned";
    } else {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. You are already assigned. Follow your orders!", group player];
};