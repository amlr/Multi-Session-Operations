private ["_hospitals","_police","_repairs","_hp","_pp","_maxdist"];
if(isNil "Emergency")then{Emergency = 1;};
if (Emergency == 0) exitWith{};

// Exit if not HC and not a server
if(isnil "EmergencyLocality") then {EmergencyLocality = 0;};
if(
	switch (EmergencyLocality) do {
	        case 0: {!isServer};
        	case 1: {!isHC};
	}
) exitWith{};

waitUntil{!isNil "bis_functions_mainscope"};
waitUntil{typeName (bis_functions_mainscope getVariable "locations") == "ARRAY"};

crb_emergency_debug = debug_mso;

if isnil "crb_emergency_debug" then {
crb_emergency_debug = false;
};

_hospitals = [];
_police = [];
_repairs = [];
_maxdist = 3000;

// Find & mark hospitals, Police Stations and Repair centres
{
        private["_h","_hf","_pf"];
        _h = nearestObjects [position _x, ["Land_A_Hospital","Land_cwr2_hospital","Land_A_Office01","Land_A_Office01_EP1","Land_A_Stationhouse","Land_A_Stationhouse_ep1","Land_dum_mesto","Land_Mil_House_EP1","Land_repair_center","Land_Mil_Repair_center_EP1","Land_cwr2_repair_center"], 1000];
        
        _hf = 0;
        _pf = 0;
        _hp = [];
        _pp = [];
        {
                if (!(_x in _hospitals || _x in _police || _x in _repairs)) then {
                        if(typeOf _x == "Land_A_Hospital" || typeOf _x == "Land_cwr2_Hospital") then {
                                if(_hf < 2) then {_hp = [];};
                                _hp set [count _hp, _x];
                                _hf = 2;
                        } else {
                                if(_hf < 2 && (typeOf _x == "Land_A_Stationhouse" || typeOf _x == "Land_A_Stationhouse_ep1")) then {
                                        if(_hf < 1) then {_hp = [];};
                                        _hp set [count _hp, _x];
                                        _hf = 1;
                                } else {
                                        if(_hf < 1 && typeOf _x == "Land_Mil_House_EP1") then {
                                                _hp set [count _hp, _x];
                                        };
                                };
                        };
                        
                        if(typeOf _x == "Land_A_Office01" || typeOf _x == "Land_A_Office01_EP1") then {
                                if(_pf < 2) then {_pp = [];};
                                _pp set [count _pp, _x];
                                _pf = 2;
                        } else {
                                if(_pf < 2 && (typeOf _x == "Land_A_Stationhouse" || typeOf _x == "Land_A_Stationhouse_ep1")) then {
                                        if(_pf < 1) then {_pp = [];};
                                        _pp set [count _pp, _x];
                                        _pf = 1;
                                } else {
                                        if(_pf < 1 && (typeOf _x == "Land_Mil_House_EP1" || typeOf _x == "Land_dum_mesto")) then {
                                                _pp set [count _pp, _x];
                                        };
                                };
                        };
                        
                        if(typeOf _x == "Land_repair_center" || typeOf _x == "Land_Mil_Repair_center_EP1" || typeOf _x == "Land_cwr2_repair_center") then {
                                _repairs set [count _repairs, _x];
                        };
                };
        } forEach _h;
        _hospitals = _hospitals + _hp;
        _police = _police + _pp;

} forEach (bis_functions_mainscope getVariable "locations");

{
        private["_n"];
        _n = format["hospital_%1", random 10000];
        _x setVariable ["name", _n];
        if (crb_emergency_debug) then {
                [_n, position _x, "Icon", [1,1], "TYPE:", "Destroy", "COLOR:", "ColorRed", "TEXT:", _n,  "GLOBAL"] call CBA_fnc_createMarker;
        };
} forEach _hospitals;

{
        private["_n"];
        _n = format["police_%1", random 10000];
        _x setVariable ["name", _n];
        if (crb_emergency_debug) then {
                [_n, position _x, "Icon", [1,1], "TYPE:", "Destroy", "COLOR:", "ColorBlue", "TEXT:", _n,  "GLOBAL"] call CBA_fnc_createMarker;
        };
} forEach _police;

