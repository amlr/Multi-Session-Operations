if (!isdedicated) then {
	_fnc_getpack = {
		if (!isnull (unitBackpack player)) then {
			removeBackpack player;
		};
		player addBackpack _this;
	};

	_this addaction ["Get Assault Pack",CBA_fnc_actionArgument_path,["US_Assault_Pack_EP1",_fnc_getpack,false]];
	_this addaction ["Get Patrol Pack",CBA_fnc_actionArgument_path,["US_Patrol_Pack_EP1",_fnc_getpack,false]];
	_this addaction ["Get LRP Pack",CBA_fnc_actionArgument_path,["US_Backpack_EP1",_fnc_getpack,false]];
	_this addaction ["Get Radio",CBA_fnc_actionArgument_path,["US_UAV_Pack_EP1",_fnc_getpack,false]];
};