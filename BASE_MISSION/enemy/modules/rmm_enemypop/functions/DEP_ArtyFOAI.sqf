/*
Some scripts by [ZSU]Blake www.zspecialunit.org, heavily modified by highhead
*/

_FO = (units (_this select 0)) select 1;
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
_AlignTime = 0;
_enemy = WEST;
_AlignTimeLimit = (90 + floor(random 90));
_quitFO = false;
_debug = debug_mso;

if (isnil "DEP_ARTY_SelectBestArty") then {
	DEP_ARTY_SelectBestArty = {
	    private ["_BestArty","_firetemplate","_AonMish"];
	    _impact = _this select 0;
        _firetemplate = _this select 1;
		_BestArty = [];

		{
            _AonMish = _x getvariable "ARTY_ONMISSION";
		    [_x, _firetemplate select 1] call BIS_ARTY_F_LoadMapRanges;
            if (([_x, _impact, _firetemplate select 1] call BIS_ARTY_F_PosInRange) && !(_AonMish)) then {_BestArty set [count _BestArty,_x]};
		} foreach ARTILLERIES;
		_BestArty call BIS_fnc_selectRandom;
	};
};

if (isnil "DEP_ARTY_SelectTargets") then {
	DEP_ARTY_SelectTargets = {
        _FO = _this select 0;
        _Range = _this select 1;
        _debug = debug_mso;
        
		_TgtNow = objNull;
		_TgtTmp = _FO nearTargets _Range;
		_TgtList =[];
		{
			_Side = _x select 2;
			if (_side == _Enemy) then {
				_TgtList set [count _TgtList, _x select 4];
				Sleep 0.01;
			};
		Sleep 0.01;	
		} forEach _TgtTmp;
        if (_debug) then {diag_log format ["FO %1 selected targets %3 within %2!", _FO,_Range,_TgtList]};
		_TgtList;
	};
};

if (isnil "DEP_ARTY_aifiremission") then {
	DEP_ARTY_aifiremission = {
		_impact = _this select 0;
		_battery = _this select 1;
		_template = _this select 2;
        _dispersion = _this select 3;
        _debug = debug_mso;

        [0, {
            [_this select 0, _this select 3] call BIS_ARTY_F_SetDispersion;
            [_this select 0, _this select 1, _this select 2] call BIS_ARTY_F_ExecuteTemplateMission;
            }, [_battery, _impact, _template,_dispersion]
        ] call CBA_fnc_globalExecute;

        if (_debug) then {diag_log format ["Artillery %4 firing! MAXRANGE:%1 MINRANGE:%2 DISTANCE:%3", _battery getVariable "ARTY_MAX_RANGE",_battery getVariable "ARTY_MIN_RANGE",(position _battery) distance _impact,_battery,_dispersion]};
	};
};

if (isnil "DEP_ARTY_CalcImpact") then {
	DEP_ARTY_CalcImpact = {
	    	_tgt = _this select 0;
	  		_adjmax = 300;
			_adjmin = -300;
			_error = 20;
            _debug = debug_mso;
			
			_Yadj = speed (_tgt) * cos (direction (_tgt)) * 20;
			if (_Yadj > _adjmax) then {_Yadj = _adjmax};
			if (_Yadj < _adjmin) then {_Yadj = _adjmin};
			_Xadj = speed (_tgt) * sin (direction (_tgt)) * 20;
			if (_Xadj > _adjmax) then {_Xadj = _adjmax};
			if (_Xadj < _adjmin) then {_Xadj = _adjmin};
			
			_hitpoint = [(getpos (_tgt) select 0) + _Xadj+(random _error - _error/2), (getpos (_tgt) select 1) + _Yadj+(random _error - _error/2), getpos (_tgt) select 2];
            if (_debug) then {diag_log format ["Calculated Impact: %1!", _hitpoint]};
	    	_hitpoint;
	};
};

_battery = [getposASL _FO, _HETMP] call DEP_ARTY_SelectBestArty;
if (isnil "_battery") exitwith {if (_debug) then {diag_log format ["MSO-%1 DEP Forward Observer exited, no artillery in range %2!",time,_FO]}};
if (isClass(configFile>>"CfgPatches">>"ace_main")) then {
    _FO addweapon "ACE_P159_RD99";
    _FO addweapon "Binocular";
} else {
    _FO addBackpack "TK_ALICE_Pack_Explosives_EP1";
    _FO addweapon "Binocular";
};

sleep random 10;

