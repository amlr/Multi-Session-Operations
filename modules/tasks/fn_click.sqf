hint "Click on the map...";
onMapSingleClick {RMM_tasks_position = _pos; createDialog 'RMM_ui_tasks'; onMapSingleClick CRB_MAPCLICK; true};