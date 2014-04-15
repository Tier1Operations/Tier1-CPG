
_killer = _this select 1;

_civ_reputation_judgement = "";
_civ_happiness_judgement = "";

// It's here because population happiness is independent from the
// side of the killer
civ_happiness = civ_happiness - 0.05;

if ((side _killer) == west) then
{
	civ_reputation = civ_reputation - 0.15;

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
	
	// publicvariable "civ_reputation";
	
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
	
	message = parseText format["<br/><img image='civ\pix\civKilled.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='1.5' color='#ff0000'>Civilian Killed</t><br/><br/>
	A civilian was killed by <t color='#ff0000'>%1</t>.<br/><br/>As this could constitute a war crime, you'd better check your fire in the future.<br/><br/>
	At the moment, the population %2 you.<br/>
	The population mood is %3<br/>	", (name _killer), _civ_reputation_judgement, _civ_happiness_judgement];
	
	[message,"hintThis"] spawn BIS_fnc_MP;
	
};
