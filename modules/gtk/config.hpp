switch (_this) do {
	case 0 : { // Outta Sight Outta Mind
		[
			{_this call OSOM_fnc_sync},
			{_this call OSOM_fnc_active},
			{_this call OSOM_fnc_inactive}
		]
	};
	case 1 : { // Outta Sight Light
		[
			nil,
			{_this call OSL_fnc_active},
			{_this call OSL_fnc_inactive}
		]
	};
	Default {
		[
			nil,
			nil,
			nil
		]
	};
};