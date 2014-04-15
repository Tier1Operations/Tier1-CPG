
_campaign_balance_judgement = "";
_civ_reputation_judgement = "";
_civ_happiness_judgement = "";


// Check how the campaign is going

if (campaign_balance >= 0.15) then
{
	_campaign_balance_judgement = "in <t color='#22ff00'>slight advantage</t>";
};
if (campaign_balance >= 0.3) then
{
	_campaign_balance_judgement = "in <t color='#00ff33'>moderate advantage</t>";
};
if (campaign_balance >= 0.75) then
{
	_campaign_balance_judgement = "in <t color='#00ff88'>definite advantage</t>";
};
if (campaign_balance <= -0.15) then
{
	_campaign_balance_judgement = "in <t color='#996600'>slight disadvantage</t>";
};
if (campaign_balance <= -0.3) then
{
	_campaign_balance_judgement = "in <t color='#cc6600'>moderate disadvantage</t>";
};
if (campaign_balance <= -0.75) then
{
	_campaign_balance_judgement = "in <t color='#ff0000'>definite disadvantage</t>";
};
if ((campaign_balance > -0.15) and (campaign_balance < 0.15)) then
{
	_campaign_balance_judgement = "in a <t color='#cccc00'>balanced</t> situation";
};

// Check Blufor reputation among civilians

if (civ_reputation >= 0.3) then
{
	_civ_reputation_judgement = "<t color='#00ff00'>likes</t>";
};
if (civ_reputation >= 0.75) then
{
	_civ_reputation_judgement = "<t color='#00ff88'>loves</t>";
};
if (civ_reputation <= -0.3) then
{
	_civ_reputation_judgement = "<t color='#cc6600'>dislikes</t>";
};
if (civ_reputation <= -0.75) then
{
	_civ_reputation_judgement = "<t color='#ff0000'>hates</t>";
};
if ((civ_reputation > -0.3) and (civ_reputation < 0.3)) then
{
	_civ_reputation_judgement = "is <t color='#cccc00'>indifferent</t> to";
};


// Check civilian happiness

if (civ_happiness >= 0.3) then
{
	_civ_happiness_judgement = "<t color='#00ff00'>content</t>";
};
if (civ_happiness >= 0.75) then
{
	_civ_happiness_judgement = "<t color='#00ff88'>happy</t>";
};
if (civ_happiness <= -0.3) then
{
	_civ_happiness_judgement = "<t color='#cc6600'>disaffected</t>";
};
if (civ_happiness <= -0.75) then
{
	_civ_happiness_judgement = "<t color='#ff0000'>murderous</t>";
};
if ((civ_happiness > -0.3) and (civ_happiness < 0.3)) then
{
	_civ_happiness_judgement = "<t color='#cccc00'>average</t>";
};



// Show the message
	
hint parseText format["<br/><img image='instructions\campaign\blufor.jpg' size='5' align='center'/><br/><br/>
<t align='center' size='1.5' color='#00ff88'>Campaign Status</t><br/><br/>
Compared to the enemy, we are %1.<br/><br/>
The population mood is %2.<br/><br/>
The population %3 us.<br/>    ", _campaign_balance_judgement, _civ_happiness_judgement, _civ_reputation_judgement];

// [message,"hintThis"] spawn BIS_fnc_MP;

