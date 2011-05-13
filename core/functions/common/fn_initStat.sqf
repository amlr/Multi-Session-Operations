private["_stage"];
_stage = _this;

if (isServer && isNil "CRB_INIT_STATUS") then {
        CRB_INIT_STATUS = [];
        publicVariable "CRB_INIT_STATUS";
};
waitUntil{!isNil "CRB_INIT_STATUS"};

if (isServer) then {
        CRB_INIT_STATUS = CRB_INIT_STATUS + [_stage];
        publicVariable "CRB_INIT_STATUS";
};

waitUntil{_stage in CRB_INIT_STATUS};
player sideChat format["Initialising: %1", _stage];
