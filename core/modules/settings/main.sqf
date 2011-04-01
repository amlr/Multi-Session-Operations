if (isdedicated) exitwith {};

["player", [mso_interaction_key], 4, ["core\modules\settings\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["Settings","createDialog ""RMM_ui_settings"""] call mso_core_fnc_updateMenu;