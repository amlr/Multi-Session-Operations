clearweaponcargo _this;
clearmagazinecargo _this;

{_this addweaponcargo _x} foreach [
	["nvgoggles",10],
	["BAF_L7A2_GPMG",2],
	["BAF_L110A1_Aim",2],
	["BAF_LRR_scoped",2],
	["BAF_L86A2_ACOG",3],
	["BAF_L85A2_RIS_CWS",10],
	["BAF_L85A2_RIS_Holo",16],
	["BAF_NLAW_Launcher",6],
	["Javelin",2]
];

{_this addmagazinecargo _x} foreach [
	["BAF_L109A1_HE",40],
	["smokeshell",10],
	["smokeshellred",5],
	["smokeshellgreen",5],
	["smokeshellyellow",5],
	["smokeshellorange",5],
	["smokeshellpurple",5],
	["smokeshellblue",5],
	["7rnd_45acp_1911",20],
	["5Rnd_86x70_L115A1",40],
	["200Rnd_556x45_L110A1",60],
	["100Rnd_762x51_M240",60],
	["30rnd_556x45_stanag",200],
	["flarewhite_m203",20],
	["flaregreen_m203",20],
	["flarered_m203",10],
	["flareyellow_m203",10],
	["1rnd_he_m203",40],
	["1rnd_smoke_m203",20],
	["1rnd_smokered_m203",20],
	["1rnd_smokegreen_m203",20],
	["1rnd_smokeyellow_m203",20],
	["IR_Strobe_marker",10],
	["NLAW",20],
	["Javelin",6]
];