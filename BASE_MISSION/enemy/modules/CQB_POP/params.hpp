class CQB_spawn {
	title = "    CQB Populator (Building %)"; 
	values[]= {0,5,10,20,30,40,50}; 
	texts[]= {"Off","5%","10%","20%","30%","40%","50%"}; 
	default = 5;
};
class CQBaicap {
	title = "        CQB AI Limit (per player)";
	values[]= {0,1,2,3,4,5}; 
	texts[]= {"Off (recommended)","15","25","50","100","AUTO"};
	default = 0;
};
class CQBmaxgrps {
	title = "        CQB Group limit";
	values[]= {144,10,25,50,75,100}; 
	texts[]= {"Off (recommended)","10","25","50","75","100"};
	default = 144;
};
class CQBspawnrange {
	title = "        CQB Spawnrange";
	values[]= {500,800,1000}; 
	texts[]= {"500m","800m","1000m"};
	default = 500;
};
class CQBlocality {
	title = "        CQB Locality";
	values[]= {0,1,2}; 
	texts[]= {"Server","Client","Headless Client"};
	default = 1;
};
