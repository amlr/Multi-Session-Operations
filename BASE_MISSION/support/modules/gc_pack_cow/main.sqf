// The following code is join in progress compatiable init.sqf scripting.
// Client side scripts should be run in the first two sections
// The first two sections are identical and may appear redundent, but are required for Join in progress compatability in multiplayer.
// The final section is for server side scripts.

if(isNil "gc_pack_cow") exitWith{};

//non-JIP player, someone who's went through role selection and briefing
if (!(isNull player)) then 
	{
	// =============================================================
	// GC Ammo Cow Script

	gc_script_pack_cow_client_object_manager = execVM "support\modules\gc_pack_cow\client_object_manager.sqf";
	gc_script_pack_cow_client_action_manager = execVM "support\modules\gc_pack_cow\action_manager.sqf";

	gc_pack_cow_move_request = false;
	gc_pack_cow_order_cow_stop = false;
	gc_pack_cow_move_point = [0,0,0];

	// End GC Ammo Cow Script
	// =============================================================
	};

//JIP player, role selection then right into mission.
if (!isServer && isNull player) then 
	{
	waitUntil {!isNull player};

	// =============================================================
	// GC Ammo Cow Script

	gc_script_pack_cow_client_object_manager = execVM "support\modules\gc_pack_cow\client_object_manager.sqf";
	gc_script_pack_cow_client_action_manager = execVM "support\modules\gc_pack_cow\action_manager.sqf";

	gc_pack_cow_move_request = false;
	gc_pack_cow_order_cow_stop = false;
	gc_pack_cow_move_point = [0,0,0];

	// End GC Ammo Cow Script
	// =============================================================
	};

//server
if (isServer) then 
	{
	gc_pack_cow disableAI "MOVE";
	gc_pack_cow_move_request = false;
	gc_pack_cow_order_cow_stop = false;
	gc_pack_cow_move_point = [0,0,0];

	gc_script_pack_cow_client_move_manager = execVM "support\modules\gc_pack_cow\cow_move_manager.sqf";
	gc_script_pack_cow_client_ai_manager = execVM "support\modules\gc_pack_cow\cow_ai_manager.sqf";
	};