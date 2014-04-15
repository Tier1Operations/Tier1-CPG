
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Enemy large HQ with armed chopper or APC, plus watchtowers
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_pos4","_barrier1","_barrier2","_barrier3","_barrier4","_barrel1","_mrk","_counter","_chopper","_mission_counter"];

_pos = _this select 0;

cpg_main_missions = cpg_main_missions;

_mission_counter = cpg_main_missions;

_hq = createVehicle ["Land_Cargo_HQ_V1_F", [_pos select 0, (_pos select 1) + 7], [], 0, "CAN_COLLIDE"];
_hq setvectorup [0,0,1];

_group_0 = createGroup east;
_ai = _group_0 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 0);
_ai setvariable ["raven_side_mission_group", 1];

_group_1 = createGroup east;
_ai = _group_1 createUnit ["O_Soldier_TL_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 1);
_ai setvariable ["raven_side_mission_group", 1];

_group_2 = createGroup east;
_ai = _group_2 createUnit ["O_Officer_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 2);
_ai setvariable ["raven_side_mission_group", 1];

_group_3 = createGroup east;
_ai = _group_3 createUnit ["O_Soldier_AR_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 3);
_ai setvariable ["raven_side_mission_group", 1];

_group_4 = createGroup east;
_ai = _group_4 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 4);
_ai setvariable ["raven_side_mission_group", 1];

_group_5 = createGroup east;
_ai = _group_5 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 5);
_ai setvariable ["raven_side_mission_group", 1];

_group_6 = createGroup east;
_ai = _group_6 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
_ai setpos (_hq buildingpos 6);
_ai setvariable ["raven_side_mission_group", 1];

_barrier1 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 18, (_pos select 1) + 6], [], 0, "CAN_COLLIDE"];
_barrier1 setdir 90;
_barrier1 setvectorup (surfacenormal _pos);
_barrier1 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 18, (_pos select 1) - 6], [], 0, "CAN_COLLIDE"];
_barrier1 setdir 90;
_barrier1 setvectorup (surfacenormal _pos);

_barrier2 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 16, (_pos select 1) + 6], [], 0, "CAN_COLLIDE"];
_barrier2 setdir 270;
_barrier2 setvectorup (surfacenormal _pos);
_barrier2 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 16, (_pos select 1) - 6], [], 0, "CAN_COLLIDE"];
_barrier2 setdir 270;
_barrier2 setvectorup (surfacenormal _pos);

_barrier3 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 6, (_pos select 1) + 18], [], 0, "CAN_COLLIDE"];
_barrier3 setvectorup (surfacenormal _pos);
_barrier3 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 6, (_pos select 1) + 18], [], 0, "CAN_COLLIDE"];
_barrier3 setvectorup (surfacenormal _pos);

_barrier4 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 6, (_pos select 1) - 20], [], 0, "CAN_COLLIDE"];
_barrier4 setvectorup (surfacenormal _pos);
_barrier4 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 6, (_pos select 1) - 20], [], 0, "CAN_COLLIDE"];
_barrier4 setvectorup (surfacenormal _pos);

