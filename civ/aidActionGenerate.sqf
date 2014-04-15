
while {true} do
{
	{
		if ((side _x == civilian) && (!(captive _x))) then 
		{
			if (_x getvariable ["civ_hasaidaction", 0] != 1) then
			{
				_intelaction = _x addAction ["<t color='#00ff33'>Need help here?</t>", raven_needAid, [_x], 10, false, true, "", "((getPosATL _target) distance (getPosATL _this) <= 5)"];
				_x setvariable ["civ_hasaidaction", 1];
			};
		};
	} forEach allUnits;
	sleep 30;
};
