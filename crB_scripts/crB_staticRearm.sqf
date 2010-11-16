//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au [CTB]
// Created: 20090930
// Modified: 20101027
// Contact: http://creobellum.org
// Purpose: Rearm enemy emplacements
///////////////////////////////////////////////////////////////////
if (!isServer) exitWith{};

{
	_x spawn {
		while {_this isKindOf "StaticWeapon" && side _this != west && alive _this} do {
			waitUntil{!someAmmo _this};
			sleep 5;
			_this setVehicleAmmo 1;
			sleep 1;
		};
	};
} forEach vehicles;
