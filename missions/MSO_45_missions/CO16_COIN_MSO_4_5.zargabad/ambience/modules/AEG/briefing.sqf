/*
	File: briefing.sqf
	Author: Loyalguard

	Description:
	Briefing file for AEG Demo Missions.

	Parameters:
	None.
 
	Execution:
	Executed from init.sqf.
*/

player createDiaryRecord ["Diary", ["ArmA 2 Electrical Grids", "<br/>DESCRIPTION<br/>
===========<br/><br/>
The ArmA Electrical Grids (AEG) simulate an electrical power grids on specific A2, OA, and CO islands. There may be power plants with smokestacks that emit smoke when generating electricity. There may also be substations and pole-mounted transformers that emit a humming noise when energized. Street lamps are turned off when power is cutoff. On Chernarus, inside the shack at each power plant location there is a computer to logon to the grid control system.<br/><br/>
IN-GAME USE<br/>
===========<br/><br/>
There are three ways players can interact with the grids:<br/><br/>
1. Destroy components to cut off power. A transformer object must be completely destroyed for power flowing through it to be cut off. The same principle goes for power plant buildings. An object is completely destroyed when it disappears (or is replaced with rubble/ruins).<br/><br/>
2. Players can also manually cutoff and restore power at by tripping and closing circuit breakers respectively. To cut off power, walk towards the transformers and face the center. When close enough, you will see an action menu option to ""Trip Circuit Breaker"" or ""Close Circuit Breaker"". This option can be turned off by the mission maker.  Mission makers can also add the possibility of an arc flash explosion when manually switching breakers.<br/><br/>
3. If given the option by the mission maker and on a supported island, players can logon to the grid control system and monitor and control power remotely. Players can also access a close circuit television system to monitor substation activity.  The grid control system has a point and click interface. If a circuit breaker is tripped or closed as described above, it can be changed back again via the control system (and vise versa).  A password (set by the mission maker) may be required to access the grid control system.  In this mission no password is required.  The default password is abc123<br/><br/>
4. Portions of the grid may be redundant in case certain components are offline.<br/><br/>
5. There may be components on the map that are inactive.<br/><br/>
6. For additional guidance a visual guide is available for download with detailed images and diagrams documenting different grid features."]]; 



