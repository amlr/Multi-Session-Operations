/* ----------------------------------------------------------------------------
Function: RMM_fnc_getDistance

Description:
	A function used to find out the distance between two positions.
Parameters:
	Array containing two of [Marker, Object, Location, Group or Position]
Example:
	_distance = [Player, [0,0,0]] call RMM_fnc_getDistance
Returns:
	Number - Distance in meters
Author:
	Rommel

---------------------------------------------------------------------------- */

((_this select 0) call RMM_fnc_getPos) distance ((_this select 1) call RMM_fnc_getPos)