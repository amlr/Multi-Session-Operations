// Headless client check
isHC = false;

if(isNil "headlessClients" && isServer) then {
        headlessClients = [];
        publicVariable "headlessClients";
};

waitUntil{!isNil "headlessClients"};

if (!isDedicated) then {
        private["_hc","_lock"];
        _hc = ppEffectCreate ["filmGrain", 2005];
        if (_hc == -1) then {
                isHC = true;
		// Random delay
		 for [{_x=1},{_x<=random 10000},{_x=_x+1}] do {};
                if(!(player in headlessClients)) then {
                        headlessClients set [count headlessClients, player];
                        publicVariable "headlessClients";
                };
        } else {
                ppEffectDestroy _hc;
        };
};
isHC;