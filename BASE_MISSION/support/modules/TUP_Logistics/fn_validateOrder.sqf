#include "\x\cba\addons\main\script_macros_mission.hpp"

private ["_invalid"];

// Validate logistics order
_invalid = false;
isClicked = false;

if (count tup_logistics_order > 0) then {
	
	tup_logistics_delivery_sel = lbCurSel 11; 
	
	if ( (({(_x select 1) iskindof "Tank"} count tup_logistics_order) > 0) && (tup_logistics_delivery_sel == 1) ) then {
		// Tank cannot be airlifted
		["Logistics Request","Tanks cannot be airlifted. Select paradrop or convoy, or remove from your order."] call mso_core_fnc_sendHint;
		_invalid = true;
	};
	
	if ( (({(_x select 1) in tup_logistics_defense} count tup_logistics_order) > 0) && (tup_logistics_delivery_sel == 2) ) then {
		// Defense supplies cannot be delivered by convoy
		["Logistics Request","Defense Supplies cannot be delivered via convoy. Select paradrop or airlift, or remove from your order."] call mso_core_fnc_sendHint;
		_invalid = true;
	};
	
	if !(_invalid) then {
		closedialog 0;
		0 call logistics_fnc_call;
	};

} else {
	["Logistics Request","You need to add items to your order to proceed."] call mso_core_fnc_sendHint;
};

