if (isdedicated) exitwith {};

RMM_mytasks = [];
if (isnil "RMM_tasks") then {
        RMM_tasks = [];
        publicvariable "RMM_tasks";
} else {
        {
                RMM_mytasks set [count RMM_mytasks, _x call tasks_fnc_taskAdd];
        } foreach RMM_tasks;
};

["player", [mso_interaction_key], 4, ["support\modules\rmm_tasks\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;

CRB_MAPCLICK = CRB_MAPCLICK + "if (_shift && _alt && ((getPlayerUID player) in MSO_R_Leader)) then {RMM_tasks_position = _pos; RMM_tasks_position set [2,0]; createDialog ""RMM_ui_tasks"";};";
onMapSingleClick CRB_MAPCLICK;

"RMM_tasks" addPublicVariableEventHandler {
	{
		if(str (_x select 2) == "[0,0,0]" && playerSide == (_x select 3)) then {
			private ["_taskname","_description","_destination","_playerSide"];
			_taskname = _x select 0;
			_description = _x select 1;
			_destination = _x select 2;
			_playerSide = _x select 3;

			if (_playerSide == playerSide) then {
				private "_task";
				_task = player createsimpletask [_taskname];
				_task setsimpletaskdescription _description;
				_task setsimpletaskdestination _destination;
				_task settaskstate "created";
				missionnamespace setvariable [_taskname,_task];

				RMM_mytasks set [count RMM_mytasks, _task];
			};
		};
	} forEach (_this select 1);
};

