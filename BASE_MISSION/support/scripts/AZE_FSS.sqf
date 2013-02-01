//////////////// Forward Squad Spawning Suite by M. Philips for MilGO insurgency Alpha (by M. Philips) //////////////////
/////////// Plce this in the init line of the object you want to interact with for the forward teleport action: ///////////
/////////// nul = this addAction ["Teleport to Squad Member", "support\scripts\AZE_FSS.sqf"]; /////////////

if (isDedicated) exitwith {};
if (isnil "keyspressed") then {
    keyspressed = {
			_key = _this select 1;
			
			//right arrow
			if (_key == 205) then {
				actualUnits = actualUnits + 1;
				if (actualUnits > (count aliveUnits)) then {actualUnits = (count aliveUnits)};
				};
			
			//left arrow
			if (_key == 203) then {
				actualUnits = actualUnits - 1; 
				if (actualUnits < 0) then {actualUnits = 0};
			};
			
			//Enter key
			if (_key == 28) then {keyout = _key};
	};
};

waituntil {alive player}; _unit = player;
aliveUnits = []; {if (alive _x and _x != player) then {aliveUnits set [count aliveUnits,_x]};} foreach units (group player); if (count aliveUnits == 0) exitwith {TitleText[format["There are no units in your group!",_playerUnit],"PLAIN DOWN"]};
actualUnits = 0;
keyout = 0;

_selection = (aliveUnits select actualUnits);

_cam = "camera" camcreate [0,0,0]; showCinemaBorder true;
_cam cameraeffect ["internal", "back"] ;
_cam camsettarget _selection;
_cam camsetrelpos [0,-5,2.5];
_cam camcommit 0;
_cam attachTo [_selection, [0,-5,2.5]];

TitleText[format["Select unit with ARROWKEYS and press ENTER to select!",true],"PLAIN DOWN"];
_DispId = ["KeyDown", "_this call keyspressed"] call CBA_fnc_addDisplayHandler;
while {!(keyout > 0)} do {
	_currentmate = (aliveUnits select actualUnits);
    
    if !(_selection == _currentmate) then {
        _selection = _currentmate;

		_cam camsettarget _selection;
		_cam camsetrelpos [0,-5,2.5];
		_cam camcommit 0;
		waituntil {camCommitted _cam};
        
        _cam attachTo [_selection, [0,-5,2.5]];
     };
	sleep 0.1;
};
["KeyDown", _DispId] call CBA_fnc_removeDisplayHandler;

_playerUnit = (aliveUnits select actualUnits);
_enemyunits = {side _x == east} count ((position _playerUnit) nearEntities [["Man"],50]);

if (_enemyunits > 0) then {
	TitleText[format["Selected unit %1 is too close to enemies!",_playerUnit],"PLAIN DOWN"];
} else {
	if (vehicle _playerUnit == _playerUnit) then {
    	TitleText[format["Transported to unit %1!",_playerUnit],"PLAIN DOWN"];
		_unit setDir direction _playerUnit;
		_unit setPosATL [getPosATL _playerUnit select 0,getPosATL _playerUnit select 1,getPosATL _playerUnit select 2];
		_unit setPos (_playerUnit modelToWorld [+0.75,-3.50,((position _playerUnit) select 2)+0]);
	} else {
        TitleText[format["Transported to unit %1!",_playerUnit],"PLAIN DOWN"];
		if (vehicle _playerUnit != _playerUnit) then {
			_freePosGunner = (vehicle _playerUnit) emptyPositions "gunner";
			_freePosCommander = (vehicle _playerUnit) emptyPositions "commander";
			_freePosCargo = (vehicle _playerUnit) emptyPositions "cargo";
			_freePosDriver = (vehicle _playerUnit) emptyPositions "driver";
			if (_freePosGunner > 0) then {
				_unit moveInGunner (vehicle _playerUnit);
			} else {
				if (_freePosCommander > 0) then {
					_unit moveInCommander (vehicle _playerUnit);
				} else {
					if (_freePosCargo > 0) then {
						_unit moveInCargo (vehicle _playerUnit);
					} else {
						if (_freePosDriver > 0) then {
							_unit moveInDriver (vehicle _playerUnit);
						} else {
							hint "The Team Leader's vehicle currently has no empty seats to teleport to.";
						};
					};
				};
			};
		};
	};
};

showCinemaBorder false;
player cameraEffect ["terminate","back"];
camdestroy _cam;