
private ["_server_file","_update_rate"];
_server_file = "mso\mso_uids.txt"; //File path relative to ArmA2 directory
_update_rate = 30; //minimum 30 seconds

// do not edit below this

if (!isMultiPlayer) exitWith {
    MSO_R_Admin = true;
    MSO_R_Leader = true;
    MSO_R_Officer = true;
    MSO_R_Air = true;
    MSO_R_Crew = true;
};

if (isserver) then {
    MP_rights_list = [];
    publicvariable "MP_rights_list";
    
    [_server_file, _update_rate min 30] spawn {
        
        private ["_server_file","_update_rate"];
        _server_file = _this select 0;
        _update_rate = _this select 1;
        while {true} do {
            private "_contents";
            _contents = preprocessFileLineNumbers _server_file;
            if (!([_contents, MP_rights_list] call BIS_fnc_areEqual)) then {
                MP_rights_list = _contents;
                publicvariable "MP_rights_list";
            };
            sleep _update_rate;
        };
    };
} else {
    sleep 0.1;
    waitUntil{!isNil "MP_rights_list"};
    player globalChat str MP_rights_list;
    waitUntil{count (call compile MP_rights_list) > 0};
    player globalChat str (call compile MP_rights_list);
    player globalChat str (getplayeruid player);
    waituntil {getplayeruid player != ""};
    player globalChat str (getplayeruid player);
    
    private ["_uid"];
    _uid = getplayeruid player;
    
    ////////////////////////////////////////////////////////////
    // Specialty Handling
    ////////////////////////////////////////////////////////////
    
    fnc_updateRights = {
        
        private ["_uid"];
        _uid = _this select 0;
        MSO_R = [];
        MSO_R_Admin = false;
        MSO_R_Leader = false;
        MSO_R_Officer = false;
        MSO_R_Air = false;
        MSO_R_Crew = false;
        {
            if (_uid == (_x select 0)) exitwith {
                MSO_R = _x select 2;
                MSO_R_Admin = "admin" in MSO_R;
                MSO_R_Leader = (_x select 1) in ["CORPORAL","SERGEANT","LIEUTENANT"] || MSO_R_Admin;
                MSO_R_Officer = (_x select 1) == "LIEUTENANT" || MSO_R_Admin;
                MSO_R_Air = ("pilot" in MSO_R) || MSO_R_Admin;
                MSO_R_Crew = ("crew" in MSO_R) || MSO_R_Admin;
            };
        } foreach call compile MP_rights_list;

		{
			if (_x iskindof "Air") then {
				if (not MSO_R_Air) then {
					_x lockdriver true;
				};
			};
			if (_x iskindof "Tank") then {
				if (not MSO_R_Crew) then {
					_x lockdriver true;
				};
			};
		} foreach vehicles;
	};
    
    "MP_rights_list" addPublicVariableEventHandler {
        [_uid] call fnc_updateRights;
    };
};