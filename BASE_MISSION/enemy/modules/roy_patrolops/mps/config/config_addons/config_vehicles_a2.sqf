mps_config_vehicles = mps_config_vehicles + [
	["USMC", "attakp", "A10",					0,0,0,0,0],
	["USMC", "attakp", "AV8B",					0,0,0,0,0],
	["USMC", "attakp", "AV8B2",					0,0,0,0,0],
	["USMC", "attakp", "F35B",					0,0,0,0,0],
	["USMC", "attakh", "AH1Z",					0,0,0,0,0],
	["USMC", "cargop", "C130J",					0,0,0,0,2500],
	["USMC", "cargop", "MV22",					1,0,1,0,500],
	["USMC", "cargoh", "MH60S",					1,0,0,0,200],
	["USMC", "cargoh", "UH1Y",					1,0,0,0,100],
	["USMC", "apc", "AAV",						0,0,0,0,0],
	["USMC", "apc", "LAV25",					0,0,0,0,0],
	["USMC", "mhq", "LAV25_HQ",					1,0,1,0,100],
	["USMC", "tank", "M1A1",					0,0,0,0,0],
	["USMC", "tank", "M1A2_TUSK_MG",				0,0,0,0,0],
	["USMC", "arti", "MLRS",					0,0,0,0,0],
	["USMC", "cargoc", "HMMWV",					1,0,1,0,100],
	["USMC", "attakc", "HMMWV_M2",					0,0,1,0,0],
	["USMC", "attakc", "HMMWV_Armored",				0,0,1,0,0],
	["USMC", "attakc", "HMMWV_MK19",				0,0,1,0,0],
	["USMC", "attakc", "HMMWV_TOW",					0,0,1,0,0],
	["USMC", "mobiaa", "HMMWV_Avenger",				0,0,1,0,0],
	["USMC", "cargoc", "HMMWV_Ambulance",				1,0,1,0,0],
	["USMC", "cargoc", "MTVR",					1,0,1,1,500],
	["USMC", "cargoc", "MtvrReammo",				1,1,1,0,500],
	["USMC", "cargoc", "MtvrRefuel",				0,1,1,0,500],
	["USMC", "cargoc", "MtvrRepair",				1,1,1,0,500],

	["CDF", "cargoh", "Mi17_CDF",					1,0,1,0,0],
	["CDF", "attakh", "Mi24_D",					0,0,0,0,0],
	["CDF", "attakp", "Su25_CDF",					0,0,0,0,0],
	["CDF", "apc", "BMP2_CDF",					0,0,0,0,0],
	["CDF", "mhq", "BMP2_HQ_CDF",					1,0,1,0,0],
	["CDF", "apc", "BRDM2_CDF",					1,0,0,0,0],
	["CDF", "apc", "BRDM2_ATGM_CDF",				0,0,0,0,0],
	["CDF", "tank", "T72_CDF",					0,0,0,0,0],
	["CDF", "mobiaa", "ZSU_CDF",					0,0,0,0,0],
	["CDF", "arti", "GRAD_CDF",					0,0,0,0,0],
	["CDF", "cargoc", "UAZ_CDF",					1,0,0,0,0],
	["CDF", "attakc", "UAZ_AGS30_CDF",				0,0,0,0,0],
	["CDF", "attakc", "UAZ_MG_CDF",					0,0,0,0,0],
	["CDF", "cargoc", "Ural_CDF",					1,0,1,1,0],
	["CDF", "cargoc", "UralOpen_CDF",				1,0,1,1,0],
	["CDF", "mobiaa", "Ural_ZU23_CDF",				0,0,1,0,0],
	["CDF", "cargoc", "UralReammo_CDF",				1,1,1,0,0],
	["CDF", "cargoc", "UralRefuel_CDF",				0,1,1,0,0],
	["CDF", "cargoc", "UralRepair_CDF",				1,1,1,0,0],

	["RU", "attakh", "Ka52",					0,0,0,0,0],
	["RU", "attakh", "Ka52Black",					0,0,0,0,0],
	["RU", "attakh", "Mi24_P",					0,0,0,0,0],
	["RU", "attakh", "Mi24_V",					0,0,0,0,0],
	["RU", "cargoh", "Mi17_rockets_RU",				1,0,1,0,0],
	["RU", "attakp", "Su39",					0,0,0,0,0],
	["RU", "attakp", "Su34",					0,0,0,0,0],
	["RU", "mobiaa", "2S6M_Tunguska",				0,0,0,0,0],
	["RU", "apc", "BMP3",						0,0,0,0,0],
	["RU", "apc", "BTR90",						0,0,0,0,0],
	["RU", "apc", "BTR90_HQ",					1,0,1,0,0],
	["RU", "tank", "T72_RU",					0,0,0,0,0],
	["RU", "tank", "T90",						0,0,0,0,0],
	["RU", "attakc", "GAZ_Vodnik",					0,0,1,0,0],
	["RU", "apc", "GAZ_Vodnik_HMG",					0,0,1,0,0],
	["RU", "arti", "GRAD_RU",					0,0,1,0,0],
	["RU", "cargoc", "UAZ_RU",					1,0,1,0,0],
	["RU", "attakc", "UAZ_AGS30_RU",				0,0,1,0,0],
	["RU", "cargoc", "Kamaz",					1,0,1,1,0],
	["RU", "cargoc", "KamazOpen",					1,0,1,1,0],
	["RU", "cargoc", "KamazReammo",					1,1,1,0,0],
	["RU", "cargoc", "KamazRefuel",					0,1,1,0,0],
	["RU", "cargoc", "KamazRepair",					1,1,1,0,0],

	["INS", "cargoh", "Mi17_Ins",					1,0,1,0,0],
	["INS", "attakp", "Su25_Ins",					0,0,0,0,0],
	["INS", "apc", "BMP2_INS",					0,0,0,0,0],
	["INS", "mhq", "BMP2_HQ_INS",					1,0,1,0,0],
	["INS", "attakc", "BRDM2_INS",					1,0,1,0,0],
	["INS", "attakc", "BRDM2_ATGM_INS",				0,0,1,0,0],
	["INS", "tank", "T72_INS",					0,0,0,0,0],
	["INS", "mobiaa", "ZSU_INS",					0,0,0,0,0],
	["INS", "arti", "GRAD_INS",					0,0,1,0,0],
	["INS", "attakc", "Offroad_DSHKM_INS",				0,0,1,0,0],
	["INS", "attakc", "Pickup_PK_INS",				0,0,1,0,0],
	["INS", "cargoc", "UAZ_INS",					1,0,1,0,0],
	["INS", "attakc", "UAZ_AGS30_INS",				0,0,1,0,0],
	["INS", "attakc", "UAZ_MG_INS",					0,0,1,0,0],
	["INS", "attakc", "UAZ_SPG9_INS",				0,0,1,0,0],
	["INS", "cargoc", "Ural_INS",					1,0,1,1,0],
	["INS", "cargoc", "UralOpen_INS",				1,0,1,1,0],
	["INS", "mobiaa", "Ural_ZU23_INS",				0,0,1,0,0],
	["INS", "cargoc", "UralReammo_INS",				1,1,1,0,0],
	["INS", "cargoc", "UralRefuel_INS",				0,1,1,0,0],
	["INS", "cargoc", "UralRepair_INS",				1,1,1,0,0],

	["GUE", "apc", "BMP2_Gue",					0,0,0,0,0],
	["GUE", "attakc", "BRDM2_Gue",					0,0,1,0,0],
	["GUE", "attakc", "BRDM2_HQ_Gue",				1,0,1,0,0],
	["GUE", "tank", "T34",						0,0,0,0,0],
	["GUE", "tank", "T72_Gue",					0,0,0,0,0],
	["GUE", "attakc", "Offroad_DSHKM_Gue",				0,0,1,0,0],
	["GUE", "attakc", "Offroad_SPG9_Gue",				0,0,1,0,0],
	["GUE", "attakc", "Pickup_PK_GUE",				0,0,1,0,0],
	["GUE", "cargoc", "V3S_Gue",					1,0,1,1,0],
	["GUE", "mobiaa", "Ural_ZU23_Gue",				0,0,1,0,0]
];