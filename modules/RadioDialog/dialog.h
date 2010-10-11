/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */
#include <defines.h>

#define __COLUMNS 5

class ADDON {
	idd = __DISPLAYID;
	movingEnable = true;
	enableSimulation = true;
	onLoad = QUOTE([] spawn FUNC(onload));

	class controls {	
		// 1st/2nd COLUMN
		#define __BOXES 1
		class BackgroundM : Dlg_FullBackground {
			x = __COLUMN_X(0);
			y = __COLUMN_Y;
			w = __COLUMN_W * 2;
			h = __COLUMN_H;
		};
		class WindowCaptionM: Dlg_WindowCaption {
			x = __COLUMN_X(0);
			y = __COLUMN_Y;
			w = __COLUMN_W * 2;
			text = "Map";
		};
		class Map : RscMapControl {
			moveOnEdges = 0;
			x = __COLUMN_X(0);
			y = __BOX_DATA_Y(0);
			w = __COLUMN_W * 2;
			h = __BOX_H;
		};
		
		// 3rd COLUMN
		#define __BOXES 3
		class BackgroundR : BackgroundM {
			x = __COLUMN_X(2);
			w = __COLUMN_W;
		};
		class WindowCaptionR: WindowCaptionM {
			x = __COLUMN_X(2);
			y = __BOX_Y(0);
			w = __COLUMN_W;
			text = "Radio";
		};
		class WindowCaptionR2: WindowCaptionR {
			y = __BOX_Y(1);
			text = "Fire Support";
		};
		class WindowCaptionR3: WindowCaptionR {
			y = __BOX_Y(2);
			text = "";
		};
		
		// OPTIONS
		class Option1: RscShortcutButton {
			text = "Request Insertion";
			action = QUOTE([] spawn FUNC(insert));
			x = __COLUMN_X(2);
			y = __BOX_DATA_Y(0);
			w = __COLUMN_W;
		};
		class Option2: Option1 {
			text = "";
			action = "";
			y = __BOX_DATA_Y(0) + __ROW_H * 1;
		};
		class Option3: Option1 {
			text = "";
			action = "";
			y = __BOX_DATA_Y(0) + __ROW_H * 2;
		};
		class Option4: Option1 {
			text = "";
			action = "";
			y = __BOX_DATA_Y(0) + __ROW_H * 3;
		};
		class Option5: Option1 {
			text = "";
			action = "";
			y = __BOX_DATA_Y(0) + __ROW_H * 4;
		};
		class Option6: Option1 {
			text = "";
			action = "";
			y = __BOX_DATA_Y(0) + __ROW_H * 5;
		};
		class Option7: Option1 {
			text = "";
			action = "";
			y = __BOX_DATA_Y(0) + __ROW_H * 6;
		};
		// END OPTIONS
		
		// FIRE SUPPORT
		class ArtyTypes: RscListBox {
			idc = __IDC_TYPES;
			x = __COLUMN_X(2) + __COLUMN_GAP;
			y = __BOX_DATA_Y(1);
			w = __COLUMN_W / 2 - __COLUMN_GAP * 2;
			h = __ROW_H * (count __TYPES);

			onLBSelChanged = QUOTE([] spawn FUNC(update));
			onLBDblClick = "";
		};
		class TimerTypes: ArtyTypes {
			idc = __IDC_TIMERTYPES;
			x = __COLUMN_X(2) + __COLUMN_W * 1/2 + __COLUMN_GAP * 1;
			h = __ROW_H * (count __TIMERTYPES);
			onLBSelChanged = QUOTE([] spawn FUNC(update));
		};
		class RoundsSlider : RscSlider {
			idc = __IDC_ROUNDS;
			x = __COLUMN_X(2) + __COLUMN_GAP;
			y = __BOX_DATA_Y(1) + __ROW_H * 4;
			w = __COLUMN_W - __COLUMN_GAP * 2;
			onSliderPosChanged = QUOTE([] spawn FUNC(update));
		};
		class Option8: Option1 {
			text = "Call Fire";
			action = QUOTE([] spawn FUNC(arty));
			x = __COLUMN_X(2) + __COLUMN_GAP;
			y = __BOX_DATA_Y(1) + __ROW_H * 5;
			w = __COLUMN_W - __COLUMN_GAP * 2;
		};
		class Option9: Option8 {
			text = "Cancel Fire";
			action = QUOTE([] spawn FUNC(cancel_arty));
			y = __BOX_DATA_Y(1) + __ROW_H * 6;
		};
		// END FIRE SUPPORT
		
		// CLOSE BUTTON
		class Close: RscShortcutButton {
			text = "Close";
			action = "closeDialog 0";
			x = __COLUMN_X(2);
			y = __BOX_Y(3) + __ROW_H;
			w = __COLUMN_W;
		};
	};
};