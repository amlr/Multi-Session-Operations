_w = [];
_m = [];

if(mps_acre_enabled) then { _w = _w + ["ACRE_PRC148","ACRE_PRC148_UHF","ACRE_PRC117F","ACRE_PRC119","ACRE_PRC343"]; };

if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
	_w = _w +  ["ACE_Earplugs","ACE_Map","ACE_GlassesBalaklava","ACE_GlassesLHD_glasses","ACE_GlassesSunglasses","ACE_GlassesTactical","ACE_ParachutePack","ACE_Rangefinder_OD","ACE_SpottingScope","NVGoggles","ItemCompass","ACE_Broken_GPS","ACE_BrokenRadio","ACE_BrokenWatch","ACE_GlassesGasMask_US","ACE_Backpack_US","ACE_Rucksack_MOLLE_ACU","ACE_Rucksack_MOLLE_ACU_Medic","ACE_ANPRC77"];
	_m = _m +  ["SmokeShellBlue","SmokeShellGreen","SmokeShellPurple","PipeBomb","HandGrenade_West","ACE_Claymore_M","ACE_BBetty_M","ACE_M4SLAM_M","ACE_TripFlare_M","ACE_Rope_M_50","ACE_Rope_M_90","ACE_Rope_M_120","ACE_Rope_TOW_M_5","ACE_Knicklicht_B","ACE_Knicklicht_G"];
	if(mps_ace_wounds) then {_m = _m + ["ACE_Tourniquet","ACE_LargeBandage","ACE_Bandage","ACE_Medkit","ACE_Epinephrine","ACE_Morphine"] };
}else{
	_w = _w +  ["Binocular","NVGoggles","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch","Binocular_Vector"];
	_m = _m +  ["SmokeShellBlue","SmokeShellGreen","SmokeShellPurple","PipeBomb","HandGrenade_West","Mine"];
};

if ( toupper (rank player) IN ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		_w = _w + ["ACE_M4"];
		_w = _w + ["ACE_M4_Aim"];
		_w = _w + ["ACE_MP5A5"];
		_w = _w + ["Colt1911"];
		_w = _w + ["M9"];
		_w = _w + ["ACE_HK416_D10_AIM"];
		_w = _w + ["Laserdesignator"];

		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC"];
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["ACE_SOC_M4A1_Aim"];
		};

		if(mps_player_class == "at") then{
			_w = _w + ["Stinger"];
			_w = _w + ["ACE_M136_CSRS"];
		};

		if(mps_player_class == "sniper") then{
			_w = _w + ["ACE_M14_ACOG"];
		};

		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["M249_EP1"];
			}else{
				_w = _w + ["M249"];
			};
		};
	}else{
		_w = _w + ["M4A1"];
		_w = _w + ["M16A2"];
		_w = _w + ["M9"];
		_w = _w + ["MP5A5"];

		_w = _w + ["Laserdesignator"];

		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC"];
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["M16A2GL"];
			_w = _w + ["M4A1_AIM_SD_camo"];
			if(mps_oa) then {
				_w = _w + ["M14_EP1"];
			};
		};
		if(mps_player_class == "at") then{
			_w = _w + ["Stinger"];
			if(mps_oa) then {
				_w = _w + ["M136"];
			};
		};
		if(mps_player_class == "sniper") then{
			_w = _w + ["M4SPR"];
			if(mps_oa) then {
				_w = _w + ["M24_des_EP1"];
			}else{
				_w = _w + ["M24"];	
			};
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["M249_EP1"];
			}else{
				_w = _w + ["M249"];
			};
		};
	};
};
if ( toupper (rank player) IN ["CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		_w = _w + ["ACE_M4_Eotech"];
		_w = _w + ["ACE_M16A4_GL_UP"];
		_w = _w + ["ACE_M136_CSRS"];
		_w = _w + ["ACE_HK416_D10_Holo"];
		if(mps_oa) then {
			_w = _w + ["M14_EP1"];
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["ACE_SOC_M4A1_Eotech"];
			_w = _w + ["ACE_HK417_Eotech_4x"];
		};

		if(mps_player_class == "at") then{
			_w = _w + ["ACE_M72A2"];
			_w = _w + ["MAAWS"];
		};

		if(mps_player_class == "sniper") then{
			if(mps_oa) then {
				_w = _w + ["M24_des_EP1"];
			}else{
				_w = _w + ["M24"];	
			};
		};
		if(mps_player_class == "mg") then{
			_w = _w + ["ACE_M249_AIM"];
		};
	}else{
		_w = _w + ["M16A4"];
		_w = _w + ["M4A1_Aim"];
		_w = _w + ["M1014"];
		if(mps_player_class == "soldier") then{
			_w = _w + ["M16A4_GL"];
		};
		if(mps_player_class == "at") then{
			_w = _w + ["MAAWS"];
		};
		if(mps_player_class == "sniper") then{
			_w = _w + ["M40A3"];	
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["M249_m145_EP1"];
			};
		};
	};
};

