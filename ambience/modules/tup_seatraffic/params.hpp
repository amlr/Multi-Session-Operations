class ambientSeaHeader {
        title = "Ambient - Sea"; 
        values[]= {0}; 
        texts[]= {" "}; 
        default = 0;
};
class Amount {
        title = "    Intensity"; 
        values[]= {0,1,2}; 
        texts[]= {"Full","Reduced","None"}; 
        default = 1;
};
class SeaROE {
        title = "    Rules of Engagement"; 
       values[]= {1,2,3,4,5}; 
       texts[]= {"Never fire","Hold fire - defend only","Hold fire, engage at will","Fire at will","Fire at will, engage at will"}; 
       default = 2;
};
class AmbientLHD {
        title = "    Landing Helicopter Dock"; 
       values[]= {0,2,1}; 
       texts[]= {"False","Random","True"}; 
       default = 0;
};
