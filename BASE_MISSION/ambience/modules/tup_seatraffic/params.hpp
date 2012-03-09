class tup_seatraffic_amount {
        title = "    Enable Ambient Sea Traffic"; 
        values[]= {0,1,2}; 
        texts[]= {"Full","Reduced","Off"}; 
        default = 1;
};
class tup_seatraffic_ROE {
        title = "        Ambient Sea Traffic Rules of Engagement"; 
       values[]= {1,2,3,4,5}; 
       texts[]= {"Never fire","Hold fire - defend only","Hold fire, engage at will","Fire at will","Fire at will, engage at will"}; 
       default = 2;
};
class tup_seatraffic_LHD {
        title = "        Ambient LHD Helicopter Dock"; 
       values[]= {0,1,2}; 
       texts[]= {"Never","Always","Random"}; 
       default = 2;
};
