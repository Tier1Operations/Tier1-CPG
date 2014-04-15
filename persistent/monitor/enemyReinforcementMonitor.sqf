
private ["_enemies", "_multiplier"];

cpg_finished = 0;

waitUntil {sleep 5; cpg_finished == 1; };

while { true } do
{
	if (campaign_balance < 0) then
	{
		_multiplier = 0;
	} else
	{
		_multiplier = campaign_balance;
	};
	
	sleep (30 + (_multiplier * 1200));

	_enemies = 0;
	{
		if ((side _x) == east) then
		{
			_enemies = _enemies + 1;
		};
	} forEach AllUnits;

	if (_enemies < cpg_v_nr) then
	{
		execVM "persistent/monitor/sendEnemyReinforcements.sqf";
	};
};


