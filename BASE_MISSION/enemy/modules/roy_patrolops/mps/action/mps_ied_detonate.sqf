// Written by BON_IF
// Adpated by EightySix

	_ied = _this select 0;

	mission_commandchat = format["%1 has set the self destruct",name player]; publicVariable "mission_commandchat"; player sideChat mission_commandchat;

	sleep 1;	mission_commandchat = "10 Seconds to Detonation"; 	publicVariable "mission_commandchat"; hint mission_commandchat;
	sleep 7;	mission_commandchat = "3.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
	sleep 1;	mission_commandchat = "2.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;
	sleep 1;	mission_commandchat = "1.."; 				publicVariable "mission_commandchat"; hintsilent mission_commandchat;

	sleep random 2;
	hintsilent "";

	_ied setvariable ["bon_ied_blowit",true,true];