if ((random 100) < 50) then
{
	if ((random 100) < 50) then
	{
		_chopper = createVehicle ["O_Heli_Light_02_F", [_pos select 0, (_pos select 1) - 10], [], 0, "NONE"];
		_chopper removeweapon "missiles_DAGR";
		_chopper setDir (random 360);
		_chopper setvehiclelock "LOCKED";
	} else
	{
		_chopper = createVehicle ["O_Heli_Attack_02_F", [_pos select 0, (_pos select 1) - 10], [], 0, "NONE"];
		_chopper removeweapon "missiles_DAGR";
		_chopper setDir (random 360);
		_chopper setvehiclelock "LOCKED";
	};
	
	if ((random 100) < 50) then 
	{
		_group_0 = createGroup east;
		_ai = _group_0 createUnit ["O_helipilot_F", [_pos select 0, (_pos select 1) - 7], [], 0, "NONE"];
		_ai moveindriver _chopper;
		_ai = _group_0 createUnit ["O_helipilot_F", [_pos select 0, (_pos select 1) - 7], [], 0, "NONE"];
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
	
} else
{
	if ((random 100) < 50) then
	{
		_chopper = createVehicle ["O_APC_Wheeled_02_rcws_F", [_pos select 0, (_pos select 1) - 10], [], 0, "NONE"];
		_chopper setDir (random 360);
		_chopper setvehiclelock "LOCKED";
	} else
	{
		_chopper = createVehicle ["O_APC_Tracked_02_cannon_F", [_pos select 0, (_pos select 1) - 10], [], 0, "NONE"];
		_chopper setDir (random 360);
		_chopper setvehiclelock "LOCKED";
	};
	
	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_helipilot_F", [_pos select 0, (_pos select 1) - 7], [], 0, "NONE"];
	_ai moveindriver _chopper;
	_ai = _group_0 createUnit ["O_helipilot_F", [_pos select 0, (_pos select 1) - 7], [], 0, "NONE"];
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


_helipad = createVehicle ["Land_HelipadSquare_F", [_pos select 0, (_pos select 1) - 10], [], 0, "CAN_COLLIDE"];	

if ((random 100) < 50) then
{
	_postower = [_pos, 25, 50, 10, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _postower, [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 1);
	_group_1 = createGroup east;
	_ai = _group_1 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 0);
};

_postower = [_pos, 50, 100, 10, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _postower, [], 0, "CAN_COLLIDE"];
_tower setvectorup [0,0,1];
_group_0 = createGroup east;
_ai = _group_0 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
_ai setpos (_tower buildingpos 1);
_ai setvariable ["raven_side_mission_group", 1];
_group_1 = createGroup east;
_ai = _group_1 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
_ai setpos (_tower buildingpos 0);
_ai setvariable ["raven_side_mission_group", 1];

if ((random 100) < 50) then
{
	_postower = [_pos, 50, 100, 15, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _postower, [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 1);
	_ai setvariable ["raven_side_mission_group", 1];
	_group_1 = createGroup east;
	_ai = _group_1 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 0);
	_ai setvariable ["raven_side_mission_group", 1];
};

_postower = [_pos, 100, 150, 15, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _postower, [], 0, "CAN_COLLIDE"];
_tower setvectorup [0,0,1];
_group_0 = createGroup east;
_ai = _group_0 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
_ai setpos (_tower buildingpos 1);
_ai setvariable ["raven_side_mission_group", 1];
_group_1 = createGroup east;
_ai = _group_1 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
_ai setpos (_tower buildingpos 0);
_ai setvariable ["raven_side_mission_group", 1];

if ((random 100) < 50) then
{
	_postower = [_pos, 100, 150, 15, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _postower, [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 1);
	_ai setvariable ["raven_side_mission_group", 1];
	_group_1 = createGroup east;
	_ai = _group_1 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 0);
	_ai setvariable ["raven_side_mission_group", 1];
};

_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [(_pos select 0) + 8, (_pos select 1) + 18], [], 0, "CAN_COLLIDE"];
_ammo2 = createVehicle ["Box_East_AmmoOrd_F", [(_pos select 0) - 8, (_pos select 1) - 18], [], 0, "CAN_COLLIDE"];

cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [50, 50];
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
_mrk setMarkerSizeLocal [100, 100];
_type = [0] call cpg_fnc_chooseEnemy;
_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
nul = [leader _grp, _mrk, "nofollow", "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
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

cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [200, 200];
_type = [0] call cpg_fnc_chooseEnemy;
_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
nul = [leader _grp, _mrk, "nofollow", "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);
		
_pos3 = [_pos, 250, 25, 20] call BIS_fnc_findOverwatch;
_pos2 = [_pos3, 0, 15, 2, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos2];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [200, 200];
_type = [0] call cpg_fnc_chooseEnemy;
_grp = [_pos2, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);

_pos4 = [_pos, 10, 150, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;

if (side_mission_show_markers == 1) then
{
	_mrk = createMarker [format["main_mission_%1",_mission_counter], _pos4];
	_mrk setMarkerType "o_hq";
	_mrk setMarkerAlpha 0.8;
	_mrk setMarkerColor "ColorRed";
	_mrk setMarkerText " Destroy Main HQ";
	_mrk setMarkerSize [1, 1];
	_mrk setMarkerPos _pos4;
};


[[[[["TaskDSM_Main","Destroy Main HQ","Destroy Main HQ<br/><br/>Enemy forces have set up a major HQ in order to command and organize all their operations on the island. Our objective is to find and destroy this site, thus disrupting the chain of command of the enemy, limiting its effectiveness on the field.<br/><br/>Destroy the Enemy Main HQ."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\HQ.jpg' size='5' align='center'/><br/><br/>
<t align='center' size='2'>Objective</t><br/>
<t align='center' size='1.5'>Destroy Main HQ</t><br/><br/>
<t align='center' size='1.5' color='#08b000'>Assigned</t>
<br/><br/>
Enemy forces have set up a major HQ in order to command and organize all their operations on the island. Our objective is to find and destroy this site, thus disrupting the chain of command of the enemy, limiting its effectiveness on the field.<br/><br/>
Destroy the Enemy Main HQ.<br/>   ";

[message,"hintThis"] spawn BIS_fnc_MP;

if ((persistent_module_on) == 1) then
{
	
	_string2 = "Enemy Main HQ Pos";
	["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

	_string3 = "Enemy Main HQ Destroyed";
	["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
	
};


waitUntil { sleep 5; ((damage _hq) > 0.9) };

		
campaign_balance = campaign_balance + 0.15;

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
<t align='center' size='1.5'>Destroy Main HQ</t><br/><br/>
<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
The enemy Main HQ is destroyed: now their operations will result much more ineffective, giving us a marked advantage over them.
<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

[message,"hintThis"] spawn BIS_fnc_MP;

if (side_mission_show_markers == 1) then
{
	_mrk setMarkerColor "ColorGreen";
	_mrk setMarkerText " Main HQ Destroyed";
};

_string3 = "Enemy Main HQ Destroyed";

if ((persistent_module_on) == 1) then
{
	["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
};
	

