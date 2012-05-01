PAPABEAR = [West,"HQ"];

if !(typeOf player in PO_teamleads) exitwith {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. Only team leaders are authorized to abort an operation!", group player];
};

if !(call mso_fnc_hasRadio) exitwith {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. You need to be equiped with radio to confirm abortion!", group player];
};

if (runningmission_po) then {
	ABORTTASK_PO = true;
	Publicvariable "ABORTTASK_PO";
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. Abortion confirmed...", group player];
} else {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. There is no active operation to abort...", group player];
};

