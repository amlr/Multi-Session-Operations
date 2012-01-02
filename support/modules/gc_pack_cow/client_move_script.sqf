_move_pos = _this select 0;
gc_pack_cow_move_point = _move_pos;
gc_pack_cow_move_request = true;
publicvariable "gc_pack_cow_move_request";
publicvariable "gc_pack_cow_move_point";
onMapSingleClick "";
openMap false;
hint "Move order issued.";