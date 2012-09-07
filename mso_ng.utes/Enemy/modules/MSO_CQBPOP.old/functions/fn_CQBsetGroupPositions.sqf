//MSO_fnc_CQBSetGroupPositions

private ["_unit","_spawnpos","_units","_group","_bldgpos"];

_group = _this select 0;
_bldgpos = _this select 1;
_units = units _group;

// Position units indoors in various nearby houses
// and set to crouch or prone if high in building
{
        _spawnpos = _bldgpos call BIS_fnc_selectRandom;
        _spawnpos set [2, (_spawnpos select 2) + 0.5];
        _unit = _x;
        _unit setPos _spawnpos;
        _unit setVelocity [0,0,-0.2];
        _unit setUnitPos "Middle";
        // If units got spawned on a houseroof accidentally they 
        // get in prone pos so they are not seen by players
        if ((getPosATL _unit) select 2 > 3) then {
                _unit setUnitPos "DOWN";
        };
} forEach _units;

//After 20 seconds they can stand up or crouch
_units spawn {
        {
                sleep 20;
                _x setUnitPos "AUTO";
        } forEach _this;
};
