fn_fail = {
        hint format["**FAIL**: %1",_this];
        diag_log format["**FAIL**: %1",_this];
        sleep 15;
        TEST_FAIL = true;
	publicVariable "TEST_FAIL";
	forceEnd;
	sleep 5;
};

fn_log = {        
        hint str _this;
        diag_log _this;
};

fn_enterArea = {
	_this setPos getMarkerPos "enter";
};

fn_exitArea = {
	_this setPos getMarkerPos "exit";
};

fn_areaTest = {
        
        private ["_category","_control","_real"];
        _category = _this select 0;
        _control = _this select 1;
        _real = _this select 2;
        
        if(_control * 1.1 < _real) exitWith {[_category,"Value too large", _control, _real]  call fn_fail;};
        if(_control > _real * 1.1) exitWith {[_category,"Value too small", _control, _real]  call fn_fail;};
};
