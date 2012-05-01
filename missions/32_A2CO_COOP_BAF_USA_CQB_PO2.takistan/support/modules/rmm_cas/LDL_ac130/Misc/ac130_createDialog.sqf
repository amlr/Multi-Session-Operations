/*	ac130_createDialog.sqf for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

//local variables
private["_dialog","_display"];

while{dialog} do
{
	closeDialog 0;	
};

_dialog = createDialog "LDL_DialogAC130";

waitUntil{(dialog)};

disableSerialization;
_display = (findDisplay 1000);

if(LDL_Adjustments select 3) then
{
	(_display displayctrl 1000) ctrlShow true;
}
else
{
	(_display displayctrl 1000) ctrlShow false;
};