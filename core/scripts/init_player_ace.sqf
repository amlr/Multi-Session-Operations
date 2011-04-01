// Changed / editing by rockfakey for ACE only item persistence on spawn

private ["_unit","_corpse","_hasruck","_weaponOnBack","_bp"];
_unit = _this select 0;
_corpse = _this select 1;

_weaponOnBack = [_corpse] call ACE_fnc_WeaponOnBackName;
_unit addWeapon _weaponOnBack;
[_unit, _weaponOnBack] call ACE_fnc_PutWeaponOnBack;
[_corpse, _weaponOnBack] call ACE_fnc_RemWeapon;


_hasruck = _corpse call ACE_fnc_hasRuck;
if (_hasruck) then {		
        // Get the backpack type
        _bp = [_corpse] call ACE_fnc_FindRuck;	
        
        // Set the weapon on back
        // Add the backpack
        If (_bp != "") then {
                _unit addWeapon _bp;
                [_unit, "ALL"] call ACE_fnc_RemoveGear;
        };
        
        // Add Ace Ruck magazines
        {
                [_unit, _x select 0, _x select 1] call ACE_fnc_PackMagazine;
        } forEach ([_corpse] call ACE_fnc_RuckMagazinesList);
        // Add Ace Ruck Weapons							
        {
                [_unit, _x select 0, _x select 1] call ACE_fnc_PackWeapon;
        } forEach ([_corpse] call ACE_fnc_RuckWeaponsList);
        
        [_corpse, "ALL"] call ACE_fnc_RemoveGear;
        [_corpse, _bp] call ACE_fnc_RemWeapon;
};
