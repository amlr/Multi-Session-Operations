// Written by EightySix
// Declares the Ammobox Type (suitable for TvT)

// Arma 2
_ammoboxes = ["Box_NATO_Wps_F","Box_East_Wps_F","Box_East_Wps_F"];

// Arma 2 OA
if(mps_oa) then { _ammoboxes = ["Box_NATO_Wps_F","Box_East_WpsSpecial_F","Box_East_WpsSpecial_F"]; };


// =========================================================================================================
//	DO NOT TOUCH CODE BELOW THIS LINE
// =========================================================================================================

mission_base_ammobox = switch (side player) do {
	case WEST: {_ammoboxes select 0};
	case EAST: {_ammoboxes select 1};
	case resistance: {_ammoboxes select 2};
	default {_ammoboxes select 0};
};

mission_mobile_ammo = switch (side player) do {
	case WEST: {_ammoboxes select 0};
	case EAST: {_ammoboxes select 1};
	case resistance: {_ammoboxes select 2};
	default {_ammoboxes select 0};
};