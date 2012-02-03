/* DynamicWeatherEffects.sqf version 1.0 by Engima of Ostgota Ops
 * Description:
 *   Script that generates dynamic (random) weather in. Works in single player, multiplayer (hosted and dedicated), and is JIP compatible.
 * Arguments:
 *   [_minWeatherChangeTimeMin]: Optional. Minimum time in minutes for the weather to change.
 *   [_maxWeatherChangeTimeMin]: Optional. Maximum time in minutes for the weather to change.
 *   [_minTimeBetweenWeatherChangesMin]: Optional. Minimum time in minutes that weather stays unchanged between weather changes.
 *   [_maxTimeBetweenWeatherChangesMin]: Optional. Maximum time in minutes that weather stays unchanged between weather changes.
 *   [_allowRain]: Optional. true if it is allowed to rain, otherwise false.
 *   [_debug]: Optional. true if debug mode is on, otherwise false.
 */

private ["_minWeatherChangeTimeMin", "_maxWeatherChangeTimeMin", "_minTimeBetweenWeatherChangesMin", "_maxTimeBetweenWeatherChangesMin", "_allowRain", "_debug"];

if (isNil "_this") then { _this = []; };
if (count _this > 0) then { _minWeatherChangeTimeMin = _this select 0; } else { _minWeatherChangeTimeMin = 10; };
if (count _this > 1) then { _maxWeatherChangeTimeMin = _this select 1; } else { _maxWeatherChangeTimeMin = 25; };
if (count _this > 2) then { _minTimeBetweenWeatherChangesMin = _this select 2; } else { _minTimeBetweenWeatherChangesMin = 5; };
if (count _this > 3) then { _maxTimeBetweenWeatherChangesMin = _this select 3; } else { _maxTimeBetweenWeatherChangesMin = 15; };
if (count _this > 4) then { _allowRain = _this select 4; } else { _allowRain = true; };
if (count _this > 5) then { _debug = _this select 5; } else { _debug = false; };

if (isNil "drn_var_CL_CommonLibVersion") then {
    while {true} do {
        player sideChat "Script DynamicWeatherEffects.sqf requires CommonLib v1.02.";
        sleep 5;
    };
}
else {
    if (drn_var_CL_CommonLibVersion < 1.02) then {
        player sideChat "Script DynamicWeatherEffects.sqf requires CommonLib v1.02.";
        sleep 5;
    };
};

if (_debug) then {
    ["Starting script WeatherEffects.sqf..."] call drn_fnc_CL_ShowDebugTextLocal;
};

if (!isDedicated) then {
	waitUntil {!isNull player};
};

drn_DynamicWeatherEventArgs = []; // [current overcast, current fog, current rain, current weather change ("OVERCAST", "FOG" or ""), target weather value, time until weather completion (in seconds), current wind x, current wind z]
drn_AskServerDynamicWeatherEventArgs = []; // []

drn_fnc_DynamicWeather_SetWeatherLocal = {
    private ["_currentOvercast", "_currentFog", "_currentRain", "_currentWeatherChange", "_targetWeatherValue", "_timeUntilCompletion", "_currentWindX", "_currentWindZ"];

    _currentOvercast = _this select 0;
    _currentFog = _this select 1;
    _currentRain = _this select 2;
    _currentWeatherChange = _this select 3;
    _targetWeatherValue = _this select 4;
    _timeUntilCompletion = _this select 5;
    _currentWindX = _this select 6;
    _currentWindZ = _this select 7;
    
    // Set current weather values
    0 setOvercast _currentOvercast;
    0 setFog _currentFog;
    drn_var_DynamicWeather_Rain = _currentRain;
    setWind [_currentWindX, _currentWindZ, true];
    
    // Set forecast
    if (_currentWeatherChange == "OVERCAST") then {
        _timeUntilCompletion setOvercast _targetWeatherValue;
    };
    if (_currentWeatherChange == "FOG") then {
        _timeUntilCompletion setFog _targetWeatherValue;
    };
};

