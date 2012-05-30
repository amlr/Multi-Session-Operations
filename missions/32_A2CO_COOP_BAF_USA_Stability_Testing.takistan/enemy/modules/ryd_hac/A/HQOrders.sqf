sleep 1;
RydHQ_DefDone = false;
RydHQ_NewOrders = true;
sleep 1.1;
RydHQ_NewOrders = false;
_distances = [];

_Trg = leaderHQ;

RydHQ_NearestE = ObjNull;

if (isNil ("RydHQ_Orderfirst")) then {RydHQ_Orderfirst = true; RydHQ_FlankReady = false};

if (isNil ("RydHQ_Obj")) then {_Trg = leaderHQ} else {_Trg = RydHQ_Obj};
_landE = RydHQ_KnEnemiesG - (RydHQ_EnNavalG + RydHQ_EnAirG);

if (RydHQ_Debug) then {
		diag_log format ["MSO-%1 HETMAN: HQ issuing orders for objective at %2, expected enemy strength %3", time, mapgridposition _Trg, count _landE];
};
	
if ((count _landE) > 0) then 
	{

	for [{_a = 0},{_a < (count _landE)},{_a = _a + 1}] do
		{
		_enemy = leader (_landE select _a);
		_distance = leaderHQ distance _enemy;
		_distances = _distances + [_distance];
		};

	RydHQ_NearestE = _landE select 0;

		{
		for [{_r = 0},{_r < (count _distances)},{_r = _r + 1}] do
			{
			_distance = _distances select _r;
			if (isNil ("_distance")) then {_distance = 10000};
			if (_distance <= _x) then {RydHQ_NearestE = _landE select _r};
			if (isNull RydHQ_NearestE) then {RydHQ_NearestE = _landE select 0}
			}
		}
	foreach _distances;

	_Trg = (leader RydHQ_NearestE);
	};
_PosObj1 = position _Trg;
if (isNil ("RydHQ_ReconReserve")) then {RydHQ_ReconReserve = 0.3 * (0.5 + RydHQ_Circumspection)};

RydHQ_ReconAv = [];

	{
	_recvar = str _x;
	_busy = false;
	_busy = _x getvariable ("Busy" + _recvar);
	if (isNil ("_busy")) then {_busy = false};
	if (not (_x in RydHQ_ReconAv) and not (_busy)) then {RydHQ_ReconAv = RydHQ_ReconAv + [_x]};
	}
foreach (RydHQ_reconG + RydHQ_FOG + RydHQ_snipersG + RydHQ_InfG);

if (RydHQ_ReconReserve > 0) then 
	{
	for [{_b = 0},{_b < (floor ((count RydHQ_ReconAv)*RydHQ_ReconReserve))},{_b = _b + 1}] do
		{
		_RRp = RydHQ_ReconAv select _b;
		RydHQ_ReconAv = RydHQ_ReconAv - [_RRp];
		}
	};

RydHQ_AttackAv = [];
RydHQ_FlankAv = [];

if (isNil ("RydHQ_AttackReserve")) then {RydHQ_AttackReserve = 0.5 * (0.5 + (RydHQ_Circumspection/1.5))};

	{
	_recvar = str _x;
	_busy = false;
	_busy = _x getvariable ("Busy" + _recvar);
	if (isNil ("_busy")) then {_busy = false};
	if (not (_x in RydHQ_AttackAv) and not (_busy) and not (_x in RydHQ_FlankAv)) then {RydHQ_AttackAv = RydHQ_AttackAv + [_x]};
	}
foreach (RydHQ_Friends - (RydHQ_reconG + RydHQ_FOG));

if (RydHQ_AttackReserve > 0) then 
	{
	for [{_g = 0},{_g < floor ((count RydHQ_AttackAv)*RydHQ_AttackReserve)},{_g = _g + 1}] do
		{
		_ResC = RydHQ_AttackAv select _g;
		RydHQ_AttackAv = RydHQ_AttackAv - [_ResC];
		if ((random 100 > (30/(0.5 + RydHQ_Fineness))) and not (_ResC in RydHQ_FlankAv)) then {RydHQ_FlankAv = RydHQ_FlankAv + [_ResC]}
		}
	};
if ((RydHQ_Orderfirst) and not (RydHQ_Order == "DEFEND")) then {nul = execVM (RYD_HAC_PATH + "A\Flanking.sqf")};

