// Headless client check
isHC = false;
if(isNil "headlessClients") then {
	headlessClients = [];
	publicVariable "headlessClients";
};
if !(Isdedicated) then {
	private["_hc"];
  _hc = ppEffectCreate ["filmGrain", 2005];
        if (_hc == -1) then {
                isHC = true;
                if(!(player in headlessClients)) then {
                        headlessClients set [count headlessClients, player];
                        publicVariable "headlessClients";
                };                        
		} else {
			ppEffectDestroy _hc;
        };
};
isHC;