
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Enemy large FOB with armed chopper
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_pos4","_barrier1","_barrier2","_barrier3","_barrier4","_barrel1","_mrk","_counter","_chopper"];

_pos = _this select 0;

_counter = 0;

if (_counter < 10000) then 
{

	cpg_side_missions = cpg_side_missions + 1;
	
	_mission_counter = cpg_side_missions;

	_barrier1 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 8, _pos select 1], [], 0, "CAN_COLLIDE"];
	_barrier1 setdir 90;
	_barrier1 setvectorup (surfacenormal _pos);
	_barrier2 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 10, _pos select 1], [], 0, "CAN_COLLIDE"];
	_barrier2 setdir 270;
	_barrier2 setvectorup (surfacenormal _pos);
	_barrier3 = createVehicle ["Land_HBarrier_5_F", [_pos select 0, (_pos select 1) + 10], [], 0, "CAN_COLLIDE"];
	_barrier3 setvectorup (surfacenormal _pos);
	_barrier4 = createVehicle ["Land_HBarrier_5_F", [_pos select 0, (_pos select 1) - 10], [], 0, "CAN_COLLIDE"];
	_barrier4 setvectorup (surfacenormal _pos);

	if ((random 100) < 50) then
	{
		_chopper = createVehicle ["O_Heli_Light_02_F", _pos, [], 0, "NONE"];
	} else
	{
		_chopper = createVehicle ["O_Heli_Attack_02_F", _pos, [], 0, "NONE"];
	};
	
	_helipad = createVehicle ["Land_HelipadSquare_F", _pos, [], 0, "CAN_COLLIDE"];

	if ((random 100) < 50) then 
	{
		_group_0 = createGroup east;
		_ai = _group_0 createUnit ["O_helipilot_F", _pos, [], 0, "NONE"];
		_ai moveindriver _chopper;
		_ai = _group_0 createUnit ["O_helipilot_F", _pos, [], 0, "NONE"];
		_ai moveinturret [_chopper, [0]];
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		_mrk setMarkerSizeLocal [2000, 2000];
		nul = [leader _group_0, _mrk, "ambush2", "spawned"] execVM "scripts\UPSMON.sqf";
		{
			_x setvariable ["raven_side_mission_group", 1];
		} forEach (units _group_0);
	};
	
	_chopper removeweapon "missiles_DAGR";

	_chopper setvehiclelock "LOCKED";

	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 2, (_pos select 1) + 8.5], [], 0, "CAN_COLLIDE"];
	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 8.5, (_pos select 1) + 2], [], 0, "CAN_COLLIDE"];
	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 8.5, (_pos select 1) + 3], [], 0, "CAN_COLLIDE"];
	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 8.5, (_pos select 1) - 1], [], 0, "CAN_COLLIDE"];

	_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [(_pos select 0) + 4, (_pos select 1) + 8.5], [], 0, "CAN_COLLIDE"];

	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [20, 20];
	_type = [0] call cpg_fnc_chooseEnemy;
	_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
	nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _grp);

	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [150, 150];
	_type = [0] call cpg_fnc_chooseEnemy;
	_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
	nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _grp);
			

	_pos3 = [_pos, 250, 25, 20] call BIS_fnc_findOverwatch;
	_pos2 = [_pos3, 0, 15, 2, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos2];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [250, 250];
	_type = [0] call cpg_fnc_chooseEnemy;
	_grp = [_pos2, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
	nul = [leader _grp, _mrk, "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _grp);

	_pos4 = [_pos, 10, 150, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	
	if (side_mission_show_markers == 1) then
	{
		_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos4];
		_mrk setMarkerType "o_air";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorRed";
		_mrk setMarkerText " Destroy Helicopter";
		_mrk setMarkerSize [1, 1];
		_mrk setMarkerPos _pos4;
	};


	[[[[["TaskDSM_6","Destroy Helicopter","Destroy Helicopter<br/><br/>Enemy forces have set up an FOB, supporting the activity of an armed helicopter. This helicopter could be manned, so practice extreme caution during the approach.<br/><br/>Destroy the armed helicopter."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\ka60.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Destroy Helicopter</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	Enemy forces have set up an FOB, supporting the activity of an armed helicopter. The attack helicopter could be manned, so practice extreme caution during the approach.<br/><br/>
	Destroy the armed helicopter.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
	
	if ((persistent_module_on) == 1) then
	{
		_string = format ["Side Mission Type %1", _mission_counter];
		["CPG_database", "Side Missions", _string, 6]  call iniDB_write;
		
		_string2 = format ["Side Mission Pos %1", _mission_counter];
		["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

		_string3 = format ["Side Mission Complete %1", _mission_counter];
		["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
	};


	while { alive _chopper } do 
	{
		_chopper setfuel 1;
		if (side_mission_show_markers == 1) then
		{
			_mrk setMarkerPos (getPos _chopper); 
		};
		sleep 10;
	};
			
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
	<t align='center' size='1.5'>Destroy Helicopter</t><br/><br/>
	<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
	The enemy attack helicopter has been destroyed: this enormous threat to our operation has finally ceased to exist.
	<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

	[message,"hintThis"] spawn BIS_fnc_MP;

	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerColor "ColorGreen";
		_mrk setMarkerText " Helicopter Destroyed";
	};
	
	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
	
};
