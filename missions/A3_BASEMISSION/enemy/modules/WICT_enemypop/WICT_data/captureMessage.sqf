private ["_message","_flag"];






			for [{_i=0}, {_i<15}, {_i=_i+1}] do
				_marker = createMarker [_marker_name, getMarkerPos _flag];


				if ((_message == "OB") or (_message == "ON")) then 	{_marker_name setMarkerColor "ColorRed";};

		
				_marker_name setMarkerSize [80,80];



				sleep 0.5;
				_null =	deleteMarker _marker_name;
				sleep 0.5;
			};

		if (_message == "BO") then 		{
			hint "We've captured the base.";
 
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
 
			[] call _set_marker;
		};
		if (_message == "OB") then 
			hint "We've lost the base.";

			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;

     
			hint "We've captured neutral sector.";

			_flag setmarkertype "mil_circle";
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";


		};

			hint "Enemy has captured neutral sector.";
			_flag setMarkerColor "ColorRed";
			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;
		};
		
			hint "Enemy's base has been turned to neutral sector.";

			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";


		};
		if (_message == "NB") then 


			_flag setmarkertype "mil_circle";
			_WICT_mrk_name = "WICT_base_mkr"+ str(time);
			RMM_jipmarkers set [count RMM_jipmarkers, [_WICT_mrk_name, getMarkerPos _flag, getMarkerType _flag, ""]];
			publicvariable "RMM_jipmarkers";
			_null = [] execVM (WICT_PATH + "WICT\AI\static.sqf");
			[] call _set_marker;
		};