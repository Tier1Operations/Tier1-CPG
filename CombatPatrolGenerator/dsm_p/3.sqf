
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Enemy HQ at long range from the patrol marker.
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_tower","_mrk","_counter"];

_pos = _this select 0;

// We want to find a good position to create the HQ, so we need the isFlatEmpty function to check if
// the position found by BIS_fnc_findSafePos is a good one. If not, retry.

_check = [];
_counter = 0;

if (_counter < 10000) then 
{

	cpg_side_missions = cpg_side_missions + 1;
	
	_mission_counter = cpg_side_missions;

	_tower = createVehicle ["Land_Cargo_HQ_V1_F", _pos, [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [(_pos select 0) + 12, (_pos select 1)], [], 0, "CAN_COLLIDE"];
	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 0);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_group_1 = createGroup east;
	_ai = _group_1 createUnit ["O_Soldier_TL_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 1);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_group_2 = createGroup east;
	_ai = _group_2 createUnit ["O_Soldier_lite_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 2);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_group_3 = createGroup east;
	_ai = _group_3 createUnit ["O_Soldier_AR_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 3);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_group_4 = createGroup east;
	_ai = _group_4 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 4);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_group_5 = createGroup east;
	_ai = _group_5 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 5);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_group_6 = createGroup east;
	_ai = _group_6 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 6);
	_ai setvariable ["raven_side_mission_group", 1];
	
	_pos2 = [_pos, 0, 150, 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos2];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [100, 100];
	_type = [0] call cpg_fnc_chooseEnemy;
	_grp = [_pos2, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp) + 7;
	nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _grp);

	_pos2 = [_pos, 10, 100, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	
	if (side_mission_show_markers == 1) then
	{
		_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos2];
		_mrk setMarkerType "o_hq";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorRed";
		_mrk setMarkerText " Destroy HQ";
		_mrk setMarkerSize [1, 1];
		_mrk setMarkerPos _pos2;
	};


	[[[[["TaskDSM_3","Destroy Enemy HQ","Destroy Enemy HQ<br/><br/>The enemy has set up a small headquarters building, in order to command their forces in the area.<br/><br/>Destroy the enemy HQ."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;
	
	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\HQ.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Destroy HQ</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	The enemy has set up a small headquarters building, in order to command their forces.<br/><br/>
	Destroy the enemy HQ.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
	
	if ((persistent_module_on) == 1) then
	{
		_string = format ["Side Mission Type %1", _mission_counter];
		["CPG_database", "Side Missions", _string, 3]  call iniDB_write;
		
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

	message = parseText format ["<br/><img image='CombatPatrolGenerator\sm\Tier1.jpg' size='5' align='center'/><br/><br/>
		<t align='center' size='2'>Objective</t><br/>
		<t align='center' size='1.5'>Destroy HQ</t><br/><br/>
		<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
		The enemy headquarters have been destroyed: the enemy chain of command has been severed.
		<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

	[message,"hintThis"] spawn BIS_fnc_MP;

	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerColor "ColorGreen";
		_mrk setMarkerText " HQ Destroyed";
	};
	
	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;


};

