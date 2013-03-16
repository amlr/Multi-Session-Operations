_who = _this select 0;

if (_who == "A") then 
	{
		{
			{
			if ((RydHQ_Debug) or (RydHQB_Debug)) then {	
				[-1, { [WEST, "HQ"] sideChat _this; diag_log "Side A surrenders!";}, "All teams, OPFOR has surrendered!"] call CBA_fnc_globalExecute;
			};
			_x setCaptive true;
			for [{_a = 0},{_a < (count (weapons _x))},{_a = _a + 1}] do
				{
				_weapon = (weapons _x) select _a;
				_x Action ["dropWeapon", _x, _weapon] 
				};
			_x PlayAction "Surrender";
			sleep (random 0.05);
			_x disableAI "ANIM";
			}
		foreach (units _x)
		}
	foreach RydHQ_Friends + [RydHQ]
	}
else 
	{
		{
			{
			if ((RydHQ_Debug) or (RydHQB_Debug)) then {
				[-1, { [EAST, "HQ"] sideChat _this; diag_log "Side B surrenders!";}, "All teams, BLUFOR has surrendered!"] call CBA_fnc_globalExecute;
			};
			_x setCaptive true;
			for [{_a = 0},{_a < (count (weapons _x))},{_a = _a + 1}] do
				{
				_weapon = (weapons _x) select _a;
				_x Action ["dropWeapon", _x, _weapon] 
				};
			_x PlayAction "Surrender";
			sleep (random 0.05);
			_x disableAI "ANIM";
			}
		foreach (units _x)
		}
	foreach RydHQB_Friends + [RydHQB]
	};

sleep 15;

if (_who == "A") then 
	{
		{
			{
			_x enableAI "ANIM";
			}
		foreach (units _x)
		}
	foreach RydHQ_Friends + [RydHQ];
	RydHQ_Done = true;
	}
else 
	{
		{
			{
			_x enableAI "ANIM";
			}
		foreach (units _x)
		}
	foreach RydHQB_Friends + [RydHQB];
	RydHQB_Done = true;
	};