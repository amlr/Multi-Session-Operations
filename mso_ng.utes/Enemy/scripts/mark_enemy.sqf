[] spawn {
        private ["_m","_delay","_markers"];
        _markers = [];
        _delay = 10;
        
        {
                if((west getFriend (side _x)) < 0.6) then {
                        _m = createMarkerLocal [str _x, position _x];
                        _m setMarkerShapeLocal "ICON";
                        _m setMarkerTypeLocal "Destroy";
                        _m setMarkerTextLocal typeof _x;
                        _markers set [count _markers, _m];
                };
        } forEach allUnits;
        
        sleep _delay;
        
        {
                deleteMarkerLocal _x;
        } forEach _markers;
        
};
