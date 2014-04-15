
////////////////////////////////////////////////////////////////////////////////////
////
////	Eliminate officer
////
////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_targets","_target","_poscache","_posarray","_posofficer","_mrk","_ammo0","_ammo1","_ammo2","_ammo3","_ammo4"];

_pos = _this select 0;

_valid_buildings = ["Land_i_Barracks_V1_F", "Land_i_Barracks_V2_F", "Land_i_House_Big_01_V1_F", "Land_i_House_Big_02_V1_F", "Land_i_Stone_HouseBig_V1_F", "Land_MilOffices_V1_F"];

_targets = nearestObjects [_pos, _valid_buildings, 100];

if ((count _targets) > 0) then
{

	cpg_side_missions = cpg_side_missions + 1;
	
	_mission_counter = cpg_side_missions;
	
	_target = _targets select (random ((count _targets) - 1));

	_cnt = 0;
	_posarray = [];

	//as long as building position _cnt not equal to "[0,0,0]" keep looping
	while {format ["%1", _target buildingpos _cnt] != "[0,0,0]" } do {

		_pos = _target buildingpos _cnt;        //select building position _cnt
		_posarray = _posarray + [_pos];        //add the position to the list

		_cnt = _cnt + 1;        //increment counter
		sleep 0.01;
	};  
	
	_posofficer = _posarray select (random ((count _posarray) - 1));

	_group_0 = createGroup east;

	_officer = _group_0 createUnit ["O_officer_F", _posofficer, [], 0, "CAN_COLLIDE"];
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _group_0);
	
	_pos = position _target;
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [20, 20];
	_type = [0] call cpg_fnc_chooseEnemy;
	_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
	nul = [leader _grp, _mrk, "fortify", "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _grp);
	
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [150, 150];
	_type = [0] call cpg_fnc_chooseEnemy;
	_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
	nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _grp);
	
	_pos3 = [(position _target), 10, 250, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	
	if (side_mission_show_markers == 1) then
	{
		_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos3];
		_mrk setMarkerType "mil_unknown";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorRed";
		_mrk setMarkerText " Eliminate Officer";
		_mrk setMarkerSize [0.8, 0.8];
		_mrk setMarkerPos _pos3;
	};
	
	[[[[["TaskDSM_5","Eliminate Officer","Eliminate Officer<br/><br/>An enemy officer has arrived in the area and is now taking command of enemy forces.<br/><br/>Find and eliminate the officer."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;
	
	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\officer.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Eliminate Officer</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	An enemy officer has arrived in the area and is now taking command of enemy forces.<br/><br/>
	Find and eliminate the officer.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
	
	if ((persistent_module_on) == 1) then
	{
		_string = format ["Side Mission Type %1", _mission_counter];
		["CPG_database", "Side Missions", _string, 5]  call iniDB_write;
		
		_string2 = format ["Side Mission Pos %1", _mission_counter];
		["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

		_string3 = format ["Side Mission Complete %1", _mission_counter];
		["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
	};



	waitUntil { sleep 5; !alive _officer };
			
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
	<t align='center' size='1.5'>Eliminate Officer</t><br/><br/>
	<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
	The enemy officer has been eliminated, dealing a decisive blow to the enemy's chain of command.
	<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

	[message,"hintThis"] spawn BIS_fnc_MP;

	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerColor "ColorGreen";
		_mrk setMarkerText " Officer Eliminated";
	};
	
	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
	
};


