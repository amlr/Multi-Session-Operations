/*__          __        _     _   _          _____             __ _ _      _     _______          _ \ \        / /       | |   | | (_)        / ____|           / _| (_)    | |   |__   __|        | | \ \  /\  / /__  _ __| | __| |  _ _ __   | |     ___  _ __ | |_| |_  ___| |_     | | ___   ___ | |  \ \/  \/ / _ \| '__| |/ _` | | | '_ \  | |    / _ \| '_ \|  _| | |/ __| __|    | |/ _ \ / _ \| |   \  /\  / (_) | |  | | (_| | | | | | | | |___| (_) | | | | | | | | (__| |_     | | (_) | (_) | |    \/  \/ \___/|_|  |_|\__,_| |_|_| |_|  \_____\___/|_| |_|_| |_|_|\___|\__|    |_|\___/ \___/|_|  ,---.                     ,---.  ,--.,--.,--.            ,--.,--.       /  O  \ ,--.--.,--,--,--. /  O  \ |  ||  ||  ,---.  ,---. |  |`--' ,---.|  .-.  ||  .--'|        ||  .-.  ||  ||  ||  .-.  || .-. ||  |,--.| .--'|  | |  ||  |   |  |  |  ||  | |  ||  ||  ||  | |  |' '-' '|  ||  |\ `--.`--' `--'`--'   `--`--`--'`--' `--'`--'`--'`--' `--' `---' `--'`--' `---'*/if (isServer) then{			private ["_call","_flaglist","_action"];	_call = _this select 0;	_flaglist = _this select 1;	_action = _this select 2;	{		_flag = _x;		/* Now each flag from _flaglist gets separate thread */		if (_action == "none") then		{			[_call,_flag] spawn {_null = [_this select 0,_this select 1] execVM (WICT_PATH +"WICT\capture.sqf")};		}		else		{			[_call,_flag,_action] spawn {_null = [_this select 0,_this select 1,_this select 2] execVM (WICT_PATH + "WICT\ghostBase.sqf")};						};	} forEach _flaglist;};