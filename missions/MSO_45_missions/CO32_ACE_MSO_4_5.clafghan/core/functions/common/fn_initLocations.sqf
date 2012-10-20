#include <crbprofiler.hpp>

private ["_twn","_locs","_debug","_strategic","_military","_names","_hills","_initNeighbors"];
if(!isServer) exitWith{};

CRBPROFILERSTART("mso_core_fnc_initLocations")

_debug = debug_mso_loc;

_initNeighbors = {
        private ["_twn"];
        {
                _twn = _x;
                if (isnil {_twn getvariable "neighbors"}) then {
                        _twn setvariable ["neighbors",[],true];
                };
                {
                        if (_x distance _twn < 2500) then {
                                [_x,"neighbors",[_twn],true,true] call bis_fnc_variablespaceadd;
                        };
                } foreach (bis_functions_mainscope getvariable "locations");
        } foreach (bis_functions_mainscope getvariable "locations");
};

// Zargabad - lots
_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","FlatAreaCitySmall","CityCenter","Airport"];

// Zargabad - none
_military = ["HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"];

// Zargabad - 12
_names = ["NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"];

// Zargabad - none
_hills = ["Hill","ViewPoint","RockArea","BorderCrossing","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];


if (_debug) then {player globalChat "initLocs: Custom Locs(" + worldName + ")";};
[] call BIS_fnc_locations;
CRB_LOC_DIST = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition") select 0) * 2.8;
switch toLower(worldName) do {		
        case "fallujah": {
        };
        case "zargabad": {
                {createLocation ["BorderCrossing",_x,1,1]} foreach [[3430,8150,0],[2925,50,0],[3180,50,0],[5048,50,0]];
                {(createVehicle ["HeliH", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[3534.1, 3939.4], 270],
			[[4568,4124], 110],
			[[4871.61,4678.55], 143.708]
		];
                {_twn = (group bis_functions_mainscope) createUnit ["LOGIC", (_x select 0), [], 0, "NONE"]; _twn setVariable ["name", (_x select 1)];[[_twn]] call BIS_fnc_locations;} foreach [
                        [[3489,1983,0], "Shabaz"],
                        [[4053,2081,0], "East Shabaz"],
                        [[2776,3215,0], "Ab-e Shur Dam"],
                        [[4114,3582,0], "Yarum"],
                        [[4670,3860,0], "South-East Zargabad"],
                        [[4143,4872,0], "North Zargabad"],
                        [[3489,4809,0], "North-West Zargabad"],
                        [[4040,5455,0], "South Hazar Bagh"]
                ];
                [] call _initNeighbors;
        };
        case "takistan": {
                {createLocation ["Airport",_x,1,1]} foreach [[8223.19,2061.85,0],[5930.27,11448.6,0]];
                {createLocation ["Hill",_x,1,1]} foreach [[8920.66,714.553,0],[10319.4,1218.97,0],[12581.9,2178.44,0],[11685.9,991.194,0],[11618.2,4436.46,0],[11028.5,4835.42,0],[2452.82,1939.11,0],[647.538,1643.94,0],[10225.3,8232.91,0],[11674.3,6853.18,0],[12789,7618.6,0],[12184.7,6021.2,0],[1275.98,9420.36,0],[513.379,11028.7,0],[1113.06,8122.78,0],[2371.7,6577.14,0],[1060.01,6651.81,0],[4536.94,7755.62,0],[2295.62,9966.96,0],[2570.21,3192.34,0],[252.362,3600.79,0],[246.873,4723.34,0],[1339.24,4838.62,0],[239.294,8757.12,0],[12642.3,8997.8,0],[12576.9,12244.5,0],[7286.22,7497.08,0]];
                {createLocation ["VegetationBroadleaf",_x,1,1]} foreach [[9640.95,6525.55,0],[10520.5,11069.6,0],[11911.9,11404.1,0],[6560.22,8974.16,0],[6779.77,6447.93,0],[4720.27,6736.85,0],[1438.47,6471.23,0],[1792.54,7291.65,0],[1114.61,6998.03,0],[1427.67,7865.95,0],[3327.58,8157.63,0],[2817.08,7842,0],[3398.73,10150.9,0],[3754.9,10505.1,0],[4122.55,10924.5,0],[2099.97,11448.4,0],[1929.8,10896.7,0],[1295.79,10482.3,0],[771.562,10471.3,0],[1449.49,11152,0],[1636.12,11700.9,0],[4611.67,12356,0],[6060.86,10697.6,0],[5819.05,10129.8,0],[5540.54,9490.73,0],[5880.46,8095.92,0],[5899.95,6356.44,0],[5105.43,5415.11,0],[4153.31,4450.04,0],[3213.64,3635.48,0],[4155.61,2329.04,0],[6787.2,1170.57,0],[7256.12,1237.37,0],[7490.13,1797.91,0],[9947.27,2324.41,0],[11123.1,2416.85,0],[11989.9,2868.59,0],[9527.37,3125.18,0],[8554.62,2993.05,0],[7855.69,3268.79,0],[9372.79,4572.87,0],[8917.63,4224.71,0],[1002.54,3143.03,0],[919.325,4241.86,0],[2718.33,871.307,0],[5043.3,860.979,0],[5873.79,1441.81,0],[5872.73,5710.01,0],[9290.46,10049.5,0],[9300.97,9215.94,0],[9311.09,12159,0],[11603.3,10190.1,0],[12600.1,11069.8,0],[12324.8,11113.6,0]];
                {createLocation ["BorderCrossing",_x,1,1]} foreach [[2057.5239,362.24213,0],[7418.6284,44.116211,0],[11943.901,2565.1956,0],[10968.563,6296.1953,0],[11443.324,8196.7363,0],[12640.246,9830.0742,0],[12749.133,10970.265,0],[11057.035,12744.979,0],[9163.8604,12728.431,0],[7149.5513,12744.669,0],[4560.1128,12736.298,0],[2461.167,12747.017,0],[1908.5356,12610.614,0],[883.67908,10455.702,0],[33.667603,7077.9468,0],[96.891769,5524.3794,0],[242.14958,2836.0496,0]];
                {(createVehicle ["HeliH", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[8263,1800.54], 150.567],[[8222.98,1776.7,0.0101013],150.358],[[8180.42,1752.3,0.0100098],151.828],[[6046.42,10470.4,0.0102081],112.581]];
                {_twn = (group bis_functions_mainscope) createUnit ["LOGIC", (_x select 0), [], 0, "NONE"]; _twn setVariable ["name", (_x select 1)];[[_twn]] call BIS_fnc_locations;} foreach [
                        [[12313.5,11114.6,0], "x1"],
                        [[10399.5,10995.1,0], "x2"],
                        [[4170.93,10750.5,0], "x3"],
                        [[5699.74,9955.47,0], "x4"],
                        [[5952.89,10510.5,0], "x5"],
                        [[6798.94,8916.04,0], "x6"],
                        [[3232.02,3590.37,0], "x7"],
                        [[3558.18,1298.96,0], "x8"],
                        [[11835,2606.36,0], "x9"],
                        [[6825.74,12253.1,0], "x10"],
                        [[3558.18,1298.96,0], "x11"],
                        [[1994.64,363.664,0], "x12"],
                        [[375.252,2820.15,0], "x13"],
                        [[1007.07,3141.99,0], "x14"],
                        [[1491.9,3587.9,0], "x15"],
                        [[2512.47,5097.5,0], "x16"],
                        [[12318.6,10355.2,0], "x17"],
                        [[6496.12,2108.43,0], "x18"],
                        [[8999.51,1875.36,0], "x19"]
                ];
                [] call _initNeighbors;
        };
        case "chernarus": {
                {createLocation ["BorderCrossing",_x,1,1]} foreach [[48.716465,1614.6689,0],[1823.8114,5080.3926,0],[1648.1056,7808.8857,0],[1964.0529,9121.2988,0],[2257.4221,15234.31,0],[9683.6787,13556.688,0],[11955.002,13150.367,0],[13388.054,12853.484,0],[4980.04,12584.29,0]];
                {createLocation ["Airport",_x,1,1]} foreach [[12061,12642,0]];
                {(createVehicle ["HeliHCivil", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[4700.1758,10249.779], 240],[[4685.6235,10276.778], 240],[[4669.2915,10305.309], 240],[[12171.944,12639.515], 200],[[12207.261,12625.699], 200],[[4836.9639,2521.9746], 120]];
        };
        case "eden": {
                {(createVehicle ["HeliHCivil", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[4864.86,11911.2], 270],
			[[4864.86,11881.3], 270]
		];
                {(createVehicle ["HeliHRescue", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[3877,8242.5], 2]
		];
                {(createVehicle ["HeliH", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[9917.374,1566.8381], 35]
		];
                {(createVehicle ["ED102_Hangar", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[4881.6035,11835.9], 90]
		];
                {(createVehicle ["ED102_HangarOffice", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[4882.4565,11792.185], 90]
		];
                {(createVehicle ["BuoyBig", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
			[[6199.21,3287.34,-9],0],
			[[6405.95,3106.01,-9],0],
			[[7545.28,9280.17,-9],0],
			[[6727.19,9063.23,-9],0],
			[[6590.69,9330.45,-9],0],
			[[5714.9,11919.6,-9],0],
			[[3946.06,12328.4,-9],0],
			[[3846.12,10823,-9],0],
			[[3660.39,11844.1,-9],0]
		];
                [] call mso_core_fnc_createLocations;
                [] call _initNeighbors;
        };
        case "utes": {
                //{createLocation ["BorderCrossing",_x,1,1]} foreach [[2526.3879,3821.8804,0],[4024.5266,3116.47,0],[4471.8779,3149.2815,0],[3802.4563,4043.1611,0],[3502.8076,4173.7505,0],[3282.2849,4579.8604,0],[4424.123,3572.8301,0]];
                {(createVehicle ["HeliHCivil", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[3518.45,3541.0518], 0]];
                {_twn = (group bis_functions_mainscope) createUnit ["LOGIC", (_x select 0), [], 0, "NONE"]; _twn setVariable ["name", (_x select 1)]; _twn setVariable ["demography", (_x select 2)]; [[_twn]] call BIS_fnc_locations;} foreach [
                        [[2526,3821,0], "Lighthouse", ["CIV",0,"CIV_RU",1]],
                        [[2948,4532,0], "Military Base", ["CIV",0,"CIV_RU",0]],
                        [[4418,3571,0], "Hamlet", ["CIV",1,"CIV_RU",0]]
                ];
                [] call _initNeighbors;
        };
        case "clafghan": {
		[] call mso_core_fnc_createLocations;
		{createLocation ["Strategic",_x,1,1]} foreach [
			[10067.014,19293.143,0],
			[11041.672,13297.619,0],
			[11164.224,6841.0195,0],
			[12413.818,4930.1172,0],
			[15822.142,14335.856,0],
			[16739.486,6035.1978,0],
			[17818.85,7672.3008,0],
			[17968.008,13943.173,0],
			[18160.373,14811.156,0],
			[5275.5947,16795.063,0],
			[5515.4678,14053.185,0],
			[6594.6816,18242.707,0],
			[6698.6528,12678.234,0],
			[8135.2305,9595.2012,0],
			[8336.4492,15109.688,0],
			[9402.5137,4548.3428,0]
		];
		{createLocation ["VegetationBroadleaf",_x,1,1]} foreach [
			[10139.133,5568.0488,0],
			[10652.104,6012.752,0],
			[11127.783,18380.508,0],
			[11270.496,9981.624,0],
			[11275.901,14341.889,0],
			[11425.594,11280.271,0],
			[11483.186,14203.217,0],
			[11712.869,7161.8159,0],
			[11839.326,12459.104,0],
			[11846.047,2238.7263,0],
			[12319.276,19059.047,0],
			[12650.586,8832.6885,0],
			[12932.982,14857.842,0],
			[13361.572,10555.059,0],
			[13508.866,12162.171,0],
			[13914.423,5607.0039,0],
			[13959.905,14245.268,0],
			[14409.078,4161.2568,0],
			[1445.4092,10696.975,0],
			[14516.718,13089.92,0],
			[14610.742,19493.518,0],
			[14745.433,7007.1504,0],
			[15189.51,10034.2,0],
			[15588.379,10565.312,0],
			[15896.562,8023.1084,0],
			[16003.848,12234.04,0],
			[16280.553,15637.995,0],
			[16726.988,4581.6279,0],
			[16804.959,10644.029,0],
			[16863.83,8947.1846,0],
			[17254.176,13097.999,0],
			[17696.363,8499.1387,0],
			[17838.594,15334.968,0],
			[18258.4,15772.543,0],
			[1851.1833,11749.952,0],
			[1880.9563,18502.217,0],
			[18963.594,5347.2285,0],
			[1928.9139,14167.006,0],
			[19306.242,5953.7764,0],
			[2208.8318,15754.401,0],
			[2761.2002,18875.854,0],
			[2795.1238,9051.085,0],
			[3118.4248,17274.996,0],
			[3486.9375,15809.418,0],
			[3661.7507,12982.27,0],
			[4034.1953,4831.2529,0],
			[4458.4971,7390.8271,0],
			[4630.7964,12203.362,0],
			[5510.4717,8193.252,0],
			[5807.3442,10144.93,0],
			[5994.439,6667.3726,0],
			[6484.3755,3435.2107,0],
			[6746.9434,14615.439,0],
			[7316.7505,7865.6709,0],
			[7414.5337,13436.027,0],
			[7445.8242,16448.512,0],
			[7747.3179,9986.0547,0],
			[8059.2197,6050.9468,0],
			[8098.3862,11002.773,0],
			[8533.6582,2555.4707,0],
			[9120.6875,19214.68,0]
		];
		{createLocation ["FlatArea",_x,1,1]} foreach [
			[11147.155,15995.561,0],
			[11270.502,8239.7041,0],
			[11570.344,16821.361,0],
			[12493.934,13416.794,0],
			[12694.607,17236.406,0],
			[12760.732,14678.851,0],
			[14138.252,18038.861,0],
			[14580.136,12433.271,0],
			[14971.874,15907.611,0],
			[15464.44,11446.961,0],
			[1616.5166,18035,0],
			[16636.68,7045.9531,0],
			[17068.063,19289.402,0],
			[18431.051,8837.2568,0],
			[18669.395,11196.946,0],
			[19535.834,17108.42,0],
			[19935.746,15851.761,0],
			[2342.0889,14909.376,0],
			[3313.7388,4272.5835,0],
			[4094.0603,13834.13,0],
			[4646.5024,17243.605,0],
			[4764.5615,18228.109,0],
			[5254.3901,20067.617,0],
			[5434.8511,11303.258,0],
			[5459.0415,6115.3906,0],
			[8811.0039,16748.85,0],
			[8919.9424,6755.9922,0]
		];
                {createLocation ["Airport",_x,1,1]} foreach [[15493.888,858.08838,0]];
                {(createVehicle ["HeliHCivil", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[4700.1758,10249.779], 240],[[4685.6235,10276.778], 240],[[4669.2915,10305.309], 240],[[12171.944,12639.515], 200],[[12207.261,12625.699], 200],[[4836.9639,2521.9746], 120]];
                [] call _initNeighbors;		
        };
        case "lingor": {
                {(createVehicle ["HeliH", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[919,9214], 0],[[6478,6093], 0],[[2650,6819], 0],[[3709,4189], 0],[[2988.33,6640.74],264.161],[[2650,6819], 264]];
                {(createVehicle ["HeliHCivil", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[3063.16,7974.41], 93], [[5135,6799], 0], [[5928,6798], 0], [[4237,6791], 20], [[3348,3589], 45],[[4191.1,1429.85],270],[[4191.27,1524],270],[[6493.83,6909.81],180],[[6581.21,6909.99],180],[[6626.48,6909.99],180]];
                {(createVehicle ["HeliHRescue", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [[[6846,6461], 90],[[6863.47,4452],92.293]];
        };
        case "tup_qom": {
                [] call mso_core_fnc_createLocations;
                {(createVehicle ["HeliH", (_x select 0), [],0,'NONE']) setDir (_x select 1);} foreach [
					[[1636.63,7338.07], 0],
					[[4311.03,8714.72], 4],
					[[1827.21,7392.98], 0],
					[[7067.62,4376.49], 4],
					[[844.725,6417.14],-60],
					[[2029.56,7729.28],-60],
					[[3488.31,4151.53],-27],
					[[5567.3,7011.71],160.581],
					[[2879.46,9187.48],10],
					[[2831.94,9206.63],10],
					[[2780.88,9227.2],10],
					[[2726.26,9248.48],10],
					[[2663.85,9272.59],10]
				];               
        };
       
        case "torabora": {
                [] call mso_core_fnc_createLocations;
                [] call _initNeighbors;
        };
       
        default {
                [] call mso_core_fnc_createLocations;
                [] call _initNeighbors;
        };
};

if (_debug) then {player globalChat "initLocs: Find Locs";};
_locs = [];
{
        _locs = _locs + nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), _x , CRB_LOC_DIST];
} forEach [_strategic, _military, _hills, _names];

if (_debug) then {
        player globalChat format["initLocs: Mark Locs(%1)", count _locs];
        private["_t","_m"];
        {
                _t = format["l%1",floor(random 10000)];
                _m = createMarker [_t, position _x];
                _m setMarkerType "Dot";
                _m setMarkerText str (type _x);
                
                switch(type _x) do {
                        case "NameCityCapital": {
                                _m setMarkerColor "ColorBlue";
                        };
                        case "NameCity": {
                                _m setMarkerColor "ColorBlue";
                        };
                        case "CityCenter": {
                                _m setMarkerColor "ColorBlue";
                        };
                        case "NameVillage": {
                                _m setMarkerColor "ColorBlue";
                        };
                        case "NameLocal": {
                                _m setMarkerColor "ColorBlue";
                        };
                        case "StrongpointArea": {
                                _m setMarkerColor "ColorGreen";
                        };
                        case "FlatArea": {
                                _m setMarkerColor "ColorGreen";
                        };
                        case "FlatAreaCitySmall": {
                                _m setMarkerColor "ColorGreen";
                        };
                        case "Hill": {
                                _m setMarkerColor "ColorGreen";
                        };
                        case "VegetationBroadleaf": {
                                _m setMarkerColor "Default";
                        };
                        case "VegetationFir": {
                                _m setMarkerColor "Default";
                        };
                        case "VegetationPalm": {
                                _m setMarkerColor "Default";
                        };
                        case "VegetationVineyard": {
                                _m setMarkerColor "Default";
                        };
                        case "BorderCrossing": {
                        };
                        case "Airport": {
                                _m setMarkerType "Airport";
                        };
                };
                
        } forEach _locs;
};

if (_debug) then {player globalChat format["initLocs: Shuffle Locs(%1)", count _locs];};
_locs = [_locs] call CBA_fnc_shuffle;

diag_log format["MSO-%1 Initialise Locations (%2)", time, count _locs];

CRBPROFILERSTOP

_locs;

