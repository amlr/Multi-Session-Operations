class tup_ied_header{
        title = "    Ambient IEDs and Suicide Bombers"; 
        values[]= {0,1}; 
        texts[]= {"Off","On"}; 
        default = 1;
};
class tup_ied_threat {
        title = "        Ambient IED Threat"; 
        values[]= {0,30,50,85,200}; 
        texts[]= {"None","Low","Med","High","Extreme"}; 
        default = 50;
};
class tup_suicide_threat {
        title = "        Ambient Suicide Bomber Threat"; 
        values[]= {0,10,20,30}; 
        texts[]= {"None","Low","Med","High"}; 
        default = 20;
};
class tup_vbied_threat {
        title = "        Ambient VB-IEDs"; 
        values[]= {0,5,10,15}; 
        texts[]= {"None","Low","Med","High"}; 
        default = 10;
};
class tup_ied_eod{
        title = "        Integrate with EOD Add-on (if available)"; 
        values[]= {0,1}; 
        texts[]= {"Off","On"}; 
        default = 1;
};
