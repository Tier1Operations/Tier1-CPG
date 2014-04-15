
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Enemy patrol and comms tower / radar at long range from the patrol marker.
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_tower","_case","_mrk"];

_pos = _this select 0;

cpg_side_missions = cpg_side_missions + 1;

_mission_counter = cpg_side_missions;

// We want to find a good position to create the tower, so we need the isFlatEmpty function to check if
// the position found by BIS_fnc_findSafePos is a good one. If not, retry.

_case = 0;

if ((random 100) < 50) then 
{
	_tower = createVehicle ["Land_Communication_F", _pos, [], 0, "CAN_COLLIDE"];
	_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [((_pos select 0) - 4), (_pos select 1)], [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_case = 1;
} else
{
	_tower = createVehicle ["Land_Radar_Small_F", _pos, [], 0, "CAN_COLLIDE"];
	_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [((_pos select 0) - 10), (_pos select 1)], [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_case = 2;
};

_pos2 = [_pos, 20, 100, 5, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos2];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [50, 50];
_type = [0] call cpg_fnc_chooseEnemy;
_grp = [_pos2, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);

cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos2];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [150, 150];
_type = [0] call cpg_fnc_chooseEnemy;
_grp = [_pos2, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);

if ((random 100) < 75) then
{
	nul = [_pos2, 2, _grp, 0] call cpg_fnc_spawnEmptyVehicles;
};


_pos3 = [_pos, 10, 75, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
if (side_mission_show_markers == 1) then
{
	_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos3];
};

if (_case == 1) then 
{
	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerType "loc_Transmitter";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorRed";
		_mrk setMarkerText " Destroy Comms Tower";
		_mrk setMarkerSize [0.7, 0.7];
		_mrk setMarkerPos _pos3;
	};
	
	[[[[["TaskDSM_0","Destroy Comms Tower","Destroy Comms Tower<br/><br/>Enemy forces have set up a communications relay to support their operations.<br/><br/>Destroy the communications tower."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;
	
	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\commsTower.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Destroy Comms Tower</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	Enemy forces have set up a communications relay to support their operations.<br/><br/>
	Destroy the communications tower.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
	
} else
{
	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerType "o_support";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorRed";
		_mrk setMarkerText " Destroy Radar";
		_mrk setMarkerSize [1, 1];
		_mrk setMarkerPos _pos3;
	};
	
	[[[[["TaskDSM_0","Destroy Radar","Destroy Radar<br/><br/>Enemy forces have built a small radar system, probably planning to put air defenses in place soon.<br/><br/>Destroy the small radar tower."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\smallRadar.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Destroy Small Radar</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	Enemy forces have built a small radar system, probably planning to put air defenses in place soon.<br/><br/>
	Destroy the small radar tower.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
	
};

if ((persistent_module_on) == 1) then
{
	_string = format ["Side Mission Type %1", _mission_counter];
	["CPG_database", "Side Missions", _string, 0]  call iniDB_write;
	
	_string2 = format ["Side Mission Pos %1", _mission_counter];
	["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
};



waitUntil { sleep 5; ((damage _tower) > 0.9) };

campaign_balance = campaign_balance + 0.10;

_campaign_balance_judgement = "";

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

if (_case == 1) then
{
	message = parseText format["<br/><img image='CombatPatrolGenerator\sm\Tier1.jpg' size='5' align='center'/><br/><br/>
		<t align='center' size='2'>Objective</t><br/>
		<t align='center' size='1.5'>Destroy Comms Tower</t><br/><br/>
		<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
		The enemy comms tower has been destroyed: enemy logistics and coordination have been thoroughly disrupted.
		<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

	[message,"hintThis"] spawn BIS_fnc_MP;
} else
{
	message = parseText "<br/><img image='CombatPatrolGenerator\sm\Tier1.jpg' size='5' align='center'/><br/><br/>
		<t align='center' size='2'>Objective</t><br/>
		<t align='center' size='1.5'>Destroy Small Radar</t><br/><br/>
		<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
		The enemy small radar has been destroyed: enemy plans to establish air superiority have been disrupted.
		<br/>Good job everyone.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
};

if (side_mission_show_markers == 1) then
{
	_mrk setMarkerColor "ColorGreen";
	_mrk setMarkerText " Radar Destroyed";
};

_string3 = format ["Side Mission Complete %1", _mission_counter];
["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
		
		