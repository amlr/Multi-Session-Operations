private ["_object", "_type", "_magazines", "_weapons", "_backpacks"];
_object = _this select 0;
_type = _this select 1;

if (!isdedicated) then {
	//private "_dist";
	//_dist = if (count _this > 2) then {_this select 2} else {5};
	//[_type,getpos _object,_dist] spawn RMM_fnc_3DText;
};

if (!local _object) exitwith {};

_magazines = [];
_weapons = [];
_backpacks = [];

clearweaponcargoglobal _object;
clearmagazinecargoglobal _object;
clearbackpackcargoglobal _object;

switch (_type) do {
	case "556" : {
		_magazines = [
			["20Rnd_556x45_Stanag",100],
			["30Rnd_556x45_Stanag",200],
			["30Rnd_556x45_StanagSD",50],
			["ACE_30Rnd_556x45_T_Stanag",50],
			["ACE_30Rnd_556x45_SB_Stanag",50],
			["100Rnd_556x45_M249",50],
			["ACE_100Rnd_556x45_T_M249",20],
			["200Rnd_556x45_M249",50],
			["ACE_200Rnd_556x45_T_M249",20],
			["100Rnd_556x45_BetaCMag",50]
		];
	};
	case "762" : {
		_magazines = [
			["ACE_20Rnd_762x51_B_HK417",200],
			["ACE_20Rnd_762x51_SB_HK417",50],
			["100Rnd_762x51_M240",80],
			["ACE_20Rnd_762x51_S_M110",20],
			["ACE_20Rnd_762x51_SB_M110",20],
			["ACE_20Rnd_762x51_T_M110",10],
			["5Rnd_762x51_M24",30],
			["ACE_5Rnd_762x51_T_M24",10]
		];
	};
	case "M4" : {
		_weapons = [
			["ACE_M4",2],
			["ACE_M4_ACOG",2],
			["ACE_M4_Eotech",2],
			["ACE_M4_AIM_GL",2],
			["M4A1",2],
			["ACE_M4A1_ACOG",2],
			["ACE_M4A1_ACOG_SD",2],
			["M4A1_Aim", 2],
			["M4A1_Aim_camo", 2],
			["ACE_M4A1_AIM_GL",2],
			["ACE_M4A1_AIM_GL_SD",2],
			["ACE_M4A1_Aim_SD",2],
			["M4A1_AIM_SD_camo", 2],
			["ACE_M4A1_Eotech",2],
			["M4A1_HWS_GL", 2],
			["M4A1_HWS_GL_camo", 2],
			["M4A1_HWS_GL_SD_Camo", 2],
			["ACE_M4A1_GL",2],
			["ACE_M4A1_GL_SD",2],
			["M4SPR",2],
			["ACE_M4SPR_SD",2],
			["ACE_Mk12mod1",2],
			["ACE_Mk12mod1_SD",2],
			["ACE_SOC_M4A1", 2],
			["ACE_SOC_M4A1_Aim", 2],
			["ACE_SOC_M4A1_AIM_SD", 2],
			["ACE_SOC_M4A1_Eotech", 2],
			["ACE_SOC_M4A1_Eotech_4x", 2],
			["ACE_SOC_M4A1_GL", 2],
			["ACE_SOC_M4A1_GL_13", 2],
			["ACE_SOC_M4A1_GL_AIMPOINT", 2],
			["ACE_SOC_M4A1_GL_EOTECH", 2],
			["ACE_SOC_M4A1_GL_SD", 2],
			["ACE_SOC_M4A1_GL_SD_UP", 2],
			["ACE_SOC_M4A1_GL_UP", 2],
			["ACE_SOC_M4A1_RCO_GL", 2],
			["ACE_SOC_M4A1_RCO_GL_UP", 2],
			["ACE_SOC_M4A1_SD_9", 2],
			["ACE_SOC_M4A1_SHORTDOT", 2],
			["ACE_SOC_M4A1_SHORTDOT_SD", 2],
			["ACE_SOC_M4A1_TWS", 2],
			["ACE_m16a2_scope",2],
			["ACE_m16a2gl_scope",2],
			["ACE_M16A4_Iron",2],
			["M16A4_GL", 2],
			["m16a4", 2],
			["ACE_M16A4_CCO_GL",2],
			["m16a4_acg", 2],
			["M16A4_ACG_GL", 2]
		];
	};
	case "Shotguns" : {
		_weapons = [
			["M1014", 2],
			["ACE_M1014_Eotech", 2],
			["ACE_SPAS12", 2]
		];
		_magazines = [
			["8Rnd_B_Beneli_74Slug", 20],
			["ACE_8Rnd_12Ga_Buck00", 20],
			["ACE_8Rnd_12Ga_Slug", 20]
		];
	};
	case "HK41x" : {
		_weapons = [
			["ACE_HK416_D10", 2],
			["ACE_HK416_D10_AIM", 2],
			["ACE_HK416_D10_COMPM3", 2],
			["ACE_HK416_D10_COMPM3_SD", 2],
			["ACE_HK416_D10_Holo", 2],
			["ACE_HK416_D10_M320", 2],
			["ACE_HK416_D10_M320_UP", 2],
			["ACE_HK416_D10_SD", 2],
			["ACE_HK416_D14", 2],
			["ACE_HK416_D14_ACOG_PVS14", 2],
			["ACE_HK416_D14_COMPM3", 2],
			["ACE_HK416_D14_COMPM3_M320", 2],
			["ACE_HK416_D14_COMPM3_M320_UP", 2],
			["ACE_HK416_D14_SD", 2],
			["ACE_HK416_D14_TWS", 2],
			["ACE_HK417_Eotech_4x", 2],
			["ACE_HK417_leupold", 2],
			["ACE_HK417_micro", 2],
			["ACE_HK417_Shortdot", 2],
			["ACE_M27_IAR",2],
			["ACE_M27_IAR_ACOG",2]
		];
	};
	case "CQB" : {
		_weapons = [
			["ACE_MP5A4", 3],
			["ACE_MP5A5", 3],
			["ACE_MP5SD", 3],
			["ACE_USP",10],
			["ACE_USPSD",5],
			["Colt1911",5],
			["M9",10],
			["M9SD",5],
			["ACE_P226",5],
			["ACE_P8",5]
		];
		_magazines = [
			["30Rnd_9x19_MP5",30],
			["30Rnd_9x19_MP5SD",30],
			["ACE_30Rnd_9x19_S_MP5",30],
			["15Rnd_9x19_M9",40],
			["15Rnd_9x19_M9SD",20],
			["7Rnd_45ACP_1911",20],
			["17Rnd_9x19_glock17",20],
			["ACE_12Rnd_45ACP_USP",40],
			["ACE_12Rnd_45ACP_USPSD",20],
			["ACE_15Rnd_9x19_P226",20],
			["ACE_15Rnd_9x19_P8",20]
		];
	};
	case "MG" : {
		_weapons = [
			["M249",5],
			["M249_EP1",2],
			["M249_m145_EP1",1],
			["M249_TWS_EP1",1],
			["M240",3],
			["m240_scoped_EP1",1],
			["Mk_48",3],
			["Mk_48_DES_EP1",3]
		];
	};
	case "Snipers" : {
		_weapons = [
			["M24", 5],
			["M24_des_EP1", 2],
			["M40A3", 2],
			["ACE_M110", 5],
			["ACE_M110_SD", 2],
			["M110_NVG_EP1", 2],
			["M110_TWS_EP1", 2],
			["ACE_TAC50",2],
			["ACE_TAC50_SD",2],
			["m107", 2],
			["m107_TWS_EP1", 2]
		];
		_magazines = [
			["ACE_5Rnd_127x99_B_TAC50", 20],
			["ACE_5Rnd_127x99_S_TAC50", 10],
			["ACE_5Rnd_127x99_T_TAC50", 10],
			["10Rnd_127x99_m107",10],
			["ACE_10Rnd_127x99_Raufoss_m107",10],
			["ACE_10Rnd_127x99_T_m107",10]
		];
	};
	case "Ordnance" : {
		_magazines = [
			["ACE_M84",20],
			["ACE_ANM14", 10],
			["HandGrenade_West",20],
			["BAF_L109A1_HE",20],
			["ACE_M34",20],
			["ACE_M7A3",20],
			["IR_Strobe_Marker", 10],
			["IR_Strobe_Target", 10],
			["SmokeShell", 20],
			["SmokeShellYellow", 20],
			["SmokeShellRed", 20],
			["SmokeShellGreen", 20],
			["SmokeShellPurple", 20],
			["SmokeShellBlue", 20],
			["SmokeShellOrange", 20],
			["1Rnd_HE_M203",50],
			["1Rnd_Smoke_M203",20],
			["1Rnd_SmokeRed_M203",5],
			["1Rnd_SmokeGreen_M203",5],
			["1Rnd_SmokeYellow_M203",5],
			["FlareWhite_M203",5],
			["FlareGreen_M203",5],
			["FlareRed_M203",5],
			["FlareYellow_M203",5],
			["ACE_FlareIR_M203",5],
			["ACE_1Rnd_HE_M203",20],
			["ACE_1Rnd_CS_M203",10],
			["ACE_1Rnd_PR_M203",5],
			["ACE_SSGreen_M203",5],
			["ACE_SSRed_M203",5],
			["ACE_SSWhite_M203",5],
			["ACE_SSYellow_M203",5],
			["Mine", 20],
			["ACE_BBetty_M", 10],
			["Pipebomb", 15],
			["ACE_C4_M", 20],
			["ACE_Claymore_M", 10],
			["ACE_M2SLAM_M", 10],
			["ACE_M4SLAM_M", 10],
			["ACE_MON50_M", 10],
			["ACE_Pomz_M", 10],
			["ACE_TripFlare_M", 10],
			["ACE_M86PDM", 20]
		];
	};
	case "Equipment" : {
		_weapons = [
			["ACE_WireCutter", 2],
			["Binocular", 50],
			["Binocular_Vector", 35],
			["Laserdesignator", 5],
			["NVGoggles", 100],
			["ACE_Rangefinder_OD", 2],
			["ACE_MX2A", 2],
			["ACE_Earplugs",100],
			["ACE_GlassesBalaklava",10],
			["ACE_GlassesBalaklavaGray",10],
			["ACE_GlassesBalaklavaOlive",10],
			["ACE_GlassesGasMask_US",20],
			["ACE_GlassesTactical",30],
			["ACE_KeyCuffs",20],
			["ACE_Kestrel4500", 5],
			["ACE_SpottingScope", 5],
			["ItemGPS",10],
			["ItemCompass",100],
			["ItemMap",100],
			["ItemRadio",100],
			["ItemWatch",100]
		];
		_magazines = [
			["ACE_Battery_Rangefinder", 10],
			["Laserbatteries", 10]
		];
	};
	case "Para" : {
		_weapons = [
			["ACE_ParachutePack", 100],
			["ACE_ParachuteRoundPack", 100]
		];
	};
	case "M2" : {
		_weapons = [
			["ACE_M2HBProxy",1],
			["ACE_M3TripodProxy",1]
		];
		_magazines = [
			["ACE_M2_CSWDM",6]
		];
	};
	case "Mk19" : {
		_weapons = [
			["ACE_MK19MOD3Proxy",1],
			["ACE_M3TripodProxy",1]
		];
		_magazines = [
			["ACE_MK19_CSWDM",4]
		];
	};
	case "M252" : {
		_weapons = [
			["ACE_M252Proxy",1],
			["ACE_M252TripodProxy",1]
		];
		_magazines = [
			["ACE_M252HE_CSWDM",30],
			["ACE_M252IL_CSWDM",10],
			["ACE_M252WP_CSWDM",10]
		];
	};
	case "M224" : {
		_weapons = [
			["ACE_M224Proxy",1],
			["ACE_M224TripodProxy",1]
		];
		_magazines = [
			["ACE_M224HE_CSWDM",30],
			["ACE_M224IL_CSWDM",10],
			["ACE_M224WP_CSWDM",10]
		];
	};
	case "AT4" : {
		_weapons = [
			["ACE_M136_CSRS",4]
		];
	};
	case "M72" : {
		_weapons = [
			["ACE_M72A2",4]
		];
	};
	case "Sandbags" : {
		_magazines = [
			["ACE_SandBag_Magazine",500]
		];
	};
	case "Ropes" : {
		_magazines = [
			["ACE_Rope_M_50",10],
			["ACE_Rope_M_60",10],
			["ACE_Rope_M_90",10],
			["ACE_Rope_M_120",10],
			["ACE_Rope_M5",10]
		];
	};
	case "Launchers" : {
		_weapons = [
			["Javelin",1],
			["SMAW",1],
			["MAAWS",4],
			["Stinger",1]
		];
		_magazines = [
			["Javelin",4],
			["SMAW_HEAA",5],
			["SMAW_HEDP",5],
			["MAAWS_HEAT",20],
			["MAAWS_HEDP",20],
			["Stinger",3]
		];
	};
	case "Medical" : {
		_weapons = [
			["ACE_Stretcher", 5]
		];
		_magazines = [
			["ACE_Medkit", 20],
			["ACE_Bodybag", 10],
			["ACE_Bandage", 30],
			["ACE_Epinephrine", 30],
			["ACE_Morphine", 30]
		];
	};
};

{_object addWeaponCargoGlobal [_x select 0, _x select 1];} foreach _weapons;
{_object addMagazineCargoGlobal [_x select 0, _x select 1];} foreach _magazines;
{_object addBackpackCargoGlobal [_x select 0, _x select 1];} foreach _backpacks;