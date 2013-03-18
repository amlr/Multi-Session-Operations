if (isdedicated) exitwith {};
if (DSY_CHAR_ACTIVE == 0) exitwith {};

sleep .01;
call compile preprocessFileLineNumbers "support\modules\DSY_CHAR\dsl_gear_get_lists.sqf";
player addAction [("<t color=""#ffc600"">" + ("Character Customizer") + "</t>"),'support\modules\DSY_CHAR\dsl_gear_dialog.sqf',["paperdoll"],-100,true,false,'',"player distance markerpos 'respawn_west' < 10"];

player addeventhandler ["respawn", {
    player addAction [("<t color=""#ffc600"">" + ("Character Customizer") + "</t>"),'support\modules\DSY_CHAR\dsl_gear_dialog.sqf',["paperdoll"],-100,true,false,'',"player distance markerpos 'respawn_west' < 10"];
}];