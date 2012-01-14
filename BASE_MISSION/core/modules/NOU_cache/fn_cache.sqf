private["_count"];
_count = 0;
{
        private["_pos"];
        if(_x != leader _this && !("Driver" in assignedVehicleRole _x)) then {
                _x disableAI "TARGET";
                _x disableAI "AUTOTARGET";
                _x disableAI "MOVE";
                _x disableAI "ANIM";
                _x disableAI "FSM";
                
                _x enableSimulation false;
                _x allowDamage false;
                _pos = getPosATL _x;
                _pos set [2, -2];
                _x setPosATL _pos;
                _count = _count + 1;
        };
} forEach units _this;

if(_count > 0) then {
	private["_c","_t"];
	_c = {!(simulationEnabled _x)} count allUnits;
	_t = count allUnits;
	diag_log format["MSO-%1 NOUJAY Cached: %2/%3 %4%%", time, _c, _t, floor((_c/_t) * 100)];
};
