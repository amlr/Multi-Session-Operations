class disableFog {
        title = "Disable Fog"; 
        values[]= {0,1}; 
        texts[]= {"false","true"}; 
        default = 1;
};

class timeOptions {
        title = "Time Options";
        values[] = {0,1,2};
        texts[] = {"Original","Random","Custom"};
        default = 0;
};

class timeHour {
        title = "Time Custom Hours"; 
        values[]= {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}; 
        texts[]= {"00:XX","01:XX","02:XX","03:XX","04:XX","05:XX",
        "06:XX","07:XX","08:XX","09:XX","10:XX","11:XX",
        "12:XX","13:XX","14:XX","15:XX","16:XX","17:XX",
        "18:XX","19:XX","20:XX","21:XX","22:XX","23:XX"}; 
        default = 8;
};

class timeMinute {
        title = "Time Custom Minutes"; 
        values[]= {0,5,10,15,20,25,30,35,40,45,50,55}; 
        texts[]= {"XX:00","XX:05","XX:10","XX:15","XX:20","XX:25",
        "XX:30","XX:35","XX:40","XX:45","XX:50","XX:55"};
        default = 0;
};
