if(!isDedicated) then {
        PREVVALUE = 0;
        "TESTVALUE" addPublicVariableEventHandler {
                _value = TESTVALUE select 1;
                if(_value - PREVVALUE > 1) then {
                        diag_log format["TESTVALUE-%1: %2 ***", time, TESTVALUE];
                        hintSilent format["TESTVALUE-%1: %2 ***", time, TESTVALUE];
                } else {
                        hintSilent format["TESTVALUE-%1: %2", time, TESTVALUE];
                };
                PREVVALUE  = _value;
        };
};

if(isServer) then {
        private ["_i"];
        _i = 0;
        while{_i < 1000000} do {
                TESTVALUE = [time, _i];
                publicVariable "TESTVALUE";
                _i = _i + 1;
        };
};
