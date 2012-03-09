	/* Regular infantry, soldiers, medics, leaders and officers */
	wict_e_inf = [
	["RU_Soldier_TL","RU_Soldier","RU_Soldier","RU_Soldier_Medic"],
	["RU_Soldier_TL","RU_Soldier","RU_Soldier_Marksman","RU_Soldier_Medic"],
	["RU_Soldier_TL","RU_Soldier","RU_Soldier_Medic","RU_Soldier_Medic"],
	["RU_Soldier_TL","RU_Soldier_Medic","RU_Soldier_Medic","RU_Soldier_Medic"]
	];
	
	/* Machinegunners and grenadiers */
	wict_e_support = [
	["RU_Soldier_MG","MVD_Soldier_MG","RU_Soldier_GL","RU_Soldier_MG"]
	];
	
	/* Snipers */
	wict_e_snip = [
	["RU_Soldier_Spotter","RU_Soldier_Sniper"]
	];
	
	/* Marksmen and spotters (SpecOp) */
	wict_e_spec = [
	["RU_Soldier_Marksman","RU_Soldier_AR","RU_Soldier_Spotter","RU_Soldier_Sniper"]
	];
	
	/* AT units */
	wict_e_at = [
	["RU_Soldier","RU_Soldier_HAT","RU_Soldier_HAT","RU_Soldier_AT"]
	];
	
	/* Jeeps and light vehicles -- the first element is ARRAY with vehicle(s) */
	wict_e_lightveh = [
	[["UAZ_MG_INS"],"RU_Soldier_TL","RU_Soldier_Officer","RU_Soldier"]
	];
	
	/* Transport -- the first element is ARRAY with vehicle(s) */
	wict_e_trans = [
	[["UAZ_MG_INS","UAZ_RU"],"RU_Commander","RU_Soldier_Officer","RU_Soldier","RU_Soldier","RU_Soldier","RU_Soldier_Medic","RU_Soldier_HAT","RU_Soldier_AA","RU_Soldier_GL","RU_Soldier_MG"],
	[["Offroad_DSHKM_INS","UAZ_RU"],"RU_Commander","RU_Soldier_Officer","RU_Soldier","RU_Soldier","RU_Soldier","RU_Soldier_Medic","RU_Soldier_HAT","RU_Soldier_AA","RU_Soldier_GL","RU_Soldier_MG"],
	[["UAZ_MG_INS","UAZ_RU"],"RU_Commander","RU_Soldier_Officer","RU_Soldier","RU_Soldier","RU_Soldier","RU_Soldier_Medic","RU_Soldier_HAT","RU_Soldier_AA","RU_Soldier_GL","RU_Soldier_MG"],
	[["Mi17_rockets_RU"],"Ins_Soldier_1","Ins_Soldier_2","RU_Soldier","RU_Soldier_Medic","RU_Soldier_HAT","RU_Soldier_AA","RU_Soldier_GL","RU_Soldier_MG","Ins_Soldier_Medic"]
	];
	
	/* Infantry fighting vehicles -- the first element is ARRAY with vehicle(s) */
	wict_e_ifv = [
	[["GAZ_Vodnik"],"RU_Commander","RU_Soldier_Officer","RU_Soldier","RU_Soldier","RU_Soldier","RU_Soldier_AT"]
	];
	
	/* Medium and light tanks -- the first element is ARRAY with vehicle(s) */
	wict_w_mtank = [
	[["T34"],"RU_Commander","RU_Soldier_Officer","RU_Soldier"]
	];
	
	/* Heavy tanks -- the first element is ARRAY with vehicle(s) */
	wict_e_htank = [
	[["T72_RU"],"RU_Commander","RU_Soldier_Officer","RU_Soldier"]
	];
	
	/* Medium and light choppers -- the first element is ARRAY with vehicle(s) */
	wict_e_mchop = [
	[["Ka52"],"RU_Soldier_Pilot","RU_Soldier_Crew"]
	];
	
	/* Heavy choppers -- the first element is ARRAY with vehicle(s) */
	wict_e_hchop = [
	[["Mi24_P"],"RU_Soldier_Pilot","RU_Soldier_Crew"]
	];
	
	/* Airplanes -- the first element is ARRAY with vehicle(s) */
	wict_e_air = [
	[["Su25_Ins"],"RU_Soldier_Pilot"]
	];