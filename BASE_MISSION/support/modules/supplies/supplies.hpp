class RMM_ui_supplies {
	idd = 80510;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "if (isnil ""RMM_supplies_lastdrop"")then {RMM_supplies_lastdrop = 0; publicvariable ""RMM_supplies_lastdrop""; RMM_supplies_inbound = false; publicvariable ""RMM_supplies_inbound""};";

	class controls {
		class Background : CUI_Frame {
			h = CUI_Row_DY(0,4);
		};
		class WindowCaption : CUI_Caption {
			text = "Supplies";
		};
		class Request : CUI_Button {
			text = "Request Supplies @ Current Position";
			w = CUI_Box_W;
			y = CUI_Row_Y(1);
			action = "if (RMM_supplies_lastdrop - time < 0) then {RMM_supplies_lastdrop = time + 32400; publicvariable ""RMM_supplies_lastdrop""; ; RMM_supplies_inbound = true; publicvariable ""RMM_supplies_inbound"";}";
		};
		class Inbound : CUI_Button {
			text = "Cancel Inbound Drop";
			w = CUI_Box_W;
			y = CUI_Row_Y(2);
			action = "RMM_supplies_inbound = false; publicvariable ""RMM_supplies_inbound"";";
		};
	};
};