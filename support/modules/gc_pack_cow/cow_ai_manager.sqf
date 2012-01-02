while {alive gc_pack_cow} do 
	{
	if (gc_pack_cow_order_cow_stop) then 
		{
		gc_pack_cow disableAI "MOVE";
		gc_pack_cow_order_cow_stop = false;
		};
	sleep 1;
	};