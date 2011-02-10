
private ["_debug","_strategic","_spawnpoints","_convoydest","_numconvoys"];
if(!isServer) exitWith{};

_debug = false;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

_strategic = ["Strategic","StrongpointArea","FlatArea","FlatAreaCity","Airport"];
_spawnpoints = [];
_convoydest = [];
{
        private["_t","_m"];
        if(type _x == "BorderCrossing") then {
                _spawnpoints = _spawnpoints + [position _x];
        };
        if(type _x in _strategic) then {
                _convoydest = _convoydest + [position _x];
                if (_debug) then {
                        _t = format["convoy_d%1", floor(random 10000)];
                        _m = [_t, position _x, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorOrange", "GLOBAL"] call CBA_fnc_createMarker;
                        [_m, true] call CBA_fnc_setMarkerPersistent;
                };
        };
} forEach CRB_LOCS;

if (_debug) then {
        private["_t","_m"];
        {
                _t = format["convoy_s%1", floor(random 10000)];
                _m = [_t, _x, "Icon", [1,1], "TYPE:", "Destroy", "GLOBAL"] call CBA_fnc_createMarker;
                [_m, true] call CBA_fnc_setMarkerPersistent;
        } forEach _spawnpoints;
};

_numconvoys = floor((count _convoydest) / 150) max 1;
diag_log format["MSO-%1 Convoy: destinations(%2) spawns(%3) convoys(%4)", time, count _convoydest, count _spawnpoints, _numconvoys];

for "_j" from 1 to _numconvoys do {
        [_j, _spawnpoints, _convoydest, _debug] spawn {
                private ["_timeout","_sleep","_startpos","_destpos","_endpos","_grp","_front","_facs","_wp","_cid","_t","_m","_j","_spawnpoints","_convoydest","_debug","_strnone","_strlittle","_strgood"];
                _j = _this select 0;
                _spawnpoints = _this select 1;
                _convoydest = _this select 2;
                _debug = _this select 3;
                
                _timeout = if(_debug) then {[30, 30, 30];} else {[30, 120, 300];};
                while{true} do {
                        _startpos = (_spawnpoints call BIS_fnc_selectRandom);
                        _startpos = [_startpos, 0, 0, 0, 0, 10, 0] call BIS_fnc_findSafePos;
                        _destpos = (_convoydest call BIS_fnc_selectRandom);
                        _destpos = [_destpos , 0, 50, 10, 0, 10, 0] call BIS_fnc_findSafePos;
                        _endpos = (_spawnpoints call BIS_fnc_selectRandom);
                        _endpos = [_endpos, 0, 0, 0, 0, 10, 0] call BIS_fnc_findSafePos;
                        _grp = nil;
                        _front = "";
                        while{isNil "_grp"} do {
                                _front = [["Motorized","Mechanized","Armored"],[6,3,1]] call CRB_fnc_selectRandomBias;
                                _facs = MSO_FACTIONS;
                                _grp = [_startpos, _front, _facs] call compile preprocessFileLineNumbers "scripts\crB_scripts\crB_randomGroup.sqf";
                        };
                        diag_log format["MSO-%1 Convoy: #%2 %3 %4 %5 %6", time, _j, _startpos, _destpos, _endpos, _front];
                        
                        switch(_front) do {
                                case "Motorized": {
                                        for "_i" from 0 to floor(random 2) do {
                                                [[_startpos, 50] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
                                        };
                                };
                                case "Mechanized": {
                                        for "_i" from 0 to (1 + floor(random 2)) do {
                                                [[_startpos, 50] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
                                        };
                                        if(random 1 > 0.5) then {[[_startpos, 50] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;};
                                };
                                case "Armored": {
                                        for "_i" from 0 to (2 + floor(random 1)) do {
                                                [[_startpos, 50] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
                                        };
                                        [[_startpos, 50] call CBA_fnc_randPos, 0, ([0, MSO_FACTIONS] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom, _grp] call BIS_fnc_spawnVehicle;
                                };
                        };
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointSpeed "LIMITED";
                        _wp setWaypointBehaviour "SAFE";
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_destpos, 0];
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_endpos, 0];
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_destpos, 0];
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointTimeout _timeout;
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointType "CYCLE";
                        
                        _cid = floor(random 10000);
                        _t = format["s%1",_cid];
                        _m = [_t, _startpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Start", "COLOR:", "ColorGreen", "GLOBAL"] call CBA_fnc_createMarker;
                        [_m, true] call CBA_fnc_setMarkerPersistent;
                        
                        _t = format["d%1",_cid];
                        _m = [_t, _destpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Pickup", "COLOR:", "ColorYellow", "GLOBAL"] call CBA_fnc_createMarker;
                        [_m, true] call CBA_fnc_setMarkerPersistent;
                        
                        _t = format["e%1",_cid];
                        _m = [_t, _endpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "End", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
                        [_m, true] call CBA_fnc_setMarkerPersistent;
                        
                        
                        
                        //KIERANS ADDITION - task addition
                        
                        //declare private task vars
                        private ["_taskname","_tasktitle","_taskmessage","_taskhud","_taskid","_taskarmor", "_taskintel","_tr"];
                        
                        //get a random number, if 1 or 2, intel is provided, if 0, no intel
                        _taskintel = floor(random(3));
                        
                        //detect what type of units will be there if intel is avaliable
                        _strnone = "There is no Intel on the strength of this patrol.";
                        _strlittle = "Avaliable intel reports indicate little or no armored units in the convoy.";
                        _strgood = "Avaliable intel reports indicate a good chance of armored units in the convoy.";
                        if (_taskintel != 0) then {
                                switch (_front) do {
                                        case "Motorized": {
                                                //report limited armor (motor or mech)
                                                _taskarmor = _strlittle;
                                        }; //end case
                                        
                                        case "Mechanized": {
                                                //chance of either report (motor, mech or heavy)
                                                _tr = floor(random(2));
                                                if (_tr != 1) then {
                                                        _taskarmor = _strlittle;
                                                } else {
                                                        _taskarmor = _strgood;
                                                }; //end if-else
                                        }; //end case
                                        
                                        case "Armored": {
                                                //report armor (mech or heavy)
                                                _taskarmor = _strgood;
                                        }; //end case
                                        
                                }; //end switch
                                
                        } else{
                                _taskarmor = _strnone;
                        }; //end if-else
                        
                        //DEBUG
                        if(_debug) then {diag_log format["MSO-%1 Convoy %2 Type: %3, Intel: %4", time, _cid, _front, _taskarmor];};
                        
                        //setup text for task
                        _taskname = format["convoy_ambush_%1",_cid];
                        _tasktitle = format["Ambush Convoy #%1", _cid];
                        _taskmessage = format["An enemy convoy (ID #%1) has been sighted entering the AO at <marker name='s%1'>S%1</marker>, travelling to <marker name='d%1'>D%1</marker> and halting at <marker name='e%1'>E%1</marker> before it returns.<br/><br/>Your task is to destroy this convoy, noone must be left alive.<br/><br/>%2", _cid, _taskarmor];
                        _taskhud = _tasktitle;
                        
                        //DEBUG
                        if(_debug) then {diag_log format["MSO-%1 Convoy %2 Task Info - NAME: %3, TITLE: %4, MESS: %5, HUD: %6", time, _cid, _taskname, _tasktitle, _taskmessage, _taskhud];};
                        
                        //setup task
                        //_taskid = player createSimpleTask [_taskname];
                        //_taskid setSimpleTaskDescription[_taskmessage, _tasktitle, _taskhud];
                        _taskid = [_tasktitle, [_taskmessage,_tasktitle,_tasktitle], getMarkerPos format["d%1", _cid]] call tasks_fnc_add;
                        
                        //DEBUG
                        if(_debug) then {diag_log format["MSO-%1 Convoy %2 Task ID: %3", time, _cid, _taskid];};
                        
                        //END KIERANS ADDITION	   
                        
                        waitUntil{!(_grp call CBA_fnc_isAlive)};
                        
                        //KIERANS ADDITION - task deletion
                        
                        //complete the task
                        //_taskid setTaskState "SUCCEEDED";
                        
                        //remove the task to avoid clutter in the taskslist (wait 10 seconds before deleting)
                        [_taskid, _cid] spawn {	
                                //private ["_task","_id"];
                                //_task = _this select 0;
                                //_id = _this select 1;
                                //sleep 10;
                                //player removeSimpleTask _task;
                                //diag_log Format["MSO-%1 Convoy %2 Task Deleted", time, _id];
                        };
                        
                        //alert the players
                        [-1, {[west, "Base"] sideChat (_this select 0); [(_this select 1), "SUCCEEDED"] call tasks_fnc_taskUpdate;}, [format["All teams, this is Command, UAV scans indicates convoy #%1 has been destroyed! Out.",_taskid], _cid]] call CBA_fnc_globalExecute;
                        
                        //END KIERANS ADDITION
                        
                        deletegroup _grp;
                        _t = format["s%1",_cid];
                        deleteMarker _t;
                        
                        _t = format["d%1",_cid];
                        deleteMarker _t;
                        
                        _t = format["e%1",_cid];
                        deleteMarker _t;
                        
                        _sleep = if(_debug) then {30;} else {random 300;};
                        sleep _sleep;
                };
        };
};

diag_log format["MSO-%1 Convoys # %2", time, _numconvoys];