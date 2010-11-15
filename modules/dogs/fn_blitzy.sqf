if (isServer) then {
	_leader = _this select 0;
/*	_leader2 = objNull;
	_leader2 = _this select 3;
	if (!isnull (_leader2 select 0)) then {
		_leader = _leader2 select 0;
	};
*/	if (isnil "RE") then {[] execVM "\ca\Modules\MP\data\scripts\MPframework.sqf"};
	_vari = _leader getvariable 'K-9Unit';
	if (!isnull _vari) then {
		deletevehicle _vari;
	};
	
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
	_grp = group _leader;

			
			_dogname = format ["k9%1",round (random 1000)];
			call compile format ['"%2" createUnit [getpos _leader, _grp,"%1=this; this disableAI ""AUTOTARGET"" ; this disableAI ""TARGET"" ; this setCombatMode ""BLUE"";this setbehaviour ""aware""",1]',_dogname,_breed];
			_dog = call compile format ["%1",_dogname];
			_dog setVariable ["_sound1", "dog_01"];
			_dog setVariable ["_sound2", "dog_02"];
			_dog setIdentity "blitzk9";
			[_dog] joinsilent _grp;
			_leader setvariable ['K-9Unit',_dog];
			
		[_dog,_leader] spawn {
			_dog = _this select 0;
			_leader = _this select 1;
			while {alive _dog} do
			{	
			
					_near_humans = [];
					_alive_humans = [];
					_distance = 1000;
					_neareast = objNull;
					_near_humans = position _dog nearEntities ["man",100];
						//{if ((side _x != side _leader) && (side _x != side _dog)) then {_alive_humans = _alive_humans + [_x];_dog knowsabout _x;}}forEach _near_humans;
						{if ((side _dog)getFriend (side _x) <0.6) then {_alive_humans = _alive_humans + [_x];_dog knowsabout _x;}}forEach _near_humans;
						
						
							if (count _alive_humans >0)  then {
							_nearest = _alive_humans select 0;
							_distance = (position _dog) distance (_nearest);
							if ((_distance > 75) && (_distance < 100)) then {
							_nic = [objNull, _dog, rSAY, "dog_02"] call RE;
							_dog setspeedmode "FULL";
							_dog domove position _nearest;
						};
							if ((_distance > 50) && (_distance < 75)) then {
							_nic = [objNull, _dog, rSAY, "dog_01"] call RE;
							_dog setspeedmode "FULL";
							_dog domove position _nearest;
						};
							if ((_distance > 15) && (_distance < 50)) then {
							_nic = [objNull, _dog, rSAY, "dog_01"] call RE;
							_dog setspeedmode "FULL";
							_dog domove position _nearest;
						};
							if ((_distance > 10) && (_distance < 15)) then {
							_dog setspeedmode "FULL";
							_dog domove position _nearest;
						};
							if (_distance < 10) then {
							_nic = [objNull, _dog, rSAY, "dog_maul01"] call RE;
							_dog setspeedmode "FULL";
							_dog domove position _nearest;
							[_nearest, _dog] spawn dogs_fnc_dogattack;
						};	
					};
				sleep 2;
				_dog domove position _leader;
			};
		};
};	

