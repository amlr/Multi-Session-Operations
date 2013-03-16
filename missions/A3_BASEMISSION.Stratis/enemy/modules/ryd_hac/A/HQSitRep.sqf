//waituntil {false};

RydHQ_PersDone = false;
RydHQ = GrpNull;

RydHQ = group leaderHQ;

waituntil {not (isNull RydHQ)};
nul = [] execVM (RYD_HAC_PATH + "A\HQReset.sqf");
nul = [] execVM (RYD_HAC_PATH + "A\Personality.sqf");
waituntil {RydHQ_PersDone};

//_cats = [RHQ_Recon,RHQ_FO,RHQ_Snipers,RHQ_ATInf,RHQ_AAInf,RHQ_Inf,RHQ_Art,RHQ_HArmor,RHQ_LArmor,RHQ_LArmorAT,RHQ_Cars,RHQ_Air,RHQ_Naval,RHQ_Static,RHQ_StaticAA,RHQ_StaticAT,RHQ_Support,RHQ_Cargo,RHQ_NCCargo,RHQ_Crew,RHQ_Other];
if (isNil ("RHQ_Recon")) then {RHQ_Recon = []};
if (isNil ("RHQ_Snipers")) then {RHQ_Snipers = []};
if (isNil ("RHQ_ATInf")) then {RHQ_ATInf = []};
if (isNil ("RHQ_AAInf")) then {RHQ_AAInf = []};
if (isNil ("RHQ_Inf")) then {RHQ_Inf = []};
if (isNil ("RHQ_Art")) then {RHQ_Art = []};
if (isNil ("RHQ_HArmor")) then {RHQ_HArmor = []};
if (isNil ("RHQ_LArmor")) then {RHQ_LArmor = []};
if (isNil ("RHQ_LArmorAT")) then {RHQ_LArmorAT = []};
if (isNil ("RHQ_Cars")) then {RHQ_Cars = []};
if (isNil ("RHQ_Air")) then {RHQ_Air = []};
if (isNil ("RHQ_Naval")) then {RHQ_Naval = []};
if (isNil ("RHQ_Static")) then {RHQ_Static = []};
if (isNil ("RHQ_StaticAA")) then {RHQ_StaticAA = []};
if (isNil ("RHQ_StaticAT")) then {RHQ_StaticAT = []};
if (isNil ("RHQ_Support")) then {RHQ_Support = []};
if (isNil ("RHQ_Cargo")) then {RHQ_Cargo = []};
if (isNil ("RHQ_NCCargo")) then {RHQ_NCCargo = []};
if (isNil ("RHQ_Other")) then {RHQ_Other = []};
if (isNil ("RHQ_Crew")) then {RHQ_Crew = []};
	
