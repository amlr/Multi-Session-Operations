
private ["_logic","_commander","_groups"];
_logic = createlocation ["strategic", [0,0,0], 1, 1];
_logic setside _this;

_commander = grpNull;
_logic setvariable ["commander", grpNull];

_groups = [];
_logic setvariable ["groups", []];

while {not isnull _logic} do {
	waituntil {not isnull _commander};
};