//Recon
//if (count RydHQ_InfG == 0) then  {RydHQ_ReconDone = true};

if ((count RydHQ_KnEnemiesG) == 0) then
	{
	if (not ((count RydHQ_reconG) == 0) and ((count RydHQ_ReconAv) > 0) and not (RydHQ_ReconDone)) then
		{
		for [{_c = 500},{_c <= 5000},{_c = _c + 500}] do
			{
				{
				if (((count RydHQ_ReconAv) == 0) or (RydHQ_ReconStage > 3)) exitwith {};
				if (((leader _x) distance _PosObj1) <= _c) then 
					{
					nul = [_x,_PosObj1] execVM (RYD_HAC_PATH + "A\GoRecon.sqf");
					sleep 1.2;
					}
				}
			foreach RydHQ_reconG
			}
		};

	if (not ((count RydHQ_FOG) == 0) and ((count RydHQ_ReconAv) > 0) and not (RydHQ_ReconDone)) then
		{
		for [{_d = 500},{_d <= 5000},{_d = _d + 500}] do
			{
				{
				if (((count RydHQ_ReconAv) == 0) or (RydHQ_ReconStage > 3)) exitwith {};
				if (((leader _x) distance _PosObj1) <= _d) then 
					{
					nul = [_x,_PosObj1] execVM (RYD_HAC_PATH + "A\GoRecon.sqf");
					sleep 1.2;
					}
				}
			foreach RydHQ_FOG
			}
		};

	if (not ((count RydHQ_snipersG) == 0) and ((count RydHQ_ReconAv) > 0) and not (RydHQ_ReconDone)) then
		{
		for [{_e = 500},{_e <= 5000},{_e = _e + 500}] do
			{
				{
				if (((count RydHQ_ReconAv) == 0) or (RydHQ_ReconStage > 3)) exitwith {};
				if (((leader _x) distance _PosObj1) <= _e) then 
					{
					nul = [_x,_PosObj1] execVM (RYD_HAC_PATH + "A\GoRecon.sqf");
					sleep 1.2;
					}
				}
			foreach RydHQ_snipersG
			}
		};

	if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_ReconAv) > 0) and not (RydHQ_ReconDone)) then
		{
		for [{_f = 1000},{_f <= 10000},{_f = _f + 1000}] do
			{
				{
				if (((count RydHQ_ReconAv) == 0) or (RydHQ_ReconStage > 3)) exitwith {};
				if (((leader _x) distance _PosObj1) <= _f) then 
					{
					nul = [_x,_PosObj1] execVM (RYD_HAC_PATH + "A\GoRecon.sqf");
					sleep 1.2;
					}
				}
			foreach RydHQ_InfG
			}
		};

	_LMCUA = RydHQ_Friends - (RydHQ_NavalG + RydHQ_StaticG + RydHQ_SupportG + RydHQ_ArtG);
	if (not ((count _LMCUA) == 0) and ((count RydHQ_ReconAv) > 0) and not (RydHQ_ReconDone)) then
		{
		for [{_f = 1000},{_f <= 20000},{_f = _f + 1000}] do
			{
				{
				if (((count _LMCUA) == 0) or (RydHQ_ReconStage > 3)) exitwith {};
				if (((leader _x) distance _PosObj1) <= _f) then 
					{
					nul = [_x,_PosObj1] execVM (RYD_HAC_PATH + "A\GoRecon.sqf");
					sleep 1.2;
					}
				}
			foreach _LMCUA
			}
		};
	};

sleep 1;

if (not (RydHQ_ReconDone) and ((count RydHQ_KnEnemies) == 0)) exitwith 
	{
	if (RydHQ_Orderfirst) then 
		{
		RydHQ_Orderfirst = false
		};

		{
		_recvar = str _x;
		_busy = false;
		_busy = _x getvariable ("Busy" + _recvar);
		if (isNil ("_busy")) then {_busy = false};
		if ( not (_busy) and ((count (waypoints _x)) <= 1)) then {deleteWaypoint ((waypoints _unitG) select 0);[_x] execVM (RYD_HAC_PATH + "A\GoIdle.sqf")}
		}
	foreach RydHQ_InfG;
	RydHQ_Done = true;
	};

RydHQ_FlankReady = true;

