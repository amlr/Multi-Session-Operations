scriptName format ["%1Scripts\Common\Config\Config_Loadouts.sqf",BIS_WFdPath];
//Last modified 11/4/10
//*****************************************************************************************
//Description: Loadout configurations.
//*****************************************************************************************

customTemplate = 0;

//Store types of weapons & amounts for a custom loadout.
customWeapons = [0,0,0,0,0];

//Store amounts of each misc type for a custom loadout.
customMisc = [0,0,0,0,0,0,0,0,0,0,0,0];

//WEST LOADOUTS
_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

//USMC
_w = _w		+ ["m16a4"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [30];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M16A4_GL"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [40];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["m16a4_acg"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [45];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M16A4_ACG_GL"];
_c = _c		+ [45];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M4A1_Aim"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [45];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M4A1_RCO_GL"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [50];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M4A1_HWS_GL_camo"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [55];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M4A1_AIM_SD_camo"];
_a = _a		+ ["30Rnd_556x45_StanagSD"];
_c = _c		+ [65];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["MP5A5"];
_a = _a		+ ["30Rnd_9x19_MP5"];
_c = _c		+ [30];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["MP5SD"];
_a = _a		+ ["30Rnd_9x19_MP5SD"];
_c = _c		+ [55];
_ac = _ac	+ [7];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["G36C"];
_a = _a		+ ["30Rnd_556x45_G36"];
_c = _c		+ [35];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["G36K"];
_a = _a		+ ["30Rnd_556x45_G36"];
_c = _c		+ [40];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["G36_C_SD_eotech"];
_a = _a		+ ["30Rnd_556x45_G36SD"];
_c = _c		+ [70];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["MG36"];
_a = _a		+ ["100Rnd_556x45_BetaCMag"];
_c = _c		+ [75];
_ac = _ac	+ [15];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M1014"];
_a = _a		+ ["8Rnd_B_Beneli_74Slug"];
_c = _c		+ [30];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M4SPR"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [50];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M24"];
_a = _a		+ ["5Rnd_762x51_M24"];
_c = _c		+ [55];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M40A3"];
_a = _a		+ ["5Rnd_762x51_M24"];
_c = _c		+ [55];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["DMR"];
_a = _a		+ ["20Rnd_762x51_DMR"];
_c = _c		+ [80];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["m107"];
_a = _a		+ ["10Rnd_127x99_m107"];
_c = _c		+ [150];
_ac = _ac	+ [15];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M249"];
_a = _a		+ ["200Rnd_556x45_M249"];
_c = _c		+ [55];
_ac = _ac	+ [15];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M240"];
_a = _a		+ ["100Rnd_762x51_M240"];
_c = _c		+ [65];
_ac = _ac	+ [15];
_f = _f		+ [Localize "STR_FN_USMC"];

