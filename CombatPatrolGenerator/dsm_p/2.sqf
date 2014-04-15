
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Enemy small FOB
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_pos4","_barrier1","_barrier2","_barrier3","_barrier4","_barrel1","_mrk","_counter"];

_pos = _this select 0;

cpg_side_missions = cpg_side_missions + 1;

_mission_counter = cpg_side_missions;

_barrier1 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 5, _pos select 1], [], 0, "CAN_COLLIDE"];
_barrier1 setdir 90;
_barrier1 setvectorup (surfacenormal _pos);
_barrier2 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 5, _pos select 1], [], 0, "CAN_COLLIDE"];
_barrier2 setdir 270;
_barrier2 setvectorup (surfacenormal _pos);
_barrier3 = createVehicle ["Land_HBarrier_5_F", [_pos select 0, (_pos select 1) + 5], [], 0, "CAN_COLLIDE"];
_barrier3 setvectorup (surfacenormal _pos);
_barrier4 = createVehicle ["Land_HBarrier_5_F", [_pos select 0, (_pos select 1) - 5], [], 0, "CAN_COLLIDE"];
_barrier4 setvectorup (surfacenormal _pos);

_barrel1 = createVehicle ["Land_MetalBarrel_F", [_pos select 0, (_pos select 1) - 1], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) - 1.5, (_pos select 1) - 1.5], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) - 1, (_pos select 1) - 0.5], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) - 0.5, (_pos select 1) - 2], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [_pos select 0, (_pos select 1) - 2.5], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) - 0.5, _pos select 1], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 0.5, _pos select 1], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 1, (_pos select 1) + 1], [], 0, "CAN_COLLIDE"];
_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [(_pos select 0) + 2, (_pos select 1) + 2], [], 0, "CAN_COLLIDE"];

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
nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);

_pos4 = [_pos, 10, 100, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;

if (side_mission_show_markers == 1) then
{
	_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos4];
	_mrk setMarkerType "o_support";
	_mrk setMarkerAlpha 0.8;
	_mrk setMarkerColor "ColorRed";
	_mrk setMarkerText " Destroy FOB";
	_mrk setMarkerSize [1, 1];
	_mrk setMarkerPos _pos4;
};


[[[[["TaskDSM_2","Destroy Small FOB","Destroy Small FOB<br/><br/>Enemy forces have set up a small FOB, supporting their motorized operations on the island.<br/><br/>Destroy the small FOB."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\smallFOB.jpg' size='5' align='center'/><br/><br/>
<t align='center' size='2'>Objective</t><br/>
<t align='center' size='1.5'>Destroy Small FOB</t><br/><br/>
<t align='center' size='1.5' color='#08b000'>Assigned</t>
<br/><br/>
Enemy forces have set up a small FOB, supporting their motorized operations on the island.<br/><br/>
Destroy the small FOB.<br/>   ";

[message,"hintThis"] spawn BIS_fnc_MP;

if ((persistent_module_on) == 1) then
{
	_string = format ["Side Mission Type %1", _mission_counter];
	["CPG_database", "Side Missions", _string, 2]  call iniDB_write;
	
	_string2 = format ["Side Mission Pos %1", _mission_counter];
	["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
};



waitUntil { sleep 5; !alive _barrier1; !alive _barrier2; !alive _barrier3; !alive _barrier4 };

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
	<t align='center' size='1.5'>Destroy Small FOB</t><br/><br/>
	<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
	The enemy small FOB has been destroyed: the enemy logistics and motorized operations have been disrupted.
	<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

[message,"hintThis"] spawn BIS_fnc_MP;

if (side_mission_show_markers == 1) then
{
	_mrk setMarkerColor "ColorGreen";
	_mrk setMarkerText " FOB Destroyed";
};

_string3 = format ["Side Mission Complete %1", _mission_counter];
["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
