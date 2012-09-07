// ----------------------------------------------------------------------------

#include <script_macros_core.hpp>
SCRIPT(test_clusters);

// ----------------------------------------------------------------------------

private ["_result","_expected","_err","_obj_array","_point","_center","_clusters"];

LOG("Testing Clusters");

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("MSO_fnc_getObjectsByType","");
ASSERT_DEFINED("MSO_fnc_getNearestObjectInCluster","");
ASSERT_DEFINED("MSO_fnc_findClusterCenter","");
ASSERT_DEFINED("MSO_fnc_chooseInitialCenters","");
ASSERT_DEFINED("MSO_fnc_assignPointsToClusters","");
ASSERT_DEFINED("MSO_fnc_findClusters","");

// Create mock objects
_obj_array = [];
createCenter sideLogic;
{
        _obj_array set [count _obj_array, (createGroup sideLogic) createUnit ["LOGIC", (player modelToWorld _x), [], 0, "NONE"]];
} forEach [
        [-1200,-900],
        [-900,-600],
        [-600,-900],
        [300,0],
        [300,1200],
        [600,900],
        [900,600],
        [900,300]
];
_err = "create mock objects";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array == 8,_err);
{
        [str _x, position _x, "Icon", [1, 1],"TYPE:", "Dot"] call CBA_fnc_createMarker;
} forEach _obj_array;

// Test finding nearest object from cluster
_point = _obj_array select 0;
_result = [_point, _obj_array] call MSO_fnc_getNearestObjectInCluster;
_expected = _obj_array select 1;
_err = "getNearestObjectInCluster #1";
ASSERT_TRUE(_result  == _expected, _err);
(str _point) setMarkerColor "ColorBlue";
(str _result) setMarkerColor "ColorBlue";
[_result, _point] call mso_fnc_createLink;

_point = _obj_array select 6;
_result = [_point, _obj_array] call MSO_fnc_getNearestObjectInCluster;
_expected = _obj_array select 7;
_err = "getNearestObjectInCluster #2";
ASSERT_TRUE(_result == _expected, _err);
(str _point) setMarkerColor "ColorBlue";
(str _result) setMarkerColor "ColorBlue";
[_result, _point] call mso_fnc_createLink;

// Test finding centre of cluster of objects
_center = [_obj_array] call MSO_fnc_findClusterCenter;
_err = "cluster center";
ASSERT_DEFINED("_center",_err);
ASSERT_TRUE(typeName _center == "ARRAY", _err);
ASSERT_TRUE(count _center == 2,_err);
[str _center, _center, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorOrange", "TEXT:","Cluster Center"] call CBA_fnc_createMarker;

// Find initial cluster seed centres
_clusters = [_obj_array] call MSO_fnc_chooseInitialCenters;
_err = "cluster center";
ASSERT_DEFINED("_clusters",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
        [str _x, position _x, "Icon", [1, 1],"TYPE:", "Dot","COLOR:","ColorYellow", "TEXT:", format["Cluster Center #%1", _forEachIndex]] call CBA_fnc_createMarker;
} forEach _clusters;

// Reassign objects to nearest cluster #1
[_clusters, _obj_array] call MSO_fnc_assignPointsToClusters;
_err = "cluster reassignment #1";
ASSERT_DEFINED("_clusters",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
        _x setPos ([_x getVariable "ClusterNodes"] call MSO_fnc_findClusterCenter);
        str _x setMarkerPos position _x;
} forEach _clusters;

// Reassign objects to nearest cluster #2
[_clusters, _obj_array] call MSO_fnc_assignPointsToClusters;
_err = "cluster reassignment #2";
ASSERT_DEFINED("_clusters",_err);
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
        _x setPos ([_x getVariable "ClusterNodes"] call MSO_fnc_findClusterCenter);
        str _x setMarkerPos position _x;
} forEach _clusters;

// Run same exercise using the findClusters function
_clusters = [_obj_array] call MSO_fnc_findClusters;
_err = "finding clusters";
ASSERT_TRUE(typeName _clusters == "ARRAY", _err);
ASSERT_TRUE(count _clusters == ceil(sqrt(count _obj_array / 2)),_err);
{
        [str _x, position _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorYellow", "TEXT:", format["Cluster Center #%1", _forEachIndex]] call CBA_fnc_createMarker;
} forEach _clusters;

nil;
