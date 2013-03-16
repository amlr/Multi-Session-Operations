class tup_airtraffic_factions {
        title = "    Enable Ambient Air Factions"; 
        values[]= {0,1,2,3}; 
        texts[]= {"None","Civilian Only","Military Only","All Factions"}; 
        default = 1;
};
class tup_airtraffic_intensity {
        title = "        Ambient Air Intensity"; 
       values[]= {5, 10, 25, 50, 75, 100}; 
       texts[]= {"5%","10%","25%","50%","75%","100%"}; 
       default = 10;
};
class tup_airtraffic_ROE {
        title = "        Ambient Air Rules of Engagement"; 
       values[]= {1,2,3,4,5}; 
       texts[]= {"Never fire","Hold fire - defend only","Hold fire, engage at will","Fire at will","Fire at will, engage at will"}; 
       default = 2;
};
class tup_airtraffic_locality {
	title = "        Ambient Air Locality";
	values[]= {0,1}; 
	texts[]= {"Server","Headless Client"};
	default = 0;
};
