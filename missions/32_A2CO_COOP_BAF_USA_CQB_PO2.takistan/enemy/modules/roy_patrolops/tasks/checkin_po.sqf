PAPABEAR = [West,"HQ"];

if !(typeOf player in PO_teamleads) exitwith {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. Only team leaders are authorized to sign in!", group player];
};

if !(call mso_fnc_hasRadio) exitwith {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. You need to be equiped with a radio!", group player];
};

if !(runningmission_po) then {
	PAPABEAR sideChat format ["%1 this is PAPA BEAR. Request Authorised. Transmitting INTEL!", group player];
    runningmission_po = true;
    Publicvariable "runningmission_po";
    
    //Deactivating Request Task option in comms for all localities
    [0,[],{
    PO_SUBMENU set [1, ["Request Tasking", [2], "", -5, [["expression", "[] call compile preprocessFileLineNumbers 'enemy\modules\roy_patrolops\tasks\checkin_po.sqf' "]], "1", "0"]];
    }] call mso_core_fnc_ExMP;
    
    ABORTTASK_PO = false;
    Publicvariable "ABORTTASK_PO";
    } else {
    PAPABEAR sideChat format ["%1 this is PAPA BEAR. You are already assigned. Follow your orders!", group player];
};