{
        private["_n"];
        _n = format["repair_%1", random 10000];
        _x setVariable ["name", _n];
        if (crb_emergency_debug) then {
                [_n, position _x, "Icon", [1,1], "TYPE:", "Destroy", "COLOR:", "ColorGreen", "TEXT:", _n,  "GLOBAL"] call CBA_fnc_createMarker;
        };
} forEach _repairs;

[_hospitals, _police, _repairs, _maxdist] spawn {
        private ["_hospitals","_police","_repairs","_maxdist","_grp","_h","_name"];
        _hospitals = _this select 0;
        _police = _this select 1;
        _repairs = _this select 2;
        _maxdist = _this select 3;
        
        while{true} do {
                // Place ambulance/doctos and police cars/police outside, and
                // add SUPPORT and GUARD waypoints
                {
                        _h = _x;
                        _grp = _h getVariable "EmergencyGroup";
                        _name = _h getVariable "name";
                        //diag_log format["%1 %2 %3 %4", _name, (isNil "_grp"), (isNull _grp), _grp];
                        if(isNil "_grp" && ({_h distance _x < _maxdist} count ([] call BIS_fnc_listPlayers) > 0)) then {
                                private["_pos","_veh","_unit","_wp"];
                                _pos = _h buildingExit 0;
                                if(str _pos == "[0,0,0]") then {_pos = _h buildingPos 0;};
                                if(str _pos == "[0,0,0]") then {_pos = position _h;};
                                _veh = createvehicle ["S1203_ambulance_EP1", _pos, [], 0, "NONE"];
                                _veh allowDamage false;
                                _veh setVectorUp [0,0,1];
                                _veh setDir (getDir _h) + 90;
                                _grp = createGroup civilian;
                                _unit = _grp createUnit ["Doctor", _pos, [], 0, "NONE"];
                                _unit setSkill 0.2;
                                _unit allowDamage false;
                                _unit assignAsDriver _veh;
                                _unit moveInDriver _veh;
                                //_unit = _grp createUnit ["Doctor", _pos, [], 0, "NONE"];
                                //_unit setSkill 0.2;
                                //_unit allowDamage false;
                                //_unit assignAsCargo _veh;
                                //_unit moveInCargo _veh;
                                
                                _wp = _grp addwaypoint [_pos, 0];
                                _wp setWaypointSpeed "FULL";
                                _wp setWaypointBehaviour "SAFE";
                                _wp setWaypointType "SUPPORT";        
                                
                                if (crb_emergency_debug) then {
                                        diag_log format ["MSO-%1 Emergency: Spawning %2", time, _name];
                                };
                                _h setVariable ["EmergencyGroup", _grp];
                        } else {
                                if(!isNil "_grp" && ({_h distance _x < _maxdist} count ([] call BIS_fnc_listPlayers) == 0)) then {
                                        if (crb_emergency_debug) then {
                                                diag_log format ["MSO-%1 Emergency: Removing %2", time, _name];
                                        };
                                        {
                                                deleteVehicle (assignedVehicle _x);
                                                deleteVehicle _x;
                                        } forEach units _grp;
                                        deleteGroup _grp;
                                        _h setVariable ["EmergencyGroup", nil];
                                };
                        };
                } forEach _hospitals;
                
                {
                        _h = _x;
                        _grp = _h getVariable "EmergencyGroup";
                        _name = _h getVariable "name";
                        //diag_log format["%1 %2 %3 %4", _name, (isNil "_grp"), (isNull _grp), _grp];
                        if(isNil "_grp" && ({_h distance _x < _maxdist} count ([] call BIS_fnc_listPlayers) > 0)) then {
                                private["_pos","_veh","_unit","_wp"];
                                _pos = _h buildingExit 0;
                                if(str _pos == "[0,0,0]") then {_pos = _h buildingPos 0;};
                                if(str _pos == "[0,0,0]") then {_pos = position _h;};
                                _veh = createvehicle ["LadaLM", _pos, [], 0, "NONE"];
                                _veh allowDamage false;
                                _veh setVectorUp [0,0,1];
                                _veh addMagazineCargo ["8Rnd_9x18_Makarov", 20];
                                _veh setDir (getDir _h) + 90;
                                _grp = createGroup civilian;
                                _unit = _grp createUnit ["Policeman", _pos, [], 0, "NONE"];
                                _unit setSkill 0.2;
                                _unit allowDamage false;
                                {_unit addMagazine "8Rnd_9x18_Makarov"} forEach [1,2,3,4,5,6,7,8];
                                _unit addWeapon "Makarov"; 
                                _unit assignAsDriver _veh;
                                _unit moveInDriver _veh;
                                _unit = _grp createUnit ["Policeman", _pos, [], 0, "NONE"];
                                _unit setSkill 0.2;
                                _unit allowDamage false;
                                {_unit addMagazine "8Rnd_9x18_Makarov"} forEach [1,2,3,4,5,6,7,8];
                                _unit addWeapon "Makarov"; 
                                _unit assignAsCargo _veh;
                                _unit moveInCargo _veh;
                                
                                _wp = _grp addwaypoint [_pos, 0];
                                _wp setWaypointSpeed "FULL";
                                _wp setWaypointBehaviour "SAFE";
                                _wp setWaypointType "GUARD";        
                                
                                if (crb_emergency_debug) then {
                                        diag_log format ["MSO-%1 Emergency: Spawning %2", time, _name];
                                };
                                _h setVariable ["EmergencyGroup", _grp];
                        } else {
                                if(!isNil "_grp" && ({_h distance _x < _maxdist} count ([] call BIS_fnc_listPlayers) == 0)) then {
                                        if (crb_emergency_debug) then {
                                                diag_log format ["MSO-%1 Emergency: Removing %2", time, _name];
                                        };
                                        {
                                                deleteVehicle (assignedVehicle _x);
                                                deleteVehicle _x;
                                        } forEach units _grp;
                                        deleteGroup _grp;
                                        _h setVariable ["EmergencyGroup", nil];
                                };
                        };
                } forEach _police;
                
                {
                        _h = _x;
                        _grp = _h getVariable "EmergencyGroup";
                        _name = _h getVariable "name";
                        //diag_log format["%1 %2 %3 %4", _name, (isNil "_grp"), (isNull _grp), _grp];
                        if(isNil "_grp" && ({_h distance _x < _maxdist} count ([] call BIS_fnc_listPlayers) > 0)) then {
                                private["_pos","_veh","_unit","_wp"];
                                _pos = _h buildingExit 3;
                                if(str _pos == "[0,0,0]") then {_pos = _h buildingPos 0;};
                                if(str _pos == "[0,0,0]") then {_pos = position _h;};
                                _veh = createvehicle ["V3S_Repair_TK_GUE_EP1", _pos, [], 0, "NONE"];
                                _veh allowDamage false;
                                _veh setVectorUp [0,0,1];
                                _veh setDir (getDir _h) + 180;
                                _grp = createGroup civilian;
                                _unit = _grp createUnit [["TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"] call BIS_fnc_selectRandom, _pos, [], 0, "NONE"];
                                _unit setSkill 0.2;
                                _unit allowDamage false;
                                _unit assignAsDriver _veh;
                                _unit moveInDriver _veh;
                                
                                _wp = _grp addwaypoint [_pos, 0];
                                _wp setWaypointSpeed "FULL";
                                _wp setWaypointBehaviour "SAFE";
                                _wp setWaypointType "SUPPORT";        
                                
                                if (crb_emergency_debug) then {
                                        diag_log format ["MSO-%1 Emergency: Spawning %2", time, _name];
                                };
                                _h setVariable ["EmergencyGroup", _grp];
                        } else {
                                if(!isNil "_grp" && ({_h distance _x < _maxdist} count ([] call BIS_fnc_listPlayers) == 0)) then {
                                        if (crb_emergency_debug) then {
                                                diag_log format ["MSO-%1 Emergency: Removing %2", time, _name];
                                        };
                                        {
                                                deleteVehicle (assignedVehicle _x);
                                                deleteVehicle _x;
                                        } forEach units _grp;
                                        deleteGroup _grp;
                                        _h setVariable ["EmergencyGroup", nil];
                                };
                        };
                } forEach _repairs;
                
                sleep 3;
        };
};