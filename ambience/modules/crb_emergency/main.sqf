private ["_hospitals","_police","_repairs","_id","_debug"];
if(!isServer) exitWith{};

waitUntil{!isNil "bis_functions_mainscope"};

_debug = true;
_hospitals = [];
_police = [];
_repairs = [];

// Find & mark hospitals, Police Stations and Repair centres
{
        private["_h","_hf","_pf"];
        _h = nearestObjects [position _x, ["Land_A_Hospital","Land_A_Office01","Land_A_Office01_EP1","Land_A_Stationhouse","Land_A_Stationhouse_ep1","Land_Mil_House_EP1","Land_repair_center","Land_Mil_Repair_center_EP1"], 500];

	_hf = 0;
	_pf = 0;
	_hp = [];
	_pp = [];
        {
                if(typeOf _x == "Land_A_Hospital") then {
			if(_hf < 2) then {_hp = [];};
                        _hp = _hp + [_x];
			_hf = 2;
                } else {
                        if(_hf < 2 && (typeOf _x == "Land_A_Stationhouse" || typeOf _x == "Land_A_Stationhouse_ep1")) then {
				if(_hf < 1) then {_hp = [];};
                                _hp = _hp + [_x];
				_hf = 1;
                        } else {
                                if(_hf < 1 && typeOf _x == "Land_Mil_House_EP1") then {
                                        _hp = _hp + [_x];
                                };
                        };
                };
                
                if(typeOf _x == "Land_A_Office01" || typeOf _x == "Land_A_Office01_EP1") then {
			if(_pf < 2) then {_pp = [];};
                        _pp = _pp + [_x];
			_pf = 2;
                } else {
                        if(_pf < 2 && (typeOf _x == "Land_A_Stationhouse" || typeOf _x == "Land_A_Stationhouse_ep1")) then {
				if(_pf < 1) then {_pp = [];};
                                _pp = _pp + [_x];
				_pf = 1;
                        } else {
                                if(_pf < 1 && typeOf _x == "Land_Mil_House_EP1") then {
                                        _pp = _pp + [_x];
                                };
                        };
                };
                
                if(typeOf _x == "Land_repair_center" || typeOf _x == "Land_Mil_Repair_center_EP1") then {
                        _repairs =  _repairs + [_x];
                };
        } forEach _h;
	_hospitals = _hospitals + _hp;
	_police = _police + _pp;

} forEach (bis_functions_mainscope getVariable "locations");

// Place ambulance/doctos and police cars/police outside, and
// add SUPPORT and GUARD waypoints
_id = 0;
{
        private["_pos","_veh","_grp","_unit","_wp"];
        _pos = _x buildingExit 0;
        if(str _pos == "[0,0,0]") then {_pos = _x buildingPos 0;};
        if(str _pos == "[0,0,0]") then {_pos = position _x;};
        _veh = createvehicle ["S1203_ambulance_EP1", _pos, [], 0, "NONE"];
        //_veh allowDamage false;
	_veh setVectorUp [0,0,1];
        _veh setDir (getDir _x) + 90;
        _grp = createGroup civilian;
        _unit = _grp createUnit ["Doctor", _pos, [], 0, "NONE"];
        //_unit allowDamage false;
        _unit assignAsDriver _veh;
        _unit moveInDriver _veh;
        _unit = _grp createUnit ["Doctor", _pos, [], 0, "NONE"];
        //_unit allowDamage false;
        _unit assignAsCargo _veh;
        _unit moveInCargo _veh;
        
        _wp = _grp addwaypoint [_pos, 0];
        _wp setWaypointSpeed "FULL";
        _wp setWaypointBehaviour "SAFE";
        _wp setWaypointType "SUPPORT";        
        
        if (_debug) then {
                private["_n"];
                _n = format["hospital_%1", _id];
                [_n, _pos, "Icon", [1,1], "TYPE:", "Destroy", "COLOR:", "ColorRed", "TEXT:", _n,  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                _id = _id + 1;
        };
        
} forEach _hospitals;

_id = 0;
{
        private["_pos","_veh","_grp","_unit","_wp"];
        _pos = _x buildingExit 0;
        if(str _pos == "[0,0,0]") then {_pos = _x buildingPos 0;};
        if(str _pos == "[0,0,0]") then {_pos = position _x;};
        _veh = createvehicle ["LadaLM", _pos, [], 0, "NONE"];
        //_veh allowDamage false;
	_veh setVectorUp [0,0,1];
        _veh addMagazineCargo ["8Rnd_9x18_Makarov", 20];
        _veh setDir (getDir _x) + 90;
        _grp = createGroup civilian;
        _unit = _grp createUnit ["Policeman", _pos, [], 0, "NONE"];
        //_unit allowDamage false;
        {_unit addMagazine "8Rnd_9x18_Makarov"} forEach [1,2,3,4,5,6,7,8];
        _unit addWeapon "Makarov"; 
        _unit assignAsDriver _veh;
        _unit moveInDriver _veh;
        _unit = _grp createUnit ["Policeman", _pos, [], 0, "NONE"];
        //_unit allowDamage false;
        {_unit addMagazine "8Rnd_9x18_Makarov"} forEach [1,2,3,4,5,6,7,8];
        _unit addWeapon "Makarov"; 
        _unit assignAsCargo _veh;
        _unit moveInCargo _veh;
        
        _wp = _grp addwaypoint [_pos, 0];
        _wp setWaypointSpeed "FULL";
        _wp setWaypointBehaviour "SAFE";
        _wp setWaypointType "GUARD";        
        
        if (_debug) then {
                private["_n"];
                _n = format["police_%1", _id];
                [_n, _pos, "Icon", [1,1], "TYPE:", "Destroy", "COLOR:", "ColorBlue", "TEXT:", _n,  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                _id = _id + 1;
        };
        
} forEach _police;

_id = 0;
{
        private["_pos","_veh","_grp","_unit","_wp"];
        _pos = _x buildingExit 3;
        if(str _pos == "[0,0,0]") then {_pos = _x buildingPos 0;};
        if(str _pos == "[0,0,0]") then {_pos = position _x;};
        _veh = createvehicle ["V3S_Repair_TK_GUE_EP1", _pos, [], 0, "NONE"];
        //_veh allowDamage false;
	_veh setVectorUp [0,0,1];
        _veh setDir (getDir _x) + 180;
        _grp = createGroup civilian;
        _unit = _grp createUnit [["TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"] call BIS_fnc_selectRandom, _pos, [], 0, "NONE"];
        //_unit allowDamage false;
        _unit assignAsDriver _veh;
        _unit moveInDriver _veh;
        
        _wp = _grp addwaypoint [_pos, 0];
        _wp setWaypointSpeed "FULL";
        _wp setWaypointBehaviour "SAFE";
        _wp setWaypointType "SUPPORT";        
        
        if (_debug) then {
                private["_n"];
                _n = format["repair_%1", _id];
                [_n, _pos, "Icon", [1,1], "TYPE:", "Destroy", "COLOR:", "ColorGreen", "TEXT:", _n,  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                _id = _id + 1;
        };
        
} forEach _repairs;
