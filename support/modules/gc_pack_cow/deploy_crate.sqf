private ["_distance", "_ref_create_class", "_reference_crate"];

_distance = (getmarkerpos gc_pack_cow_ammo_storage) distance gc_pack_cow_ammo_crate;
// make sure crate is already not deployed, if so exit with message.
if (_distance > 5) exitWith 
	{
	hint "Invalid action. The ammo crate is already deployed.";
	};

hint "Deploying crate...";
// create and attach reference crate for deployment position...
_ref_create_class = typeof gc_pack_cow_ammo_crate;
_reference_crate = _ref_create_class createvehicle (getmarkerpos "gc_pack_cow_object_generation_marker");
_reference_crate attachto [gc_pack_cow,[0,-5,0]];
sleep 1;
_crate_pos = getpos _reference_crate;
detach _reference_crate;
sleep 1;
deletevehicle _reference_crate;

// move ammo crate to new position.
gc_pack_cow_ammo_crate setpos [_crate_pos select 0, _crate_pos select 1, 0];
hint "Ammo crate deployed.";