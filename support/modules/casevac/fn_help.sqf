disableserialization;

_display = findDisplay 80513;
_string = switch (_this select 0) do {
	case (_display displayCtrl 0) : {
		"<t size='1.5'>Location</t><br/>6 Digit GRID COORDINATE";
	};
	case (_display displayCtrl 1) : {
		"<t size='1.5'>Call Sign</t><br/>Call Sign that will be used by the ground unit at the LZ. You should know this information before every operation";
	};
	case (_display displayCtrl 2) : {
		private "_string";
		_string = "<t size='1.5'>Procedure:</t>";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["Alpha","Urgent"],
			["Bravo","Urgent Surgical"],
			["Charlie","Priority"],
			["Delta","Routine"],
			["Echo","Convenience"]
		];
		_string;
	};
	case (_display displayCtrl 3) : {
		private "_string";
		_string = "<t size='1.5'>Special Equipment:</t><br/>Special equipment to be brought to the CASEVAC coordinates.";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["Alpha","None"]
		];
		_string;
	};
	case (_display displayCtrl 4) : {
		private "_string";
		_string = "<t size='1.5'>Patients by Type:</t>";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["Lima","Litter Patients"],
			["Alpha","Ambulatory"]
		];
		_string;
	};
	case (_display displayCtrl 5) : {
		private "_string";
		_string = "<t size='1.5'>Security of Pickup Site:</t>";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["November","No enemy"],
			["Papa","Possible Enemy, approach with caution"],
			["Echo","Enemy, approach with caution"],
			["X-Ray","Enemy, armed escort required"]
		];
		_string;
	};
	case (_display displayCtrl 6) : {
		private "_string";
		_string = "<t size='1.5'>Method of Marking Pickup Site:</t>";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["Alpha","Chemlights"],
			["Bravo","IR Strobes"],
			["Charlie","Smoke signal"],
			["Delta","None"]
		];
		_string;
	};
	case (_display displayCtrl 7) : {
		private "_string";
		_string = "<t size='1.5'>Patient Nationality and Status:</t>";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["Alpha","AU Military"],
			["Bravo","AU Citizen"],
			["Charlie","Non AU Military"],
			["Delta","Non AU Citizen"],
			["Echo","Enemy Prisoner of War"]
		];
		_string;
	};
	case (_display displayCtrl 8) : {
		private "_string";
		_string = "<t size='1.5'>NBC Contamination:</t>";
		{
			_string = _string + format["<br/>%1 -- %2", _x select 0, _x select 1];
		} foreach [
			["November","Nuclear"],
			["Bravo","Biological"],
			["Charlie","Chemical"],
			["Zero","None"]
		];
		_string;
	};
	default {""};
};
hint parseText _string;