_reconthreat = [];
_FOthreat = [];
_snipersthreat = [];
_ATinfthreat = [];
_AAinfthreat = [];
_Infthreat = [];
_Artthreat = [];
_HArmorthreat = [];
_LArmorthreat = [];
_LArmorATthreat = [];
_Carsthreat = [];
_Airthreat = [];
_Navalthreat = [];
_Staticthreat = [];
_StaticAAthreat = [];
_StaticATthreat = [];
_Supportthreat = [];
_Cargothreat = [];
_Otherthreat = [];


	{
	_GE = (group _x);
	_GEvar = str _GE;
	_checked = _GE getvariable ("Checked" + _GEvar);
	if (isNil ("_checked")) then {_GE setvariable [("Checked" + _GEvar),false,true]};
	_checked = _GE getvariable ("Checked" + _GEvar);
	switch true do
		{
		case ((_x in RydHQ_Enrecon) and not (_GE in _reconthreat) and not (_checked)) : {_reconthreat = _reconthreat + [_GE]};
		case ((_x in RydHQ_EnFO) and not (_GE in _FOthreat) and not (_checked)) : {_FOthreat = _FOthreat + [_GE]};
		case ((_x in RydHQ_Ensnipers) and not (_GE in _snipersthreat) and not (_checked)) : {_snipersthreat = _snipersthreat + [_GE]};
		case ((_x in RydHQ_EnATinf) and not (_GE in _ATinfthreat) and not (_checked)) : {_ATinfthreat = _ATinfthreat + [_GE]};
		case ((_x in RydHQ_EnAAinf) and not (_GE in _AAinfthreat) and not (_checked)) : {_AAinfthreat = _AAinfthreat + [_GE]};
		case ((_x in RydHQ_EnInf) and not (_GE in _Infthreat) and not (_checked)) : {_Infthreat = _Infthreat + [_GE]};
		case ((_x in RydHQ_EnArt) and not (_GE in _Artthreat) and not (_checked)) : {_Artthreat = _Artthreat + [_GE]};
		case ((_x in RydHQ_EnHArmor) and not (_GE in _LArmorthreat) and not (_checked)) : {_LArmorthreat = _LArmorthreat + [_GE]};
		case ((_x in RydHQ_EnLArmor) and not (_GE in _reconthreat) and not (_checked)) : {_reconthreat = _reconthreat + [_GE]};
		case ((_x in RydHQ_EnLArmorAT) and not (_GE in _LArmorATthreat) and not (_checked)) : {_LArmorATthreat = _LArmorATthreat + [_GE]};
		case ((_x in RydHQ_EnCars) and not (_GE in _Carsthreat) and not (_checked)) : {_Carsthreat = _Carsthreat + [_GE]};
		case ((_x in RydHQ_EnAir) and not (_GE in _Airthreat) and not (_checked)) : {_Airthreat = _Airthreat + [_GE]};
		case ((_x in RydHQ_EnNaval) and not (_GE in _Navalthreat) and not (_checked)) : {_Navalthreat = _Navalthreat + [_GE]};
		case ((_x in RydHQ_EnStatic) and not (_GE in _Staticthreat) and not (_checked)) : {_Staticthreat = _Staticthreat + [_GE]};
		case ((_x in RydHQ_EnStaticAA) and not (_GE in _StaticAAthreat) and not (_checked)) : {_StaticAAthreat = _StaticAAthreat + [_GE]};
		case ((_x in RydHQ_EnStaticAT) and not (_GE in _StaticATthreat) and not (_checked)) : {_StaticATthreat = _StaticATthreat + [_GE]};
		case ((_x in RydHQ_EnSupport) and not (_GE in _Supportthreat) and not (_checked)) : {_Supportthreat = _Supportthreat + [_GE]};
		case ((_x in RydHQ_EnCargo) and not (_GE in _Cargothreat) and not (_checked)) : {_Cargothreat = _Cargothreat + [_GE]};

		case ((_x in RydHQ_EnInf) and ((vehicle _x) in RydHQ_EnCargo) and not (_x in RydHQ_EnCrew) and not (_GE in _Infthreat) and not (_checked)) : {_Infthreat = _Infthreat + [_GE]};

		default {}
		};
	if ((isNil ("_checked")) or not (_checked)) then {_GE setVariable [("Checked" + _GEvar), true, true]};
	}
foreach RydHQ_KnEnemies;

