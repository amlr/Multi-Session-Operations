_debug = debug_mso;

while {true} do {
    sleep 3;
    {
    	//identify all CQB units without PV-broadcasting each one individually
        _catched = nil; _catched = (leader _x) getvariable "identified";
        _creator = nil; _creator = (leader _x) getvariable "PM";
        _pos = position (leader _x);
 
    	if ((_creator == "CQB") && (isnil "_catched")) then {
        	{
                _x setvariable ["PM","CQB"];
                _x setvariable ["identified",true];
            } foreach units _x;
            if (_debug) then {diag_log format["MSO-%1 CQB Population: Identified CQB-group %2 on server...", time, _x]};
		};

		//delete if CQB-units are local to server and not clientside anymore
		if ((local (leader _x)) && (_creator == "CQB") && ({_pos distance _x < 2500} count ([] call BIS_fnc_listPlayers) < 1)) then {
            if (_debug) then {diag_log format["MSO-%1 CQB Population: Deleting CQB-group %2 from server...", time, _x]};
            {
                _x setvariable ["identified",nil];
                _x setdamage 1;
            	deletevehicle _x;
        	} foreach units _x;
            deletegroup _x;
    	};
        //clean up CQB groups to be sure
        if ((count (units _x) == 0) && (_creator == "CQB")) then {deletegroup _x;};
    } foreach allgroups;
};