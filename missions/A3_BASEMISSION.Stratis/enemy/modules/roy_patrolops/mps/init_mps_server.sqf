if(!isServer) exitWith {};

// Determine if Server is running ACE & ACRE
	[] execVM (mps_path+"func\mps_func_detect_ace.sqf");

// AMMOBOX
	mps_ammobox_list = []; publicVariable "mps_ammobox_list";

// Ambient Civillians
	if(AMBCIVILLIAN > 0 && count ALICE_MODULE > 0) then {
		MISSION_GroupLogic = createGroup sideLogic;
		ALICE = MISSION_GroupLogic createUnit [(ALICE_MODULE) select 0,[0,0,0],[],0,"NONE"];
		ALICE setVariable ["spawnDistance",500];
		ALICE setVariable ["ALICE_civilianinit",[{
			_this addEventHandler ["Killed",{
				_killer = _this select 1;
				if(side _killer == (SIDE_A select 0) ) then{ mission_commandchat = format["%1 killed a civilian!",name _killer]; publicVariable "mission_commandchat"; player commandchat mission_commandchat;};
			}];
		}]];
	};

	[] spawn compile preprocessFileLineNumbers (mps_path+"func\mps_func_ieds.sqf");

// Unit Recruiting
// Written By BON_IF
// Adapted by EightySix

	"mps_recruit_newunit" addPublicVariableEventHandler {
		_newunit = _this select 1;
		[_newunit] execFSM (mps_path+"recruit\recruit_lifecycle.fsm");
	};

// Storeable Objects Reference point
// Written By R3F
// Adapted by EightySix

	mps_logistics_referencepoint = "Land_CargoBox_V1_F" createVehicle [0, 0, 0];
	publicVariable "mps_logistics_referencepoint";

// Initilise MHQ
// Written By EightySix
	[] spawn {
		{
			_mhq = !isNil {_x getVariable "mhq_side"};
			if(_mhq) then {
				_x setVariable ["mhq_status",false,true];
				_x setVariable ["liftable",true,true];
				_x setVariable ["vehicle_ammobox",true,true];
				[_x] spawn mps_mhq_toggle;
			};
		} forEach (nearestObjects [ [0,0], ["LandVehicle"], 80000 ] );
	};

//
	[] spawn CREATE_OPFOR_AIRPATROLS;