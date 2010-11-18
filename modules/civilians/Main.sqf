if(isServer) then {
	waitUntil{!isNil "BIS_fnc_init"};
	if(isNil "CRB_LOCS") then {
		CRB_LOCS = [] call CRB_fnc_initLocations;
	};

	if(isNil "CRB_CTYCENTER") then {
		CRB_CTYCENTER = [];
		{
			if(type _x == "CityCenter") then {
				CRB_CTYCENTER = CRB_CTYCENTER + [_x];
			};		
		} forEach CRB_LOCS;
	};

	createcenter sidelogic;
	_logicgrp = creategroup sidelogic;

	_logicACFnc = _logicGrp createunit ["Alice2Manager",[0,0,0],[],0,"NONE"];
//	_logicACFnc setVariable ["debug", true, true];
// Needs city radiuses
//	_logicACFnc setvariable ["townlist", CRB_CTYCENTER, true]; 
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";

	_logicAVFnc = _logicGrp createunit ["SilvieManager",[0,0,0],[],0,"NONE"];
//	_logicAVFnc setVariable ["debug", true, true];
// Needs city radiuses
//	_logicAVFnc setvariable ["townlist", CRB_CTYCENTER, true]; 
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";
};

if(worldName == "Zargabad") then {
	[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";
};