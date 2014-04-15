
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Investigate war crimes
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_pos4","_barrier1","_barrier2","_barrier3","_barrier4","_barrel1","_mrk","_counter"];


_pos = [cpg_v_cpos, cpg_side_adder, (1600*cpg_side_mult), 4, 0, 1, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;

cpg_side_missions = cpg_side_missions + 1;

_mission_counter = cpg_side_missions;

_barrier1 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) + 8, _pos select 1], [], 0, "CAN_COLLIDE"];
_barrier1 setdir 90;
_barrier1 setvectorup (surfacenormal [(_pos select 0) + 8, _pos select 1]);
_barrier2 = createVehicle ["Land_HBarrier_5_F", [(_pos select 0) - 8, _pos select 1], [], 0, "CAN_COLLIDE"];
_barrier2 setdir 270;
_barrier2 setvectorup (surfacenormal [(_pos select 0) - 8, _pos select 1]);
_barrier3 = createVehicle ["Land_HBarrier_5_F", [_pos select 0, (_pos select 1) + 8], [], 0, "CAN_COLLIDE"];
_barrier4 = createVehicle ["Land_HBarrier_5_F", [_pos select 0, (_pos select 1) - 8], [], 0, "CAN_COLLIDE"];
_barrel1 = createVehicle ["Land_MetalBarrel_empty_F", [(_pos select 0) + 6.5, (_pos select 1) - 1], [], 0, "CAN_COLLIDE"];

_barrier1 = createVehicle ["Land_HumanSkeleton_F", [(_pos select 0) + 4, (_pos select 1) + 6], [], 0, "CAN_COLLIDE"];
_skeleton1 = createVehicle ["Land_HumanSkeleton_F", [(_pos select 0) + 2, (_pos select 1) + 2], [], 0, "CAN_COLLIDE"];
_barrier1 = createVehicle ["Land_HumanSkeleton_F", [(_pos select 0) - 4, (_pos select 1) + 5], [], 0, "CAN_COLLIDE"];
_barrier1 = createVehicle ["Land_HumanSkull_F", [(_pos select 0) + 3, (_pos select 1) - 4], [], 0, "CAN_COLLIDE"];
_barrier1 = createVehicle ["Land_HumanSkull_F", [(_pos select 0) + 6, (_pos select 1) - 5], [], 0, "CAN_COLLIDE"];

for "_i" from 0 to 10 do
{

	_posciv = [((_pos select 0) - 7 + (random 14)), ((_pos select 1) - 7 + (random 14)), 0];
	_group_0 = createGroup civilian;
	
	switch (floor (random 7)) do
	{
		case 0:
		{ 
			_guy = _group_0 createUnit ["C_man_1", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
		case 1:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_1_F", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
		case 2:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_2_F", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
		case 3:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_3_F", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
		case 4:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_4_F", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
		case 5:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_5_F", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
		case 6:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_6_F", _posciv, [], 0, "CAN_COLLIDE"];
			_guy setdir (random 360);			
			_guy setdamage 1;
		};
		case 7:
		{ 
			_guy = _group_0 createUnit ["C_man_polo_6_F", _posciv, [], 0, "CAN_COLLIDE"]; 
			_guy setdir (random 360);
			_guy setdamage 1;
		};
	};
};


_pos2 = [_pos, 0, 30, 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_grp = createGroup east;
_leader1 = _grp createUnit ["O_recon_TL_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_M_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_LAT_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_JTAC_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_Medic_F", _pos2, [], 0, "CAN_COLLIDE"];
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [50, 50];
nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);

_pos2 = [_pos, 0, 100, 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_grp = createGroup east;
_leader2 = _grp createUnit ["O_recon_TL_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_M_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_LAT_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_JTAC_F", _pos2, [], 0, "CAN_COLLIDE"];
_ai = _grp createUnit ["O_recon_Medic_F", _pos2, [], 0, "CAN_COLLIDE"];
cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [150, 150];
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

if (side_mission_show_markers == 1) then
{
	_pos4 = [_pos, 10, 100, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos4];
	_mrk setMarkerType "o_recon";
	_mrk setMarkerAlpha 0.8;
	_mrk setMarkerColor "ColorRed";
	_mrk setMarkerText " Investigate War Crimes";
	_mrk setMarkerSize [1, 1];
	_mrk setMarkerPos _pos4;
};


[[[[["TaskDSM_8","Investigate War Crimes","Investigate War Crimes<br/><br/>We have intel of ongoing war crimes in our area, by hands of the enemy. Recon the area and check these reports.<br/><br/>Find evidence of war crimes."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

message = parseText "<br/><img image='civ\pix\civKilled.jpg' size='5' align='center'/><br/><br/>
<t align='center' size='2'>Objective</t><br/>
<t align='center' size='1.5'>Investigate War Crimes</t><br/><br/>
<t align='center' size='1.5' color='#08b000'>Assigned</t>
<br/><br/>
We have intel of ongoing war crimes in our area, by hands of the enemy. Recon the area and check these reports.<br/><br/>
Find evidence of war crimes.<br/>   ";

[message,"hintThis"] spawn BIS_fnc_MP;

if ((persistent_module_on) == 1) then
{
	_string = format ["Side Mission Type %1", _mission_counter];
	["CPG_database", "Side Missions", _string, 8]  call iniDB_write;
	
	_string2 = format ["Side Mission Pos %1", _mission_counter];
	["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
	
	["CPG_database", "Side Missions", "Side Missions Number", _mission_counter]  call iniDB_write;
};


waitUntil { sleep 5; ([getPosATL (_skeleton1), 25, true, "count"] call custom_nearestPlayers) > 0 };
		
// [[["TaskDSM_8","succeeded"],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;	

campaign_balance = campaign_balance + 0.01;

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

_civ_reputation_judgement = "";

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
if (civ_reputation < -0.75) then
{
	_civ_reputation_judgement = "<t color='#ff0000'>hates</t>";
};
if ((civ_reputation > -0.3) && (civ_reputation < 0.3)) then
{
	_civ_reputation_judgement = "is <t color='#cccc00'>indifferent</t> to";
};

message = parseText format ["<br/><img image='CombatPatrolGenerator\sm\Tier1.jpg' size='5' align='center'/><br/><br/>
<t align='center' size='2'>Objective</t><br/>
<t align='center' size='1.5'>Investigate War Crimes</t><br/><br/>
<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
The evidence has been found: the population will know about these crimes, enhancing their support towards our operation.
<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>At the moment, the population %2 you.<br/>   ", _campaign_balance_judgement, _civ_reputation_judgement];

[message,"hintThis"] spawn BIS_fnc_MP;

if (side_mission_show_markers == 1) then
{
	_mrk setMarkerColor "ColorGreen";
	_mrk setMarkerText " War Crimes Found";
};

_string3 = format ["Side Mission Complete %1", _mission_counter];

if ((persistent_module_on) == 1) then
{
	["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
};

