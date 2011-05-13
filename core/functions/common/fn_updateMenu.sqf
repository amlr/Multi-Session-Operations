private["_name","_exp"];
_name = _this select 0;
_exp = _this select 1;
BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
        [_name,[count BIS_MENU_GroupCommunication + 1],"",-5,[["expression",_exp]],"1","1"]
];
