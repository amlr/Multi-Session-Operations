if(!isServer) exitWith {};

 _rtp = position HQ;
 _rtp = [_rtp,2,50,2,0,2,0] call BIS_fnc_findSafePos;

return_point_west = createmarkerlocal ["return_point_west",[(_rtp select 0),(_rtp select 1)]];
return_point_west setmarkershapelocal "ICON";
return_point_west setmarkercolorlocal "ColorBlue";
"return_point_west" setMarkerTypelocal "WAYPOINT";
 