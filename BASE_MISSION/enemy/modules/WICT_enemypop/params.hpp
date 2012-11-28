class WICT_wict_header {
        title = "    World In Conflict (do not mix with other enemypop-modules)"; 
        values[]= {0, 1}; 
        texts[]= {"Off","On"}; 
        default = 0;
};
class wict_ai_groups {
        title = "        WICT - Maximum AI Groups"; 
        values[]= {0,1,2,3}; 
        texts[]= {"55","80","100","120"}; 
        default = 0;
};
class wict_scandistance {
        title = "        WICT - Scandistance (for nearest base)"; 
        values[]= {0,1,2,3}; 
        texts[]= {"1000m","1500m","3000m","unlimited"}; 
        default = 1;
};
class wict_baselocations {
        title = "        WICT - Base locations"; 
        values[]= {0,1,2}; 
        texts[]= {"Even","Towns","Countryside"}; 
        default = 0;
};
class wict_ep_intensity {
        title = "        WICT - Base density"; 
        values[]= {0,1,2,3}; 
        texts[]= {"Disabled","33%","66%","100%"}; 
        default = 1;
};
class wict_ep_campprob {
        title = "        Enemy Base probability"; 
        values[]= {0,1,2,3}; 
        texts[]= {"25%","50%","80%","100%"}; 
        default = 0;
};
class wict_spawnBLUFOR {
        title = "        WICT - Spawn BLUFOR units"; 
        values[]= {0,1}; 
        texts[]= {"false","true"}; 
        default = 0;
};
class wict_debugmodule {
        title = "        WICT - Debug (or show bases)"; 
        values[]= {0,1,2}; 
        texts[]= {"false","true","Show bases"}; 
        default = 0;
};
class WICT_wict_footer {
        title = " "; 
        values[]= {0}; 
        texts[]= {" "}; 
        default = 0;
};


