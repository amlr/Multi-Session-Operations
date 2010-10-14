private ["_town", "_threat", "_group"];
_town = _this select 0;
_threat = _this select 1;

if (_threat > 0.2 && random 1 > 0.8) then {
	if (_town getvariable "ALICE_active") then {
		private "_class";
		_class = TK_GUE_ATTeam;
		if (_threat > 0.6) then {
			_class = TK_GUE_Group;
		} else {
			if (_threat > 0.4) then {
				_class = TK_GUE_Patrol;
			};
		};
		_group = [[_town, 100] call RMM_fnc_randPos, resistance, _class] call BIS_fnc_SpawnGroup;
		_group call TK_fnc_takibani;
		[_group] call RMM_fnc_taskDefend;
		_town setvariable ["threat",_threat - 0.03];
		waituntil {sleep 1; !(_town getvariable "ALICE_active")};
		_group call RMM_fnc_deleteEntity;
	};
};