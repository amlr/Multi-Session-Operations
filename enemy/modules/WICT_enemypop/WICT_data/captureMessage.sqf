private ["_message","_flag"];
_message = _this select 0;
_flag = _this select 1;
_set_marker = {		_marker_ID = str(random 100);
			_marker_name = "";
			call compile format ["_marker_name = ""marker%1"";",_marker_ID];
		
			for [{_i=0}, {_i<15}, {_i=_i+1}] do	{
				_marker = createMarker [_marker_name, getMarkerPos _flag];

				if ((_message == "BO") or (_message == "BN")) then 	{_marker_name setMarkerColor "ColorBlue";};
				if ((_message == "OB") or (_message == "ON")) then 	{_marker_name setMarkerColor "ColorRed";};
				if ((_message == "NO") or (_message == "NB")) then 	{_marker_name setMarkerColor "ColorBlack";};
		
				_marker_name setMarkerSize [80,80];
				_marker_name setMarkerShape "ELLIPSE";
				_marker_name setMarkerBrush "SOLID";
		
				sleep 0.5;
				_null =	deleteMarker _marker_name;
				sleep 0.5;
			};
		};
		if (_message == "BO") then 		{
			hint "We've captured the base.";
 			_flag setMarkerColor "ColorBlue";
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
 			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;
		};		
		if (_message == "OB") then 		{
			hint "We've lost the base.";
			_flag setMarkerColor "ColorRed";
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;
		};
     		if (_message == "BN") then 		{			
			hint "We've captured neutral sector.";
			_flag setMarkerColor "ColorBlue";
			_flag setmarkertype "mil_circle";
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;		
		};
		if (_message == "ON") then 		{
			hint "Enemy has captured neutral sector.";
			_flag setMarkerColor "ColorRed";
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;		
		};
		if (_message == "NO") then 		{
			hint "Enemy's base has been turned to neutral sector.";
			_flag setMarkerColor "ColorBlack";
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;		
		};
		if (_message == "NB") then 		{
			hint "Our base has been turned to neutral sector.";
			_flag setMarkerColor "ColorBlack";
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;		
		};
