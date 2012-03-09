	/* Regular infantry, soldiers, medics, leaders and officers */
	wict_e_inf = [
	["GUE_Commander","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_Medic"],
	["GUE_Commander","GUE_Soldier_1","GUE_Soldier_Sniper","GUE_Soldier_Medic"],
	["GUE_Commander","GUE_Soldier_1","GUE_Soldier_Medic","GUE_Soldier_Medic"],
	["GUE_Commander","GUE_Soldier_Medic","GUE_Soldier_Medic","GUE_Soldier_Medic"]
	];
	
	/* Machinegunners and grenadiers */
	wict_e_support = [
	["GUE_Soldier_MG","GUE_Soldier_MG","GUE_Soldier_GL","GUE_Soldier_MG"]
	];
	
	/* Snipers */
	wict_e_snip = [
	["GUE_Soldier_Scout","GUE_Soldier_Sniper"]
	];
	
	/* Marksmen and spotters (SpecOp) */
	wict_e_spec = [
	["GUE_Soldier_Sniper","GUE_Soldier_AR","GUE_Soldier_Scout","GUE_Soldier_Sniper"]
	];
	
	/* AT units */
	wict_e_at = [
	["GUE_Soldier_1","GUE_Soldier_AT","GUE_Soldier_AT","GUE_Soldier_AT"]
	];
	
	/* Jeeps and light vehicles -- the first element is ARRAY with vehicle(s) */
	wict_e_lightveh = [
	[["UAZ_MG_INS"],"GUE_Commander","GUE_Commander","GUE_Soldier_1"]
	];
	
	/* Transport -- the first element is ARRAY with vehicle(s) */
	wict_e_trans = [
	[["UAZ_MG_INS","UAZ_RU"],"GUE_Commander","GUE_Commander","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_Medic","GUE_Soldier_AT","GUE_Soldier_AA","GUE_Soldier_GL","GUE_Soldier_MG"],
	[["Offroad_DSHKM_INS","UAZ_RU"],"GUE_Commander","GUE_Commander","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_Medic","GUE_Soldier_AT","GUE_Soldier_AA","GUE_Soldier_GL","GUE_Soldier_MG"],
	[["UAZ_MG_INS","UAZ_RU"],"GUE_Commander","GUE_Commander","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_Medic","GUE_Soldier_AT","GUE_Soldier_AA","GUE_Soldier_GL","GUE_Soldier_MG"],
	[["Mi17_rockets_RU"],"GUE_Soldier_2","Ins_Soldier_2","GUE_Soldier_1","GUE_Soldier_Medic","GUE_Soldier_AT","GUE_Soldier_AA","GUE_Soldier_GL","GUE_Soldier_MG","GUE_Soldier_Medic"]
	];
	
	/* Infantry fighting vehicles -- the first element is ARRAY with vehicle(s) */
	wict_e_ifv = [
	[["GAZ_Vodnik"],"GUE_Commander","GUE_Commander","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_1","GUE_Soldier_AT"]
	];
	
	/* Medium and light tanks -- the first element is ARRAY with vehicle(s) */
	wict_w_mtank = [
	[["T34"],"GUE_Commander","GUE_Commander","GUE_Soldier_1"]
	];
	
	/* Heavy tanks -- the first element is ARRAY with vehicle(s) */
	wict_e_htank = [
	[["T72_RU"],"GUE_Commander","GUE_Commander","GUE_Soldier_1"]
	];
	
	/* Medium and light choppers -- the first element is ARRAY with vehicle(s) */
	wict_e_mchop = [
	[["Ka52"],"GUE_Soldier_Pilot","GUE_Soldier_Crew"]
	];
	
	/* Heavy choppers -- the first element is ARRAY with vehicle(s) */
	wict_e_hchop = [
	[["Mi24_P"],"GUE_Soldier_Pilot","GUE_Soldier_Crew"]
	];
	
	/* Airplanes -- the first element is ARRAY with vehicle(s) */
	wict_e_air = [
	[["Su25_Ins"],"GUE_Soldier_Pilot"]
	];