switch true do
	{
//Recon threat
	case (count (_reconthreat + _FOthreat + _snipersthreat) > 0) : 
		{
		if (not ((count RydHQ_snipersG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_reconthreat + _FOthreat + _snipersthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_reconthreat + _FOthreat + _snipersthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_reconthreat + _FOthreat + _snipersthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_reconthreat + _FOthreat + _snipersthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			
			for [{_j = 500},{_j <= 5000},{_j = _j + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _j) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttSniper.sqf");
						sleep 1.01;
						}
					}
				foreach RydHQ_snipersG;
				};
			};

		if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count (_reconthreat + _FOthreat + _snipersthreat))},{_k = _k + 1}] do
				{
				_enemy = leader ((_reconthreat + _FOthreat + _snipersthreat) select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_reconthreat + _FOthreat + _snipersthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader ((_reconthreat + _FOthreat + _snipersthreat) select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfG;
				}
			}
		};
//ATInf threat
	case (count _ATinfthreat > 0) : 
		{
		if (not ((count RydHQ_snipersG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _ATinfthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_ATinfthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_ATinfthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_ATinfthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 500},{_j <= 5000},{_j = _j + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _j) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttSniper.sqf");
						sleep 1.01;
						}
					}
				foreach RydHQ_snipersG
				}
			};

		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _ATinfthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_ATinfthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_ATinfthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_ATinfthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count _ATinfthreat)},{_k = _k + 1}] do
				{
				_enemy = leader (_ATinfthreat select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_ATinfthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader (_ATinfthreat select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};;
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfG
				}
			}
		};
