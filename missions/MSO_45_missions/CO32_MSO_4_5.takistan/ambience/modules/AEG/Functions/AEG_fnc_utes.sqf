/*
    File: AEG_fnc_utes.sqf
    Version: 0.90
    Author: Loyalguard

    Description:
    Create a function that will determine which power plant or transformer bus is being affected by a power related event.

    Parameters:
    _this select 0: Name of the pertinent public variable (string).

    Execution:
    Loaded into memory by AEG_utes.sqf.  Function called by AEG_events.sqf if a power related event has occurred on Utes.
*/

// Create a function that will determine which power plant or transformer bus is being affected by a power related event.
AEG_fnc_utes = 
{
    // Scope //
    private ["_var", "_feeds", "_effect", "_name", "_stack", "_zones", "_events"];

    // Parameter(s) //
    _var = _this;

    // Assign initial values to all variables that will be returned to ensure they are not null.
    _feeds = false;
    _effect = "";
    _name = "";
    _stack = "";
    _zones = [];

// Determine which which power plant or transformer bus is being affected by a power related event based on the public variable that has changed.
    switch (_var) do
    {
        //// UTES ////	


        // V_Utes (Virtual Object)
        case "AEG_on_V_Utes":
        {
            _name = "V_Utes";
        };

        // D_Utes_A
        case "AEG_on_D_Utes_A":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Utes_A";
                _zones = 
                [
                    [[3691.95,3512.34,0], 300, "U1", "Utes Airport"]
                ];
        };
        
        // D_Kame
        case "AEG_on_D_Kame":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Kame";
                _zones = 
                [
                    [[3198.02,4387.73,0], 300, "K1", "Kamenyy"]
                ];
        };
        
        // D_Stre
        case "AEG_on_D_Stre":
        {
                _feeds = true;
                _effect = "XFMR";
                _name = "D_Stre";
                _zones = 
                [
                    [[4342.38,3362.36,0], 250, "S1", "Strelka"]
                ];
        };    
    }; // End switch-do.

    // Return the array _events to AEG_events.sqf (no ";" at end of expression)
    _events = [_feeds, _effect, _name, _stack, _zones];
    _events
};