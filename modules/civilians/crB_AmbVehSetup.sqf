//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au [CTB]
// Created: 20101017
// Contact: http://creobellum.org
// Purpose: Setup BIS Ambient Vehicles
///////////////////////////////////////////////////////////////////
if(!isServer) exitWith{};

waitUntil{!isNil "BIS_fnc_init"};
waitUntil{!isNil "BIS_silvie_mainscope"};

// http://community.bistudio.com/wiki/Ambient_Civilian_Vehicles
// Reduce vehicle count formula to try to reduce number of civilian vehicles
//BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 1.5)", true];

switch toLower(worldName) do {		
	case "zargabad": {
		// Takistan
		BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 0.5)", true];
	};
	case "takistan": {
		// Takistan
		BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 1.0)", true];
	};
	case "chernarus": {
		// Chernarus
		BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 1.0)"];
	};
	case "utes": {
		// Chernarus
		BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 0.75)"];
	};
};

// add motorbikes and bicycles to Ambient Vehicles
BIS_silvie_mainscope setvariable ["vehicleRarity",["TT650_TK_CIV_EP1",0,"Old_bike_TK_CIV_EP1",0,"Old_moto_TK_Civ_EP1",0], true]; 

// randomly lock and vary fuel
BIS_silvie_mainscope setvariable ["vehicleInit",{if (random 1>0.2) then {_this lock true} else {_this  setfuel (random 1)}}, true];
