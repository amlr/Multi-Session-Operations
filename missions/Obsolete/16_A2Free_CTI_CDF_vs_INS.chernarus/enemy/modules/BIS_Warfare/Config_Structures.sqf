//Last modified 3/30/10
//*****************************************************************************************
//Description: Base structure configurations.
//*****************************************************************************************

//_v - variable name
//_n - building classname
//_d - description (translated).
//_f - Faction that structure belongs to and/or faction units structure can build.
//_c - cost (in supplies), for stationary defenses cost is in money.
//_t - time to build
//_i - Image on construction menu.
//_p - Probability of AI commander creating structure (per minute).
//_pt - Probability of AI creating structure (per minute) in a town.
//_s - script executed to build
//_a - action added to player when in range
//_dir - direction from structure to place a unit created by it.
//_dis - distance from structure to place a unit created by it.

//WEST STRUCTURES
_v			= ["Headquarters"];
_n			= ["BMP2_HQ_CDF_unfolded"];
_d			= [Localize "STRWFWESTHQ"];
_f			= [[Localize "STR_FN_CDF"]];
_c			= [100];
_t			= [30];
_i			= ["\CA\Warfare2\Images\con_hq.paa"];
_p			= [100];
_s			= ["HQSite"];
_a			= [corePath + "Client\Action\Action_Headquarters.sqs"];
_dis		= [15];
_dir		= [0];
_h			= [3];

_v = _v		+ ["Barracks"];
_n = _n		+ ["CDF_WarfareBBarracks"];
_d = _d		+ [Localize "STRWFWESTBARRACKS"];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [100];
_t = _t		+ [30];
_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
_p = _p		+ [400];
_s = _s		+ ["SmallSite"];
_a = _a		+ [corePath + "Client\Action\Action_Barracks.sqs"];
_dis = _dis	+ [18];
_dir = _dir	+ [90];
_h = _h		+ [3];

_v = _v		+ ["Light"];
_n = _n		+ ["CDF_WarfareBLightFactory"];
_d = _d		+ [Localize "STRWFWESTLIGHTFACTORY"];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [400];
_t = _t		+ [40];
_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
_p = _p		+ [100];
_s = _s		+ ["MediumSite"];
_a = _a		+ [corePath + "Client\Action\Action_LightFactory.sqs"];
_dis = _dis	+ [20];
_dir = _dir	+ [90];
_h = _h		+ [4.5];

_v = _v		+ ["Heavy"];
_n = _n		+ ["CDF_WarfareBHeavyFactory"];
_d = _d		+ [Localize "STRWFWESTHEAVYFACTORY"];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [1000];
_t = _t		+ [50];
_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
_p = _p		+ [100];
_s = _s		+ ["MediumSite"];
_a = _a		+ [corePath + "Client\Action\Action_HeavyFactory.sqs"];
_dis = _dis	+ [20];
_dir = _dir	+ [90];
_h = _h		+ [4];

_v = _v		+ ["Aircraft"];
_n = _n		+ ["CDF_WarfareBAircraftFactory"];
_d = _d		+ [Localize "STRWFWESTAIRCRAFTFACTORY"];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [2000];
_t = _t		+ [70];
_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
_p = _p		+ [8];
_s = _s		+ ["SmallSite"];
_a = _a		+ [corePath + "Client\Action\Action_AircraftFactory.sqs"];
_dis = _dis	+ [21];
_dir = _dir	+ [90];
_h = _h		+ [5.5];

