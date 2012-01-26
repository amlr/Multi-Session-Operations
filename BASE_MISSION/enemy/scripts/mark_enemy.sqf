private ["_delay"];

_delay = 60;

[_delay] spawn {
        private ["_m","_repeat","_delay"];
        _delay = _this select 0;
        _repeat = true;
        while{_repeat} do {
                {
                        if((west getFriend (side _x)) < 0.6) then {
                                if(str (markerPos (str _x)) == "[0,0,0]") then {
                                        _m = createMarkerLocal [str _x, position _x];
                                        //_m setMarkerShapeLocal "ICON";
                                        _m setMarkerTypeLocal "DOT";
                                } else {
                                        (str _x) setMarkerPosLocal (position _x);
                                };
                        };
                } forEach allUnits;
                
                if(_delay == 0) then {
                        _repeat = false
                } else {
                        sleep _delay;
                };
        };
};