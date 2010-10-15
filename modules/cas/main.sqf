if (isdedicated) exitwith {};

RMM_cas_types = [
	"A10",
	"AH64D",
	"AH1Z"
];
RMM_cas_missiontime = 540;
RMM_cas_flyinheight = 125;
RMM_cas_frequency = 10800;

if (isnil "RMM_cas_lastTime") then {
	RMM_cas_lastTime = -10800;
	publicvariable "RMM_cas_lastTime";
};