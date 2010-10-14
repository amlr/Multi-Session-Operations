if (isdedicated) exitwith {};

RMM_cas_types = [
	"BAF_Apache_AH1_D",
	"AW159_Lynx_BAF"
];
RMM_cas_missiontime = 600;
RMM_cas_flyinheight = 125;

if (isnil "RMM_cas_lastTime") then {
	RMM_cas_lastTime = -10800;
	publicvariable "RMM_cas_lastTime";
};