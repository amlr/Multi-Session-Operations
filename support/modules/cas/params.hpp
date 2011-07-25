class CASHeader {
        title = "Close Air Support"; 
        values[]= {0}; 
        texts[]= {" "}; 
        default = 0;
};
class RMM_cas_frequency {
        title = "    Frequency"; 
        values[]= {120,1800,3600,10800}; 
        texts[]= {"2 minutes","30 minutes","1 hour","3 hours"}; 
        default = 3600;
};
class RMM_cas_available {
        title = "    Gunship/UAV Available per Leader"; 
        values[]= {0,3,6,12,999}; 
        texts[]= {"None","3","6","12","Unlimited"}; 
        default = 3;
};
