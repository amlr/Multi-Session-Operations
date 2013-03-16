	/* Regular infantry, soldiers, medics, leaders and officers */
	wict_e_inf = [
	["IRAN_CON_TL","IRAN_CON_SOLDIER","IRAN_CON_SOLDIER2","IRAN_CON_SOLDIER3","IRAN_CON_SOLDIER4","IRAN_CON_GUNNER"],
	["IRAN_MAN_Squadleader","IRAN_MAN_Medic","IRAN_MAN_SOLDIER","IRAN_MAN_SOLDIER"],
	["IRAN_MAN_Officer","IRAN_MAN_MARKSMAN","IRAN_MAN_SOLDIER","IRAN_MAN_Medic"],
	["IRAN_MAN_Teamleader","IRAN_MAN_SOLDIER","IRAN_MAN_RTO","IRAN_MAN_Medic"],
	["IRAN_COM_Officer","IRAN_COM_SOLDIER","IRAN_COM_Medic","IRAN_COM_Engineer"],
	["IRAN_COM_Squadleader","IRAN_COM_SOLDIER","IRAN_COM_Medic","IRAN_COM_Scout"],
	["IRAN_COM_Teamleader","IRAN_COM_SOLDIER","IRAN_COM_MARKSMAN","IRAN_COM_Medic"],
	["IRAN_IRGC_Officer","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_MARKSMAN"],
	["IRAN_IRGC_Teamleader","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_Engineer"],
	["IRAN_IRGC_Squadleader","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_SOLDIER"],
	["IRAN_IRGC_SF","IRAN_IRGC_SF2","IRAN_IRGC_SF3","IRAN_IRGC_SF4","IRAN_IRGC_SF5","IRAN_IRGC_SF6"]
	];
	
	/* Machinegunners and grenadiers */
	wict_e_support = [
	["IRAN_MAN_MGUNNER","IRAN_MAN_Grenadier","IRAN_COM_Grenadier","IRAN_COM_MGUNNER","IRAN_COM_GUNNER","IRAN_IRGC_GUNNER","IRAN_IRGC_Mortar"]
	];
	
	/* Snipers */
	wict_e_snip = [
	["IRAN_MAN_MARKSMAN","IRAN_COM_MARKSMAN","IRAN_IRGC_MARKSMAN"]
	];
	
	/* Marksmen and spotters (SpecOp) */
	wict_e_spec = [
	["IRAN_MAN_MARKSMAN","IRAN_COM_MARKSMAN","IRAN_COM_Scout","IRAN_IRGC_MARKSMAN"]
	];
	
	/* AT units */
	wict_e_at = [
	["IRAN_MAN_ANTITANK","IRAN_COM_ANTITANKG","IRAN_COM_ANTITANK","IRAN_IRGC_Mortar"]
	];
	
	/* Jeeps and light vehicles -- the first element is ARRAY with vehicle(s) */
	wict_e_lightveh = [
	[["LandRover_IRAN","LandRover_MG_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_COM_SOLDIER","IRAN_COM_MARKSMAN","IRAN_COM_Medic","IRAN_COM_AA","IRAN_IRGC_SOLDIER"],
	[["LandRover_IRAN","LandRover_SPG9_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_IRGC_SF2","IRAN_IRGC_SF3","IRAN_IRGC_SF4","IRAN_IRGC_SF5","IRAN_IRGC_SF6"]
	];
	
	/* Transport -- the first element is ARRAY with vehicle(s) */
	wict_e_trans = [
	[["UAZ_IRAN","UAZ_SPG9_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_SOLDIER","IRAN_MAN_AA","IRAN_MAN_ANTITANK"],
	[["Ural_IRAN","LandRover_MG_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_CON_TL","IRAN_CON_SOLDIER","IRAN_CON_SOLDIER2","IRAN_CON_SOLDIER3","IRAN_CON_SOLDIER4","IRAN_CON_GUNNER"],
	[["TT650_IRAN","TT650_IRAN","TT650_IRAN","TT650_IRAN"],"IRAN_COM_SOLDIER","IRAN_COM_SOLDIER","IRAN_COM_SOLDIER"],
	[["Mi17_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_CON_TL","IRAN_CON_SOLDIER","IRAN_CON_SOLDIER2","IRAN_CON_SOLDIER3","IRAN_CON_SOLDIER4","IRAN_CON_GUNNER"],
	[["IRAN_C47SKY"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_CON_TL","IRAN_CON_SOLDIER","IRAN_CON_SOLDIER2","IRAN_CON_SOLDIER3","IRAN_CON_SOLDIER4","IRAN_CON_GUNNER"],
	[["IRAN_An_72"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_CON_TL","IRAN_CON_SOLDIER","IRAN_CON_SOLDIER2","IRAN_CON_SOLDIER3","IRAN_CON_SOLDIER4","IRAN_CON_GUNNER"],
	[["iran_c130"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_CON_TL","IRAN_CON_SOLDIER","IRAN_CON_SOLDIER2","IRAN_CON_SOLDIER3","IRAN_CON_SOLDIER4","IRAN_CON_GUNNER"]
	];
	
	/* Infantry fighting vehicles -- the first element is ARRAY with vehicle(s) */
	wict_e_ifv = [
	[["IRAN_Boragh1"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_SOLDIER","IRAN_MAN_AA","IRAN_MAN_ANTITANK"],
	[["IRAN_Boragh"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_SOLDIER","IRAN_MAN_AA","IRAN_MAN_ANTITANK"],
	[["IRAN_BTR50"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_SOLDIER","IRAN_MAN_AA","IRAN_MAN_ANTITANK"],
	[["IRAN_BTR60"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_IRGC_SOLDIER","IRAN_IRGC_Medic","IRAN_IRGC_SOLDIER","IRAN_MAN_AA","IRAN_MAN_ANTITANK"]
	];
	
	/* Medium and light tanks -- the first element is ARRAY with vehicle(s) */
	wict_w_mtank = [
	[["T72S_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_MAN_TCrew"]
	];
	
	/* Heavy tanks -- the first element is ARRAY with vehicle(s) */
	wict_e_htank = [
	[["T72_IRAN"],"IRAN_IRGC_Officer","IRAN_IRGC_Officer","IRAN_MAN_TCrew"]
	];
	
	/* Medium and light choppers -- the first element is ARRAY with vehicle(s) */
	wict_e_mchop = [
	[["IRAN_AH1J"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"],
	[["Panha2091"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"],
	[["iran_uh1n"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"],
	[["IRAN_AB206"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"]
	];
	
	/* Heavy choppers -- the first element is ARRAY with vehicle(s) */
	wict_e_hchop = [
	[["Mi17_IRAN"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"]
	];
	
	/* Airplanes -- the first element is ARRAY with vehicle(s) */
	wict_e_air = [
	[["IRAN_F4_CAS"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"],
	[["IRAN_F14_CAS"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"],
	[["IRAN_F14_CAP"],"IRAN_MAN_Pilot","IRAN_MAN_Pilot"]
	];