_v = _v		+ ["ServicePoint"];
_n = _n		+ ["CDF_WarfareBVehicleServicePoint"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [200];
_t = _t		+ [40];
_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
_p = _p		+ [15];
_s = _s		+ ["VehicleServicePointSite"];
_a = _a		+ [""];
_dis = _dis	+ [21];
_dir = _dir	+ [90];
_h = _h		+ [5.5];

for [{_count = Count _v - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["WEST%1TYPE = %2",_v Select _count,_count];
};

WESTAIRPORTTYPE = Count _v;
WESTDEPOTTYPE = Count _v + 1;
WESTMHQNAME = "BMP2_HQ_CDF";
WESTFLAGPOLE = "\ca\data\flag_chernarus_co.paa";

westStructures = _v;
westStructureNames = _n;
westStructureDescriptions = _d;
westStructureFactions = _f;
westStructureCosts = _c;
westStructureTimes = _t;
westStructureImages = _i;
westStructureChances = _p;
westStructureDistances = _dis;
westStructureDirections = _dir;
westStructureScripts = _s;
westStructureActions = _a;
westStructureHeights = _h;

//Note that cost of defenses is in money instead of supplies.
//WEST STATIONARY DEFENSES
_v			= ["MGNest"];
_n			= ["CDF_WarfareBMGNest_PK"];
_d			= [Localize "STRWFBWESTMGNEST"];
_f			= [[Localize "STR_FN_CDF"]];
_c			= [200];
_t			= [0];
_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
_p			= [25];
_pt			= [5];
_s			= ["StationaryDefense"];
_a			= [""];
_dis		= [0];
_dir		= [0];
_h			= [0];

_v = _v		+ ["DSHKM"];
_n = _n		+ ["DSHKM_CDF"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [200];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
_p = _p		+ [25];
_pt = _pt	+ [5];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["AGS30"];
_n = _n		+ ["AGS_CDF"];
_d = _d		+ [Localize "STR_DN_AGS30"];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [300];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
_p = _p		+ [25];
_pt = _pt	+ [4];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SPG9"];
_n = _n		+ ["SPG9_CDF"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [Localize "STR_FN_CDF"];
_c = _c		+ [400];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
_p = _p		+ [40];
_pt = _pt	+ [3];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["ZU23"];
_n = _n		+ ["ZU23_CDF"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [Localize "STR_FN_CDF"];
_c = _c		+ [400];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
_p = _p		+ [40];
_pt = _pt	+ [1];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["D30"];
_n = _n		+ ["D30_CDF"];
_d = _d		+ [Localize "STR_DN_D30"];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [2500];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
_p = _p		+ [50];
_pt = _pt	+ [1];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SmallWall"];
_n = _n		+ ["Land_HBarrier3"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [25];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["MediumWall"];
_n = _n		+ ["Land_HBarrier5"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [50];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["LargeWall"];
_n = _n		+ ["Land_HBarrier_large"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [75];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["Sandbags"];
_n = _n		+ ["Land_fort_bagfence_long"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [10];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SandbagsCorner"];
_n = _n		+ ["Land_fort_bagfence_corner"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [10];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SandbagsRound"];
_n = _n		+ ["Land_fort_bagfence_round"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [10];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["FortifiedNest"];
_n = _n		+ ["Land_fortified_nest_small"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [50];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["BarbedWire"];
_n = _n		+ ["Fort_RazorWire"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [25];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["Rampart"];
_n = _n		+ ["Land_fort_rampart"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [25];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["ArtilleryRampart"];
_n = _n		+ ["Land_fort_artillery_nest"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_CDF"]];
_c = _c		+ [75];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

for [{_count = Count _v - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["WEST%1TYPE = %2",_v Select _count,_count];
};

westDefenses = _v;
westDefenseNames = _n;
westDefenseDescriptions = _d;
westDefenseFactions = _f;
westDefenseCosts = _c;
westDefenseTimes = _t;
westDefenseImages = _i;
westDefenseChances = _p;
westDefenseTownChances = _pt;
westDefenseDistances = _dis;
westDefenseDirections = _dir;
westDefenseScripts = _s;
westDefenseActions = _a;
westDefenseHeights = _h;

//EAST STRUCTURES
_v			= ["Headquarters"];
_n			= ["BMP2_HQ_INS_unfolded"];
_d			= [Localize "STRWFEASTHQ"];
_f			= [Localize "STR_FN_INS"];
_c			= [100];
_t			= [30];
_i			= ["\CA\Warfare2\Images\con_hq.paa"];
_p			= [100];
_s			= ["HQSite"];
_a			= [corePath + "Client\Action\Action_Headquarters.sqs"];
_dis		= [15];
_dir			= [0];
_h			= [3];

_v = _v		+ ["Barracks"];
_n = _n		+ ["Ins_WarfareBBarracks"];
_d = _d		+ [Localize "STRWFEASTBARRACKS"];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [100];
_t = _t		+ [30];
_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
_p = _p		+ [400];
_s = _s		+ ["SmallSite"];
_a = _a		+ [corePath + "Client\Action\Action_Barracks.sqs"];
_dis = _dis	+ [18];
_dir = _dir	+ [90];
_h = _h		+ [3];

_v = _v		+ ["Light"];
_n = _n		+ ["Ins_WarfareBLightFactory"];
_d = _d		+ [Localize "STRWFEASTLIGHTFACTORY"];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [400];
_t = _t		+ [40];
_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
_p = _p		+ [100];
_s = _s		+ ["MediumSite"];
_a = _a		+ [corePath + "Client\Action\Action_LightFactory.sqs"];
_dis = _dis	+ [20];
_dir = _dir	+ [90];
_h = _h		+ [4.5];

_v = _v		+ ["Heavy"];
_n = _n		+ ["Ins_WarfareBHeavyFactory"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [1000];
_t = _t		+ [50];
_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
_p = _p		+ [100];
_s = _s		+ ["MediumSite"];
_a = _a		+ [corePath + "Client\Action\Action_HeavyFactory.sqs"];
_dis = _dis	+ [20];
_dir = _dir	+ [90];
_h = _h		+ [4];

_v = _v		+ ["Aircraft"];
_n = _n		+ ["WarfareBAircraftFactory_Ins"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [2000];
_t = _t		+ [70];
_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
_p = _p		+ [8];
_s = _s		+ ["SmallSite"];
_a = _a		+ [corePath + "Client\Action\Action_AircraftFactory.sqs"];
_dis = _dis	+ [21];
_dir = _dir	+ [90];
_h = _h		+ [5.5];

_v = _v		+ ["ServicePoint"];
_n = _n		+ ["INS_WarfareBVehicleServicePoint"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [200];
_t = _t		+ [40];
_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
_p = _p		+ [15];
_s = _s		+ ["VehicleServicePointSite"];
_a = _a		+ [""];
_dis = _dis	+ [21];
_dir = _dir	+ [90];
_h = _h		+ [5.5];

for [{_count = Count _v - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["EAST%1TYPE = %2",_v Select _count,_count];
};

EASTAIRPORTTYPE = Count _v;
EASTDEPOTTYPE = Count _v + 1;
EASTMHQNAME = "BMP2_HQ_INS";
EASTFLAGPOLE = "\ca\data\flag_chdkz_co.paa";

eastStructures = _v;
eastStructureNames = _n;
eastStructureDescriptions = _d;
eastStructureFactions = _f;
eastStructureCosts = _c;
eastStructureTimes = _t;
eastStructureImages = _i;
eastStructureChances = _p;
eastStructureDistances = _dis;
eastStructureDirections = _dir;
eastStructureScripts = _s;
eastStructureActions = _a;
eastStructureHeights = _h;

//Note that cost of defenses is in money instead of supplies.
//EAST STATIONARY DEFENSES
_v			= ["MGNest"];
_n			= ["Ins_WarfareBMGNest_PK"];
_d			= [Localize "STRWFBWESTMGNEST"];
_f			= [[Localize "STR_FN_INS"]];
_c			= [200];
_t			= [0];
_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
_p			= [25];
_pt			= [5];
_s			= ["StationaryDefense"];
_a			= [""];
_dis		= [0];
_dir		= [0];
_h			= [0];

_v = _v		+ ["DSHKM"];
_n = _n		+ ["DSHKM_Ins"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [200];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
_p = _p		+ [25];
_pt = _pt	+ [5];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["AGS30"];
_n = _n		+ ["AGS_Ins"];
_d = _d		+ [Localize "STR_DN_AGS30"];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [300];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
_p = _p		+ [30];
_pt = _pt	+ [4];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SPG9"];
_n = _n		+ ["SPG9_Ins"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [Localize "STR_FN_INS"];
_c = _c		+ [400];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
_p = _p		+ [40];
_pt = _pt	+ [3];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["ZU23"];
_n = _n		+ ["ZU23_Ins"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [Localize "STR_FN_INS"];
_c = _c		+ [400];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
_p = _p		+ [40];
_pt = _pt	+ [1];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["D30"];
_n = _n		+ ["D30_Ins"];
_d = _d		+ [Localize "STR_DN_D30"];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [2500];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
_p = _p		+ [50];
_pt = _pt	+ [1];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SmallWall"];
_n = _n		+ ["Land_HBarrier3"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [25];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["MediumWall"];
_n = _n		+ ["Land_HBarrier5"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [50];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["LargeWall"];
_n = _n		+ ["Land_HBarrier_large"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [75];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["Sandbags"];
_n = _n		+ ["Land_fort_bagfence_long"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [10];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SandbagsCorner"];
_n = _n		+ ["Land_fort_bagfence_corner"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [10];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["SandbagsRound"];
_n = _n		+ ["Land_fort_bagfence_round"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [10];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["FortifiedNest"];
_n = _n		+ ["Land_fortified_nest_small"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [50];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["BarbedWire"];
_n = _n		+ ["Fort_RazorWire"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [25];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["Rampart"];
_n = _n		+ ["Land_fort_rampart"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [25];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

_v = _v		+ ["ArtilleryRampart"];
_n = _n		+ ["Land_fort_artillery_nest"];
_d = _d		+ [GetText (configFile >> "CfgVehicles" >> (_n Select (Count _n - 1)) >> "displayName")];
_f = _f		+ [[Localize "STR_FN_INS"]];
_c = _c		+ [75];
_t = _t		+ [0];
_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
_p = _p		+ [0];
_pt = _pt	+ [0];
_s = _s		+ ["StationaryDefense"];
_a = _a		+ [""];
_dis = _dis	+ [0];
_dir = _dir	+ [0];
_h = _h		+ [0];

for [{_count = Count _v - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["EAST%1TYPE = %2",_v Select _count,_count];
};

eastDefenses = _v;
eastDefenseNames = _n;
eastDefenseDescriptions = _d;
eastDefenseFactions = _f;
eastDefenseCosts = _c;
eastDefenseTimes = _t;
eastDefenseImages = _i;
eastDefenseChances = _p;
eastDefenseTownChances = _pt;
eastDefenseDistances = _dis;
eastDefenseDirections = _dir;
eastDefenseScripts = _s;
eastDefenseActions = _a;
eastDefenseHeights = _h;

//*****************************************************************************************
//3/26/7 MM - Created file.