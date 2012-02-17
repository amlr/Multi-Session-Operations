// Written by EightySix
// Replaces a units gear and weapons with defaults on Join

waitUntil {!isNil "mps_ace_enabled"};

private["_weapons","_magazineP"];

_wep = weapons player; _mag = magazines player; 

removeAllWeapons player;
removeAllItems player;
removeBackpack player;

_weapons = [];
_magazineP = [];

// Set Defaults Here for ACE and Vanila Server Bootup Options

if(mps_ace_enabled) then{
	_weapons = ["ACE_M4","Binocular","NVGoggles","ACE_Map","ItemCompass","ACE_Broken_GPS","ACE_BrokenRadio","ACE_BrokenWatch","ACE_Earplugs"];
	_magazineP = ["ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag"]
}else{
	_weapons = ["SCAR_L_CQC","Binocular","NVGoggles","ItemMap","ItemCompass","ItemGPS","ItemRadio","ItemWatch"];
	_magazineP = ["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]
};


{ player addMagazine _x; } forEach _magazineP;
{ player addWeapon _x; } forEach _weapons;