While {alive _FO && !(_quitFO)} do {
	if ([getposATL _FO,_Range] call fplayersinside) then {
            _targets = [_FO,_Range] call DEP_ARTY_SelectTargets;
            
            if (count _targets > 0) then {
                if !(_AlignTime < _AlignTimeLimit) then {
	                
                    if !(_battery getvariable "ARTY_ONMISSION") then {
                        private ["_hit"];
                    
		                _target = _targets call BIS_fnc_selectRandom;
						_RndPos = _target getvariable ["ACC_RNDS",[getposASL _target,150]];
		                _disp = _RndPos select 1;
                        
                        _FO selectWeapon "Binoculars";
	                	_FO dowatch _target;

						if (!isNull _target && {(position _target) distance _FO > 100}) then {
                            
	                        if ((_RndPos select 0) distance (getposASL _target) < _disp) then {
			                    if (speed _target > 20) then {
			                        _hit = [_target] call DEP_ARTY_CalcImpact;
			                        if (_debug) then {diag_log format ["Impactcalculation for %1: %2 !", _target, _hit]};
			                    } else {
                                    _minD = (_disp / 10)*3;
			                        _hitA = [position _target, _disp] call CBA_fnc_randPos;
								    _hit = [position _target,_minD,_disp,0,0,100,0,[],[_hitA]] call BIS_fnc_findSafePos;
                                    _hit = [_hit select 0, _hit select 1,(getposASL _target) select 2];
			                        if (_debug) then {diag_log format ["Randpos calculation for %1: %2 !", _target, _hit]};
			                    };
			                    if (_disp >= 25) then {_disp = _disp - 25} else {_disp = 25};
				                _RndPosNEW = [_hit,_disp];
				                _target setvariable ["ACC_RNDS",_RndPosNEW];
				            } else {
			                    if (speed _target > 20) then {
			                        _hit = [_target] call DEP_ARTY_CalcImpact;
			                        if (_debug) then {diag_log format ["Impactcalculation for %1: %2 !", _target, _hit]};
			                    } else {
			                        _hitA = [position _target, _disp] call CBA_fnc_randPos;
								    _hit = [position _target,20,_disp,0,0,100,0,[],[_hitA]] call BIS_fnc_findSafePos;
                                    _hit = [_hit select 0, _hit select 1,(getposASL _target) select 2];
			                        if (_debug) then {diag_log format ["Randpos calculation for %1: %2 !", _target, _hit]};
			                    };
			                    if (_disp <= 150) then {_disp = _disp + 25} else {_disp = 150};
				                _RndPosNEW = [_hit,_disp];
				                _target setvariable ["ACC_RNDS",_RndPosNEW];
				            };
			            
				            _impact = (_target getvariable "ACC_RNDS") select 0;
			                _dispersion = (_target getvariable "ACC_RNDS") select 1;
				            if (_debug) then {diag_log format ["Checking variables %1 on Target %2 - Impact will be: %3!", _target, _target getvariable "ACC_RNDS",_impact]};
                            
			                if (sunOrMoon < 0.15 && {(_FMcount > 3 || _FMcount == -1)}) then {
			                    if !(isnil "_battery") then {
		                             [_battery, _illumTMP select 1] call BIS_ARTY_F_LoadMapRanges;
		                            
		                            if ([_battery, _impact, _illumTMP select 1] call BIS_ARTY_F_PosInRange) then {
		                                _null1 = [_impact,_battery,_illumTMP,_dispersion] call DEP_ARTY_aifiremission;
		                                if (_debug) then {diag_log format ["Impact %1 selected for battery %2 and template %3 dispersion %4",_impact,_battery,_HETMP,_dispersion]};
		                            } else {
		                                _battery = [_impact, _illumTMP] call DEP_ARTY_SelectBestArty;
		                                if (_debug) then {diag_log format ["Artillery out of range, Calling new Artillery! MAXRANGE:%1 MINRANGE:%2 DISTANCE:%3", _battery getVariable "ARTY_MAX_RANGE",_battery getVariable "ARTY_MIN_RANGE",(position _battery) distance _impact]};
		                                _AlignTime = 0;
		                            };
			                    } else {
	                                	_quitFO = true;
			                    };
				                _FMcount = 0;
			                } else {
			                    if !(isnil "_battery") then {
		                            [_battery, _HETMP select 1] call BIS_ARTY_F_LoadMapRanges;
		                            
		                            if ([_battery, _impact, _HETMP select 1] call BIS_ARTY_F_PosInRange) then {
		                                _null1 = [_impact,_battery,_HETMP,_dispersion] call DEP_ARTY_aifiremission;
	                                    _FMcount = _FMcount + 1;
		                                if (_debug) then {diag_log format ["Impact %1 selected for battery %2 and template %3 dispersion %4",_impact,_battery,_HETMP,_dispersion]};
		                            } else {
		                                _battery = [_impact, _HETMP] call DEP_ARTY_SelectBestArty;
		                                if (_debug) then {diag_log format ["Artillery out of range, Calling New Artillery! MAXRANGE:%1 MINRANGE:%2 DISTANCE:%3", _battery getVariable "ARTY_MAX_RANGE",_battery getVariable "ARTY_MIN_RANGE",(position _battery) distance _impact]};
		                                _AlignTime = 0;
		                            };
			                    } else {
	                                	_quitFO = true;
			                    };
			                };
						} else {
			                if (_debug) then {diag_log format ["Target %1 isNull: %2 and Impact is farer away then 100mtrs: %3", _target, isNull _target,_impact, _impact distance _FO > 100]};
			            };
                  	};  
					Sleep 10;
                    _FO selectWeapon (primaryweapon _FO);
    				_FO dowatch ObjNull;
                    sleep 10;
	            } else {
	                _AlignTime = _AlignTime + 20;
	        		if (_debug) then {diag_log format ["Waiting %1 of %2", _AlignTime,_AlignTimeLimit]};
	                Sleep 20;
	            };
			} else {
                	sleep 20;
        			_AlignTime = 0;
                    if (_debug) then {diag_log format ["Waiting %1 of %2", _AlignTime,_AlignTimeLimit]};
            };
	} else {
	    sleep 20;
        _AlignTime = 0;
	};
};

if (_debug) then {diag_log format ["MSO-%1 DEP Forward Observer exited %2.",time,_FO,_battery]};