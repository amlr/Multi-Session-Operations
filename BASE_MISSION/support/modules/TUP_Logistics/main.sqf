if (isdedicated) then {
	"TUP_LOGISTICS_REQUEST" addPublicVariableEventHandler { 
			if (debug_mso) then {
				diag_log format["MSO-%1 Tup_Logistics: Receiving %2 position %3", time, (_this select 1) select 1, (_this select 1) select 0];
			};
			(_this select 1) call logistics_fnc_delivery;
	};
};

if (isdedicated) exitwith {};

//if (!(getPlayerUID player) in MSO_R_Leader)) exitwith {};

// Set lines of data
TUP_logistics_lines = [
	{["0","1","2","3","4","5","6","7","8","9"]},
	{["0","1","2","3","4","5","6","7","8","9"]},
	{["0","1","2","3","4","5","6","7","8","9"]},
	{["0","1","2","3","4","5","6","7","8","9"]},
	{["0","1","2","3","4","5","6","7","8","9"]}
];

tup_logistics_air = [0, faction player,"Air"] call mso_core_fnc_findVehicleType;
//diag_log format["Air = %1",tup_logistics_air];

tup_logistics_land = [0, faction player,"Car"] call mso_core_fnc_findVehicleType; 
//diag_log format["Car = %1",tup_logistics_land];
tup_logistics_land = tup_logistics_land + ([0, faction player,"Tank"] call mso_core_fnc_findVehicleType);
//diag_log format["Car + Tank = %1",tup_logistics_land];
tup_logistics_land = tup_logistics_land + ([0, faction player,"Motorcycle"] call mso_core_fnc_findVehicleType); 
//diag_log format["Car + Tank + Bikes = %1",tup_logistics_land];

tup_logistics_crate = ["Default","ReammoBox"] call logistics_fnc_findNonVehicleType;
//diag_log format["Crate = %1",tup_logistics_crate];
tup_logistics_static = [faction player,"StaticWeapon"] call logistics_fnc_findNonVehicleType;
//diag_log format["Static = %1",tup_logistics_static];

// Define Defence Supplies that can be ordered
tup_logistics_defence = [
	"RoadBarrier_light",
	"FlagCarrierCore",
	"Hedgehog",
	"Hhedgehog_concrete",
	"Hhedgehog_concreteBig",
	"Land_fortified_nest_small",
	"Land_fortified_nest_big",
	"Land_Fort_Watchtower", 
	"Fort_Barracks_USMC",
	"Land_fort_rampart",
	"Land_fort_artillery_nest",
	"Land_fort_bagfence_long",
	"Land_fort_bagfence_round",
	"Fort_Barricade",
	"Land_CamoNet_NATO",
	"Land_fort_bagfence_corner",
	"Fort_RazorWire",
	"Land_HBarrier1",
	"Land_HBarrier3",
	"Land_HBarrier5",
	"Land_HBarrier_large",
	"Base_WarfareBBarrier5x",
	"Land_Misc_deerstand",
	"Misc_Cargo1B_military",
	"Land_Misc_Cargo1Ao",
	"Land_Misc_Cargo1B",
	"Land_Misc_Cargo1Bo",
	"Land_Misc_Cargo1C",
	"Land_Misc_Cargo1D",
	"Land_Misc_Cargo1E",
	"Land_Misc_Cargo1F",
	"Land_Misc_Cargo1G",
	"Base_WarfareBContructionSite",
	"Misc_cargo_cont_net1", 
	"Misc_cargo_cont_net2",
	"Misc_cargo_cont_net3",
	"Misc_cargo_cont_small",
	"Misc_cargo_cont_small2",
	"Misc_cargo_cont_tiny",
	"Land_Pneu",
	"Land_fort_bagfence_long",
	"Land_fort_bagfence_corner",
	"Land_fort_bagfence_round",
	"Fort_RazorWire",
	"Hedgehog_EP1",
	"Land_fortified_nest_small_EP1",
	"Land_fort_artillery_nest_EP1",
	"Land_fortified_nest_big_EP1",
	"MASH_EP1",
	"Land_CamoNet_NATO_EP1", 
	"Land_CamoNetB_NATO_EP1", 
	"Land_CamoNetVar_NATO_EP1"];
	
["player", [mso_interaction_key], -9405, ["support\modules\tup_logistics\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["Logistics Request","if(call mso_fnc_hasRadio && ((getPlayerUID player) in MSO_R_Leader)) then {createDialog ""TUP_ui_logistics""}"] call mso_core_fnc_updateMenu;