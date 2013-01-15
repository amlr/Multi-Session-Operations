// Headless client check
_isHC = false;
if !(Isdedicated) then {
  _hc = ppEffectCreate ["filmGrain", 2005];
  if (_hc == -1) then {_isHC = true; player setvariable ["isHC", 1, true]} else {_isHC = false; player setvariable ["isHC", 0, true]};
};
_isHC;