if ( toupper (rank player) IN ["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		_w = _w + ["ACE_M136_CSRS"];
		_w = _w + ["ACE_M1014_Eotech"];
		_w = _w + ["ACE_HK416_D10_M320_UP"];
		_w = _w + ["ACE_HK417_Eotech_4x"];
		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC_CCO_SD"];
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["ACE_SOC_M4A1_GL_EOTECH"];
			_w = _w + ["ACE_SPAS12"];
			_w = _w + ["ACE_HK417_Shortdot"];
			if(mps_oa) then {
				_w = _w + ["SCAR_H_CQC_CCO"];
				_w = _w + ["SCAR_H_CQC_CCO_SD"];
			};
		};

		if(mps_player_class == "at") then{
			_w = _w + ["MAAWS"];
		};

		if(mps_player_class == "sniper") then{
			_w = _w + ["DMR"];
		};

		if(mps_player_class == "mg") then{
			_w = _w + ["ACE_M240L"];
		};
	}else{

		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC_CCO_SD"];
			_w = _w + ["M136"];	
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["M4A1_HWS_GL_camo"];
			
			if(mps_oa) then {
				_w = _w + ["M4A3_CCO_EP1"];
			};
		};
		if(mps_player_class == "at") then{
			_w = _w + ["SMAW"];
		};
		if(mps_player_class == "sniper") then{
			_w = _w + ["DMR"];
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["M60A4_EP1"];
			}else{
				_w = _w + ["M240"];
			};
		};
	};
};
if ( toupper (rank player) IN ["LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		_w = _w + ["ACE_HK417_Shortdot"];
		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC_Holo"];
			_w = _w + ["SCAR_L_STD_HOLO"];
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["ACE_SOC_M4A1_SHORTDOT"];
			if(mps_oa) then {
				_w = _w + ["SCAR_L_STD_Mk4CQT"];
			};
		};
		if(mps_player_class == "at") then{
			_w = _w + ["SMAW"];
		};
		if(mps_player_class == "sniper") then{
			if(mps_oa) then {
				_w = _w + ["SCAR_H_LNG_Sniper"];
			};
		};
		if(mps_player_class == "mg") then{
			_w = _w + ["ACE_M240L_M145"];
		};
	}else{
		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC_Holo"];
			_w = _w + ["SCAR_L_STD_HOLO"];
		};
		if(mps_player_class == "soldier") then{
			_w = _w + ["M4A1_HWS_GL_SD_Camo"];
			_w = _w + ["M16A4_ACG"];
			
			if(mps_oa) then {
				_w = _w + ["SCAR_H_CQC_CCO"];
			};
		};
		if(mps_player_class == "at") then{
			if(mps_oa) then {
				_w = _w + ["M47Launcher_EP1"];
			};
		};
		if(mps_player_class == "sniper") then{
			if(mps_oa) then {
				_w = _w + ["SCAR_H_LNG_Sniper"];
			};
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["Mk_48_DES_EP1"];
			}else{
				_w = _w + ["Mk_48"];
			};
		};
	};
};
if ( toupper (rank player) IN ["CAPTAIN","MAJOR","COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		if(mps_oa) then {
			_w = _w + ["SCAR_L_CQC_EGLM_Holo"];
		};

		if(mps_player_class == "soldier") then{
			_w = _w + ["ACE_SOC_M4A1_RCO_GL_UP"];
			if(mps_oa) then {
				_w = _w + ["SCAR_L_STD_EGLM_RCO"];
			};
		};
		if(mps_player_class == "at") then{
			if(mps_oa) then {
				_w = _w + ["M47Launcher_EP1"];
			};
		};
		if(mps_player_class == "sniper") then{
			if(mps_oa) then {
				_w = _w + ["M110_NVG_EP1"];
			};
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["Mk_48_DES_EP1"];
			}else{
				_w = _w + ["Mk_48"];
			};
		};
	}else{
		if(mps_oa) then {
			_w = _w + ["SCAR_H_CQC_CCO"];
		};
		if(mps_player_class == "soldier") then{
			_w = _w + ["M16A4_ACG_GL"];
			if(mps_oa) then {
				_w = _w + ["SCAR_H_CQC_CCO_SD"];
			};
		};
		if(mps_player_class == "at") then{
			_w = _w + ["Javelin"];
		};
		if(mps_player_class == "sniper") then{
			if(mps_oa) then {
				_w = _w + ["M110_NVG_EP1"];
			};
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {
				_w = _w + ["m240_scoped_EP1"];
			};
		};
	};
};
if ( toupper (rank player) IN ["MAJOR","COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		if(mps_player_class == "soldier") then{
			_w = _w + ["ACE_SCAR_H_STD_Spect"];
		};
		if(mps_player_class == "at") then{
			_w = _w + ["ACE_Javelin_CLU"];
			_w = _w + ["ACE_Javelin_Direct"];
		};
		if(mps_player_class == "sniper") then{
			_w = _w + ["m107"];
		};
		if(mps_player_class == "mg") then{
			if(mps_oa) then {_w = _w + ["M60A4_EP1"];};
		};
	}else{
		if(mps_player_class == "soldier") then{
			_w = _w + ["M4A1_RCO_GL"];
			if(mps_oa) then {_w = _w + ["SCAR_L_STD_Mk4CQT"];};
		};
		if(mps_player_class == "sniper") then{
			_w = _w + ["m107"];
		};
	};
};
if ( toupper (rank player) IN ["COLONEL"] ) then {
	if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
		if(mps_player_class == "sniper") then{
			_w = _w + ["ACE_TAC50_SD"];
		};
	}else{
		if(mps_player_class == "soldier") then{
			if(mps_oa) then {_w = _w + ["M4A3_RCO_GL_EP1"];	};
		};
		if(mps_player_class == "sniper") then{
			_w = _w + ["m107"];
		};
	};
};

