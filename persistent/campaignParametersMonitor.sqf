
while { true } do
{
	sleep 280;
	
	// Handle the civilian happiness
	
	if (civ_happiness > 0.15) then
	{
		civ_happiness = civ_happiness - 0.02;
	};
	if (civ_happiness < -0.15) then
	{
		civ_happiness = civ_happiness + 0.02;
	};
	
	if (civ_happiness < civ_happiness_lower_limit) then
	{
		civ_happiness = civ_happiness_lower_limit;
	};
	
	if (civ_happiness > 1) then
	{
		civ_happiness = 1;
	};
	
	if (civ_happiness < -1) then
	{
		civ_happiness = -1;
	};
	
	publicvariable "civ_happiness";
	
	sleep 10;
	
	// Handle blufor reputation among civilians
	
	if (civ_reputation > 0.15) then
	{
		civ_reputation = civ_reputation - 0.05;
	};
	if (civ_reputation < -0.15) then
	{
		civ_reputation = civ_reputation + 0.05;
	};
	
	if (civ_reputation < civ_reputation_lower_limit) then
	{
		civ_reputation = civ_reputation_lower_limit;
	};
	
	if (civ_reputation > 1) then
	{
		civ_reputation = 1;
	};
	
	if (civ_reputation < -1) then
	{
		civ_reputation = -1;
	};
	
	publicvariable "civ_reputation";
	
	sleep 10;
	
	// Handle campaign balance
	
	if (campaign_balance > 0.15) then
	{
		campaign_balance = campaign_balance - 0.001;
	};
	if (campaign_balance < -0.15) then
	{
		campaign_balance = campaign_balance + 0.001;
	};
	
	if (campaign_balance > 1) then
	{
		campaign_balance = 1;
	};
	
	if (campaign_balance < -1) then
	{
		campaign_balance = -1;
	};
	
	publicvariable "campaign_balance";
	
};
