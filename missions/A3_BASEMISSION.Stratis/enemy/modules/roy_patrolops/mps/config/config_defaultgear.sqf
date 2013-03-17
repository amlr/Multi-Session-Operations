// Written by EightySix
// Replaces a units gear and weapons with defaults on Join

waitUntil {!isNil "mps_ace_enabled" && !isNil "mps_acre_enabled"};

private["_weapons","_magazine"];

_wep = weapons player;
_mag = magazines player;

removeAllWeapons player;
removeAllItems player;
if(mps_co) then {
	removeBackpack player;
};

_weapons = [];
_magazine = [];
//default weps here
if( mps_a3 ) then 
{
	_weapons = _weapons + ["arifle_MX_ACOg_point_grip_F"];
}else{
	if( mps_oa ) then 
	{
		_weapons = _weapons + ["SCAR_L_CQC"];
	}else{
		_weapons = _weapons + ["M16A2"];
	};
};



if( mps_ace_enabled ) then{
	if( mps_aaw ) then 
	{
		_weapons = ["AAW_f88_A1","Binocular","NVGoggles","ACE_Map","ItemRadio","ItemCompass","ItemGPS","ItemWatch","ACE_Earplugs"];
		_magazine = ["aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f1_grenade","SmokeShellBlue"];
	}else{
		_weapons = ["ACE_M16A4_Iron","Binocular","NVGoggles","ACE_Map","ItemRadio","ItemCompass","ItemGPS","ItemWatch","ACE_Earplugs"];
		_magazine = ["ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","ACE_30Rnd_556x45_S_Stanag","HandGrenade_West","SmokeShellBlue"];
	};
}else{
	_weapons = _weapons + ["Binocular","NVGoggles","ItemMap","ItemCompass","ItemGPS","ItemWatch","ItemRadio"];
	if( mps_aaw ) then 
	{
		_magazine = ["aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f88_mag","aaw_f1_grenade","SmokeShellBlue"];
		//may be def mags
	}else{
		_magazine = [""];
	};
};

{ player addWeapon _x; } forEach _weapons;
{ player addMagazine _x; } forEach _magazine;
