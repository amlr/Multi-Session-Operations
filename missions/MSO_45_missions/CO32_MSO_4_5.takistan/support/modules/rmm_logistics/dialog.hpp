class RMM_ui_logistics {
	idd = 80507;
	movingEnable = 1;
	enableSimulation = 1;
	
	class controls {
		class Background : CUI_Frame {
			x = CUI_Box_X(1);
			y = CUI_Box_Row(0,0);
			w = CUI_Box_W * 2;
		};
		class WindowCaption : CUI_Caption {
			x = CUI_Box_X(1);
			y = CUI_Box_Row(0,0);
			w = CUI_Box_W * 2;
			text = "Logistics";
		};
		class SText : CUI_Text {
			x = CUI_Box_X(1);
			y = CUI_Box_Row(0,1);
			w = CUI_Box_W;
			text = "Available ()";
		};
		class SLb : CUI_List {
			idc = 1;
			x = CUI_Box_X(1);
			y = CUI_Box_Row(0,2);
			w = CUI_Box_W;
			h = CUI_Row_DY(1,CUI_Box_Rows);
			onLBDblClick = "_this spawn logistics_fnc_load";
		};
		class PText : SText {
			idc = 2;
			x = CUI_Box_X(2);
			y = CUI_Box_Row(0,1);
			text = "Error: <No Vehicle>";
		};
		class PLb : SLb {
			idc = 3;
			x = CUI_Box_X(2);
			onLBDblClick = "_this spawn logistics_fnc_unload";
		};
	};
};