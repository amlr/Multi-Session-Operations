scriptName "DynO\data\scripts\compositions\checkpoint1_us.sqf";
private ["_objs"];
_objs =
[
	["Land_CncBlock",[-0.0925293,0.0700684,0.000175476],19.1602,1,0],
	["Land_coneLight",[-1.88623,-1.17358,7.24792e-005],111.852,1,0],
	["Land_CncBlock",[2.40747,-0.790039,0.000167847],19.9974,1,0],
	["Land_CncBlock",[-2.63281,1.02002,0.000177383],20.0961,1,0],
	["Land_Fort_Watchtower",[1.7334,2.98608,-0.0123386],289.18,1,0],
	["Land_CncBlock",[-3.34985,-1.16016,-9.53674e-006],358.88,1,0],
	["Land_BagFenceLong",[-1.49951,3.8584,0.0221252],111.051,1,0],
	["Land_CncBlock",[4.95776,-1.61011,5.72205e-006],16.0257,1,0],
	["Land_CncBlock",[-5.88257,-0.76001,0.000120163],19.7289,1,0],
	["Land_BagFenceLong",[-6.11914,1.08887,0.0429344],109.201,1,0],
	["Land_CncBlock",[-6.53857,1.06909,0.000394821],108.806,1,0],
	["Land_CncBlock",[-5.78857,3.58911,0.00038147],107.879,1,0],
	["Land_CncBlock",[-3.50293,-7.09985,1.90735e-005],20.4696,1,0],
	//["Fort_RazorWire",[-7.76343,1.43604,-0.019268],109.133,1,0],
	["Land_fort_bagfence_long",[-5.01343,6.36279,0.000907898],107.438,1,0],
	["Land_CncBlock",[3.00122,-7.80054,0.000171661],111.458,1,0],
	["Land_CncBlock",[8.24976,-2.22998,2.86102e-005],1.75733,1,0],
	["Land_CncBlock",[-6.00269,-6.12988,-3.8147e-005],21.3571,1,0],
	["Land_HBarrier3",[4.69824,8.56396,0.0305729],108.432,1,0],
	["Paleta1",[-6.16992,6.66699,8.2016e-005],20.872,1,0],
	["Land_CncBlock",[9.27246,-1.10669,9.91821e-005],63.2317,1,0],
	["Fort_RazorWire",[4.2312,-8.85449,-0.00309181],108.212,1,0],
	["FoldTable",[-3.54614,-8.88403,8.01086e-005],20.4991,1,0],
	["SearchLight",[-8.29004,4.79028,-0.075037],220.296,1,0],
	["Land_CncBlock_D",[-8.85986,3.76147,0.0004673],199.675,1,0],
	["Land_HBarrier3",[3.48877,9.1875,-0.0278587],197.732,1,0],
	["Land_fort_bagfence_long",[-5.6123,-8.16675,0.000228882],110.017,1,0],
	["Land_CncBlock",[-8.43237,-5.29004,-4.00543e-005],18.4081,1,0],
	["Barrel1",[6.80005,-7.37598,5.91278e-005],48.7262,1,0],
	["Land_CncBlock",[7.51733,-6.6897,-3.62396e-005],20.7373,1,0],
	["FoldChair",[-4.03516,-9.58496,9.72748e-005],162.044,1,0],
	["Land_HBarrier3",[-1.84375,11.0112,0.0364189],21.2453,1,0],
	["Land_fortified_nest_small",[-4.72754,10.7205,0.0543346],109.649,1,0],
	["Land_fortified_nest_small",[0.485596,-10.4338,-0.00617599],197.906,1,0],
	["Land_HBarrier_large",[1.90503,10.9304,0.00792122],200.749,1,0],
	["RoadBarrier_long",[-10.9956,2.49463,0.00158691],292.353,1,0],
	["Land_CncBlock",[-10.9524,-4.41016,-4.00543e-005],19.2623,1,0],
	["cwr2_JeepWreck3",[11.4644,-1.08374,-0.512926],146.994,1,0],
	["Land_CncBlock",[-11.3027,4.62988,0.000114441],20.6212,1,0],
	["Land_CncBlock",[6.21729,-10.7598,-4.00543e-005],19.7926,1,0],
	["Land_Toilet",[4.2771,11.2178,-0.0223408],200.037,1,0],
	["Land_Toilet",[5.34351,10.7888,-0.0202656],200.421,1,0],
	["Land_CncBlock",[12.6384,1.04004,0.000162125],12.5184,1,0],
	["Land_CncBlock",[10.1077,-7.70996,-4.00543e-005],18.6213,1,0],
	["MetalBucket",[2.67188,12.7585,0.0273476],284.334,1,0],
	["Paleta1",[3.021,12.7241,0.000358582],283.911,1,0],
	["Land_Barrel_water",[3.33008,12.76,0.23139],274.468,1,0],
	["HMMWV_Armored",[8.83008,-9.92505,0.000495911],107.114,1,0],
	["Land_coneLight",[-12.71,5.08911,0.000320435],91.5605,1,0],
	["Land_fort_bagfence_corner",[5.91919,13.3657,0.0247841],203.714,1,0],
	["Land_CncBlock",[-13.5125,-3.55005,-4.00543e-005],19.1837,1,0],
	["Land_Pneu",[13.9712,-0.0639648,0.00012207],41.452,1,0],
	["Land_fort_bagfence_long",[0.726563,-14.0471,-2.67029e-005],107.438,1,0],
	["Land_CncBlock",[8.70752,-11.7097,0],18.2768,1,0],
	["Land_CncBlock_D",[12.55,-8.44849,7.62939e-005],200.436,1,0],
	["Land_CncBlock_D",[15.408,-2.0896,0],55,1,0],
	["Land_coneLight",[14.8938,-4.78003,3.62396e-005],116.457,1,0],
	["Land_CncBlock_D",[-16.0303,-2.68774,8.2016e-005],196.991,1,0],
	["Land_Pneu",[16.4512,-0.992676,6.67572e-005],41.452,1,0],
	["Land_CncBlock",[11.218,-12.45,0],15.058,1,0],
	["RoadBarrier_light",[14.1248,-9.31763,0.000757217],286.284,1,0],
	["cwr2_M2HB_High",[-4.72754,10.7205,0.0543346],109.649,1,0],
	["cwr2_M2HB_High",[0.485596,-10.4338,-0.00617599],197.906,1,0]
];

_objs