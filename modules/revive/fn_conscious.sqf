if (alive _this) then {
	_this setunconscious false;
	_this playaction "agonystop";
	_this setdamage (damage _this);
};