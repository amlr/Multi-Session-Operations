private ["_distance"];

_distance = (getmarkerpos gc_pack_cow_ammo_storage) distance gc_pack_cow_ammo_crate;
// make sure crate is already not deployed, if so exit with message.
if (_distance < 5) exitWith 
	{
	hint "Invalid action. The ammo crate is already loaded.";
	};

gc_pack_cow_ammo_crate setpos (getmarkerpos "gc_pack_cow_ammo_storage");
hint "Ammo crate loaded.";