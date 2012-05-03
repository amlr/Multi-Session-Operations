private["_stage"];
_stage = format["Initialising: %1", _this];

player createDiaryRecord ["msoPage", ["Initialisation", 
	_stage
]]; 
titleText [_stage, "BLACK FADED"];
