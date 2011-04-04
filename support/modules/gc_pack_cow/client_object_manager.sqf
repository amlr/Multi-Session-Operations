private ["_object_generation_point", "_gc_ammo_cow_cart", "_cow_alive", "_ammo_storage_point", "_ref_ammo_storage_point", "_gc_ref_crate", "_ammo_stored"];

_ammo_stored = false;
_ammo_storage_point = getmarkerpos "gc_pack_cow_ammo_storage";
_ref_ammo_storage_point = getmarkerpos "gc_pack_cow_ref_crate_storage";
// check if cow is alive...
if (alive gc_pack_cow) then 
	{
	_cow_alive = true;
	};
_object_generation_point = getmarkerpos "gc_pack_cow_object_generation_marker";

// Create Ammo crate and reference crate and attach to cow if he's alive.
if (_cow_alive) then 
	{
	// create cow's cart.
	_gc_ammo_cow_cart = "Land_transport_cart_EP1" createvehiclelocal _object_generation_point;
	sleep 1; // wait for object to initialize.
	_gc_ammo_cow_cart attachto [gc_pack_cow,[0,-1,1]];
	_gc_ammo_cow_cart setdir 180;
	_gc_ammo_cow_cart setVectorUp [0,-5,10];
	sleep 1;
	// create reference crate
	_gc_ref_crate = "GuerillaCacheBox_EP1" createvehiclelocal _object_generation_point;
	clearmagazinecargo _gc_ref_crate;
	clearweaponcargo _gc_ref_crate;
	};

while {_cow_alive} do 
	{
	// check if cow is dead, if so delete ammo crate.
	if (!alive gc_pack_cow) then 
		{
		detach _gc_ammo_cow_cart;
		detach _gc_ref_crate;
		sleep 1; // wait for detatch to occur...
		deletevehicle _gc_ammo_cow_cart;
		deletevehicle _gc_ref_crate;
		_cow_alive = false;
		};
	// Check if crate is loaded
	_crate_distance = gc_pack_cow_ammo_crate distance _ammo_storage_point;
	if (_crate_distance > 5) then 
		{
		if (!(_ammo_stored)) then 
			{
			// ammo crate is stored, position at storage
			_ammo_stored = true;
			detach _gc_ref_crate;
			_gc_ref_crate setpos _ref_ammo_storage_point;
			};
		};
	if (_crate_distance < 5) then 
		{
		// ammo crate is deployed.
		_gc_ref_crate attachto [gc_pack_cow,[0,-1.6,1.6]];
		_gc_ref_crate setVectorUp [0,-5,10];
		_ammo_stored = false;
		};
	sleep 1;
	};