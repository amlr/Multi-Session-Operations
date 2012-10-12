//init variables
PXS_SatelliteInitialHeight = 900;
PXS_SatelliteFOV = 0.2;
PXS_SatelliteZoom = 12.4;
PXS_SatelliteNorthMovementDelta = 0;
PXS_SatelliteSouthMovementDelta = 0;
PXS_SatelliteEastMovementDelta = 0;
PXS_SatelliteWestMovementDelta = 0;
PXS_ViewDistance = 0;

onMapSingleClick	{if ((player distance _pos) < 2000) then 	{
									PXS_SatelliteTarget = "Logic" createVehicleLocal _pos;
									PXS_SatelliteTarget setDir 0;
									call PXS_viewSatellite;
									[4] call PXS_adjustCamera;
									} else {if (true) exitwith {hint "Satellite viewrange is limited to a 2000 mtrs radius!"};
								};
			};

hint localize "STR_PXS_HINT";
openMap true;