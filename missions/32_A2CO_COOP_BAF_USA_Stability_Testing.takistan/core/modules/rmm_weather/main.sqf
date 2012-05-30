private ["_currentDate"];

waitUntil{!isNil "bis_fnc_init"};

CRB_timeSync = {
        private["_stime","_sdiff"];
        _stime = _this;
        _sdiff = time - _stime;
        if(timeSync != 0) then {
                if(abs(_sdiff) > (timeDiff * 60)) then {
                        diag_log format["MSO-%1 Time Sync: Syncing %2 seconds", time, _sdiff];
                        skipTime (_stime/3600);
                };
        } else {
                diag_log format["MSO-%1 Time Sync: %2 difference", time, _sdiff];
        };
};

if (isserver) then {        
        if(isNil "timeSync") then {
                timeSync = 0;
        };
        
        if(isNil "timeDiff") then {
                timeDiff = 5;
        };
        
        if(isNil "timeOptions") then {
                timeOptions = 0;
        };
        
        if(isNil "timeSeasons") then {
                timeSeasons = 3;
        };
        
        if(isNil "timeHour") then {
                timeHour = 8;
        };
        
        if(isNil "timeMinute") then {
                timeMinute = 0;
        };
        
        // Set server time if required
        switch (timeOptions) do {
                // Original
                case 0: {
                };
                // Random
                case 1: {
                        _currentDate = date;
                        _currentDate set [1, [12,3,6,9] call BIS_fnc_selectRandom];
                        _currentDate set [2, 22];
                        _currentDate set [3, floor(random 24)];
                        _currentDate set [4, floor(random 60)];
                        setDate _currentDate;
                };
                // Custom
                case 2: {
                        _currentDate = date;
                        _currentDate set [1, timeSeasons];
                        _currentDate set [2, 22];
                        _currentDate set [3, timeHour];
                        _currentDate set [4, timeMinute];
                        setDate _currentDate;
                };
        };
        
        timeSync spawn {
                private ["_delay"];
                _delay = _this;
                if(_delay == 0) then {
                        _delay = 60;
                };
                waitUntil{
                        CRB_t = time;
                        publicvariable "CRB_t";
                        sleep _delay;
			false;
                };
        };
        
};

if(!isDedicated) then {
        "CRB_t" addPublicVariableEventHandler {CRB_t call CRB_timeSync;};
};
