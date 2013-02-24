/*
Some scripts by [ZSU]Blake www.zspecialunit.org, heavily modified by highhead
*/

_FO = leader (_this select 0);
_Range = _this select 1;
_NoRnds = if (count _this > 3) then {_this select 3} else {1};
_RndType = if (count _this > 4) then {_this select 4} else {"HE"};
_Dispersion = if (count _this > 5) then {_this select 5} else {100};
_adjmult = if (count _this > 6) then {_this select 6} else {20};
_skill = if (count _this > 7) then {_this select 7} else {5};
_friendlycheck = if (count _this > 8) then {_this select 8} else {"SoldierEB"};
_illumTMP = ["IMMEDIATE", "ILLUM", 3, 3];
_HETMP = ["IMMEDIATE", "HE", 3, 3];
_FMcount = -1;
_enemy = WEST;
_debug = debug_mso;

_BestArty = [];
{
    _maxR = _x getvariable "ARTY_MAX_RANGE";
    _minR = _x getvariable "ARTY_MIN_RANGE";
    if (((getposATL _FO) distance (position _x) > _minR) && {((getposATL _FO) distance (position _x) < _maxR)}) then {_BestArty set [count _BestArty,_x]};
} foreach ARTILLERIES;
_battery = _BestArty call BIS_fnc_selectRandom;
if (_debug) then {diag_log format ["MSO-%1 DEP Forward Observer initialised %2 Arty %3.",time,_FO,_battery]};

if (isnil "DEP_ARTY_aifiremission") then {
	DEP_ARTY_aifiremission = {
		_tgt = _this select 0;
		_battery = _this select 1;
		_template = _this select 2;
        _debug = debug_mso;
		
		_adjmax = 300;
		_adjmin = -300;
		_error = (10-5)*10;
		
		_Yadj = speed (_tgt) * cos (direction (_tgt)) * 20;
		if (_Yadj > _adjmax) then {_Yadj = _adjmax};
		if (_Yadj < _adjmin) then {_Yadj = _adjmin};
		_Xadj = speed (_tgt) * sin (direction (_tgt)) * 20;
		if (_Xadj > _adjmax) then {_Xadj = _adjmax};
		if (_Xadj < _adjmin) then {_Xadj = _adjmin};
		
		_impact = [(getpos (_tgt) select 0) + _Xadj+(random _error - _error/2), (getpos (_tgt) select 1) + _Yadj+(random _error - _error/2), getpos (_tgt) select 2];
        [0, {
             _this call BIS_ARTY_F_ExecuteTemplateMission;
            }, [_battery, _impact, _template]
        ] call CBA_fnc_globalExecute;

        if (_debug) then {diag_log format ["Artillery %4 firing! MAXRANGE:%1 MINRANGE:%2 DISTANCE:%3", _battery getVariable "ARTY_MAX_RANGE",_battery getVariable "ARTY_MIN_RANGE",(position _battery) distance _impact,_battery]};
	};
};

While {alive _FO} do {
	if ([getposATL _FO,_Range] call fplayersinside) then {

        _AonMish = _battery getvariable "ARTY_ONMISSION";
        if !(_AonMish) then {
	        
			_TgtNow = objNull;
			_TgtList = _FO nearTargets _Range;
			
			{
				_Side = _x select 2;
				if (_side == _Enemy) then {
					_tgtNow = _x select 4;
					Sleep 0.01;
				};
			Sleep 0.01;	
			} forEach _TgtList;
		    
			if (!isNull _TgtNow && {_TgtNow distance _FO > 100}) then {
                
                if (sunOrMoon < 0.15 && {(_FMcount > 3 || _FMcount == -1)}) then {
                    [_battery, _illumTMP select 1] call BIS_ARTY_F_LoadMapRanges;
                    if ([_battery, getposASL _TgtNow, _illumTMP select 1] call BIS_ARTY_F_PosInRange) then {
                        _null1 = [_TgtNow,_battery,_illumTMP] call DEP_ARTY_aifiremission;
                    } else {
                      if (_debug) then {diag_log format ["Artillery out of range! MAXRANGE:%1 MINRANGE:%2 DISTANCE:%3", _battery getVariable "ARTY_MAX_RANGE",_battery getVariable "ARTY_MIN_RANGE",(position _battery) distance getposATL _TgtNow]};  
                    };
	                _FMcount = 0;
                } else {
                    [_battery, _HETMP select 1] call BIS_ARTY_F_LoadMapRanges;
                    if ([_battery, getposASL _TgtNow, _HETMP select 1] call BIS_ARTY_F_PosInRange) then {
                        _null1 = [_TgtNow,_battery,_HETMP] call DEP_ARTY_aifiremission;
                    } else {
                      if (_debug) then {diag_log format ["Artillery out of range! MAXRANGE:%1 MINRANGE:%2 DISTANCE:%3", _battery getVariable "ARTY_MAX_RANGE",_battery getVariable "ARTY_MIN_RANGE",(position _battery) distance getposATL _TgtNow]};  
                    };
	                _FMcount = _FMcount + 1;
                };
			};
        };
		Sleep 5;
	} else {
	    sleep 5;
	};
};

if (_debug) then {diag_log format ["MSO-%1 DEP Forward Observer exited %2.",time,_FO,_battery]};