if( if(isNil "mps_ace_enabled") then {false}else{mps_ace_enabled}) then{
	_m = _m + ["10Rnd_127x99_m107","15Rnd_9x19_M9","30Rnd_556x45_Stanag","5Rnd_762x51_M24","7Rnd_45ACP_1911",
		"ACE_100Rnd_556x45_T_M249","ACE_1Rnd_CS_M203","ACE_1Rnd_HE_M203","ACE_200Rnd_556x45_T_M249",
		"ACE_20Rnd_762x51_S_SCAR","ACE_20Rnd_762x51_T_DMR","ACE_20Rnd_762x51_T_DMR","ACE_20Rnd_762x51_T_HK417",
		"ACE_20Rnd_762x51_T_SCAR","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_T_Stanag","ACE_30Rnd_9x19_S_MP5",
		"ACE_5Rnd_127x99_B_TAC50","ACE_5Rnd_127x99_S_TAC50","ACE_5Rnd_127x99_T_TAC50","ACE_8Rnd_12Ga_Buck00",
		"ACE_8Rnd_12Ga_Slug","ACE_FlareIR_M203","ACE_HuntIR_M203","ACE_Javelin_Direct","ACE_M136_CSRS","ACE_M576",
		"ACE_M72A2","ACE_SMAW_NE","ACE_SSGreen_M203","ACE_SSRed_M203","ACE_SSRed_M203","ACE_SSWhite_M203",
		"ACE_SSWhite_M203","ACE_SSYellow_M203","Dragon_EP1","FlareRed_M203","FlareWhite_M203","Laserbatteries",
		"Stinger"
	];
}else{
	_m = _m + [
		"100Rnd_762x51_M240","10Rnd_127x99_m107","15Rnd_9x19_M9","1Rnd_HE_M203","1Rnd_Smoke_M203",
		"1Rnd_SmokeGreen_M203","1Rnd_SmokeRed_M203","1Rnd_SmokeYellow_M203","20Rnd_556x45_Stanag",
		"20Rnd_762x51_B_SCAR","20Rnd_762x51_DMR","20Rnd_762x51_SB_SCAR","30Rnd_556x45_Stanag",
		"30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","5Rnd_762x51_M24","8Rnd_B_Beneli_74Slug","Dragon_EP1",
		"FlareGreen_M203","FlareRed_M203","FlareWhite_M203","FlareYellow_M203","Javelin","Laserbatteries",
		"M136","MAAWS_HEAT","MAAWS_HEDP","SMAW_HEAA","SMAW_HEDP","Stinger"
	];
};

mps_armoury_weapons = _w;
mps_armoury_mags = _m;