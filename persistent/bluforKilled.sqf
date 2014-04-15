
_type = _this select 0;

switch (_type) do
{
	case 0:
	{
		campaign_balance = campaign_balance - 0.015; // Infantry
	};
	case 1:
	{
		campaign_balance = campaign_balance - 0.015; // Hunters & HEMTT
	};
	case 2:
	{
		campaign_balance = campaign_balance - 0.030; // Armed Hunters, MH-9s
	};
	case 3:
	{
		campaign_balance = campaign_balance - 0.050; // UH-80s, APCs, AH-9s
	};
	case 4:
	{
		campaign_balance = campaign_balance - 0.075; // Tanks, Gunships, AH-99s
	};
};

// hint "dead";
