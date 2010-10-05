if (local _this) then {
	private ["_types"];
	_types = _this getvariable "takibani";
	if (isnil "_types") then {_types = [""]};
	removeAllWeapons _this;
	removeAllItems _this;
	{
		switch (_x) do {
			case "leader" : {
				_this addweapon "itemMap";
				_this addweapon "itemWatch";
				_this addweapon "EvPhoto";
				_this addweapon "Evkobalt";
			};
			case "observer" : {
				_this addweapon "itemRadio";
				_this addweapon "binocular";
			};
			case "sapper" : {
				_this addmagazine "pipebomb";
				_this addmagazine "pipebomb";
			};
			case "sniper" : {
				_this addweapon "SVD";
				_this addmagazine "10Rnd_762x54_SVD";
				_this addmagazine "10Rnd_762x54_SVD";
				_this addmagazine "10Rnd_762x54_SVD";
				_this addmagazine "10Rnd_762x54_SVD";
				_this addmagazine "10Rnd_762x54_SVD";
			};
			case "rpg" : {
				_this addweapon "RPG7V";
				_this addmagazine "PG7V";
				_this addmagazine "OG7";
				if (random 1 > 0.4) then {_this addmagazine "OG7"};
			};
			default {
				if (leader _this == _this) then {
					_this addweapon "itemMap";
					_this addweapon "itemCompass";
				};
				if (random 1 > 0.8) then {
					_this addweapon "itemWatch";
				};
				if (random 1 > 0.97) then {
					_this addweapon "EvPhoto";
				};
				if (random 1 > 0.99) then {
					_this addweapon "Evkobalt";
				};
				switch (floor (random 9)) do {
					case 0 : {
						_this addweapon "LeeEnfield";
						for "_i" from 1 to (2+(random 3)) do {_this addmagazine "10x_303"};
					};
					case 1 : {
						_this addweapon "Sa58P_EP1";
						for "_i" from 1 to (3+(random 4)) do {_this addmagazine "30Rnd_762x39_AK47"};
					};
					case 2 : {
						_this addweapon "Sa58V_EP1";
						for "_i" from 1 to (3+(random 5)) do {_this addmagazine "30Rnd_762x39_AK47"};
					};
					case 3 : {
						_this addweapon "AK_47_S";
						for "_i" from 1 to (3+(random 4)) do {_this addmagazine "30Rnd_762x39_AK47"};
					};
					case 4 : {
						_this addweapon "AK_47_M";
						for "_i" from 1 to (3+(random 4)) do {_this addmagazine "30Rnd_762x39_AK47"};
					};
					case 5 : {
						_this addweapon "PK";
						for "_i" from 1 to (2+(random 3)) do {_this addmagazine "100Rnd_762x54_PK"};
					};
					case 6 : {
						_this addweapon "RPK_74";
						for "_i" from 1 to (3+(random 3)) do {_this addmagazine "75Rnd_545x39_RPK"};
					};
					case 7 : {
						_this addweapon "AKS_74_U";
						for "_i" from 1 to (2+(random 4)) do {_this addmagazine "30Rnd_545x39_AK"};
					};
					case 8 : {
						_this addweapon "AK_74";
						for "_i" from 1 to (3+(random 4)) do {_this addmagazine "30Rnd_545x39_AK"};
					};
					case 9 : {
						_this addweapon "AKS_74";
						for "_i" from 1 to (2+(random 4)) do {_this addmagazine "30Rnd_545x39_AK"};
					};
				};
			};
		};
	} foreach _types;
};