class CfgPatches {
	class RMM_noSatMap {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.01;
		requiredAddons[] = {"CAUI"};
	};
};
class RscMapControl;
class RscDisplayMainMap {
	class controlsBackground {
		class CA_Map : RscMapControl {
			maxSatelliteAlpha = 0;
			sizeExLevel = 0.03;
		};
	};
};
