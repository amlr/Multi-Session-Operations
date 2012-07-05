if(count ep_locations < 1) exitWith{};
diag_log [diag_frameno, diag_ticktime, time, "MISSION TASK SNI_HVT.sqf"];

private["_killtasktime","_AO","_location","_taskid","_position","_types","_unittypes","_unittype","_HVTgrp","_HVT","_cleared"];

_AO = (ep_locations call mps_getRandomElement);
_AOtype = _AO select 0;
while {!((_AOtype == "Camp") or (_AOtype == "AA") or (_AOtype == "RB"))} do {
    _AO = (ep_locations call mps_getRandomElement);
    _AOtype = _AO select 0;
    sleep 0.1;
};
_position = _AO select 1;

_killtasktime = 0;
_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];
_HVTgrp = nil;
_HVT = nil;

sleep 1;

switch (_AOtype) do {
    
    case "Camp": {
        _HVTgrp = creategroup EAST;
		"RU_Functionary1" createUnit [_position, _HVTgrp];
        _HVT = leader _HVTgrp;
        _chkdist = 200;
        
		[
        	format["TASK%1",_taskid],
			format["Eliminate High Value Target!", _taskid],
			format["We received HUMINT of an High Value Target (HVT)! Eliminate the target as quickly as possible!", _taskid],
			true,
			[format["MARK%1",_taskid],(_position),"hd_objective","ColorRedAlpha","Target"],
			"created",
			_position
		] call mps_tasks_add;
	};
    case "AA": {
        _chkdist = 200;
        
        [
        	format["TASK%1",_taskid],
			"Take out AAA placement!",
			"An hostile AAA camp was revealed! Take out all surrounding enemies!",
			true,
			[format["MARK%1",_taskid],(_position),"hd_objective","ColorRedAlpha","Target"],
			"created",
			_position
		] call mps_tasks_add;

    };
    case "RB": {
        _chkdist = 150;
        
        [
        	format["TASK%1",_taskid],
			"Clear enemy roadblock!",
			"We received HUMINT about a roadblock! Recon the area and eliminate all enemies at the reported site!",
			true,
			[format["MARK%1",_taskid],(_position),"hd_objective","ColorRedAlpha","Target"],
			"created",
			_position
		] call mps_tasks_add;
    };
};

_cleared = false;
_cntr = 0;                                                                                 		                    
while {!(ABORTTASK_PO) && (_killtasktime < 3600) && !(_cleared)} do {
    if ([_position, rmm_ep_spawn_dist] call fPlayersInside) then {
        sleep 2;
        _EnemyCnt = {(str(side _x) != "west") && (str(side _x) != "Civilian") && alive _x} count (nearestObjects [_position, ["CAManBase","Tank"], _chkdist]);
        if (_EnemyCnt == 0) then {
            if (_cntr > 20) then {_cleared = true};
            _cntr = _cntr + 2;
        } else {
            _cntr = 0;
        };
        if !(isnil "_HVT") then {if !(alive _HVT) then {_cleared = true};};
	} else {
        _killtasktime = _killtasktime + 2;
        _cntr = 0;
    	sleep 2;	
    };
};

if (!ABORTTASK_PO && _cleared) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	{deletevehicle _x} foreach _units;
    deletegroup _HVTgrp;

    _idx = [ep_locations, _AO] call BIS_fnc_arrayFindDeep;
    if (typename _idx == "ARRAY") then {
    	_idx = _idx select 0;
    	ep_locations set [_idx, ">REMOVE<"];
   		ep_locations = ep_locations - [">REMOVE<"];
    };
    
    mps_mission_status = 2;
} else {
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
    {deletevehicle _x} foreach (units _HVTgrp);
    deletegroup _HVTgrp;
    
    _idx = [ep_locations, _AO] call BIS_fnc_arrayFindDeep;
    _idx = _idx select 0;
    ep_locations set [_idx, ">REMOVE<"];
    ep_locations = ep_locations - [">REMOVE<"];
    
    mps_mission_status = 3;
};