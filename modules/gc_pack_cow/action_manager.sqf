private ["_act_id_deploy_crate", "_act_id_load_crate", "_distance"];
_act_id_deploy_crate = 9999;
_act_id_load_crate = 9999;

_act_id_move_cow = gc_pack_cow  addaction ["Move Cow", "modules\gc_pack_cow\move_cow.sqf", "", 0, false, true, "", ""];
_act_id_stop_cow = gc_pack_cow  addaction ["Stop Cow", "modules\gc_pack_cow\stop_cow.sqf", "", 0, false, true, "", ""];

while {alive gc_pack_cow} do 
	{
	// check conditions to add actions...
	// add action to deploy ammo crate...
	_distance = (getmarkerpos "gc_pack_cow_ammo_storage") distance gc_pack_cow_ammo_crate;
	if (_distance < 5) then 
		{
		if (_act_id_deploy_crate == 9999) then 
			{
			_act_id_deploy_crate = gc_pack_cow addaction ["Deploy Ammo Crate", "modules\gc_pack_cow\deploy_crate.sqf", "", 0, false, true, "", ""];
			};
		};
	// add action to load crate...
	_distance = (getmarkerpos "gc_pack_cow_ammo_storage") distance gc_pack_cow_ammo_crate;
	if (_distance > 5) then 
		{
		if (_act_id_load_crate == 9999) then 
			{
			_act_id_load_crate = gc_pack_cow addaction ["Load Ammo Crate", "modules\gc_pack_cow\load_crate.sqf", "", 0, false, true, "", ""];
			};
		};
	
	// check conditions to remove actions...
	// remove action to deploy ammo crate...
	_distance = (getmarkerpos "gc_pack_cow_ammo_storage") distance gc_pack_cow_ammo_crate;
	if (_distance > 5) then 
		{
		if (_act_id_deploy_crate != 9999) then 
			{
			gc_pack_cow removeaction _act_id_deploy_crate;
			_act_id_deploy_crate = 9999;
			};
		};
	// remove action to load crate...
	_distance = (getmarkerpos "gc_pack_cow_ammo_storage") distance gc_pack_cow_ammo_crate;
	if (_distance < 5) then 
		{
		if (_act_id_load_crate != 9999) then 
			{
			gc_pack_cow removeaction _act_id_load_crate;
			_act_id_load_crate = 9999;
			};
		};
	sleep 1;
	};

// remove actions if added...
if (_act_id_load_crate != 9999) then 
		{
		gc_pack_cow removeaction _act_id_load_crate;
		_act_id_load_crate = 9999;
		};

if (_act_id_deploy_crate != 9999) then 
	{
	gc_pack_cow removeaction _act_id_deploy_crate;
	_act_id_deploy_crate = 9999;
	};

gc_pack_cow removeaction _act_id_move_cow;
gc_pack_cow removeaction _act_id_stop_cow;