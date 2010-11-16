if (isServer) then {
	_leader = _this select 0;
	_list = _this select 1;
	_list = side (_list select 0);
	_side = east;
	switch (_list) do {
		case west:
	{
		_side = east;
	};
		case east:
	{
		_side = west;
	};
	};	

	if (isnil "RE") then {[] execVM "\ca\Modules\MP\data\scripts\MPframework.sqf"};
	
	_grp = creategroup _side;
	//_grp = creategroup Resistance;
	

	//player sidechat format ["%1 - %2 - %3",_list,_side,_grp];

	_random = round(random 4) +3;

		for "_i" from 1 to _random do {
	
	_type = round(random 1);
	_breed = "Pastor";
	switch (_type) do {
		case 0:
	{
		_breed = "Pastor";
	};
		case 1:
	{
		_breed = "Fin";
	};
	};	

			//_dog = _grp createUnit [_breed, getpos _leader,[],50,"none"];
			_dogname = format ["k9%1",round (random 1000)];
			call compile format ['"%2" createUnit [position _leader, _grp,"%1=this; this setSpeedMode ""full"";this setbehaviour ""safe""",1]',_dogname,_breed];
			_dog = call compile format ["%1",_dogname];
			_dog addrating -1000; 
			_dog setVariable ["_sound1", "dog_01"];
			_dog setVariable ["_sound2", "dog_02"];
			
			[_dog] joinsilent _grp;
			
		[_dog,_leader,_side] spawn {
			_dog = _this select 0;
			_leader = _this select 1;
			_side = _this select 2;
			//player sidechat format ["%1", side _dog];
			while {alive _dog} do
			{	
					_near_humans = [];
					_alive_humans = [];
					_distance = 1000;
					_neareast = objNull;
					_near_humans = position _dog nearEntities ["man",100];
						{if ((side _dog)getFriend (side _x) <0.6) then {_alive_humans = _alive_humans + [_x];_dog knowsabout _x;}}forEach _near_humans;
						// or attack everything!!!
						//{_alive_humans = _alive_humans + [_x];_dog knowsabout _x;}forEach _near_humans;
							if (count _alive_humans >0)  then {
							_nearest = _alive_humans select 0;
							_distance = (position _dog) distance (_nearest);
							if ((_distance > 75) && (_distance < 100)) then {
							_nic = [objNull, _dog, rSAY, "dog_02"] call RE;
							_dog domove position _nearest;
							_dog setspeedmode "FULL";
						};
							if ((_distance > 50) && (_distance < 75)) then {
							_nic = [objNull, _dog, rSAY, "dog_01"] call RE;
							_dog domove position _nearest;
							_dog setspeedmode "FULL";
						};
							if ((_distance > 15) && (_distance < 50)) then {
							_nic = [objNull, _dog, rSAY, "dog_01"] call RE;
							_dog domove position _nearest;
							_dog setspeedmode "FULL";
						};
							if ((_distance > 5) && (_distance < 15)) then {
							_dog domove position _nearest;
							_dog setspeedmode "FULL";
						};
							if (_distance < 5) then {
							_nic = [objNull, _dog, rSAY, "dog_maul01"] call RE;
							_dog domove position _nearest;
							_dog setspeedmode "FULL";
							[_nearest, _dog] spawn dogs_fnc_dogattack;
						};	
					};
				sleep 2;
				_dog domove position _leader;
				_dog setspeedmode "FULL";
			};
			};
		};
};	