if (!isServer) then {
    "drn_DynamicWeatherEventArgs" addPublicVariableEventHandler {
        drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal;
    };
    
    waitUntil {!isNil "drn_var_DynamicWeather_ServerInitialized"};
    
    drn_AskServerDynamicWeatherEventArgs = [true];
    publicVariable "drn_AskServerDynamicWeatherEventArgs";
};

if (isServer) then {
    drn_DynamicWeather_CurrentWeatherChange = "";
    drn_DynamicWeather_WeatherTargetValue = 0;
    drn_DynamicWeather_WeatherChangeStartedTime = time;
    drn_DynamicWeather_WeatherChangeCompletedTime = time;
    drn_DynamicWeather_WindX = wind select 0;
    drn_DynamicWeather_WindZ = wind select 1;
    
    drn_fnc_DynamicWeather_SetWeatherAllClients = {
        private ["_timeUntilCompletion", "_currentWeatherChange"];
        
        _timeUntilCompletion = drn_DynamicWeather_WeatherChangeCompletedTime - drn_DynamicWeather_WeatherChangeStartedTime;
        if (_timeUntilCompletion > 0) then {
            _currentWeatherChange = drn_DynamicWeather_CurrentWeatherChange;
        }
        else {
            _currentWeatherChange = "";
        };
        
        drn_DynamicWeatherEventArgs = [overcast, fog, drn_var_DynamicWeather_Rain, _currentWeatherChange, drn_DynamicWeather_WeatherTargetValue, _timeUntilCompletion, drn_DynamicWeather_WindX, drn_DynamicWeather_WindZ];
        publicVariable "drn_DynamicWeatherEventArgs";
        drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal;
    };
    
    "drn_AskServerDynamicWeatherEventArgs" addPublicVariableEventHandler {
        call drn_fnc_DynamicWeather_SetWeatherAllClients;
    };

    //sleep 0.01;
    
    drn_var_DynamicWeather_Rain = rain;
    publicVariable "drn_var_DynamicWeather_Rain";
    drn_var_DynamicWeather_ServerInitialized = true;
    publicVariable "drn_var_DynamicWeather_ServerInitialized";
    
    // Start weather thread
    [_minWeatherChangeTimeMin, _maxWeatherChangeTimeMin, _minTimeBetweenWeatherChangesMin, _maxTimeBetweenWeatherChangesMin, _debug] spawn {
        private ["_minWeatherChangeTimeMin", "_maxWeatherChangeTimeMin", "_minTimeBetweenWeatherChangesMin", "_maxTimeBetweenWeatherChangesMin", "_debug"];
        private ["_weatherType", "_fogLevel", "_overcastLevel", "_oldFogLevel", "_oldOvercastLevel", "_weatherChangeTimeSek"];
        
        _minWeatherChangeTimeMin = _this select 0;
        _maxWeatherChangeTimeMin = _this select 1;
        _minTimeBetweenWeatherChangesMin = _this select 2;
        _maxTimeBetweenWeatherChangesMin = _this select 3;
        _debug = _this select 4;
        
/*
        _oldFogLevel = -1;
        _fogLevel = -1;
        _oldOvercastLevel = -1;
        _overcastLevel = -1;
*/
        
        // Set initial fog level
        _fogLevel = 0;
        if (fog >= 0.05) then {
            _fogLevel = 1;
        };
        if (fog >= 0.2) then {
            _fogLevel = 2;
        };
        if (fog >= 0.45) then {
            _fogLevel = 3;
        };
        
        // Set initial overcast level
        _overcastLevel = 0;
        if (overcast >= 0.05) then {
            _overcastLevel = 1;
        };
        if (overcast >= 0.35) then {
            _overcastLevel = 2;
        };
        if (overcast >= 0.7) then {
            _overcastLevel = 3;
        };
        
        while {true} do {
            // Sleep a while until next weather change
            sleep floor (_minTimeBetweenWeatherChangesMin * 60 + random ((_maxTimeBetweenWeatherChangesMin - _minTimeBetweenWeatherChangesMin) * 60));
            
            // Select type of weather to change
            if ((random 100) < 50) then {
                _weatherType = "OVERCAST";
            }
            else {
                _weatherType = "FOG";
            };
            
            // DEBUG
            //_weatherType = "OVERCAST";
            
            if (_weatherType == "FOG") then {
                
                drn_DynamicWeather_CurrentWeatherChange = "FOG";
                
                // Select a new fog level
                _oldFogLevel = _fogLevel;
                _fogLevel = floor ((random 100) / 25);
                
                while {_fogLevel == _oldFogLevel} do {
                    _fogLevel = floor ((random 100) / 25);
                };
                
                if (_fogLevel == 0) then {
                    drn_DynamicWeather_WeatherTargetValue = (random 5) / 100;
                };
                if (_fogLevel == 1) then {
                    drn_DynamicWeather_WeatherTargetValue = (5 + random 15) / 100;
                };
                if (_fogLevel == 2) then {
                    drn_DynamicWeather_WeatherTargetValue = (20 + random 25) / 100;
                };
                if (_fogLevel == 3) then {
                    drn_DynamicWeather_WeatherTargetValue = (45 + random 45) / 100;
                };
                
                drn_DynamicWeather_WeatherChangeStartedTime = time;
                _weatherChangeTimeSek = _minWeatherChangeTimeMin * 60 + random ((_maxWeatherChangeTimeMin - _minWeatherChangeTimeMin) * 60);
                drn_DynamicWeather_WeatherChangeCompletedTime = time + _weatherChangeTimeSek;
                
                // On average every one fourth of weather changes, change wind too
                if (random 100 < 25) then {
                    private ["_maxWind"];
                    
                    _maxWind = random 20;
                    drn_DynamicWeather_WindX = (random _maxWind) - (_maxWind / 2);
                    drn_DynamicWeather_WindZ = (random _maxWind) - (_maxWind / 2);
                    
                    if (_debug) then {
                        ["Wind changes: [" + str drn_DynamicWeather_WindX + ", " + str drn_DynamicWeather_WindZ + "]."] call drn_fnc_CL_ShowDebugTextAllClients;
                    };
                };
                
                call drn_fnc_DynamicWeather_SetWeatherAllClients;
                
                if (_debug) then {
                    ["Weather forecast: Fog " + str drn_DynamicWeather_WeatherTargetValue + " in " + str round (_weatherChangeTimeSek / 60) + " minutes."] call drn_fnc_CL_ShowDebugTextAllClients;
                };

                sleep _weatherChangeTimeSek;
            };
            
            if (_weatherType == "OVERCAST") then {
                
                drn_DynamicWeather_CurrentWeatherChange = "OVERCAST";
                
                // Select a new overcast level
                _oldOvercastLevel = _overcastLevel;
                //_overcastLevel = floor ((random 100) / 25);
                _overcastLevel = 3;
                
                while {_overcastLevel == _oldOvercastLevel} do {
                    _overcastLevel = floor ((random 100) / 25);
                };
                
                if (_overcastLevel == 0) then {
                    drn_DynamicWeather_WeatherTargetValue = (random 5) / 100;
                };
                if (_overcastLevel == 1) then {
                    drn_DynamicWeather_WeatherTargetValue = (5 + random 30) / 100;
                };
                if (_overcastLevel == 2) then {
                    drn_DynamicWeather_WeatherTargetValue = (35 + random 35) / 100;
                };
                if (_overcastLevel == 3) then {
                    drn_DynamicWeather_WeatherTargetValue = (70 + random 30) / 100;
                };
                
                // DEBUG
                /*
                if (overcast > 0.8) then {
                    drn_DynamicWeather_WeatherTargetValue = 0.5;
                }
                else {
                    drn_DynamicWeather_WeatherTargetValue = 0.85;
                };
                */
                
                drn_DynamicWeather_WeatherChangeStartedTime = time;
                _weatherChangeTimeSek = _minWeatherChangeTimeMin * 60 + random ((_maxWeatherChangeTimeMin - _minWeatherChangeTimeMin) * 60);
                drn_DynamicWeather_WeatherChangeCompletedTime = time + _weatherChangeTimeSek;
                
                // On average every one fourth of weather changes, change wind too
                // DEBUG
                if (random 100 < 25) then {
                    private ["_maxWind"];
                    
                    _maxWind = random 20;
                    drn_DynamicWeather_WindX = (random _maxWind) - (_maxWind / 2);
                    drn_DynamicWeather_WindZ = (random _maxWind) - (_maxWind / 2);
                    
                    if (_debug) then {
                        ["Wind changes: [" + str drn_DynamicWeather_WindX + ", " + str drn_DynamicWeather_WindZ + "]."] call drn_fnc_CL_ShowDebugTextAllClients;
                    };
                };
                
                call drn_fnc_DynamicWeather_SetWeatherAllClients;
                
                if (_debug) then {
                    ["Weather forecast: Overcast " + str drn_DynamicWeather_WeatherTargetValue + " in " + str round (_weatherChangeTimeSek / 60) + " minutes."] call drn_fnc_CL_ShowDebugTextAllClients;
                };
                
                sleep _weatherChangeTimeSek;
            };
        };
    };
    
    // Start rain thread
    if (_allowRain) then {
        [_debug] spawn {
            private ["_isRaining", "_hasRained", "_debug"];
            
            _debug = _this select 0;
            
            _hasRained = false;
            _isRaining = false;
            if (rain > 0) then {
                drn_var_DynamicWeather_Rain = rain;
                publicVariable "drn_var_DynamicWeather_Rain";
                _isRaining = true;
            };
            
            while {true} do {
                if (overcast > 0.75) then {
                    
                    // Every iteration there is this chance to stop raining
                    if (_isRaining && (random 100) < 2) then {
                        drn_var_DynamicWeather_Rain = 0;
                        publicVariable "drn_var_DynamicWeather_Rain";
                        _isRaining = false;
                        _hasRained = true;
                        if (_debug) then {
                            ["Rain stops due to randomness."] call drn_fnc_CL_ShowDebugTextAllClients;
                        };
                    };
                    
                    // Every iteration there is this chance of rain.
                    if ((random 100) < 5 && !_hasRained) then {
                        drn_var_DynamicWeather_Rain = (random 80) / 100;
                        publicVariable "drn_var_DynamicWeather_Rain";
                        _isRaining = true;
                        if (_debug) then {
                            ["Rain starting (" + str drn_var_DynamicWeather_Rain + ")."] call drn_fnc_CL_ShowDebugTextAllClients;
                        };
                    };
                }
                else {
                    if (_isRaining) then {
                        drn_var_DynamicWeather_Rain = 0;
                        publicVariable "drn_var_DynamicWeather_Rain";
                        _isRaining = false;
                        if (_debug) then {
                            ["Rain stops due to low overcast."] call drn_fnc_CL_ShowDebugTextAllClients;
                        };
                    };
                    
                    _hasRained = false;
                };
                
                // DEBUG
                //sleep 1;
                
                sleep 60;
            };
        };
    };
};

if (!isNull player) then {
    [_allowRain] spawn {
        private ["_allowRain"];
        private ["_rain", "_rainPerSecond"];
        
        _allowRain = _this select 0;
        _rainPerSecond = 0.01;
        
        if (_allowRain) then {
            _rain = drn_var_DynamicWeather_Rain;
        }
        else {
            _rain = 0;
        };
        
        0 setRain _rain;
        sleep 0.1;
        
        while {true} do {
            if (_allowRain) then {
                if (_rain < drn_var_DynamicWeather_Rain) then {
                    _rain = _rain + _rainPerSecond;
                };
                if (_rain > drn_var_DynamicWeather_Rain) then {
                    _rain = _rain - _rainPerSecond;
                    if (_rain < 0) then { _rain = 0; };
                };
            }
            else {
                _rain = 0;
            };
            
            3 setRain _rain;
            
            sleep 1;
        };
    };
};




