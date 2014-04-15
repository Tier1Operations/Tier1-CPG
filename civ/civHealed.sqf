
_guy = _this select 0;
_healer = _this select 1;

_civ_reputation_judgement = "";
_civ_happiness_judgement = "";

// It's here because population happiness is independent from the
// side of the healer
civ_happiness = civ_happiness + 0.05;

// hint format["%1, %2", _guy, _healer];

if ((side _healer) == west) then
{
	_guy setSpeedMode "LIMITED";
	_guy setBehaviour "SAFE";
	_guy domove (getpos _guy);
	_guy setSpeedMode "LIMITED";
	_guy setBehaviour "SAFE";
	sleep 0.1;
	_guy playMove "AmovPsitMstpSnonWnonDnon_ground";
	sleep 1;
	_guy domove (getpos _guy);
	sleep 2;
	_guy domove (getpos _guy);
	
	// publicvariable "_guy";
	
	civ_reputation = civ_reputation + 0.10;

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

	message = parseText format["<br/><img image='civ\pix\civHealed.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='1.5' color='#00ff88'>Civilian Healed</t><br/><br/>
	A civilian was healed by <t color='#00ff88'>%1</t>.<br/><br/>This is a rescue act that will not pass unnoticed among the population, improving its support towards our operation.<br/><br/>
	At the moment, the population %2 you.<br/>
	The population mood is %3<br/>	", (name _healer), _civ_reputation_judgement, _civ_happiness_judgement];
	
	[message,"hintThis"] spawn BIS_fnc_MP;
	
};
