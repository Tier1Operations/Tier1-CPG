
////////////////////////////////////////////////////////////////////////////////////
////
////	Find the cache!
////
////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_targets","_target","_poscache","_posarray","_mrk","_ammo0","_ammo1","_ammo2","_ammo3","_ammo4"];

_pos = _this select 0;

_valid_buildings = ["Land_i_Barracks_V1_F", "Land_i_Barracks_V2_F", "Land_i_House_Big_01_V1_F", "Land_i_House_Big_02_V1_F", "Land_i_Stone_HouseBig_V1_F", "Land_MilOffices_V1_F"];

_targets = nearestObjects [_pos, _valid_buildings, 100];

if ((count _targets) > 0) then
{

	cpg_side_missions = cpg_side_missions + 1;
	
	_mission_counter = cpg_side_missions;

	_target = _targets select (random ((count _targets) -1));

	_cnt = 0;
	_posarray = [];

	//as long as building position _cnt not equal to "[0,0,0]" keep looping
	while {format ["%1", _target buildingpos _cnt] != "[0,0,0]" } do {

		_pos = _target buildingpos _cnt;        //select building position _cnt
		_posarray = _posarray + [_pos];        //add the position to the list

		_cnt = _cnt + 1;        //increment counter
		sleep 0.01;
	};  

	for "_i" from 0 to ((count _posarray) - 1) do
	{
		_poscache = _posarray select _i;
		if (_i == 0) then
		{
			_ammo0 = createVehicle ["Box_East_AmmoOrd_F", _poscache, [], 0, "CAN_COLLIDE"];
		};
		
		if (_i == 1) then
		{
			_ammo1 = createVehicle ["Box_East_AmmoOrd_F", _poscache, [], 0, "CAN_COLLIDE"];
		};
		
		if (_i == 2) then
		{
			_ammo2 = createVehicle ["Box_East_AmmoOrd_F", _poscache, [], 0, "CAN_COLLIDE"];
		};
		
		if (_i == 3) then
		{
			_ammo3 = createVehicle ["Box_East_AmmoOrd_F", _poscache, [], 0, "CAN_COLLIDE"];
		};
		
		if (_i == 4) then
		{
			_ammo4 = createVehicle ["Box_East_AmmoOrd_F", _poscache, [], 0, "CAN_COLLIDE"];
		};
		
	};
	
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
		_mrk setMarkerText " Destroy cache";
		_mrk setMarkerSize [0.8, 0.8];
		_mrk setMarkerPos _pos3;
	};
	
	[[[[["TaskDSM_4","Destroy Cache","Destroy Cache<br/><br/>Enemy forces have gathered weapons in an unknown location.<br/><br/>Find and destroy the weapons cache."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;
	
	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\cache.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Destroy Cache</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	Enemy forces have gathered weapons in an unknown location.<br/><br/>
	Find and destroy the ammo cache.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;

	if ((persistent_module_on) == 1) then
	{
		_string = format ["Side Mission Type %1", _mission_counter];
		["CPG_database", "Side Missions", _string, 4]  call iniDB_write;
		
		_string2 = format ["Side Mission Pos %1", _mission_counter];
		["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

		_string3 = format ["Side Mission Complete %1", _mission_counter];
		["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
	};
	
	
	waitUntil { sleep 5; !alive _ammo0; !alive _ammo1; !alive _ammo2; !alive _ammo3; !alive _ammo4 };
			
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
	
	for "_i" from 0 to 10 do
	{
		_bomb = createVehicle ['R_60mm_HE', _pos, [], 0, 'NONE'];
		_bomb setvectorup [0,0,-1];
		sleep (random 2);
	};

	message = parseText format ["<br/><img image='CombatPatrolGenerator\sm\Tier1.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Destroy Cache</t><br/><br/>
	<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
	The enemy cache has been destroyed: taking out their weapons, they will have little to fight us with.
	<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

	[message,"hintThis"] spawn BIS_fnc_MP;

	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerColor "ColorGreen";
		_mrk setMarkerText " Cache Destroyed";
	};
	
	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
	
};