_recon = RHQ_Recon + ["FR_TL","FR_Sykes","FR_R","FR_Rodriguez","FR_OHara","FR_Miles","FR_Marksman","FR_AR","FR_GL","FR_AC","FR_Sapper","FR_Corpsman","FR_Cooper","FR_Commander","FR_Assault_R","FR_Assault_GL","USMC_SoldierS_Spotter","USMC_SoldierS","MQ9PredatorB","CDF_Soldier_Spotter","RU_Soldier_Spotter","RUS_Soldier3","Pchela1T","Ins_Soldier_Sniper","GUE_Soldier_Scout"];
_FO = RHQ_FO + ["USMC_SoldierS_Spotter","CDF_Soldier_Spotter","RU_Soldier_Spotter","Ins_Soldier_CO","GUE_Soldier_Scout","GUE_Soldier_Scout"];
_snipers = RHQ_Snipers + ["USMC_SoldierS_Sniper","USMC_SoldierS_SniperH","USMC_SoldierM_Marksman","FR_Marksman","CDF_Soldier_Sniper","CDF_Soldier_Marksman","RU_Soldier_Marksman","RU_Soldier_Sniper","RU_Soldier_SniperH","MVD_Soldier_Marksman","MVD_Soldier_Sniper","RUS_Soldier_Marksman","Ins_Soldier_Sniper","GUE_Soldier_Sniper"];
_ATinf = RHQ_ATInf + ["USMC_Soldier_HAT","USMC_Soldier_AT","USMC_Soldier_LAT","HMMWV_TOW","CDF_Soldier_RPG","RU_Soldier_HAT","RU_Soldier_AT","RU_Soldier_LAT","MVD_Soldier_AT","Ins_Soldier_AT","GUE_Soldier_AT"];
_AAinf = RHQ_AAInf + ["USMC_Soldier_AA","HMMWV_Avenger","CDF_Soldier_Strela","Ural_ZU23_CDF","RU_Soldier_AA","2S6M_Tunguska","Ins_Soldier_AA","ZSU_INS","Ural_ZU23_INS","GUE_Soldier_AA","Ural_ZU23_Gue"];
_Inf = RHQ_Inf + ["GUE_Commander","GUE_Soldier_Scout","GUE_Soldier_Sab","GUE_Soldier_AA","GUE_Soldier_AT","GUE_Soldier_1","GUE_Soldier_2","GUE_Soldier_3","GUE_Soldier_Pilot","GUE_Soldier_Medic","GUE_Soldier_MG","GUE_Soldier_Sniper","GUE_Soldier_GL","GUE_Soldier_Crew","GUE_Soldier_CO","GUE_Soldier_AR","Ins_Woodlander1","Ins_Villager4","Ins_Worker2","Ins_Woodlander2","Ins_Woodlander3","Ins_Villager3","Ins_Soldier_Sniper","Ins_Soldier_Sapper","Ins_Soldier_Sab","Ins_Soldier_2","Ins_Soldier_1","Ins_Soldier_Pilot","Ins_Soldier_CO","Ins_Soldier_Medic","Ins_Soldier_MG","Ins_Bardak","Ins_Soldier_GL","Ins_Soldier_Crew","Ins_Commander","Ins_Lopotev","Ins_Soldier_AR","Ins_Soldier_AT","Ins_Soldier_AA","RUS_Soldier_TL","RUS_Soldier3","RUS_Soldier2","RUS_Soldier1","RUS_Commander","RUS_Soldier_Marksman","RUS_Soldier_GL","RUS_Soldier_Sab","MVD_Soldier_TL","MVD_Soldier_Sniper","MVD_Soldier_AT","MVD_Soldier_GL","MVD_Soldier","MVD_Soldier_Marksman","MVD_Soldier_MG","RU_Soldier_TL","RU_Soldier_SL","RU_Soldier_Spotter","RU_Soldier_SniperH","RU_Soldier_Sniper","RU_Soldier2","RU_Soldier_AT","RU_Soldier_LAT","RU_Soldier","RU_Soldier_Pilot","RU_Soldier_Officer","RU_Soldier_Medic","RU_Soldier_Marksman","RU_Soldier_MG","RU_Soldier_GL","RU_Commander","RU_Soldier_Crew","RU_Soldier_AR","RU_Soldier_HAT","RU_Soldier_AA","CDF_Soldier_TL","CDF_Soldier_Spotter","CDF_Soldier_Light","CDF_Soldier_Sniper","CDF_Soldier","CDF_Soldier_Pilot","CDF_Soldier_Officer","CDF_Soldier_Militia","CDF_Soldier_Medic","CDF_Soldier_Marksman","CDF_Soldier_MG","CDF_Soldier_GL","CDF_Commander","CDF_Soldier_Engineer","CDF_Soldier_Crew","CDF_Soldier_AR","CDF_Soldier_RPG","CDF_Soldier_Strela","FR_TL","FR_Sykes","FR_R","FR_Rodriguez","FR_OHara","FR_Miles","FR_Marksman","FR_AR","FR_GL","FR_AC","FR_Sapper","FR_Corpsman","FR_Cooper","FR_Commander","FR_Assault_R","FR_Assault_GL","USMC_Soldier_SL","USMC_SoldierS_Spotter","USMC_SoldierS_SniperH","USMC_SoldierS_Sniper","USMC_SoldierS","USMC_Soldier_LAT","USMC_Soldier2","USMC_Soldier","USMC_Soldier_Pilot","USMC_Soldier_Officer","USMC_Soldier_MG","USMC_Soldier_GL","USMC_Soldier_TL","USMC_SoldierS_Engineer","USMC_SoldierM_Marksman","USMC_Soldier_Crew","USMC_Soldier_Medic","USMC_Soldier_AR","USMC_Soldier_AT","USMC_Soldier_HAT","USMC_Soldier_AA"];
_Art = RHQ_Art + ["2b14_82mm_GUE","2b14_82mm_INS","GRAD_INS","2b14_82mm","D30_RU","GRAD_RU","2b14_82mm_CDF","D30_CDF","GRAD_CDF","MLRS","M252","M119"];
_HArmor = RHQ_HArmor + ["T72_Gue","T34","T72_INS","T90","T72_RU","T72_CDF","M1A1","M1A2_TUSK_MG"];
_LArmor = RHQ_LArmor + ["BRDM2_HQ_Gue","BRDM2_Gue","BMP2_Gue","ZSU_INS","BRDM2_ATGM_INS","BRDM2_INS","BMP2_HQ_INS","BMP2_INS","GAZ_Vodnik_HMG","GAZ_Vodnik","BTR90_HQ","BTR90","BMP3","2S6M_Tunguska","ZSU_CDF","BRDM2_ATGM_CDF","BRDM2_CDF","BMP2_HQ_CDF","BMP2_CDF","LAV25_HQ","LAV25","AAV"];
_LArmorAT = RHQ_LArmorAT + ["BMP2_Gue","BRDM2_ATGM_INS","BMP2_INS","BTR90","BMP3","BRDM2_ATGM_CDF","BMP2_CDF"];
_Cars = RHQ_Cars + ["Ural_ZU23_Gue","V3S_Gue","Pickup_PK_GUE","Offroad_SPG9_Gue","Offroad_DSHKM_Gue","TT650_Gue","UralRepair_INS","UralRefuel_INS","UralReammo_INS","BMP2_Ambul_INS","Ural_ZU23_INS","UralOpen_INS","Ural_INS","UAZ_SPG9_INS","UAZ_MG_INS","UAZ_AGS30_INS","UAZ_INS","Pickup_PK_INS","Offroad_DSHKM_INS","TT650_Ins","GRAD_INS","GAZ_Vodnik_MedEvac","KamazRepair","KamazRefuel","KamazReammo","KamazOpen","Kamaz","UAZ_AGS30_RU","UAZ_RU","GRAD_RU","UralRepair_CDF","UralRefuel_CDF","UralReammo_CDF","BMP2_Ambul_CDF","Ural_ZU23_CDF","UralOpen_CDF","Ural_CDF","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","GRAD_CDF","MtvrRepair","MtvrRefuel","MtvrReammo","HMMWV_Ambulance","TowingTractor","MTVR","MMT_USMC","M1030","HMMWV_Avenger","HMMWV_TOW","HMMWV_MK19","HMMWV_Armored","HMMWV_M2","HMMWV"];
_Air = RHQ_Air + ["Mi17_medevac_Ins","Su25_Ins","Mi17_Ins","Mi17_medevac_RU","Su34","Su39","Pchela1T","Mi17_rockets_RU","Mi24_V","Mi24_P","Ka52Black","Ka52","Mi17_medevac_CDF","Su25_CDF","Mi24_D","Mi17_CDF","MV22","C130J","MQ9PredatorB","AH64D","UH1Y","MH60S","F35B","AV8B","AV8B2","AH1Z","A10"];
_Naval = RHQ_Naval + ["PBX","RHIB2Turret","RHIB","Zodiac"];
_Static = RHQ_Static + ["GUE_WarfareBMGNest_PK","ZU23_Gue","SPG9_Gue","2b14_82mm_GUE","DSHKM_Gue","Ins_WarfareBMGNest_PK","ZU23_Ins","SPG9_Ins","2b14_82mm_INS","DSHkM_Mini_TriPod","DSHKM_Ins","D30_Ins","AGS_Ins","RU_WarfareBMGNest_PK","CDF_WarfareBMGNest_PK","USMC_WarfareBMGNest_M240","2b14_82mm","Metis","KORD","KORD_high","D30_RU","AGS_RU","Igla_AA_pod_East","ZU23_CDF","SPG9_CDF","2b14_82mm_CDF","DSHkM_Mini_TriPod_CDF","DSHKM_CDF","D30_CDF","AGS_CDF","TOW_TriPod","MK19_TriPod","M2HD_mini_TriPod","M252","M2StaticMG","M119","Stinger_Pod","Fort_Nest_M240"];
_StaticAA = RHQ_StaticAA + ["ZU23_Gue","ZU23_Ins","Igla_AA_pod_East","ZU23_CDF","Stinger_Pod"];
_StaticAT = RHQ_StaticAT + ["SPG9_Gue","SPG9_Ins","Metis","SPG9_CDF","TOW_TriPod"];
_Support = RHQ_Support + ["UralRepair_INS","UralRefuel_INS","UralReammo_INS","Mi17_medevac_Ins","BMP2_Ambul_INS","GAZ_Vodnik_MedEvac","KamazRepair","KamazRefuel","Mi17_medevac_RU","KamazReammo","UralRepair_CDF","UralRefuel_CDF","UralReammo_CDF","Mi17_medevac_CDF","BMP2_Ambul_CDF","MtvrRepair","MtvrRefuel","MtvrReammo","HMMWV_Ambulance"];
_Cargo = RHQ_Cargo + ["V3S_Gue","Pickup_PK_GUE","Offroad_SPG9_Gue","Offroad_DSHKM_Gue","BRDM2_HQ_Gue","BRDM2_Gue","BMP2_Gue","Mi17_medevac_Ins","BMP2_Ambul_INS","UralOpen_INS","Ural_INS","UAZ_SPG9_INS","UAZ_MG_INS","UAZ_AGS30_INS","UAZ_INS","Pickup_PK_INS","Offroad_DSHKM_INS","BRDM2_ATGM_INS","BRDM2_INS","BMP2_HQ_INS","BMP2_INS","Mi17_Ins","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","PBX","KamazOpen","Kamaz","UAZ_AGS30_RU","UAZ_RU","GAZ_Vodnik_HMG","GAZ_Vodnik","BTR90_HQ","BTR90","BMP3","Mi17_rockets_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","UralOpen_CDF","Ural_CDF","UAZ_MG_CDF","UAZ_AGS30_CDF","UAZ_CDF","BRDM2_ATGM_CDF","BRDM2_CDF","BMP2_HQ_CDF","BMP2_CDF","Mi17_CDF","HMMWV_Ambulance","RHIB2Turret","RHIB","Zodiac","MTVR","HMMWV_TOW","HMMWV_MK19","HMMWV_Armored","HMMWV_M2","HMMWV","LAV25_HQ","LAV25","AAV","UH1Y","MH60S","MV22","C130J"];
_NCCargo = RHQ_NCCargo + ["V3S_Gue","Mi17_medevac_Ins","BMP2_Ambul_INS","UralOpen_INS","Ural_INS","UAZ_INS","GAZ_Vodnik_MedEvac","Mi17_medevac_RU","PBX","KamazOpen","Kamaz","UAZ_RU","Mi17_medevac_CDF","BMP2_Ambul_CDF","UralOpen_CDF","Ural_CDF","UAZ_CDF","HMMWV_Ambulance","Zodiac","MTVR","HMMWV","MV22","C130J"];
_Other = RHQ_Other + [];

