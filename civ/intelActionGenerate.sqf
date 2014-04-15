
while {true} do
{
	{
		if ((side _x == civilian) && (!(captive _x))) then 
		{
			if (_x getvariable ["civ_hasintelaction", 0] != 1) then
			{
				_intelaction = _x addAction ["<t color='#0000ff'>Question Civilian</t>", raven_giveIntel, [_x], 10, true, true, "", "((getPosATL _target) distance (getPosATL _this) <= 5)"];
				_x setvariable ["civ_hasintelaction", 1];
			};
		};
	} forEach allUnits;
	sleep 30;
};
