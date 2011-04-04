openMap true;
hint "Click on the map where the cow should move.";
onMapSingleClick "gc_pack_cow_move_script = [_pos] execVM ""support\modules\gc_pack_cow\client_move_script.sqf""";


/*

_move_pos = this;
gc_pack_cow_move_request = true;
gc_pack_cow_move_point = _move_pos;
publicvariable "gc_pack_cow_move_request";
publicvariable "gc_pack_cow_move_point";
gc_pack_cow_move_request = false;
onMapSingleClick "";

*/