_string = format ["%1/%2 %3 - %4",(date select 2),(date select 1),([daytime] call BIS_fnc_timeToString),(ctrlText 2)];
_name = "mkr" + str(random time + 1);
_mkr = createMarker [_name, RMM_jipmarkers_position];
_mkr setmarkertype (RMM_jipmarkers_types select (lbCurSel 1));
_mkr setmarkertext _string;
RMM_jipmarkers set [count RMM_jipmarkers, [_name, getMarkerPos _mkr, getMarkerType _mkr, _string]];
publicvariable "RMM_jipmarkers";