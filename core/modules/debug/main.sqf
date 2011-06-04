if (!isdedicated) then {
	["player", [mso_interaction_key], 4, ["core\modules\debug\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
	["Debug","if((getPlayerUID player) in MSO_R_Admin) then {createDialog ""RMM_ui_debug""};"] call mso_core_fnc_updateMenu;
};

displayStats = {
	_maxF = CRBSERVERFPS select 0;
	_avgF = CRBSERVERFPS select 1;
	_minF = CRBSERVERFPS select 2;
	_maxU = CRBSERVERFPS select 3;
	_avgU = CRBSERVERFPS select 4;
	_curU = CRBSERVERFPS select 5;
	hint format["Server FPS(Max/Avg/Min): %1/%2/%3\nUnits(Max/Avg/Cur): %4/%5/%6\nGroups: %7", _maxF, _avgF, _minF, _maxU, _avgU, _curU, count allGroups];
	diag_log format["CRBSERVERFPS,%2,%3,%4,%5,%6,%7,%8", time, _maxF, _avgF, _minF, _maxU, _avgU, _curU, count allGroups];
};	

if(isNil "debug_serverfps") then {debug_serverfps = 30;};

if(isServer && debug_serverfps != 0) then{
	waitUntil{!isNil "bis_fnc_init"};
	[] spawn {
		_i = 0;
		_fpsmax = 0;
		_fpsavg = 0;
		_maxU = 0;
		_avgU = 0;
		while{true} do {
			private ["_testTime","_fpsmin","_startTime","_startFrameNo","_currFrameNo","_endTime","_endFrameNo"];
			private ["_FPSminArray","_fpsminmed","_handle"];

			//test length - time in seconds taken as first record in argument
			_testTime = debug_serverfps;

			if (isnil ("_testTime")) then {_testTime=300;};

			//minimal fps is calculated from worst frame time only
			_fpsmin = 1000;

			_startTime = diag_tickTime;
			_startFrameNo = diag_frameno;

			_currFrameNo = diag_frameno;

			_FPSminArray = [];

			while {diag_tickTime < (_startTime + _testTime)} do
			{
				while {(_currFrameNo + 16) > diag_frameno;} do {Sleep(0.001);}; //we want to call diag_fpsmin with all frames (diag_fpsmin uses last 16 frames)
				//player globalChat format["%1", diag_frameno];
				if (_fpsmin > diag_fpsmin) then {_fpsmin = diag_fpsmin};

				_FPSminArray = [diag_fpsmin] + _FPSminArray;
				_currFrameNo = diag_frameno;
			};

			_endTime = diag_tickTime;
			_endFrameNo = diag_frameno;

			private ["_testTimeAct","_frameCnt"];
			_testTimeAct = (_endTime - _startTime);
			_frameCnt = (_endFrameNo - _startFrameNo);

			_serverfps = _frameCnt / _testTimeAct;
			if (_fpsmax < _serverfps) then {_fpsmax = _serverfps};
			_fpsavg = (_fpsavg *  _i + _serverfps) / (_i + 1);
			_allunits = count allUnits;
			if (_maxU < _allunits) then {_maxU = _allunits};
			_avgU = (_avgU *  _i + _allunits) / (_i + 1);
			_i = _i + 1;
			
			CRBSERVERFPS = [_fpsmax, _fpsavg, _fpsmin, _maxU, _avgU, _allunits];
			publicVariable "CRBSERVERFPS";
			call displayStats;
		};
	};
};

diag_log "CRBSERVERFPS,Time,FPSMax,FPSAvg,FPSMin,UnitsMax,UnitsAvg,UnitsCur,allGroups";
"CRBSERVERFPS" addPublicVariableEventHandler {
	call displayStats;
};