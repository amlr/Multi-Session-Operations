if(!isDedicated) then {
        private ["_testvalue","_value","_prevvalue"];
        _prevvalue = 0;
        
        while {true} do {
                waituntil {(!isnil {(MYOBJECT getvariable "TESTVALUE")})};
                _testvalue = (MYOBJECT getvariable "TESTVALUE");
                _value = TESTVALUE select 1;
                if(_value - _prevvalue > 1) then {
                        diag_log format["TESTVALUE-%1: %2 ***", time, _testvalue];
                        hintSilent format["TESTVALUE-%1: %2 ***", time, _testvalue];
                } else {
                        hintSilent format["TESTVALUE-%1: %2", time, _testvalue];
                };
                _prevvalue  = _value;
                
                MYOBJECT setVariable ["TESTVALUE", nil, false];        
        };
};

if(isServer) then {
        private ["_i","_value"];
        MYOBJECT = createVehicle ["HeliEmpty", [0,0,0],[], 0, "NONE"];
        _i = 0;
        
        while{_i < 1000000} do {
                _value = [time, _i];
                MYOBJECT setVariable ["TESTVALUE", _value];
                _i = _i + 1;
        };
};
