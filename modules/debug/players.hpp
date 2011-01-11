/* 
	PLAYERS INFO 
*/
class Players : CUI_Frame {
	y = CUI_Row_Y(0);
	x = CUI_Box_X(3);
	h = CUI_Row_DY(0,5);
	w = CUI_Box_W / 1.4;
};
class PlayersCaption : CUI_Caption {
	text = "Players";
	x = CUI_Box_X(3);
	y = CUI_Row_Y(0);
	w = CUI_Box_W / 1.4;
};
class Lb0 : CUI_Combo {
	idc = 61;
	x = CUI_Box_X(3);
	y = CUI_Row_Y(1);
	w = CUI_Box_W / 1.4;
	onLBSelChanged = "_sel = lbCurSel 61;_player = playableunits select _sel;ctrlSetText [62, str (getpos _player)];ctrlSetText [63, _player call {_str = getPlayerUID _this; if (_str == '') then {_str = 'AI'}; _str;}];ctrlSetText [64, str (damage _player)];";
};
class PStat1 : CUI_Edit {
	idc = 62;
	x = CUI_Box_X(3);
	y = CUI_Row_Y(2);
	w = CUI_Box_W / 1.4;
	h = CUI_Row_DY(1,2);
};
class PStat2 : PStat1 {idc = 63; y = CUI_Row_Y(3);};
class PStat3 : PStat1 {idc = 64; y = CUI_Row_Y(4);};