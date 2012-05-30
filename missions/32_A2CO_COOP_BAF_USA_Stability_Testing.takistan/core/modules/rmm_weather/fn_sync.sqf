private ["_ocurrent","_oforecast","_ostart","_oend","_fcurrent","_fforecast","_fstart","_fend","_rcurrent","_rforecast","_rstart","_rend"];
_ocurrent = _this select 0;
_oforecast = _this select 1;
_ostart = _this select 2;
_oend = _this select 3;

_fcurrent = _this select 4;
_fforecast = _this select 5;
_fstart = _this select 6;
_fend = _this select 7;

_rcurrent = _this select 8;
_rforecast = _this select 9;
_rstart = _this select 10;
_rend = _this select 11;

diag_log format["MSO-%1 Weather Client Sync: O=[%2,%3,%4,%5]", time, _ocurrent,_oforecast,_ostart,_oend];
diag_log format["MSO-%1 Weather Client Sync: F=[%2,%3,%4,%5]", time, _fcurrent,_fforecast,_fstart,_fend];
diag_log format["MSO-%1 Weather Client Sync: R=[%2,%3,%4,%5]", time, _rcurrent,_rforecast,_rstart,_rend];

(_oend - time) setOvercast _oforecast;

if(disableFog == 0) then {
        (_fend - time) setFog _fforecast;

/*
	// Disabled until FSM is fixed to end at the correct time
	if (_fforecast > 0.5) then {
		_end = daytime + (_fend * 60 * 60);
		0 = [player,100,20,10,4,7,-0.3,0.1,0.8,1,1,1,13,12,15,true,2,2.1,0.1,4,6,0,daytime,_end] execFSM "core\modules\rmm_weather\Fog.fsm";
	};
*/
} else {
        0 setFog 0;
};

(_rend - time) setRain _rforecast;