_Crew = RHQ_Crew + ["GUE_Soldier_Pilot","INS_Soldier_Pilot","RU_Soldier_Pilot","CDF_Soldier_Pilot","USMC_Soldier_Pilot","GUE_Soldier_Crew","INS_Soldier_Crew","RU_Soldier_Crew","CDF_Soldier_Crew","USMC_Soldier_Crew"];
/*
_ModSideHQ = createCenter sideLogic;
_group = creategroup sideLogic;
_funcmod = _group createUnit ["FunctionsManager", [1200,1200], [], 0, "NONE"];
waituntil {sleep 1.1; not (isnil ("bis_fnc_init"))};
*/
RydHQ_ReconDone = false;
RydHQ_DefDone = false;
RydHQ_ReconStage = 1;
RydHQ_KnEnPos = [];
RydHQ_AirInDef = [];
if (isNil ("RydHQ_Excluded")) then {RydHQ_Excluded = []};
if (isNil ("RydHQ_Fast")) then {RydHQ_Fast = false};

RydHQ_Init = true;

RydHQ_Inertia = 0;
RydHQ_Morale = 0;
RydHQ_CInitial = 0;
RydHQ_CLast = 0;
RydHQ_CCurrent = 0;
RydHQ_CIMoraleC = 0;
RydHQ_CLMoraleC = 0;
RydHQ_Surrender = false;
RydHQ_Cycle = 0;
RydHQ_FirstEMark = true;
RydHQ_LastE = 0;

