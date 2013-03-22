if (isDedicated) exitWith{};
waituntil {not isnull player};

////////////////////////////////////////////////////////////
// Respawn Handling
////////////////////////////////////////////////////////////

RWG_saveloadout = {
	weaponsvar = weapons player;
	magazinesvar = magazines player;
    primaccvar = primaryWeaponItems player; 
	vestvar = vest player;
	uniformvar = uniform player;
	headgearvar = headgear player;
	backpackvar = backpack player;
	secaccvar = secondaryWeaponItems player;
	sideaccvar = handgunItems player;
	itemsvar = items player;
	assitemsvar = assignedItems player;
    hint "Gear saved!"
};

RWG_restoreloadout = {
    private ["_p","_primw"];
	_p = _this select 0;
	
	removeAllWeapons _p;
	
	_p addBackpack backpackvar;
    diag_log format["%1 backpackvar %2",_p,backpackvar];
	_p addVest vestvar;
    diag_log format["%1 addvest %2",_p,assitemsvar];
	_p addUniform uniformvar;
    diag_log format["%1 addUniform %2",_p,uniformvar];
	_p addHeadgear headgearvar;
    diag_log format["%1 addHeadgear %2",_p,headgearvar];
	{_p addMagazine _x} forEach magazinesvar;
    diag_log format["%1 magazinesvar %2",_p,magazinesvar];
	{_p addWeapon _x} forEach weaponsvar;
    diag_log format["%1 weaponsvar %2",_p,weaponsvar];
	{_p addPrimaryWeaponItem _x} forEach primaccvar;
    diag_log format["%1 primaccvar %2",_p,primaccvar];
	{_p addSecondaryWeaponItem _x} forEach secaccvar;
    diag_log format["%1 secaccvar %2",_p,secaccvar];
	{_p addHandgunItem _x} forEach sideaccvar;
    diag_log format["%1 sideaccvar %2",_p,sideaccvar];
	{_p addItem _x} forEach itemsvar;
    diag_log format["%1 itemsvar %2",_p,itemsvar];
	{_p assignItem _x} forEach assitemsvar;
    diag_log format["%1 assitemsvar %2",_p,assitemsvar];
	
	_primw = primaryWeapon _p;
	if (_primw != "") then {
	    _p selectWeapon _primw;
	    _muzzles = getArray(configFile>>"cfgWeapons" >> _primw >> "muzzles");
	    _p selectWeapon (_muzzles select 0);
	};
};

player switchmove "";
player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];
player setVariable ["BIS_noCoreConversations", true];

player addeventhandler ["respawn", {
        _unit = _this select 0;
        _corpse = _this select 1;
        
        [_unit] call RWG_restoreloadout;
        
        diag_log format["Respawn: %1", _unit];
        player addRating -(rating player);
        [] call RWG_restoreloadoud;
        player switchmove "";
		_unit addAction [("<t color=""#ffc600"">" + ("Save Gear") + "</t>"),{[] call RWG_saveloadout},["paperdoll"],-100,true,false,'',"player distance markerpos 'respawn_west' < 20"];
        _unit addAction [("<t color=""#ffc600"">" + ("Load Gear") + "</t>"),{[_unit] call RWG_restoreloadout},["paperdoll"],-100,true,false,'',"player distance markerpos 'respawn_west' < 20"];
        removeallweapons _corpse;
        removeallitems _corpse;
        removebackpack _corpse;
}];

[] call RWG_saveloadout;
player addAction [("<t color=""#ffc600"">" + ("Save Gear") + "</t>"),{[] call RWG_saveloadout},["paperdoll"],-100,true,false,'',"player distance markerpos 'respawn_west' < 20"];
player addAction [("<t color=""#ffc600"">" + ("Load Gear") + "</t>"),{[player] call RWG_restoreloadout},["paperdoll"],-100,true,false,'',"player distance markerpos 'respawn_west' < 20"];
