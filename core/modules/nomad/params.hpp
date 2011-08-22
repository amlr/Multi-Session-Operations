class nomadHeader {
        title = "Nomad"; 
        values[]= {0}; 
        texts[]= {" "}; 
        default = 0;
};
class nomadRespawns {
	title = "    Respawns"; 
	values[]= {1,2,3,4,5,6,7,999}; 
	texts[]= {"1","2","3","4","5","6","7","Infinite"}; 
	default = 3; 
};
class nomadReinforcements {
	title = "    Reset Lives"; 
	values[]= {999,0.5,1,2}; 
	texts[]= {"Never","12 hours","1 day","2 days"}; 
	default = 1; 
};
class nomadClassRestricted {
	title = "    Restrict Class"; 
	values[]= {0,1}; 
	texts[]= {"Allow any class","Only as initial class"}; 
	default = 0; 
};