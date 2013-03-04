class rmm_dynamic {
        title = "    Dynamic Enemy Populator";
        values[]= {0,1}; 
        texts[]= {"Off","On"};
        default = 1;
};
class rmm_locality {
        title = "        Enemy Populator Locality";
        values[]= {0,1};
        texts[]= {"Server","Headless Client"}; 
        default = 0;
};
class DEP_ACTIVE_LOCS {
        title = "        Enemy Active Locations"; 
        values[]= {0,20,40,60,80,100}; 
        texts[]= {"Disabled","20","40","60","80","100"}; 
        default = 40;
};
class DEP_LOC_DENSITY {
        title = "        Enemy Density";
        values[]= {0,500,1000,1500,2000,2500}; 
        texts[]= {"Disabled","Very High","High","Medium","Low","Very Low"}; 
        default = 1500;
};
class rmm_ep_spawn_dist {
        title = "        Enemy Spawn Distance"; 
        values[]= {500,1000,2000,4000,8000,20000}; 
        texts[]= {"500m","1000m","2000m","4000m","8000m","20km"}; 
        default = 2000;
};
class rmm_ep_safe_zone {
        title = "        Friendly Safe Zone"; 
        values[]= {500,1000,2000,4000}; 
        texts[]= {"500m","1000m","2000m","4000m"}; 
        default = 2000;
};
class rmm_ep_inf {
        title = "        Enemy Infantry Units"; 
        values[]= {0,9,8,7,6,5,4,3,2,1}; 
        texts[]= {"Disabled","90%","80%","70%","60%","50%","40%","30%","20%","10%"}; 
        default = 4;
};
class rmm_ep_mot {
        title = "        Enemy Motorized Units"; 
        values[]= {0,9,8,7,6,5,4,3,2,1}; 
        texts[]= {"Disabled","90%","80%","70%","60%","50%","40%","30%","20%","10%"}; 
        default = 3;
};
class rmm_ep_mec {
        title = "        Enemy Mechanized Units"; 
        values[]= {0,9,8,7,6,5,4,3,2,1}; 
        texts[]= {"Disabled","90%","80%","70%","60%","50%","40%","30%","20%","10%"}; 
        default = 2;
};
class rmm_ep_arm {
        title = "        Enemy Armoured Units"; 
        values[]= {0,9,8,7,6,5,4,3,2,1}; 
        texts[]= {"Disabled","90%","80%","70%","60%","50%","40%","30%","20%","10%"}; 
        default = 1;
};
class rmm_ep_aa {
        title = "        Enemy Anti-Air Units"; 
        values[]= {0,1,2}; 
        texts[]= {"None","with AA Missiles","without AA Missiles"}; 
        default = 2;
};
class rmm_ep_arty {
        title = "        Enemy Artillery Batteries"; 
        values[]= {0,8,6,4}; 
        texts[]= {"None","low","Medium","High"}; 
        default = 8;
};