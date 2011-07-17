class ambientAirHeader {
        title = "Ambient - Air"; 
        values[]= {0}; 
        texts[]= {" "}; 
        default = 0;
};
class factionsMask {
        title = "    Factions"; 
        values[]= {0,1,2}; 
        texts[]= {"All Factions","Civilian Only","None"}; 
        default = 0;
};
class AirIntensity {
        title = "    Intensity"; 
       values[]= {0, 1, 2, 3}; 
       texts[]= {"25%","50%","75%","100%"}; 
       default = 1;
};
class AirROE {
        title = "    Rules of Engagement"; 
       values[]= {1,2,3,4,5}; 
       texts[]= {"Never fire","Hold fire - defend only","Hold fire, engage at will","Fire at will","Fire at will, engage at will"}; 
       default = 1;
};
