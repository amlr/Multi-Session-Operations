/* Just waiting for Functions and Multiplayer framework */
waituntil {!isnil "bis_fnc_init"};
waituntil {BIS_MPF_InitDone};

_sync = _this select 0;
_delay = _this select 1;
_shift = _this select 2;

if (_shift < 1) then {_shift = 1;};
if (_delay < 1) then {_delay = 1;};

_shift = _shift/60;
_new_shift = 0;
_new_delay = 0;

_shift = _shift/10;
_delay = _delay/10;

_continue = true;

while {_continue} do
{	
	_new_shift = _shift;
	_new_delay = _delay;
	_shift = _shift/2;
	_delay = _delay/2;
	
	if ((_shift < 0.00026) or (_delay < 0.025)) then {_continue = false;};
};

_shift = _new_shift;
_delay = _new_delay;

//diag_log format ["Shift: %1, delay: %2",_shift,_delay];

if ((isServer) and (isMultiplayer)) then 
{
	_null = [_sync] spawn 
	{
		private ["_sync"];
		_sync = _this select 0;
		
		sleep 5;
		
		while {true} do
		{
			_DateStamp = Date;

			_year = _DateStamp select 0;
			_month = _DateStamp select 1;
			_day = _DateStamp select 2;
			_hour = _DateStamp select 3;
			_minute = _DateStamp select 4;
			
			[nil,nil,rSETDATE,_year,_month,_day,_hour,_minute] call RE;
			sleep _sync;
		};
	};
};

while {true} do
{
	skiptime _shift; sleep _delay; 
};