//Infthreat
	case (count _Infthreat > 0) : 
		{
		if (not ((count RydHQ_LArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Infthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Infthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Infthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Infthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (90/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_LArmorG
				}
			};
			
		if (not ((count RydHQ_HArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Infthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Infthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Infthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Infthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_HArmorG
				}

			};
		_combatCars = RydHQ_CarsG - (RydHQ_ATInfG + RydHQ_AAInfG + RydHQ_SupportG + RydHQ_NCCargoG);
		if (not ((count _combatCars) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Infthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Infthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Infthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Infthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_PosObj1 = position _Trg;
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat + _LArmorthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach _combatCars
				}

			};

		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Infthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Infthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Infthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Infthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count _Infthreat)},{_k = _k + 1}] do
				{
				_enemy = leader (_Infthreat select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Infthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader (_Infthreat select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfG
				}
			}
		};
//Armor threat

	case (count (_LArmorthreat + _HArmorthreat) > 0) : 
		{
		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_LArmorthreat + _HArmorthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_LArmorthreat + _HArmorthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_LArmorthreat + _HArmorthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_LArmorthreat + _HArmorthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_HArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_LArmorthreat + _HArmorthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_LArmorthreat + _HArmorthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_LArmorthreat + _HArmorthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_LArmorthreat + _HArmorthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (50/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_HArmorG
				}
			};
			
		if (not ((count RydHQ_LArmorATG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_LArmorthreat + _HArmorthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_LArmorthreat + _HArmorthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_LArmorthreat + _HArmorthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_LArmorthreat + _HArmorthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (50/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (50/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_LArmorATG
				}

			};

		if (not ((count RydHQ_InfATG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count (_LArmorthreat + _HArmorthreat))},{_k = _k + 1}] do
				{
				_enemy = leader ((_LArmorthreat + _HArmorthreat) select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_LArmorthreat + _HArmorthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader ((_LArmorthreat + _HArmorthreat) select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfATG
				}
			}
		};

//Carsthreat

	case (count _Carsthreat > 0) : 
		{
		if (not ((count RydHQ_LArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Carsthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Carsthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Carsthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Carsthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (90/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_LArmorG
				}
			};

		_combatCars = RydHQ_CarsG - (RydHQ_ATInfG + RydHQ_AAInfG + RydHQ_SupportG + RydHQ_NCCargoG);
		if (not ((count _combatCars) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Carsthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Carsthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Carsthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Carsthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat + _LArmorATthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach _combatCars
				}

			};
			
		if (not ((count RydHQ_HArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Carsthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Carsthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Carsthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Carsthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_HArmorG
				}

			};

		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Carsthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Carsthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Carsthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Carsthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count _Carsthreat)},{_k = _k + 1}] do
				{
				_enemy = leader (_Carsthreat select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Carsthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader (_Carsthreat select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfG
				}
			}
		};

//ArtThreat

	case (count _Artthreat > 0) : 
		{
		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Artthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Artthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Artthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Artthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_LArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Artthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Artthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Artthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Artthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_LArmorG
				}
			};

		_combatCars = RydHQ_CarsG - (RydHQ_ATInfG + RydHQ_AAInfG + RydHQ_SupportG + RydHQ_NCCargoG);
		if (not ((count _combatCars) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Artthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Artthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Artthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Artthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat + _LArmorATthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach _combatCars
				}

			};
			
		if (not ((count RydHQ_HArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Artthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Artthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Artthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Artthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (80/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_HArmorG
				}

			};

		if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count _Artthreat)},{_k = _k + 1}] do
				{
				_enemy = leader (_Artthreat select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Artthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader (_Artthreat select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfG
				}
			}
		};

//Airthreat

	case (count _Airthreat > 0) : 
		{
		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count _Airthreat)},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader (_Airthreat select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Airthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader (_Airthreat select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (75/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_AAInfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count _Airthreat)},{_k = _k + 1}] do
				{
				_enemy = leader (_Airthreat select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader (_Airthreat select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader (_Airthreat select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AAInfG
				}
			}
		};
//Staticthreat
	case (count (_Staticthreat - _Artthreat) > 0) : 
		{
		if (not ((count RydHQ_AirG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_Staticthreat - _Artthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_Staticthreat - _Artthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_Staticthreat - _Artthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_Staticthreat - _Artthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 20000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("AirAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 0.1) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_AAinfthreat + _StaticAAthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttAir.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_AirG
				}
			};

		if (not ((count RydHQ_LArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_Staticthreat - _Artthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_Staticthreat - _Artthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_Staticthreat - _Artthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_Staticthreat - _Artthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (90/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_LArmorG
				}
			};

		_combatCars = RydHQ_CarsG - (RydHQ_ATInfG + RydHQ_AAInfG + RydHQ_SupportG + RydHQ_NCCargoG);
		if (not ((count _combatCars) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_Staticthreat - _Artthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_Staticthreat - _Artthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_Staticthreat - _Artthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_Staticthreat - _Artthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat + _LArmorATthreat) == 0) or (random 100 > (90/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach _combatCars
				}

			};
			
		if (not ((count RydHQ_HArmorG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			for [{_h = 0},{_h < (count (_Staticthreat - _Artthreat))},{_h = _h + 1}] do
				{
				_distances = [];
				_enemy = leader ((_Staticthreat - _Artthreat) select _h);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_Staticthreat - _Artthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_i = 0},{_i < (count _distances)},{_i = _i + 1}] do
					{
					_distance = _distances select _i;
					if (_distance <= _x) then {_Trg = leader ((_Staticthreat - _Artthreat) select _i)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_j = 1000},{_j <= 10000},{_j = _j + 1000}] do
				{
				_isAttacked = _Trg getvariable ("ArmorAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 2) exitwith {};
					{
					if ((((leader _x) distance _PosObj1) <= _j) and ((count (_ATinfthreat + _StaticATthreat) == 0) or (random 100 > (85/(0.5 + (2*RydHQ_Recklessness))))) and ((count (_HArmorthreat + _LArmorATthreat) == 0) or (random 100 > (90/(0.5 + (2*RydHQ_Recklessness)))))) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttArmor.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_HArmorG
				}

			};

		if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
			{
			_distances = [];
			for [{_k = 0},{_k < (count (_Staticthreat - _Artthreat))},{_k = _k + 1}] do
				{
				_enemy = leader ((_Staticthreat - _Artthreat) select _k);
				_distance = leaderHQ distance _enemy;
				_distances = _distances + [_distance];
				};

			_Trg = leader ((_Staticthreat - _Artthreat) select 0);
			_PosObj1 = position _Trg;
				{
				for [{_l = 0},{_l < (count _distances)},{_l = _l + 1}] do
					{
					_distance = _distances select _l;
					if (_distance <= _x) then {_Trg = leader ((_Staticthreat - _Artthreat) select _l)};
					};
				}
			foreach _distances;
			_PosObj1 = position _Trg;
			RydHQ_Scan = false;
			nul = [_PosObj1] execVM (RYD_HAC_PATH + "A\TerrainScan.sqf");
			waituntil {sleep 1.3;RydHQ_Scan};
			_distances = [];
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("InfAttacked" + str _Trg);
				if (isNil ("_isAttacked")) then {_isAttacked = 0};
				if (_isAttacked > 3) exitwith {};
					{
					if (((leader _x) distance _PosObj1) <= _m) then 
						{
						nul = [_x,_Trg] execVM (RYD_HAC_PATH + "A\GoAttInf.sqf");
						sleep 1.01
						}
					}
				foreach RydHQ_InfG
				}
			}
		};
	default {};
	};

/////////////////////////////////////////
// Capture Objective
	
if (((random 100) > ((count RydHQ_KnEnemies)*(5/(0.5 + (2*RydHQ_Recklessness))))) and not (RydHQ_Orderfirst)) then  
	{
	if (not ((count RydHQ_snipersG) == 0) and ((count RydHQ_AttackAv) > 0)) then
		{
		for [{_j = 500},{_j <= 5000},{_j = _j + 500}] do
			{
			if (isNil ("RydHQ_Obj")) then {_trg = leaderHQ} else {_trg = RydHQ_Obj};
			_isAttacked = _Trg getvariable ("Capturing" + (str _trg));
			if (isNil ("Capturing")) then {_isAttacked = 0};
			if (_isAttacked > 3) exitwith {};
				{
				if (((leader _x) distance _PosObj1) <= _j) then 
					{
					nul = [_x] execVM (RYD_HAC_PATH + "A\GoCapture.sqf");
					waituntil {sleep 1.01;((_Trg getvariable ("Capturing" + (str _trg))) > 0)}
					}
				}
			foreach RydHQ_snipersG
			}
		};

	if (not ((count RydHQ_InfG) == 0) and ((count RydHQ_AttackAv) > 0)) then
		{
		for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
			{
			if (isNil ("RydHQ_Obj")) then {_trg = leaderHQ} else {_trg = RydHQ_Obj};
			_isAttacked = _Trg getvariable ("Capturing" + (str _trg));
			if (isNil ("Capturing")) then {_isAttacked = 0};
			if (_isAttacked > 3) exitwith {};
				{
				if (((leader _x) distance _PosObj1) <= _m) then 
					{
					nul = [_x] execVM (RYD_HAC_PATH + "A\GoCapture.sqf");
					waituntil {sleep 1.01;((_Trg getvariable ("Capturing" + (str _trg))) > 0)}
					}
				}
			foreach RydHQ_InfG
			}
		};
	_LMCU = RydHQ_Friends - (RydHQ_AirG + RydHQ_NavalG + RydHQ_StaticG + RydHQ_SupportG + RydHQ_ArtG + (RydHQ_NCCargoG - (RydHQ_Friends - (RydHQ_AirG + RydHQ_NavalG + RydHQ_StaticG + RydHQ_SupportG + RydHQ_ArtG))));
	if (not ((count _LMCU) == 0) and ((count RydHQ_AttackAv) > 0)) then
		{
		for [{_m = 1000},{_m <= 20000},{_m = _m + 1000}] do
			{
			if (isNil ("RydHQ_Obj")) then {_trg = leaderHQ} else {_trg = RydHQ_Obj};
			_isAttacked = _Trg getvariable ("Capturing" + (str _trg));
			if (isNil ("Capturing")) then {_isAttacked = 0};
			if (_isAttacked > 3) exitwith {};
				{
				if (((leader _x) distance _PosObj1) <= _m) then 
					{
					nul = [_x] execVM (RYD_HAC_PATH + "A\GoCapture.sqf");
					waituntil {sleep 1.01;((_Trg getvariable ("Capturing" + (str _trg))) > 0)}
					}
				}
			foreach _LMCU
			}
		}
	};

	{
	_recvar = str _x;
	_busy = false;
	_busy = _x getvariable ("Busy" + _recvar);
	if (isNil ("_busy")) then {_busy = false};
	if ( not (_busy) and ((count (waypoints _x)) <= 1)) then {deleteWaypoint ((waypoints _unitG) select 0);[_x] execVM (RYD_HAC_PATH + "A\GoIdle.sqf")}
	}
foreach RydHQ_InfG;

	{
	_GE = (group _x);
	_GEvar = str _GE;
	_GE setvariable [("Checked" + _GEvar),false,true];
	}
foreach RydHQ_KnEnemies;

if (RydHQ_Orderfirst) then {RydHQ_Orderfirst = false};

RydHQ_Done = true;