/*
__          __        _     _   _          _____             __ _ _      _     _______          _ 
\ \        / /       | |   | | (_)        / ____|           / _| (_)    | |   |__   __|        | |
 \ \  /\  / /__  _ __| | __| |  _ _ __   | |     ___  _ __ | |_| |_  ___| |_     | | ___   ___ | |
  \ \/  \/ / _ \| '__| |/ _` | | | '_ \  | |    / _ \| '_ \|  _| | |/ __| __|    | |/ _ \ / _ \| |
   \  /\  / (_) | |  | | (_| | | | | | | | |___| (_) | | | | | | | | (__| |_     | | (_) | (_) | |
    \/  \/ \___/|_|  |_|\__,_| |_|_| |_|  \_____\___/|_| |_|_| |_|_|\___|\__|    |_|\___/ \___/|_|

  ,---.                     ,---.  ,--.,--.,--.            ,--.,--.      
 /  O  \ ,--.--.,--,--,--. /  O  \ |  ||  ||  ,---.  ,---. |  |`--' ,---.
|  .-.  ||  .--'|        ||  .-.  ||  ||  ||  .-.  || .-. ||  |,--.| .--'
|  | |  ||  |   |  |  |  ||  | |  ||  ||  ||  | |  |' '-' '|  ||  |\ `--.
`--' `--'`--'   `--`--`--'`--' `--'`--'`--'`--' `--' `---' `--'`--' `---'

Takes the base type, generates lists and makes trigger zones for you :)
*/
_baseType = "";
_baseType = _this select 0;
_trigRadius = _this select 1;
_trigTime = _this select 2;

/* Generates the list of the bases, checks first if they exist in the editor!!! */
_flaglist = [];
_genericBase = "";

for "_i" from 0 to WICT_flagLoopLimit do 
{	
	call compile format ["_markerType = getMarkerType ""%1_%2""; if (_markerType !="""") then {_flaglist = _flaglist + [""%1_%2""];};",_baseType,_i];
};

//diag_log format ["Flag list : %1",_flaglist];

/* Putting flags in the lists and creating triggers. */
{
	_marker = _x;
	
	/* Puts the flag in a appropriate list according to the color in editor */
		if (getMarkerColor _marker == "ColorBlue") then {WICT_wbl set [count WICT_wbl, _marker];};
		if (getMarkerColor _marker == "ColorRed") then {WICT_ebl set [count WICT_ebl, _marker];};
		if (getMarkerColor _marker == "ColorBlack") then {WICT_nbl set [count WICT_nbl, _marker];};
	
	/* Creates necessary triggers */
	
	_trgW = createTrigger["EmptyDetector",getMarkerPos _marker];
	_trgW setTriggerArea[_trigRadius,_trigRadius,0,false];
	_trgW setTriggerActivation["ANY","PRESENT",true];
	_trgW setTriggerTimeout [(_trigTime select 0),(_trigTime select 1),(_trigTime select 2),false];
	
	_string = format ["WICT_flag = [""west"",[""%1""],""none"",1]; publicVariable ""WICT_flag"";",_marker];
	
	_trgW setTriggerStatements["west countSide thisList > 0",_string,""];
	
	
	
	_trgE = createTrigger["EmptyDetector",getMarkerPos _marker];
	_trgE setTriggerArea[_trigRadius,_trigRadius,0,false];
	_trgE setTriggerActivation["ANY","PRESENT",true];
	_trgE setTriggerTimeout [(_trigTime select 0),(_trigTime select 1),(_trigTime select 2),false];
	
	_string = format ["WICT_flag = [""east"",[""%1""],""none"",1]; publicVariable ""WICT_flag"";",_marker];
	
	_trgE setTriggerStatements["east countSide thisList > 0",_string,""]; 

	
} forEach _flaglist;