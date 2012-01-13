switch (toUpper(_this)) do {
	case "CEP" : { // Coop Essentials Pack Caching
		[
			nil,
			nil,
			nil,
			nil
		]
	};
	case "NOUJAY" : { // NouberNou's Caching
		[
			nil,
			nil,
			nil,
			nil
		]
	};
	case "OSOM" : { // Outta Sight Outta Mind
		[
			{_this call OSOM_fnc_init},
			{_this call OSOM_fnc_sync},
			{_this call OSOM_fnc_inactive},
			{_this call OSOM_fnc_active}
		]
	};
	case "OSL" : { // Outta Sight Light
		[
			{_this call OSL_fnc_init},
			nil,
			{_this call OSL_fnc_inactive},
			{_this call OSL_fnc_active}
		]
	};
	case "DEBUG" : {
		[
			{hint "GTK Initialising";_this;},
			{hintSilent format["GTK Syncing - %1", _this getvariable "rmm_gtk_cached"];},
			{hint "GTK Caching";},
			{hint "GTK Uncaching";}
		]
	};
	Default {
		[
			nil,
			nil,
			nil,
			nil
		]
	};
};
