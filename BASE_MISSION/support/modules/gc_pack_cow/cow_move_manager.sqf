while {alive gc_pack_cow} do 
	{
	if (gc_pack_cow_move_request) then 
		{
		gc_pack_cow enableAI "MOVE";
		gc_pack_cow moveto gc_pack_cow_move_point;
		gc_pack_cow_move_request = false;	
		};
	sleep 1;
	};