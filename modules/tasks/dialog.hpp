class RMM_ui_tasks { // by Rommel
	idd = 80514;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "";

	class controls {
		class Background : CUI_Frame {
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,5);
			w = CUI_Box_W;
		};
		class Caption : CUI_Caption {
			text = "Task Creator";
			y = CUI_Row_Y(0);
			h = CUI_Row_DY(0,1);
			w = CUI_Box_W;
		};
		class LblText : CUI_Text {
			y = CUI_Row_Y(1);
			text = "Title:";
		};
		class TaskText : CUI_Edit {
			idc = 1;
			x = CUI_Box_X(1/4);
			y = CUI_Row_Y(1);
			w = CUI_Box_W * 3/4;
		};
		class LblDescription : CUI_Text {
			y = CUI_Row_Y(2);
			text = "Text:";
		};
		class TaskDescription : CUI_Edit {
			idc = 2;
			x = CUI_Box_X(1/4);
			y = CUI_Row_Y(2);
			w = CUI_Box_W * 3/4;
		};
		class Transmit : CUI_Button {
			text = "Transmit";
			w = CUI_Box_W;
			y = CUI_Row_Y(3);
			action = "[str (time + random 1),[(ctrlText 2),(ctrlText 1),(ctrlText 1)],RMM_task_position] call tasks_fnc_add; closeDialog 0;";
		};
		class Delete : CUI_Button {
			text = "Delete Nearest";
			w = CUI_Box_W;
			y = CUI_Row_Y(4);
			action = "if (count RMM_tasks > 0) then {RMM_task_position call tasks_fnc_deletenearest; closeDialog 0;};";
		};
	};
};