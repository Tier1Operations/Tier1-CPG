
while { true } do
{
	sleep 60;
	["CPG_database", "Campaign_Parameters", "Campaign_Balance", campaign_balance]  call iniDB_write;
	["CPG_database", "Civilian_Parameters", "Happiness", civ_happiness]  call iniDB_write;
	["CPG_database", "Civilian_Parameters", "Blufor_Reputation", civ_reputation] call iniDB_write;
};

