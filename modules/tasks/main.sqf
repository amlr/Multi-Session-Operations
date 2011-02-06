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
if (MSO_R_Leader) then {
        ["player", [mso_interaction_key], 4, ["modules\tasks\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;

        CRB_MAPCLICK = CRB_MAPCLICK + "if (_shift && _alt) then {RMM_task_position = _pos; createDialog ""RMM_ui_tasks"";};";
        onMapSingleClick CRB_MAPCLICK;
};