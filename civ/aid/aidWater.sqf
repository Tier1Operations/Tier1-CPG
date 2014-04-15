
_targetpos = _this select 0;

_spawnpos = getpos spawnA3;

_judgement = "";

_spawnpos1 = [((_spawnpos select 0) - 10 + (random 20)), ((_spawnpos select 1) - 10 + (random 20)), (_spawnpos select 2)];

_bricks = createVehicle ["Land_WaterBarrel_F", _spawnpos1, [], 0, "CAN_COLLIDE"];
_bricks allowdamage false;

message = parsetext "<br/><img image='civ\pix\aidWater.jpg' size='5' align='center'/><br/><br/><t align='center' size='2'>Aid Request</t><br/><br/><t align='center' size='1.5' color='#00ff88'>Water</t><br/><br/><t align='center'>A civilian says his town needs water.<br/>Bring here a water canister to let people drink proper clean water.</t><br/><br/>Be advised: the enemy will try to stop you from delivering the aid.<br/>  "; 
[message,"hintThis"] spawn BIS_fnc_MP;

cpg_v_inr = cpg_v_inr + 1;
_aidmrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _targetpos];
_aidmrk setMarkerType 'mil_warning';
_aidmrk setMarkerAlpha 0.8;
_aidmrk setMarkerColor 'ColorBlue';
_aidmrk setMarkerBrush 'Solid';
_aidmrk setMarkerSize [0.8, 0.8];
_aidmrk setMarkerText ' Water needed';

_wait1 = 150 + (random 300);
_wait2 = 450 + (random 450);

[_targetpos, _wait1] execVM "civ\aid\civ_createAirAmbush.sqf";
[_targetpos, _wait2] execVM "civ\aid\civ_createAirAmbush.sqf";

waitUntil { sleep 2; ((_bricks distance _targetpos) < 150) && (((getposATL _bricks) select 2) < 0.5) };

civ_reputation = civ_reputation + 0.10;

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

publicvariable "civ_reputation";

civ_happiness = civ_happiness + 0.05;

message = parseText format ["<br/><img image='civ\pix\aidWater.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='1.5'>Humanitarian Aid</t><br/><br/>
	<t align='center' size='1.5' color='#01df01'>Delivered</t><br/><br/>
	The water has been delivered to the population that has requested it. This is a small but important step towards the stabilization of the area.
	<br/>Good job everyone.<br/><br/>At the moment, the population %1 you.<br/>   ", _judgement];
	
[message,"hintThis"] spawn BIS_fnc_MP;

_aidmrk setMarkerColor "ColorGreen";
_aidmrk setMarkerText " Water Delivered";
