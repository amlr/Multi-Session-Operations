
private ["_find_stuff","_type_array_m","_type_array_c","_type_array_e","_tmp_array","_obj_array","_clusters","_clusters_m","_clusters_c"];
_find_stuff = {
        private ["_obj_array","_type","_color"];
        _type = _this select 0;
        _color = _this select 1;
        _obj_array = [_type] call MSO_fnc_getObjectsByType;
        {
                [str _x, getPosATL _x, "Icon", [0.5, 0.5],"TYPE:", "Dot", "COLOR:", _color, "TEXT:", _type] call CBA_fnc_createMarker;
        } forEach _obj_array;
};

_type_array_m = [
        ["barrack2","ColorBlue"],
        ["mil_barracks.p3d","ColorBlue"],
        ["mil_barracks_l","ColorBlue"],
        ["mil_barracks_i","ColorBlue"],
        
        ["shed_02","ColorOrange"], // Compound shed
        ["vez.p3d","ColorOrange"] // Watchtowers
];

_type_array_c = [
        // Civilian Infrastructure
        ["controltower","ColorGreen"],
        ["mil_house","ColorGreen"],
        ["ss_hangar","ColorGreen"],
        ["lighthouse","ColorGreen"],
        ["nav_pier_m_end","ColorGreen"],
        ["housev2_04_interier","ColorGreen"], // Administrative Office
        ["housev_2i","ColorGreen"], // Administrative building*/
        ["boathouse","ColorGreen"],
        ["barn","ColorGreen"]
];

_type_array_e = [
        // Electrical Infrastructure
        ["powline","ColorYellow"],
        ["trafostanica","ColorYellow"],
        ["PowerStation","ColorYellow"],
        ["Pec_03a","ColorYellow"],
        ["sloup_vn","ColorYellow"]
];

{
        _x call _find_stuff;
} forEach _type_array_m + _type_array_c;

_tmp_array = [];
{
        _tmp_array set [count _tmp_array, _x select 0];
} forEach _type_array_m;

_obj_array = _tmp_array call MSO_fnc_getObjectsByType;
_clusters_m = [_obj_array] call MSO_fnc_findClusters;

_tmp_array = [];
{
        _tmp_array set [count _tmp_array, _x select 0];
} forEach _type_array_c;

_obj_array = _tmp_array call MSO_fnc_getObjectsByType;
_clusters_c = [_obj_array] call MSO_fnc_findClusters;

_clusters = [_clusters_m, _clusters_c] call MSO_fnc_consolidateClusters;
{
        private["_nodes"];
        _nodes = _x getVariable "ClusterNodes";
        if(count _nodes > 0) then {
                _x setPos ([_nodes] call MSO_fnc_findClusterCenter);
        };
        
} forEach (_clusters select 0) + (_clusters select 1);

{
        private["_max","_center"];
        _max = 0;
        _center = _x;
        [str _x, getPosATL _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorRed", "TEXT:", format["Cluster Center #%1", _forEachIndex]] call CBA_fnc_createMarker;
        {
                if(_x distance _center > _max) then {_max = _x distance _center ;};
        } forEach (_center getVariable "ClusterNodes");
        [str _x + "_0", getPosATL _x, "Ellipse", [_max, _max], "COLOR:", "ColorRed"] call CBA_fnc_createMarker;
} forEach (_clusters select 0);

{
        private["_max","_center"];
        _max = 0;
        _center = _x;
        [str _x, getPosATL _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorYellow", "TEXT:", format["Cluster Center #%1", _forEachIndex]] call CBA_fnc_createMarker;
        {
                if(_x distance _center > _max) then {_max = _x distance _center ;};
        } forEach (_center getVariable "ClusterNodes");
        [str _x + "_0", getPosATL _x, "Ellipse", [_max, _max], "COLOR:", "ColorYellow"] call CBA_fnc_createMarker;
} forEach (_clusters select 1);