sleep 60;

while {not ((isNull RydHQ) or (RydHQ_Surrender))} do
	{
	//diag_Log format ["(A) A done: %1 B done: %2",RydHQ_Done,RydHQB_Done];
	if not (RydHQ_Fast) then {waituntil {sleep 1.1;((RydHQ_Done) and (RydHQB_Done))}};
	RydHQ_Cycle = RydHQ_Cycle + 1;
	diag_log format ["MSO-%1 HETMAN: RydHQ_Cycle = %2", time, RydHQ_Cycle];
	RydHQ_Done = false;
	leaderHQ = leader RydHQ;
	RydHQ_recon = [];
	RydHQ_FO = [];
	RydHQ_snipers = [];
	RydHQ_ATinf = [];
	RydHQ_AAinf = [];
	RydHQ_Inf = [];
	RydHQ_Art = [];
	RydHQ_HArmor = [];
	RydHQ_LArmor = [];
	RydHQ_LArmorAT = [];
	RydHQ_Cars = [];
	RydHQ_Air = [];
	RydHQ_Naval = [];
	RydHQ_Static = [];
	RydHQ_StaticAA = [];
	RydHQ_StaticAT = [];
	RydHQ_Support = [];
	RydHQ_Cargo = [];
	RydHQ_NCCargo = [];
	RydHQ_Other = [];

	RydHQ_reconG = [];
	RydHQ_FOG = [];
	RydHQ_snipersG = [];
	RydHQ_ATinfG = [];
	RydHQ_AAinfG = [];
	RydHQ_InfG = [];
	RydHQ_ArtG = [];
	RydHQ_HArmorG = [];
	RydHQ_LArmorG = [];
	RydHQ_LArmorATG = [];
	RydHQ_CarsG = [];
	RydHQ_AirG = [];
	RydHQ_NavalG = [];
	RydHQ_StaticG = [];
	RydHQ_StaticAAG = [];
	RydHQ_StaticATG = [];
	RydHQ_SupportG = [];
	RydHQ_CargoG = [];
	RydHQ_NCCargoG = [];
	RydHQ_OtherG = [];

	RydHQ_Enrecon = [];
	RydHQ_EnFO = [];
	RydHQ_Ensnipers = [];
	RydHQ_EnATinf = [];
	RydHQ_EnAAinf = [];
	RydHQ_EnInf = [];
	RydHQ_EnArt = [];
	RydHQ_EnHArmor = [];
	RydHQ_EnLArmor = [];
	RydHQ_EnLArmorAT = [];
	RydHQ_EnCars = [];
	RydHQ_EnAir = [];
	RydHQ_EnNaval = [];
	RydHQ_EnStatic = [];
	RydHQ_EnStaticAA = [];
	RydHQ_EnStaticAT = [];
	RydHQ_EnSupport = [];
	RydHQ_EnCargo = [];
	RydHQ_EnNCCargo = [];
	RydHQ_EnOther = [];

	RydHQ_EnreconG = [];
	RydHQ_EnFOG = [];
	RydHQ_EnsnipersG = [];
	RydHQ_EnATinfG = [];
	RydHQ_EnAAinfG = [];
	RydHQ_EnInfG = [];
	RydHQ_EnArtG = [];
	RydHQ_EnHArmorG = [];
	RydHQ_EnLArmorG = [];
	RydHQ_EnLArmorATG = [];
	RydHQ_EnCarsG = [];
	RydHQ_EnAirG = [];
	RydHQ_EnNavalG = [];
	RydHQ_EnStaticG = [];
	RydHQ_EnStaticAAG = [];
	RydHQ_EnStaticATG = [];
	RydHQ_EnSupportG = [];
	RydHQ_EnCargoG = [];
	RydHQ_EnNCCargoG = [];
	RydHQ_EnOtherG = [];

	RydHQ_LastE = count RydHQ_KnEnemies;

	RydHQ_Friends = [];
	RydHQ_Enemies = [];
	RydHQ_KnEnemies = [];
	RydHQ_KnEnemiesG = [];
	RydHQ_FValue = 0;
	RydHQ_EValue = 0;

	// Register all OPFOR groups with HQ (exclude CIVS)
		{
		if not ((isNull (leaderHQ)) and not (isNull _x) and (alive (leaderHQ)) and (alive (leader _x))) then
			{
			switch ((side _x) getFriend (side RydHQ) < 0.6) do
				{
				case true : {if not (_x in RydHQ_Enemies) then {RydHQ_Enemies = RydHQ_Enemies + [_x]}};

				case false : {if (not (_x in RydHQ_Friends) and not 
					(((leader _x) in RydHQ_Excluded) or 
						(faction (leader _x) == "CIV") or 
							(faction (leader _x) == "CIV_RU") or 
								(faction (leader _x) == "BIS_TK_CIV") or 
									(faction (leader _x) == "BIS_CIV_special"))) then 
						{
						RydHQ_Friends = RydHQ_Friends + [_x]
						}
					};
				}
			}
		}
	foreach allGroups;

	RydHQ_Friends = RydHQ_Friends - [RydHQ];

	// Count OPFOR numbers
	if (RydHQ_Init) then 
		{
			{
			RydHQ_CInitial = RydHQ_CInitial + (count (units _x))
			}
		foreach RydHQ_Friends
		};

	RydHQ_CLast = RydHQ_CCurrent;
	RydHQ_CCurrent = 0;
		{
		RydHQ_CCurrent = RydHQ_CCurrent + (count (units _x))
		}
	foreach RydHQ_Friends;
	
	if (RydHQ_Debug) then {diag_log format ["MSO-%1 HETMAN: Friendly Groups: %2. Friendly Units: %3",time, count RydHQ_Friends, RydHQ_CCurrent]};
	if (RydHQ_Debug) then {diag_log format ["MSO-%1 HETMAN: Enemy Groups: %2",time, count RydHQ_Enemies]};

	// Work out which enemies OPFOR know abouts
		{
		for [{_a = 0},{_a < count (units _x)},{_a = _a + 1}] do
			{
			_enemyU = vehicle ((units _x) select _a);
				{
				if ((_x knowsAbout _enemyU) >= 0.05) exitwith 
					{
					if not (_enemyU in RydHQ_KnEnemies) then {RydHQ_KnEnemies = RydHQ_KnEnemies + [_enemyU]};
					if not ((group _enemyU) in RydHQ_KnEnemiesG) then {RydHQ_KnEnemiesG = RydHQ_KnEnemiesG + [(group _enemyU)]}
					} 
				}
			foreach (RydHQ_Friends + [RydHQ])
			}
		}
	foreach RydHQ_Enemies;
	
	

	// Adjust Morale
	if not (RydHQ_Init) then {RydHQ_Morale = RydHQ_Morale + ((RydHQ_CCurrent - RydHQ_CInitial) + (2 * (RydHQ_CCurrent - RydHQ_CLast)))/((10*RydHQ_CInitial)/(1 + (count RydHQ_KnEnemies)))};
	if (RydHQ_Debug) then {diag_log format ["MSO-%1 HETMAN: Morale A: %2",time, RydHQ_Morale]};
	if (RydHQ_Morale < -50) then {RydHQ_Morale = -50};

	if ((((count RydHQ_KnEnemies)/RydHQ_CCurrent) > (4/(1 - (RydHQ_Morale/12.5)))) and ((Random 100) > (95 + (RydHQ_Morale*((count RydHQ_KnEnemies)/RydHQ_CCurrent)/4))) and not (RydHQB_Surrender)) exitwith {RydHQ_Surrender = true;nul = ["A"] execVM (RYD_HAC_PATH + "Surr.sqf")};	

	RydHQ_Init = false;
		{
			{
			_reconcheck = false;
			_FOcheck = false;
			_sniperscheck = false;
			_ATinfcheck = false;
			_AAinfcheck = false;
			_Infcheck = false;
			_Artcheck = false;
			_HArmorcheck = false;
			_LArmorcheck = false;
			_LArmorATcheck = false;
			_Carscheck = false;
			_Aircheck = false;
			_Navalcheck = false;
			_Staticcheck = false;
			_StaticAAcheck = false;
			_StaticATcheck = false;
			_Supportcheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Othercheck = true;

			switch true do
				{
				case ((typeof (vehicle _x)) in _recon) : {_reconcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _FO) : {_FOcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _snipers) : {_sniperscheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _ATinf) : {_ATinfcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _AAinf) : {_AAinfcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Inf) : {_Infcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Art) : {_Artcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _HArmor) : {_HArmorcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _LArmor) : {_LArmorcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _LArmorAT) : {_LArmorATcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Cars) : {_Carscheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Air) : {_Aircheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Naval) : {_Navalcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Static) : {_Staticcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _StaticAA) : {_StaticAAcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _StaticAT) : {_StaticATcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Support) : {_Supportcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Cargo) : {_Cargocheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _NCCargo) : {_NCCargocheck = true;_Othercheck = false};

				case (((typeof _x) in _Inf) and ((typeof (vehicle _x)) in _Cargo) and not (typeof _x in _Crew)) : {_Infcheck = true;_Othercheck = false};

				default {}
				};

			switch true do
				{
				case (_reconcheck) : {if not ((vehicle _x) in RydHQ_recon) then {RydHQ_recon = RydHQ_recon + [(vehicle _x)]};if not ((group _x) in RydHQ_reconG) then {RydHQ_reconG = RydHQ_reconG + [(group _x)]}};
				case (_FOcheck) : {if not ((vehicle _x) in RydHQ_FO) then {RydHQ_FO = RydHQ_FO + [(vehicle _x)]};if not ((group _x) in RydHQ_FOG) then {RydHQ_FOG = RydHQ_FOG + [(group _x)]}};
				case (_sniperscheck) : {if not ((vehicle _x) in RydHQ_snipers) then {RydHQ_snipers = RydHQ_snipers + [(vehicle _x)]};if not ((group _x) in RydHQ_snipersG) then {RydHQ_snipersG = RydHQ_snipersG + [(group _x)]}};
				case (_ATinfcheck) : {if not ((vehicle _x) in RydHQ_ATinf) then {RydHQ_ATinf = RydHQ_ATinf + [(vehicle _x)]};if not ((group _x) in RydHQ_ATinfG) then {RydHQ_ATinfG = RydHQ_ATinfG + [(group _x)]}};
				case (_AAinfcheck) : {if not ((vehicle _x) in RydHQ_AAinf) then {RydHQ_AAinf = RydHQ_AAinf + [(vehicle _x)]};if not ((group _x) in RydHQ_AAinfG) then {RydHQ_AAinfG = RydHQ_AAinfG + [(group _x)]}};
				case (_Infcheck) : {if not ((vehicle _x) in RydHQ_Inf) then {RydHQ_FValue = RydHQ_FValue + 1;RydHQ_Inf = RydHQ_Inf + [(vehicle _x)]};if not ((group _x) in RydHQ_InfG) then {RydHQ_InfG = RydHQ_InfG + [(group _x)]}};
				case (_Artcheck) : {if not ((vehicle _x) in RydHQ_Art) then {RydHQ_FValue = RydHQ_FValue + 3;RydHQ_Art = RydHQ_Art + [(vehicle _x)]};if not ((group _x) in RydHQ_ArtG) then {RydHQ_ArtG = RydHQ_ArtG + [(group _x)]}};
				case (_HArmorcheck) : {if not ((vehicle _x) in RydHQ_HArmor) then {RydHQ_FValue = RydHQ_FValue + 10;RydHQ_HArmor = RydHQ_HArmor + [(vehicle _x)]};if not ((group _x) in RydHQ_HArmorG) then {RydHQ_HArmorG = RydHQ_HArmorG + [(group _x)]}};
				case (_LArmorcheck) : {if not ((vehicle _x) in RydHQ_LArmor) then {RydHQ_FValue = RydHQ_FValue + 5;RydHQ_LArmor = RydHQ_LArmor + [(vehicle _x)]};if not ((group _x) in RydHQ_LArmorG) then {RydHQ_LArmorG = RydHQ_LArmorG + [(group _x)]}};
				case (_LArmorATcheck) : {if not ((vehicle _x) in RydHQ_LArmorAT) then {RydHQ_LArmorAT = RydHQ_LArmorAT + [(vehicle _x)]};if not ((group _x) in RydHQ_LArmorATG) then {RydHQ_LArmorATG = RydHQ_LArmorATG + [(group _x)]}};
				case (_Carscheck) : {if not ((vehicle _x) in RydHQ_Cars) then {RydHQ_FValue = RydHQ_FValue + 3;RydHQ_Cars = RydHQ_Cars + [(vehicle _x)]};if not ((group _x) in RydHQ_CarsG) then {RydHQ_CarsG = RydHQ_CarsG + [(group _x)]}};
				case (_Aircheck) : {if not ((vehicle _x) in RydHQ_Air) then {RydHQ_FValue = RydHQ_FValue + 15;RydHQ_Air = RydHQ_Air + [(vehicle _x)]};if not ((group _x) in RydHQ_AirG) then {RydHQ_AirG = RydHQ_AirG + [(group _x)]}};
				case (_Navalcheck) : {if not ((vehicle _x) in RydHQ_Naval) then {RydHQ_Naval = RydHQ_Naval + [(vehicle _x)]};if not ((group _x) in RydHQ_NavalG) then {RydHQ_NavalG = RydHQ_NavalG + [(group _x)]}};
				case (_Staticcheck) : {if not ((vehicle _x) in RydHQ_Static) then {RydHQ_FValue = RydHQ_FValue + 1;RydHQ_Static = RydHQ_Static + [(vehicle _x)]};if not ((group _x) in RydHQ_StaticG) then {RydHQ_StaticG = RydHQ_StaticG + [(group _x)]}};
				case (_StaticAAcheck) : {if not ((vehicle _x) in RydHQ_StaticAA) then {RydHQ_StaticAA = RydHQ_StaticAA + [(vehicle _x)]};if not ((group _x) in RydHQ_StaticAAG) then {RydHQ_StaticAAG = RydHQ_StaticAAG + [(group _x)]}};
				case (_StaticATcheck) : {if not ((vehicle _x) in RydHQ_StaticAT) then {RydHQ_StaticAT = RydHQ_StaticAT + [(vehicle _x)]};if not ((group _x) in RydHQ_StaticATG) then {RydHQ_StaticATG = RydHQ_StaticATG + [(group _x)]}};
				case (_Supportcheck) : {if not ((vehicle _x) in RydHQ_Support) then {RydHQ_Support = RydHQ_Support + [(vehicle _x)]};if not ((group _x) in RydHQ_SupportG) then {RydHQ_SupportG = RydHQ_SupportG + [(group _x)]}};
				case (_Cargocheck) : {if not ((vehicle _x) in RydHQ_Cargo) then {RydHQ_Cargo = RydHQ_Cargo + [(vehicle _x)]};if not ((group _x) in RydHQ_CargoG) then {RydHQ_CargoG = RydHQ_CargoG + [(group _x)]}};
				case (_NCCargocheck) : {if not ((vehicle _x) in RydHQ_NCCargo) then {RydHQ_NCCargo = RydHQ_NCCargo + [(vehicle _x)]};if not ((group _x) in RydHQ_NCCargoG) then {RydHQ_NCCargoG = RydHQ_NCCargoG + [(group _x)]}};
				default {if not ((vehicle _x) in RydHQ_Other) then {RydHQ_Other = RydHQ_Other + [(vehicle _x)]};if not ((group _x) in RydHQ_OtherG) then {RydHQ_OtherG = RydHQ_OtherG + [(group _x)]}};
				}
			}
		foreach (units _x)
		}
	foreach RydHQ_Friends;

		{
			{
			_reconcheck = false;
			_FOcheck = false;
			_sniperscheck = false;
			_ATinfcheck = false;
			_AAinfcheck = false;
			_Infcheck = false;
			_Artcheck = false;
			_HArmorcheck = false;
			_LArmorcheck = false;
			_LArmorATcheck = false;
			_Carscheck = false;
			_Aircheck = false;
			_Navalcheck = false;
			_Staticcheck = false;
			_StaticAAcheck = false;
			_StaticATcheck = false;
			_Supportcheck = false;
			_Cargocheck = false;
			_NCCargocheck = false;
			_Othercheck = true;

			switch true do
				{
				case ((typeof (vehicle _x)) in _recon) : {_reconcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _FO) : {_FOcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _snipers) : {_sniperscheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _ATinf) : {_ATinfcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _AAinf) : {_AAinfcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Inf) : {_Infcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Art) : {_Artcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _HArmor) : {_HArmorcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _LArmor) : {_LArmorcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _LArmorAT) : {_LArmorATcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Cars) : {_Carscheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Air) : {_Aircheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Naval) : {_Navalcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Static) : {_Staticcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _StaticAA) : {_StaticAAcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _StaticAT) : {_StaticATcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Support) : {_Supportcheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _Cargo) : {_Cargocheck = true;_Othercheck = false};
				case ((typeof (vehicle _x)) in _NCCargo) : {_NCCargocheck = true;_Othercheck = false};

				case (((typeof _x) in _Inf) and ((typeof (vehicle _x)) in _Cargo) and not (typeof _x in _Crew)) : {_Infcheck = true;_Othercheck = false};

				default {}
				};

			switch true do
				{
				case (_reconcheck) : {if not ((vehicle _x) in RydHQ_Enrecon) then {RydHQ_Enrecon = RydHQ_Enrecon + [(vehicle _x)]};if not ((group _x) in RydHQ_EnreconG) then {RydHQ_EnreconG = RydHQ_EnreconG + [(group _x)]}};
				case (_FOcheck) : {if not ((vehicle _x) in RydHQ_EnFO) then {RydHQ_EnFO = RydHQ_EnFO + [(vehicle _x)]};if not ((group _x) in RydHQ_EnFOG) then {RydHQ_EnFOG = RydHQ_EnFOG + [(group _x)]}};
				case (_sniperscheck) : {if not ((vehicle _x) in RydHQ_Ensnipers) then {RydHQ_Ensnipers = RydHQ_Ensnipers + [(vehicle _x)]};if not ((group _x) in RydHQ_EnsnipersG) then {RydHQ_EnsnipersG = RydHQ_EnsnipersG + [(group _x)]}};
				case (_ATinfcheck) : {if not ((vehicle _x) in RydHQ_EnATinf) then {RydHQ_EnATinf = RydHQ_EnATinf + [(vehicle _x)]};if not ((group _x) in RydHQ_EnATinfG) then {RydHQ_EnATinfG = RydHQ_EnATinfG + [(group _x)]}};
				case (_AAinfcheck) : {if not ((vehicle _x) in RydHQ_EnAAinf) then {RydHQ_EnAAinf = RydHQ_EnAAinf + [(vehicle _x)]};if not ((group _x) in RydHQ_EnAAinfG) then {RydHQ_EnAAinfG = RydHQ_EnAAinfG + [(group _x)]}};
				case (_Infcheck) : {if not ((vehicle _x) in RydHQ_EnInf) then {RydHQ_EValue = RydHQ_EValue + 1;RydHQ_EnInf = RydHQ_EnInf + [(vehicle _x)]};if not ((group _x) in RydHQ_EnInfG) then {RydHQ_EnInfG = RydHQ_EnInfG + [(group _x)]}};
				case (_Artcheck) : {if not ((vehicle _x) in RydHQ_EnArt) then {RydHQ_EValue = RydHQ_EValue + 3;RydHQ_EnArt = RydHQ_EnArt + [(vehicle _x)]};if not ((group _x) in RydHQ_EnArtG) then {RydHQ_EnArtG = RydHQ_EnArtG + [(group _x)]}};
				case (_HArmorcheck) : {if not ((vehicle _x) in RydHQ_EnHArmor) then {RydHQ_EValue = RydHQ_EValue + 10;RydHQ_EnHArmor = RydHQ_EnHArmor + [(vehicle _x)]};if not ((group _x) in RydHQ_EnHArmorG) then {RydHQ_EnHArmorG = RydHQ_EnHArmorG + [(group _x)]}};
				case (_LArmorcheck) : {if not ((vehicle _x) in RydHQ_EnLArmor) then {RydHQ_EValue = RydHQ_EValue + 5;RydHQ_EnLArmor = RydHQ_EnLArmor + [(vehicle _x)]};if not ((group _x) in RydHQ_EnLArmorG) then {RydHQ_EnLArmorG = RydHQ_EnLArmorG + [(group _x)]}};
				case (_LArmorATcheck) : {if not ((vehicle _x) in RydHQ_EnLArmorAT) then {RydHQ_EnLArmorAT = RydHQ_EnLArmorAT + [(vehicle _x)]};if not ((group _x) in RydHQ_EnLArmorATG) then {RydHQ_EnLArmorATG = RydHQ_EnLArmorATG + [(group _x)]}};
				case (_Carscheck) : {if not ((vehicle _x) in RydHQ_EnCars) then {RydHQ_EValue = RydHQ_EValue + 3;RydHQ_EnCars = RydHQ_EnCars + [(vehicle _x)]};if not ((group _x) in RydHQ_EnCarsG) then {RydHQ_EnCarsG = RydHQ_EnCarsG + [(group _x)]}};
				case (_Aircheck) : {if not ((vehicle _x) in RydHQ_EnAir) then {RydHQ_EValue = RydHQ_EValue + 15;RydHQ_EnAir = RydHQ_EnAir + [(vehicle _x)]};if not ((group _x) in RydHQ_EnAirG) then {RydHQ_EnAirG = RydHQ_EnAirG + [(group _x)]}};
				case (_Navalcheck) : {if not ((vehicle _x) in RydHQ_EnNaval) then {RydHQ_EnNaval = RydHQ_EnNaval + [(vehicle _x)]};if not ((group _x) in RydHQ_EnNavalG) then {RydHQ_EnNavalG = RydHQ_EnNavalG + [(group _x)]}};
				case (_Staticcheck) : {if not ((vehicle _x) in RydHQ_EnStatic) then {RydHQ_EValue = RydHQ_EValue + 1;RydHQ_EnStatic = RydHQ_EnStatic + [(vehicle _x)]};if not ((group _x) in RydHQ_EnStaticG) then {RydHQ_EnStaticG = RydHQ_EnStaticG + [(group _x)]}};
				case (_StaticAAcheck) : {if not ((vehicle _x) in RydHQ_EnStaticAA) then {RydHQ_EnStaticAA = RydHQ_EnStaticAA + [(vehicle _x)]};if not ((group _x) in RydHQ_EnStaticAAG) then {RydHQ_EnStaticAAG = RydHQ_EnStaticAAG + [(group _x)]}};
				case (_StaticATcheck) : {if not ((vehicle _x) in RydHQ_EnStaticAT) then {RydHQ_EnStaticAT = RydHQ_EnStaticAT + [(vehicle _x)]};if not ((group _x) in RydHQ_EnStaticATG) then {RydHQ_EnStaticATG = RydHQ_EnStaticATG + [(group _x)]}};
				case (_Supportcheck) : {if not ((vehicle _x) in RydHQ_EnSupport) then {RydHQ_EnSupport = RydHQ_EnSupport + [(vehicle _x)]};if not ((group _x) in RydHQ_EnSupportG) then {RydHQ_EnSupportG = RydHQ_EnSupportG + [(group _x)]}};
				case (_Cargocheck) : {if not ((vehicle _x) in RydHQ_EnCargo) then {RydHQ_EnCargo = RydHQ_EnCargo + [(vehicle _x)]};if not ((group _x) in RydHQ_EnCargoG) then {RydHQ_EnCargoG = RydHQ_EnCargoG + [(group _x)]}};
				case (_NCCargocheck) : {if not ((vehicle _x) in RydHQ_EnNCCargo) then {RydHQ_EnNCCargo = RydHQ_EnNCCargo + [(vehicle _x)]};if not ((group _x) in RydHQ_EnNCCargoG) then {RydHQ_EnNCCargoG = RydHQ_EnNCCargoG + [(group _x)]}};
				default {if not ((vehicle _x) in RydHQ_EnOther) then {RydHQ_EnOther = RydHQ_EnOther + [(vehicle _x)]};if not ((group _x) in RydHQ_EnOtherG) then {RydHQ_EnOtherG = RydHQ_EnOtherG + [(group _x)]}};
				}
			}
		foreach (units _x)
		}
	foreach RydHQ_KnEnemiesG;

		{
		RydHQ_KnEnPos = RydHQ_KnEnPos + [getpos (vehicle (leader _x))];
		if ((count RydHQ_KnEnPos) >= 100) then {RydHQ_KnEnPos = RydHQ_KnEnPos - [RydHQ_KnEnPos select 0]};
		}
	foreach RydHQ_KnEnemiesG;

	sleep 1.1;

	if (isNil ("RydHQ_Order")) then {RydHQ_Order = "ATTACK"};
	_gauss100 = (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10) + (random 10);
	if (((_gauss100 + RydHQ_Inertia + RydHQ_Morale) > ((RydHQ_EValue/(RydHQ_FValue + 0.1)) * 60)) and not (isNil ("RydHQ_Obj")) and not (RydHQ_Order == "DEFEND")) then 
		{
		RydHQ_Inertia = 30 * (0.5 + RydHQ_Consistency)*(0.5 + RydHQ_Activity);
		if (RydHQ_Debug) then {
			diag_log format ["MSO-%1 HETMAN: leaderHQ is getting ready to %2", time, RydHQ_Order];
		};
		nul = [] execVM (RYD_HAC_PATH + "A\HQOrders.sqf")
		} 
	else 
		{
		RydHQ_Inertia = - (30  * (0.5 + RydHQ_Consistency))/(0.5 + RydHQ_Activity);
		if (RydHQ_Debug) then {
			diag_log format ["MSO-%1 HETMAN: leaderHQ is getting ready to DEFEND", time];
		};
		nul = [] execVM (RYD_HAC_PATH + "A\HQOrdersDef.sqf")
		};

	if (alive leaderHQ) then {
		while {((count (waypoints RydHQ)) > 0)} do {
			 deleteWaypoint ((waypoints RydHQ) select 0);
		};
		_wp = RydHQ addWaypoint [position leaderHQ, 0, 1];
		_wp setWaypointType "HOLD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "GREEN";
		_wp setWaypointSpeed "NORMAL";
		RydHQ setCurrentWaypoint _wp;
	};
	if (isNil ("RydHQ_CommDelay")) then {RydHQ_CommDelay = 1};
	_delay = (((22.5 + (count RydHQ_Friends))/(0.5 + RydHQ_Reflex)) * RydHQ_CommDelay);
	sleep _delay;
		{
		RydHQ reveal vehicle (leader _x)
		}
	foreach RydHQ_Friends;

	for [{_z = 0},{_z < (count RydHQ_KnEnemies)},{_z = _z + 1}] do
		{
		_KnEnemy = RydHQ_KnEnemies select _z;
			{
			if ((_x knowsAbout _KnEnemy) >= 0.05) then {RydHQ reveal _KnEnemy}
			}
		foreach RydHQ_Friends
		}
	};
