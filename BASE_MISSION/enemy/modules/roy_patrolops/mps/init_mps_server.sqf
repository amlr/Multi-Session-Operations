if(!isServer) exitWith {};

// Determine if Server is running ACE & ACRE
	[] execVM (mps_path+"func\mps_func_detect_ace.sqf");


/*
// AMMOBOX
	mps_ammobox_list = []; publicVariable "mps_ammobox_list";

// Ambient Civillians
	if(AMBCIVILLIAN > 0 && count ALICE_MODULE > 0) then {
		MISSION_GroupLogic = createGroup sideLogic;
		ALICE = MISSION_GroupLogic createUnit [(ALICE_MODULE) select 0,[0,0,0],[],0,"NONE"];
		ALICE setVariable ["spawnDistance",2000];
		ALICE setVariable ["ALICE_civilianinit",[{
			_this addEventHandler ["Killed",{
				_killer = _this select 1;
				if(side _killer == (SIDE_A select 0) ) then{ mission_commandchat = format["%1 killed a civilian!",name _killer]; publicVariable "mission_commandchat"; player commandchat mission_commandchat;};
			}];
		}]];
	};
*/
	[] spawn compile preprocessFileLineNumbers (mps_path+"func\mps_func_ieds.sqf");


/*
 
//
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

	mps_logistics_referencepoint = "HeliHEmpty" createVehicle [0, 0, 0];
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
		} forEach (nearestObjects [ [0,0], ["LandVehicle"], 40000 ] );
	};
      
 */
 
 _rtp = position HQ;
 _rtp = [_rtp,2,50,2,0,2,0] call BIS_fnc_findSafePos;

return_point_west = createmarkerlocal ["return_point_west",[(_rtp select 0),(_rtp select 1)]];
return_point_west setmarkershapelocal "ICON";
return_point_west setmarkercolorlocal "ColorBlue";
"return_point_west" setMarkerTypelocal "WAYPOINT";
 