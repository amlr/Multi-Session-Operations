class nomadHeader {
        title = "Nomad"; 
        values[]= {1,0}; 
        texts[]= {"On","Off"}; 
        default = 1;
};
class nomadTime {
	title = "    NOMAD Player State Save Option"; 
	values[]= {5,30,60,300,600,3600,7200,43200}; 
	texts[]= {"Every 5 secs","Every 30 secs","Every 1 min","Every 5 mins","Every 10 mins","Every 30 mins","Every hour","Manually"}; 
	default = 60; 
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