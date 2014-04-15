
_ied = _this select 0;
_defuser = _this select 1;
_ied setVariable ["isIed", 0, true];
_ied removeaction 0;

_judgement = "";

civ_reputation = civ_reputation + 0.25;

if (civ_reputation >= 0.3) then
{
	_judgement = "<t color='#00ff00'>likes</t>";
};
if (civ_reputation >= 0.75) then
{
	_judgement = "<t color='#00ff88'>loves</t>";
};
if (civ_reputation <= -0.3) then
{
	_judgement = "<t color='#cc6600'>dislikes</t>";
};
if (civ_reputation < -0.75) then
{
	_judgement = "<t color='#ff0000'>hates</t>";
};
if ((civ_reputation > -0.3) && (civ_reputation < 0.3)) then
{
	_judgement = "is <t color='#cccc00'>indifferent</t> to";
};

message = parseText format["<br/><img image='CombatPatrolGenerator\sm\Tier1.jpg' size='5' align='center'/><br/>
<t align='center' size='1.5' color='#00ff88'>IED Disarmed</t><br/><br/>
The roadside IED has been successfully disarmed by <t color='#00ff88'>%1</t>, saving our lives as well as civilians'.<br/><br/>
At the moment, the population %2 you.<br/>   ", (name _defuser), _judgement];

[message,"hintThis"] spawn BIS_fnc_MP;
