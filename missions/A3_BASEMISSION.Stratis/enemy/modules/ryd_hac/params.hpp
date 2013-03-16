class Ryd_Header {
        title = "    Enable Enemy AI Commander"; 
        values[]= {0,1}; 
        texts[]= {"Off","On"}; 
        default = 0;
};
class RydHQ_Order_Param {
        title = "        Enemy Posture"; 
        values[]= {0,1}; 
        texts[]= {"Offensive","Defensive"}; 
        default = 0;
};
class RydHQ_Personality_Param {
        title = "        Enemy Commander Personality"; 
        values[]= {0,1,2,3,4,5,6,7,8}; 
        texts[]= {"GENIUS","IDIOT","COMPETENT","EAGER","DILATORY","SCHEMER","BRUTE","CHAOTIC","RANDOM"}; 
        default = 8;
};
class RydHQ_CommDelay_Param {
        title = "        Enemy Comms Delay"; 
        values[]= {1,2}; 
        texts[]= {"Off","On"}; 
        default = 1;
};
class RydHQ_Fast_Param {
        title = "        Enemy AI Processing"; 
        values[]= {0,1}; 
        texts[]= {"Normal",Fast (Caution)"}; 
        default = 0;
};
class RydHQ_Debug_Param {
        title = "        HETMAN Debug Mode"; 
        values[]= {0,1}; 
        texts[]= {"Off","On"}; 
        default = 0;
};
