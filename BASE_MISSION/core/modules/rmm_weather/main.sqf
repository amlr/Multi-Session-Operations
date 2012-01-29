private ["_ocurrent","_oforecast","_ostart","_oend","_fcurrent","_fforecast","_fstart","_fend","_rcurrent","_rforecast","_rstart","_rend","_overcast","_fog","_rain","_currentDate"];

waitUntil{!isNil "bis_fnc_init"};

CRB_timeSync = {
        private["_stime","_sdiff"];
        _stime = _this select 0;
        _sdiff = (((datetonumber date) - (datetonumber _stime)) * 365 * 24 * 60);
        if(abs(_sdiff) > timeDiff) then {
                player sideChat format["Time syncing (%1=>%2)...", date, _stime];
                setDate _stime;
        };
};

CRB_randomOvercast = {
        private ["_value","_delay"];
        _value = random 1; //new overcast% (0-1)
        _delay = 300 + random 1500; // finish
        
        [overcast, _value, time, time + _delay];
};

CRB_randomFog = {
        private ["_value","_delay"];
        if (daytime > 1 && daytime < 8) then {
                _value = random 1; //new fog% (0-0.5)
        } else {
                _value = random 0.25;
        };
        _delay = 300 + random 300; // finish
        
        [fog, _value, time, time + _delay];
};

CRB_randomRain = {
        private ["_value","_delay"];
        _value = random 1; //new rain% (0-1)
        _delay = 300 + random 1500; // finish
        
        [rain, _value, time, time + _delay];
};

if (isserver) then {        
        if(isNil "disableFog") then {
                disableFog = 0;
        };
        
        if(isNil "timeSync") then {
                timeSync = 300;
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
        
        CRB_t = [date];
        publicvariable "CRB_t";
        
        // Set random weather on server
       	_overcast = random 1;
        diag_log format["MSO-%1 Weather Server Start: Overcast=%2", time, _overcast];
        0 setOvercast _overcast;
        
        _fog = if(disableFog == 0) then {random 0.5;} else {0};
        diag_log format["MSO-%1 Weather Server Start: Fog=%2", time, _fog];
        0 setFog _fog;
        
        _rain = random 1;
        diag_log format["MSO-%1 Weather Server Start: Rain=%2", time, _rain];
        0 setRain _rain;
        
        // Setup random weather forecast on server
        RMM_o = call CRB_randomOvercast;
        RMM_f = call CRB_randomFog;
        RMM_r = call CRB_randomRain;
        RMM_w = RMM_o + RMM_f + RMM_r;
        RMM_w call weather_fnc_sync;
        publicVariable "RMM_w";
        
        [{               
                private ["_oend","_fend","_rend","_publish"];
                _publish = false;
                _oend = RMM_w select 3;               
                _fend = RMM_w select 7;
                _rend = RMM_w select 11;
                
                if (time > _oend) then {
                        RMM_o = call CRB_randomOvercast;                                
                        _publish = true;
                };
                if (time > _fend) then {
                        RMM_f = call CRB_randomFog;
                        _publish = true;
                };
                if (time > _rend) then {
                        RMM_r = call CRB_randomRain;
                        _publish = true;
                };
                if (_publish) then {
                        RMM_w = RMM_o + RMM_f + RMM_r;
                        RMM_w call weather_fnc_sync;
                        publicVariable "RMM_w";
                };
        }, 30, []] call mso_core_fnc_addLoopHandler;
        
        [{CRB_t = [date]; publicvariable "CRB_t";}, timeSync, []] call mso_core_fnc_addLoopHandler;
        
};

if(!isDedicated) then {
        "CRB_t" addPublicVariableEventHandler {CRB_t call CRB_timeSync;};
        "RMM_w" addPublicVariableEventHandler {RMM_w call weather_fnc_sync;};
        
        waitUntil{!isNil "CRB_t"};
        CRB_t call CRB_timeSync;
        
        waitUntil{!isNil "RMM_w"};
        _ocurrent = RMM_w select 0;
        _oforecast = RMM_w select 1;
        _ostart = RMM_w select 2;
        _oend = RMM_w select 3;
        
        _fcurrent = RMM_w select 4;
        _fforecast = RMM_w select 5;
        _fstart = RMM_w select 6;
        _fend = RMM_w select 7;
        
        _rcurrent = RMM_w select 8;
        _rforecast = RMM_w select 9;
        _rstart = RMM_w select 10;
        _rend = RMM_w select 11;
        
        //Linear interpolation
        _overcast = ((time - _ostart) * (_oforecast - _ocurrent)/(_oend - _ostart)) + _ocurrent;
        diag_log format["MSO-%1 Weather Client Start: Overcast=%2", time, _overcast];
        0 setOvercast _overcast;
        
        _fog = if(disableFog == 0) then {
                ((time - _fstart) * (_fforecast - _fcurrent)/(_fend - _fstart)) + _fcurrent;
        } else {0};
        diag_log format["MSO-%1 Weather Client Start: Fog=%2", time, _fog];
        0 setFog _fog;
        
        _rain = ((time - _rstart) * (_rforecast - _rcurrent)/(_rend - _rstart)) + _rcurrent;
        diag_log format["MSO-%1 Weather Client Start: Rain=%2", time, _rain];
        0 setRain _rain;
        
        RMM_w call weather_fnc_sync;
};
