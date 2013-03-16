if (isserver || isHC) then {
	CQB_PlayersGroundCheck = {
		private["_pos","_dist"];
		_pos = _this select 0;
		_dist = _this select 1;
		({(_pos distance _x < _dist) && (_pos distance _x > 100) && (((getposATL _x) select 2) < 5)} count ([] call BIS_fnc_listPlayers) > 0);
	};
} else {
	CQB_PlayersGroundCheck = {
		private["_pos","_dist"];
		_pos = _this select 0;
		_dist = _this select 1;
		((_pos distance player < _dist) && {(_pos distance player > 100)} && {(((getposATL player) select 2) < 5)});
	};
};



