[
	[500, 900],		// Reducer Ranges
	[700, 1200],	// Freezer Ranges
	[8, 10],		// Default Unit Range
	false			// Debug Mode
] call {
	DAC_Reducer_Ranges = _this select 0;
	DAC_Freezer_Ranges = _this select 1;
	DAC_Unit_Range = _this select 2;
	DAC_Debug = _this select 3;
}