//CDF
_w = _w		+ ["AK_74"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [20];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["AK_74_GL"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [30];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["AKS_74_pso"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [35];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["AKS_74_UN_kobra"];
_a = _a		+ ["30Rnd_545x39_AKSD"];
_c = _c		+ [70];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["RPK_74"];
_a = _a		+ ["75Rnd_545x39_RPK"];
_c = _c		+ [45];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["PK"];
_a = _a		+ ["100Rnd_762x54_PK"];
_c = _c		+ [50];
_ac = _ac	+ [15];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["SVD"];
_a = _a		+ ["10Rnd_762x54_SVD"];
_c = _c		+ [85];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_CDF"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

westPrimaryWeapons = _w;
westPrimaryCosts = _c;
westPrimaryAmmo = _a;
westPrimaryAmmoCosts = _ac;
westPrimaryFactions = _f;

westPrimaryNames = [];
westPrimaryImages = [];
westPrimaryAmmoNames = [];
westPrimaryAmmoSpaces = [];
westPrimaryAmmoImages = [];

{
	westPrimaryNames = westPrimaryNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	westPrimaryImages = westPrimaryImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach westPrimaryWeapons;

westPrimaryNames Set[0,Localize "STRWFNONE"];

{
	westPrimaryAmmoNames = westPrimaryAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	westPrimaryAmmoImages = westPrimaryAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	westPrimaryAmmoSpaces = westPrimaryAmmoSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach westPrimaryAmmo;

_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

//USMC
_w = _w		+ ["M136"];
_a = _a		+ ["M136"];
_c = _c		+ [150];
_ac = _ac	+ [45];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["SMAW"];
_a = _a		+ ["SMAW_HEAA"];
_c = _c		+ [200];
_ac = _ac	+ [75];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["Javelin"];
_a = _a		+ ["Javelin"];
_c = _c		+ [400];
_ac = _ac	+ [200];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["Stinger"];
_a = _a		+ ["Stinger"];
_c = _c		+ [250];
_ac = _ac	+ [150];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["Laserdesignator"];
_a = _a		+ ["Laserbatteries"];
_c = _c		+ [150];
_ac = _ac	+ [100];
_f = _f		+ [Localize "STR_FN_USMC"];

//CDF
_w = _w		+ ["RPG18"];
_a = _a		+ ["RPG18"];
_c = _c		+ [125];
_ac = _ac	+ [40];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["RPG7V"];
_a = _a		+ ["PG7VR"];
_c = _c		+ [150];
_ac = _ac	+ [75];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["Strela"];
_a = _a		+ ["Strela"];
_c = _c		+ [200];
_ac = _ac	+ [100];
_f = _f		+ [Localize "STR_FN_CDF"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

westSecondaryWeapons = _w;
westSecondaryCosts = _c;
westSecondaryAmmo = _a;
westSecondaryAmmoCosts = _ac;
westSecondaryFactions = _f;

westSecondaryNames = [];
westSecondaryImages = [];
westSecondaryAmmoNames = [];
westSecondaryAmmoSpaces = [];
westSecondaryAmmoImages = [];

{
	westSecondaryNames = westSecondaryNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	westSecondaryImages = westSecondaryImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach westSecondaryWeapons;

westSecondaryNames Set[0,Localize "STRWFNONE"];

{
	westSecondaryAmmoNames = westSecondaryAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	westSecondaryAmmoImages = westSecondaryAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	westSecondaryAmmoSpaces = westSecondaryAmmoSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach westSecondaryAmmo;

_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

//USMC
_w = _w		+ ["M9"];
_a = _a		+ ["15Rnd_9x19_M9"];
_c = _c		+ [15];
_ac = _ac	+ [2];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["M9SD"];
_a = _a		+ ["15Rnd_9x19_M9SD"];
_c = _c		+ [20];
_ac = _ac	+ [3];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["Colt1911"];
_a = _a		+ ["7Rnd_45ACP_1911"];
_c = _c		+ [20];
_ac = _ac	+ [3];
_f = _f		+ [Localize "STR_FN_USMC"];

//CDF
_w = _w		+ ["Makarov"];
_a = _a		+ ["8Rnd_9x18_Makarov"];
_c = _c		+ [15];
_ac = _ac	+ [2];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["MakarovSD"];
_a = _a		+ ["8Rnd_9x18_MakarovSD"];
_c = _c		+ [20];
_ac = _ac	+ [3];
_f = _f		+ [Localize "STR_FN_CDF"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

westSidearms = _w;
westSidearmCosts = _c;
westSidearmAmmo = _a;
westSidearmAmmoCosts = _ac;
westSidearmFactions = _f;

westSidearmNames = [];
westSidearmImages = [];
westSidearmAmmoNames = [];
westSidearmAmmoImages = [];

{
	westSidearmNames = westSidearmNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	westSidearmImages = westSidearmImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach westSidearms;

westSidearmNames Set[0,Localize "STRWFNONE"];

{
	westSidearmAmmoNames = westSidearmAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	westSidearmAmmoImages = westSidearmAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
} ForEach westSidearmAmmo;

_workarounds = [];
_workarounds1 = [];

_w			= ["None"];
_c			= [0];
_is			= [false];
_f			= ["ALL"];

_w = _w		+ ["HandGrenade"];
_c = _c		+ [5];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

_w = _w		+ ["SmokeShell"];
_c = _c		+ [5];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

//USMC
_w = _w		+ ["FlareWhite_M203"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["FlareYellow_M203"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["FlareGreen_M203"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["FlareRed_M203"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_USMC"];

//WORKAROUND - Beginning a variable with a number will cause problems.
//_w = _w	+ ["1Rnd_HE_M203"];
_w = _w		+ ["Rnd_HE_M203"];
//_workaround = Count _w - 1;
_workarounds = _workarounds + ["Rnd_HE_M203"];
_workarounds1 = _workarounds1 + ["1Rnd_HE_M203"];

_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["Mine"];
_c = _c		+ [15];
_is = _is	+ [false];
_f = _f		+ [Localize "STR_FN_USMC"];

_w = _w		+ ["PipeBomb"];
_c = _c		+ [15];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

//CDF
_w = _w		+ ["FlareWhite_GP25"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["FlareYellow_GP25"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["FlareGreen_GP25"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["FlareRed_GP25"];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_CDF"];

//WORKAROUND - Beginning a variable with a number will cause problems.
//_w = _w	+ ["1Rnd_HE_GP25"];
_w = _w		+ ["Rnd_HE_GP25"];
//_workaround = Count _w - 1;
_workarounds = _workarounds + ["Rnd_HE_GP25"];
_workarounds1 = _workarounds1 + ["1Rnd_HE_GP25"];

_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_CDF"];

_w = _w		+ ["MineE"];
_c = _c		+ [20];
_is = _is	+ [false];
_f = _f		+ [Localize "STR_FN_CDF"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

//WORKAROUND - Now that variable has been created change classname to proper value.
{
	_w Set [_w Find _x,_workarounds1 Select (_workarounds Find _x)];
} ForEach _workarounds;

westMiscWeapons = _w;
westMiscCosts = _c;
westMiscIsSidearmAmmo = _is;
westMiscFactions = _f;

westMiscNames = [];
westMiscImages = [];
westMiscSpaces = [];

{
	westMiscNames = westMiscNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	westMiscImages = westMiscImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	westMiscSpaces = westMiscSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach westMiscWeapons;

westMiscNames Set[0,Localize "STRWFNONE"];

miscEquipment = ["Binocular","NVGoggles"];
miscEquipmentNames = [Localize "STR_DN_BINOCULAR",Localize "STR_DN_NV_GOGGLES"];
miscEquipmentImages = ["\dtaExt\equip\w\w_binocular","\dtaExt\equip\w\w_nvgoggles"];
miscEquipmentCosts = [5,15];
miscEquipmentC = [configFile >> "cfgWeapons" >> "Binocular", configFile >> "cfgWeapons" >> "NVGoggles"];
miscFactions = ["ALL","ALL"];

//Loadout templates
_n			= [Localize "STRWFCUSTOM"];
_p			= [0];
_pa			= [0];
_s			= [0];
_sa			= [0];
_si			= [0];
_m			= [0];
_ma			= [0];
_m1			= [0];
_ma1		= [0];
_f			= ["ALL"];

//USMC
_n	= _n	+ [Format["%1/%2",westPrimaryNames Select M16A4TYPE,westSecondaryNames Select M136TYPE]];
_p	= _p	+ [M16A4TYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [M136TYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [M9TYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Format["%1/%2",westPrimaryNames Select M4A1_RCO_GLTYPE,westSecondaryNames Select M136TYPE]];
_p	= _p	+ [M4A1_RCO_GLTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [M136TYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [0];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [Rnd_HE_M203TYPE];
_ma1= _ma1	+ [8];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Format["%1/%2",westPrimaryNames Select M4A1_AIM_SD_CAMOTYPE,westSecondaryNames Select M136TYPE]];
_p	= _p	+ [M4A1_AIM_SD_CAMOTYPE];
_pa	= _pa	+ [7];
_s	= _s	+ [M136TYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [M9SDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [westPrimaryNames Select MP5SDTYPE];
_p	= _p	+ [MP5SDTYPE];
_pa	= _pa	+ [7];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [M9SDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Localize "STR_DN_M249"];
_p	= _p	+ [M249TYPE];
_pa	= _pa	+ [4];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [M9TYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [6];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Localize "STR_DN_M240"];
_p	= _p	+ [M240TYPE];
_pa	= _pa	+ [4];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [M9TYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [6];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Format["%1/%2",westPrimaryNames Select M4SPRTYPE,westSecondaryNames Select M136TYPE]];
_p	= _p	+ [M4SPRTYPE];
_pa	= _pa	+ [7];
_s	= _s	+ [M136TYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [M9SDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Localize "STR_DN_M24"];
_p	= _p	+ [M24TYPE];
_pa	= _pa	+ [10];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [M9SDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [2];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [1];
_f = _f		+ [Localize "STR_FN_USMC"];

_n	= _n	+ [Localize "STR_DN_M107"];
_p	= _p	+ [M107TYPE];
_pa	= _pa	+ [10];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [M9SDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [2];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [1];
_f = _f		+ [Localize "STR_FN_USMC"];

//CDF
_n	= _n	+ [Format["%1/%2",westPrimaryNames Select AK_74TYPE,westSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_74TYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_CDF"];

_n	= _n	+ [Format["%1/%2",westPrimaryNames Select AKS_74_psoTYPE,westSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AKS_74_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_CDF"];

_n	= _n	+ [Format["%1/%2",westPrimaryNames Select AK_74_GLTYPE,westSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_74_GLTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [0];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [Rnd_HE_GP25TYPE];
_ma1= _ma1	+ [8];
_f = _f		+ [Localize "STR_FN_CDF"];

_n	= _n	+ [westPrimaryNames Select RPK_74TYPE];
_p	= _p	+ [RPK_74TYPE];
_pa	= _pa	+ [4];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [6];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_CDF"];

_n	= _n	+ [westPrimaryNames Select PKTYPE];
_p	= _p	+ [PKTYPE];
_pa	= _pa	+ [4];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [6];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_CDF"];

_n	= _n	+ [westPrimaryNames Select SVDTYPE];
_p	= _p	+ [SVDTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [2];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_CDF"];

//Calculate template costs.
_c = [];
_totalTemplates = Count _n;

for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do
{
	_cost = (westPrimaryCosts Select (_p Select _count)) + (westSecondaryCosts Select (_s Select _count)) + (westSidearmCosts Select (_si Select _count));
	_cost = _cost + ((westPrimaryAmmoCosts Select (_p Select _count)) * (_pa Select _count));
	_cost = _cost + ((westSecondaryAmmoCosts Select (_s Select _count)) * (_sa Select _count));
	_cost = _cost + (((westMiscCosts Select (_m  Select _count)) * (_ma Select _count)) + ((westMiscCosts Select (_m1 Select _count)) * (_ma1 Select _count)));

	_c = _c + [_cost];
};

westTemplateNames = _n;
westTemplatePrimary = _p;
westTemplatePrimaryAmmo = _pa;
westTemplateSecondary = _s;
westTemplateSecondaryAmmo = _sa;
westTemplateSidearms = _si;
westTemplateMisc = _m;
westTemplateAmount = _ma;
westTemplateMisc1 = _m1;
westTemplateAmount1 = _ma1;
westTemplateCosts = _c;
westTemplateFactions = _f;

westDefaultWeapons = ["AK_74"];
westDefaultAmmo = ["30Rnd_545x39_AK","30Rnd_545x39_AK","30Rnd_545x39_AK","30Rnd_545x39_AK","HandGrenade","HandGrenade","HandGrenade","HandGrenade"];

westSpecOpDefaultWeapons = ["AKS_74_UN_kobra"];
westSpecOpDefaultAmmo = ["30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","HandGrenade","HandGrenade","HandGrenade","HandGrenade"];

//EAST LOADOUTS
_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

//RU
_w = _w		+ ["AK_74"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [20];
_ac = _ac	+ [5];
_f = _f		+ ["ALL"];

_w = _w		+ ["AKS_74_U"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [45];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["AK_107_pso"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [35];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["AK_107_GL_pso"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [60];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["AK_107_kobra"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [45];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["AK_107_GL_kobra"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [70];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["Saiga12K"];
_a = _a		+ ["8Rnd_B_Saiga12_74Slug"];
_c = _c		+ [25];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["Bizon"];
_a = _a		+ ["64Rnd_9x19_Bizon"];
_c = _c		+ [60];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["bizon_silenced"];
_a = _a		+ ["64Rnd_9x19_SD_Bizon"];
_c = _c		+ [70];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["AKS_74_UN_kobra"];
_a = _a		+ ["30Rnd_545x39_AKSD"];
_c = _c		+ [70];
_ac = _ac	+ [10];
_f = _f		+ ["ALL"];

_w = _w		+ ["VSS_vintorez"];
_a = _a		+ ["20Rnd_9x39_SP5_VSS"];
_c = _c		+ [110];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["RPK_74"];
_a = _a		+ ["75Rnd_545x39_RPK"];
_c = _c		+ [45];
_ac = _ac	+ [10];
_f = _f		+ ["ALL"];

_w = _w		+ ["PK"];
_a = _a		+ ["100Rnd_762x54_PK"];
_c = _c		+ [50];
_ac = _ac	+ [15];
_f = _f		+ ["ALL"];

_w = _w		+ ["Pecheneg"];
_a = _a		+ ["100Rnd_762x54_PK"];
_c = _c		+ [70];
_ac = _ac	+ [15];
_f = _f		+ ["ALL"];

_w = _w		+ ["SVD"];
_a = _a		+ ["10Rnd_762x54_SVD"];
_c = _c		+ [85];
_ac = _ac	+ [8];
_f = _f		+ ["ALL"];

_w = _w		+ ["ksvk"];
_a = _a		+ ["5Rnd_127x108_KSVK"];
_c = _c		+ [160];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_RU"];

//INSURGENTS
_w = _w		+ ["AK_47_M"];
_a = _a		+ ["30Rnd_762x39_AK47"];
_c = _c		+ [15];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_INS"];

_w = _w		+ ["AK_47_S"];
_a = _a		+ ["30Rnd_762x39_AK47"];
_c = _c		+ [20];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_INS"];

_w = _w		+ ["AK_74_GL"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [30];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_INS"];

_w = _w		+ ["AKS_74_pso"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [35];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_INS"];

_w = _w		+ ["huntingrifle"];
_a = _a		+ ["5x_22_LR_17_HMR"];
_c = _c		+ [50];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_INS"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

eastPrimaryWeapons = _w;
eastPrimaryCosts = _c;
eastPrimaryAmmo = _a;
eastPrimaryAmmoCosts = _ac;
eastPrimaryFactions = _f;

eastPrimaryNames = [];
eastPrimaryImages = [];
eastPrimaryAmmoNames = [];
eastPrimaryAmmoSpaces = [];
eastPrimaryAmmoImages = [];

{
	eastPrimaryNames = eastPrimaryNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	eastPrimaryImages = eastPrimaryImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach eastPrimaryWeapons;

eastPrimaryNames Set[0,Localize "STRWFNONE"];

{
	eastPrimaryAmmoNames = eastPrimaryAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	eastPrimaryAmmoImages = eastPrimaryAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	eastPrimaryAmmoSpaces = eastPrimaryAmmoSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach eastPrimaryAmmo;

_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

_w = _w		+ ["RPG18"];
_a = _a		+ ["RPG18"];
_c = _c		+ [125];
_ac = _ac	+ [40];
_f = _f		+ ["ALL"];

_w = _w		+ ["RPG7V"];
_a = _a		+ ["PG7VR"];
_c = _c		+ [150];
_ac = _ac	+ [75];
_f = _f		+ ["ALL"];

_w = _w		+ ["MetisLauncher"];
_a = _a		+ ["AT13"];
_c = _c		+ [350];
_ac = _ac	+ [150];
_f = _f		+ ["ALL"];

_w = _w		+ ["Igla"];
_a = _a		+ ["Igla"];
_c = _c		+ [250];
_ac = _ac	+ [100];
_f = _f		+ [Localize "STR_FN_RU"];

_w = _w		+ ["Laserdesignator"];
_a = _a		+ ["Laserbatteries"];
_c = _c		+ [150];
_ac = _ac	+ [100];
_f = _f		+ [Localize "STR_FN_RU"];

//INSURGENTS
_w = _w		+ ["Strela"];
_a = _a		+ ["Strela"];
_c = _c		+ [200];
_ac = _ac	+ [75];
_f = _f		+ [Localize "STR_FN_INS"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

eastSecondaryWeapons = _w;
eastSecondaryCosts = _c;
eastSecondaryAmmo = _a;
eastSecondaryAmmoCosts = _ac;
eastSecondaryFactions = _f;

eastSecondaryNames = [];
eastSecondaryImages = [];
eastSecondaryAmmoNames = [];
eastSecondaryAmmoSpaces = [];
eastSecondaryAmmoImages = [];

{
	eastSecondaryNames = eastSecondaryNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	eastSecondaryImages = eastSecondaryImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach eastSecondaryWeapons;

eastSecondaryNames Set[0,Localize "STRWFNONE"];

{
	eastSecondaryAmmoNames = eastSecondaryAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	eastSecondaryAmmoImages = eastSecondaryAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	eastSecondaryAmmoSpaces = eastSecondaryAmmoSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach eastSecondaryAmmo;

_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

_w = _w		+ ["Makarov"];
_a = _a		+ ["8Rnd_9x18_Makarov"];
_c = _c		+ [15];
_ac = _ac	+ [2];
_f = _f		+ ["ALL"];

_w = _w		+ ["MakarovSD"];
_a = _a		+ ["8Rnd_9x18_MakarovSD"];
_c = _c		+ [20];
_ac = _ac	+ [3];
_f = _f		+ ["ALL"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

eastSidearms = _w;
eastSidearmCosts = _c;
eastSidearmAmmo = _a;
eastSidearmAmmoCosts = _ac;
eastSidearmFactions = _f;

eastSidearmNames = [];
eastSidearmImages = [];
eastSidearmAmmoNames = [];
eastSidearmAmmoImages = [];

{
	eastSidearmNames = eastSidearmNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	eastSidearmImages = eastSidearmImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach eastSidearms;

eastSidearmNames Set[0,Localize "STRWFNONE"];

{
	eastSidearmAmmoNames = eastSidearmAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	eastSidearmAmmoImages = eastSidearmAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
} ForEach eastSidearmAmmo;

_workarounds = [];
_workarounds1 = [];

_w			= ["None"];
_c			= [0];
_is			= [false];
_f			= ["ALL"];

_weapon		= "HandGrenade";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

_weapon		= "FlareWhite_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ ["ALL"];

_weapon		= "FlareYellow_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ ["ALL"];

_weapon		= "FlareGreen_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ ["ALL"];

_weapon		= "FlareRed_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ ["ALL"];

//WORKAROUND - Beginning a variable with a number will cause problems.
//_w = _w	+ ["1Rnd_HE_GP25"];
_w = _w		+ ["Rnd_HE_GP25"];
_workarounds = _workarounds + ["Rnd_HE_GP25"];
_workarounds1 = _workarounds1 + ["1Rnd_HE_GP25"];

_weapon		= "1Rnd_HE_GP25";
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ ["ALL"];

_weapon		= "SmokeShell";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

_weapon		= "MineE";
_w = _w		+ [_weapon];
_c = _c		+ [20];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

_weapon		= "PipeBomb";
_w = _w		+ [_weapon];
_c = _c		+ [20];
_is = _is	+ [false];
_f = _f		+ ["ALL"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

//WORKAROUND - Now that variable has been created change classname to proper value.
{
	_w Set [_w Find _x,_workarounds1 Select (_workarounds Find _x)];
} ForEach _workarounds;

eastMiscWeapons = _w;
eastMiscCosts = _c;
eastMiscIsSidearmAmmo = _is;
eastMiscFactions = _f;

eastMiscNames = [];
eastMiscImages = [];
eastMiscSpaces = [];

{
	eastMiscNames = eastMiscNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	eastMiscImages = eastMiscImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	eastMiscSpaces = eastMiscSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach eastMiscWeapons;

eastMiscNames Set[0,Localize "STRWFNONE"];

//Loadout templates
_n			= [Localize "STRWFCUSTOM"];
_p			= [0];
_pa			= [0];
_s			= [0];
_sa			= [0];
_si			= [0];
_m			= [0];
_ma			= [0];
_m1			= [0];
_ma1		= [0];
_f			= ["ALL"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select Saiga12KTYPE,eastSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [Saiga12KTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_RU"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AK_74TYPE,eastSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_74TYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ ["ALL"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AK_107_psoTYPE,eastSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_107_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_RU"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AK_107_psoTYPE,eastSecondaryNames Select RPG18TYPE]];
_p	= _p	+ [AK_107_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG18TYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_RU"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AK_107_GL_psoTYPE,eastSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_107_GL_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [0];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [Rnd_HE_GP25TYPE];
_ma1= _ma1	+ [8];
_f = _f		+ [Localize "STR_FN_RU"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AK_107_GL_psoTYPE,eastSecondaryNames Select RPG18TYPE]];
_p	= _p	+ [AK_107_GL_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG18TYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [0];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [Rnd_HE_GP25TYPE];
_ma1= _ma1	+ [8];
_f = _f		+ [Localize "STR_FN_RU"];

_n	= _n	+ [eastPrimaryNames Select PKTYPE];
_p	= _p	+ [PKTYPE];
_pa	= _pa	+ [4];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [6];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ ["ALL"];

_n	= _n	+ [eastPrimaryNames Select bizon_silencedTYPE];
_p	= _p	+ [bizon_silencedTYPE];
_pa	= _pa	+ [7];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVSDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_RU"];

_n	= _n	+ [eastPrimaryNames Select SVDTYPE];
_p	= _p	+ [SVDTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVSDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [2];
_m1	= _m1	+ [SmokeShellTYPE];
_ma1= _ma1	+ [2];
_f = _f		+ ["ALL"];

//INSURGENTS
_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AKS_74_psoTYPE,eastSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AKS_74_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_INS"];

_n	= _n	+ [Format["%1/%2",eastPrimaryNames Select AK_74_GLTYPE,eastSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_74_GLTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [0];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [Rnd_HE_GP25TYPE];
_ma1= _ma1	+ [8];
_f = _f		+ [Localize "STR_FN_INS"];


//Calculate template costs.
_c = [];
_totalTemplates = Count _n;

for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do
{
	_cost = (eastPrimaryCosts Select (_p Select _count)) + (eastSecondaryCosts Select (_s Select _count)) + (eastSidearmCosts Select (_si Select _count));
	_cost = _cost + ((eastPrimaryAmmoCosts Select (_p Select _count)) * (_pa Select _count));
	_cost = _cost + ((eastSecondaryAmmoCosts Select (_s Select _count)) * (_sa Select _count));
	_cost = _cost + (((eastMiscCosts Select (_m  Select _count)) * (_ma Select _count)) + ((eastMiscCosts Select (_m1 Select _count)) * (_ma1 Select _count)));

	_c = _c + [_cost];
};

eastTemplateNames = _n;
eastTemplatePrimary = _p;
eastTemplatePrimaryAmmo = _pa;
eastTemplateSecondary = _s;
eastTemplateSecondaryAmmo = _sa;
eastTemplateSidearms = _si;
eastTemplateMisc = _m;
eastTemplateAmount = _ma;
eastTemplateMisc1 = _m1;
eastTemplateAmount1 = _ma1;
eastTemplateCosts = _c;
eastTemplateFactions = _f;

eastDefaultWeapons = ["AK_74"];
eastDefaultAmmo = ["30Rnd_545x39_AK","30Rnd_545x39_AK","30Rnd_545x39_AK","30Rnd_545x39_AK","HandGrenade","HandGrenade","HandGrenade","HandGrenade"];

eastSpecOpDefaultWeapons = ["bizon_silenced"];
eastSpecOpDefaultAmmo = ["64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","HandGrenade","HandGrenade","HandGrenade","HandGrenade"];

//RESISTANCE LOADOUTS
_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

_w = _w		+ ["AK_47_M"];
_a = _a		+ ["30Rnd_762x39_AK47"];
_c = _c		+ [15];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["AK_47_S"];
_a = _a		+ ["30Rnd_762x39_AK47"];
_c = _c		+ [20];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["AK_74"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [20];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["AK_74_GL"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [30];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["AKS_74_pso"];
_a = _a		+ ["30Rnd_545x39_AK"];
_c = _c		+ [35];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["AKS_74_UN_kobra"];
_a = _a		+ ["30Rnd_545x39_AKSD"];
_c = _c		+ [70];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["M16A2"];
_a = _a		+ ["30Rnd_556x45_Stanag"];
_c = _c		+ [25];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["RPK_74"];
_a = _a		+ ["75Rnd_545x39_RPK"];
_c = _c		+ [40];
_ac = _ac	+ [10];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["PK"];
_a = _a		+ ["100Rnd_762x54_PK"];
_c = _c		+ [45];
_ac = _ac	+ [15];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["huntingrifle"];
_a = _a		+ ["5x_22_LR_17_HMR"];
_c = _c		+ [45];
_ac = _ac	+ [5];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["SVD"];
_a = _a		+ ["10Rnd_762x54_SVD"];
_c = _c		+ [75];
_ac = _ac	+ [8];
_f = _f		+ [Localize "STR_FN_GUE"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

resistancePrimaryWeapons = _w;
resistancePrimaryCosts = _c;
resistancePrimaryAmmo = _a;
resistancePrimaryAmmoCosts = _ac;
resistancePrimaryFactions = _f;

resistancePrimaryNames = [];
resistancePrimaryImages = [];
resistancePrimaryAmmoNames = [];
resistancePrimaryAmmoSpaces = [];
resistancePrimaryAmmoImages = [];

{
	resistancePrimaryNames = resistancePrimaryNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	resistancePrimaryImages = resistancePrimaryImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach resistancePrimaryWeapons;

resistancePrimaryNames Set[0,Localize "STRWFNONE"];

{
	resistancePrimaryAmmoNames = resistancePrimaryAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	resistancePrimaryAmmoImages = resistancePrimaryAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	resistancePrimaryAmmoSpaces = resistancePrimaryAmmoSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach resistancePrimaryAmmo;

_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

_w = _w		+ ["RPG18"];
_a = _a		+ ["RPG18"];
_c = _c		+ [125];
_ac = _ac	+ [30];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["RPG7V"];
_a = _a		+ ["PG7VR"];
_c = _c		+ [150];
_ac = _ac	+ [50];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["MetisLauncher"];
_a = _a		+ ["AT13"];
_c = _c		+ [350];
_ac = _ac	+ [100];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["Stinger"];
_a = _a		+ ["Stinger"];
_c = _c		+ [200];
_ac = _ac	+ [100];
_f = _f		+ [Localize "STR_FN_GUE"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

resistanceSecondaryWeapons = _w;
resistanceSecondaryCosts = _c;
resistanceSecondaryAmmo = _a;
resistanceSecondaryAmmoCosts = _ac;
resistanceSecondaryFactions = _f;

resistanceSecondaryNames = [];
resistanceSecondaryImages = [];
resistanceSecondaryAmmoNames = [];
resistanceSecondaryAmmoSpaces = [];
resistanceSecondaryAmmoImages = [];

{
	resistanceSecondaryNames = resistanceSecondaryNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	resistanceSecondaryImages = resistanceSecondaryImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach resistanceSecondaryWeapons;

resistanceSecondaryNames Set[0,Localize "STRWFNONE"];

{
	resistanceSecondaryAmmoNames = resistanceSecondaryAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	resistanceSecondaryAmmoImages = resistanceSecondaryAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	resistanceSecondaryAmmoSpaces = resistanceSecondaryAmmoSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach resistanceSecondaryAmmo;

_w			= ["None"];
_c			= [0];
_a			= [""];
_ac			= [0];
_f			= ["ALL"];

_w = _w		+ ["Makarov"];
_a = _a		+ ["8Rnd_9x18_Makarov"];
_c = _c		+ [15];
_ac = _ac	+ [2];
_f = _f		+ [Localize "STR_FN_GUE"];

_w = _w		+ ["MakarovSD"];
_a = _a		+ ["8Rnd_9x18_MakarovSD"];
_c = _c		+ [20];
_ac = _ac	+ [3];
_f = _f		+ [Localize "STR_FN_GUE"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

resistanceSidearms = _w;
resistanceSidearmCosts = _c;
resistanceSidearmAmmo = _a;
resistanceSidearmAmmoCosts = _ac;
resistanceSidearmFactions = _f;

resistanceSidearmNames = [];
resistanceSidearmImages = [];
resistanceSidearmAmmoNames = [];
resistanceSidearmAmmoImages = [];

{
	resistanceSidearmNames = resistanceSidearmNames + [GetText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	resistanceSidearmImages = resistanceSidearmImages + [GetText (configFile >> "CfgWeapons" >> _x >> "picture")];
} ForEach resistanceSidearms;

resistanceSidearmNames Set[0,Localize "STRWFNONE"];

{
	resistanceSidearmAmmoNames = resistanceSidearmAmmoNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	resistanceSidearmAmmoImages = resistanceSidearmAmmoImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
} ForEach resistanceSidearmAmmo;

_workarounds = [];
_workarounds1 = [];

_w			= ["None"];
_c			= [0];
_is			= [false];
_f			= ["ALL"];

_weapon		= "HandGrenade";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [false];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "FlareWhite_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "FlareYellow_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "FlareGreen_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "FlareRed_GP25";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_GUE"];

//WORKAROUND - Beginning a variable with a number will cause problems.
//_w = _w	+ ["1Rnd_HE_GP25"];
_w = _w		+ ["Rnd_HE_GP25"];
_workarounds = _workarounds + ["Rnd_HE_GP25"];
_workarounds1 = _workarounds1 + ["1Rnd_HE_GP25"];

_weapon		= "1Rnd_HE_GP25";
_c = _c		+ [5];
_is = _is	+ [true];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "SmokeShell";
_w = _w		+ [_weapon];
_c = _c		+ [5];
_is = _is	+ [false];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "MineE";
_w = _w		+ [_weapon];
_c = _c		+ [20];
_is = _is	+ [false];
_f = _f		+ [Localize "STR_FN_GUE"];

_weapon		= "PipeBomb";
_w = _w		+ [_weapon];
_c = _c		+ [20];
_is = _is	+ [false];
_f = _f		+ [Localize "STR_FN_GUE"];

for [{_count = Count _w - 1},{_count >= 0},{_count = _count - 1}] do
{
	Call Compile Format["%1TYPE = %2",_w Select _count,_count];
};

//WORKAROUND - Now that variable has been created change classname to proper value.
{
	_w Set [_w Find _x,_workarounds1 Select (_workarounds Find _x)];
} ForEach _workarounds;

resistanceMiscWeapons = _w;
resistanceMiscCosts = _c;
resistanceMiscIsSidearmAmmo = _is;
resistanceMiscFactions = _f;

resistanceMiscNames = [];
resistanceMiscImages = [];
resistanceMiscSpaces = [];

{
	resistanceMiscNames = resistanceMiscNames + [GetText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	resistanceMiscImages = resistanceMiscImages + [GetText (configFile >> "CfgMagazines" >> _x >> "picture")];
	resistanceMiscSpaces = resistanceMiscSpaces + [GetNumber (configFile >> "CfgMagazines" >> _x >> "type") / 256];
} ForEach resistanceMiscWeapons;

resistanceMiscNames Set[0,Localize "STRWFNONE"];

//Loadout templates
_n			= [Localize "STRWFCUSTOM"];
_p			= [0];
_pa			= [0];
_s			= [0];
_sa			= [0];
_si			= [0];
_m			= [0];
_ma			= [0];
_m1			= [0];
_ma1		= [0];
_f			= ["ALL"];

_n	= _n	+ [Format["%1/%2",resistancePrimaryNames Select AK_47_MTYPE,resistanceSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_47_MTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_GUE"];

_n	= _n	+ [Format["%1/%2",resistancePrimaryNames Select M16A2TYPE,resistanceSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [M16A2TYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_GUE"];

_n	= _n	+ [Format["%1/%2",resistancePrimaryNames Select AK_74_GLTYPE,resistanceSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AK_74_GLTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [0];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [Rnd_HE_GP25TYPE];
_ma1= _ma1	+ [8];
_f = _f		+ [Localize "STR_FN_GUE"];

_n	= _n	+ [Format["%1/%2",resistancePrimaryNames Select AKS_74_psoTYPE,resistanceSecondaryNames Select RPG7VTYPE]];
_p	= _p	+ [AKS_74_psoTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [RPG7VTYPE];
_sa	= _sa	+ [1];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_GUE"];

_n	= _n	+ [resistancePrimaryNames Select AKS_74_UN_kobraTYPE];
_p	= _p	+ [AKS_74_UN_kobraTYPE];
_pa	= _pa	+ [7];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVSDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [4];
_m1	= _m1	+ [SmokeShellType];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_GUE"];

_n	= _n	+ [resistancePrimaryNames Select PKTYPE];
_p	= _p	+ [PKTYPE];
_pa	= _pa	+ [4];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [6];
_m1	= _m1	+ [0];
_ma1= _ma1	+ [0];
_f = _f		+ [Localize "STR_FN_GUE"];

_n	= _n	+ [resistancePrimaryNames Select SVDTYPE];
_p	= _p	+ [SVDTYPE];
_pa	= _pa	+ [9];
_s	= _s	+ [0];
_sa	= _sa	+ [0];
_si	= _si	+ [MAKAROVSDTYPE];
_m	= _m	+ [HANDGRENADETYPE];
_ma	= _ma	+ [2];
_m1	= _m1	+ [SmokeShellType];
_ma1= _ma1	+ [2];
_f = _f		+ [Localize "STR_FN_GUE"];

//Calculate template costs.
_c = [];
_totalTemplates = Count _n;

for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do
{
	_cost = (resistancePrimaryCosts Select (_p Select _count)) + (resistanceSecondaryCosts Select (_s Select _count)) + (resistanceSidearmCosts Select (_si Select _count));
	_cost = _cost + ((resistancePrimaryAmmoCosts Select (_p Select _count)) * (_pa Select _count));
	_cost = _cost + ((resistanceSecondaryAmmoCosts Select (_s Select _count)) * (_sa Select _count));
	_cost = _cost + (((resistanceMiscCosts Select (_m  Select _count)) * (_ma Select _count)) + ((resistanceMiscCosts Select (_m1 Select _count)) * (_ma1 Select _count)));

	_c = _c + [_cost];
};

resistanceTemplateNames = _n;
resistanceTemplatePrimary = _p;
resistanceTemplatePrimaryAmmo = _pa;
resistanceTemplateSecondary = _s;
resistanceTemplateSecondaryAmmo = _sa;
resistanceTemplateSidearms = _si;
resistanceTemplateMisc = _m;
resistanceTemplateAmount = _ma;
resistanceTemplateMisc1 = _m1;
resistanceTemplateAmount1 = _ma1;
resistanceTemplateCosts = _c;
resistanceTemplateFactions = _f;

resistanceDefaultWeapons = ["AK_47_M"];
resistanceDefaultAmmo = ["30Rnd_762x39_AK47","30Rnd_762x39_AK47","30Rnd_762x39_AK47","30Rnd_762x39_AK47","HandGrenade","HandGrenade","HandGrenade","HandGrenade"];

resistanceSpecOpDefaultWeapons = ["AKS_74_UN_kobra"];
resistanceSpecOpDefaultAmmo = ["30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","HandGrenade","HandGrenade","HandGrenade","HandGrenade"];

//*****************************************************************************************
//3/21/7 MM - Created file.
