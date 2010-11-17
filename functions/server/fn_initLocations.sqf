if(!isServer) exitWith{};

private ["_debug", "_dist", "_locs", "_mount", "_strategic", "_military", "_names", "_hills"];
_debug = false;
_dist = 20000;

_mount = ["Mount"];

// Zargabad - lots
_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","FlatAreaCitySmall","CityCenter","Airport"];

// Zargabad - none
_military = ["HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"];

// Zargabad - 12
_names = ["NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"];

// Zargabad - none
_hills = ["Hill","ViewPoint","RockArea","BorderCrossing","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];



switch(worldName) do {		
	case "Zargabad": {
//		{createLocation ["BorderCrossing",_x,1,1]} foreach [[3430,8150],[2925,50],[3180,50],[5048,50]];
		_dist = 4096;
	};
	case "Takistan": {
		{createLocation ["Airport",_x,1,1]} foreach [[8223.19,2061.85,0],[5930.27,11448.6,0]];
		{createLocation ["Hill",_x,1,1]} foreach [[8920.66,714.553,0],[10319.4,1218.97,0],[12581.9,2178.44,0],[11685.9,991.194,0],[11618.2,4436.46,0],[11028.5,4835.42,0],[2452.82,1939.11,0],[647.538,1643.94,0],[10225.3,8232.91,0],[11674.3,6853.18,0],[12789,7618.6,0],[12184.7,6021.2,0],[1275.98,9420.36,0],[513.379,11028.7,0],[1113.06,8122.78,0],[2371.7,6577.14,0],[1060.01,6651.81,0],[4536.94,7755.62,0],[2295.62,9966.96,0],[2570.21,3192.34,0],[252.362,3600.79,0],[246.873,4723.34,0],[1339.24,4838.62,0],[239.294,8757.12,0],[12642.3,8997.8,0],[12576.9,12244.5,0],[7286.22,7497.08,0]];
		{createLocation ["CityCenter",_x,1,1]} foreach [[12313.5,11114.6,0],[10399.5,10995.1,0],[4170.93,10750.5,0],[5699.74,9955.47,0],[5952.89,10510.5,0],[6798.94,8916.04,0],[3232.02,3590.37,0],[3558.18,1298.96,0],[11835,2606.36,0],[6825.74,12253.1,0],[3558.18,1298.96,0],[1994.64,363.664,0],[375.252,2820.15,0],[1007.07,3141.99,0],[1491.9,3587.9,0],[2512.47,5097.5,0],[12318.6,10355.2,0],[6496.12,2108.43,0],[8999.51,1875.36,0]];
		{createLocation ["VegetationBroadleaf",_x,1,1]} foreach [[9640.95,6525.55,0],[10520.5,11069.6,0],[11911.9,11404.1,0],[6560.22,8974.16,0],[6779.77,6447.93,0],[4720.27,6736.85,0],[1438.47,6471.23,0],[1792.54,7291.65,0],[1114.61,6998.03,0],[1427.67,7865.95,0],[3327.58,8157.63,0],[2817.08,7842,0],[3398.73,10150.9,0],[3754.9,10505.1,0],[4122.55,10924.5,0],[2099.97,11448.4,0],[1929.8,10896.7,0],[1295.79,10482.3,0],[771.562,10471.3,0],[1449.49,11152,0],[1636.12,11700.9,0],[4611.67,12356,0],[6060.86,10697.6,0],[5819.05,10129.8,0],[5540.54,9490.73,0],[5880.46,8095.92,0],[5899.95,6356.44,0],[5105.43,5415.11,0],[4153.31,4450.04,0],[3213.64,3635.48,0],[4155.61,2329.04,0],[6787.2,1170.57,0],[7256.12,1237.37,0],[7490.13,1797.91,0],[9947.27,2324.41,0],[11123.1,2416.85,0],[11989.9,2868.59,0],[9527.37,3125.18,0],[8554.62,2993.05,0],[7855.69,3268.79,0],[9372.79,4572.87,0],[8917.63,4224.71,0],[1002.54,3143.03,0],[919.325,4241.86,0],[2718.33,871.307,0],[5043.3,860.979,0],[5873.79,1441.81,0],[5872.73,5710.01,0],[9290.46,10049.5,0],[9300.97,9215.94,0],[9311.09,12159,0],[11603.3,10190.1,0],[12600.1,11069.8,0],[12324.8,11113.6,0]];
		_dist = 8000;
	};
};

_locs = nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), _strategic + _names + _hills + _military, _dist];
if (_debug) then {
	{
		_t = format["l%1",random 10000];
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
				_m setMarkerColor "ColorRed";
			};
			case "FlatArea": {
				_m setMarkerColor "ColorRed";
			};
			case "FlatAreaCitySmall": {
				_m setMarkerColor "ColorRed";
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

_locs;