
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Roadblock (kinda)
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_pos4","_barrier1","_barrier2","_tower","_mrk"];

_pos = _this select 0;

cpg_side_missions = cpg_side_missions + 1;

_mission_counter = cpg_side_missions;

_ambush = [];
_roads = [];
_tmpnr = 0;

while {((count _roads) < 1) and (_tmpnr < 100)} do 
{
	_ambush = [_pos, 1, 10, 5, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	_roads = _ambush nearRoads 200;
	_tmpnr = _tmpnr + 1;
};

_pos = position (_roads call BIS_fnc_selectRandom);

_nearRoads = _pos nearRoads 10;
_road = _nearRoads select 0;
_roadConnectedTo = roadsConnectedTo _road;
_connectedRoad = _roadConnectedTo select 0;
_direction = [_road, _connectedRoad] call BIS_fnc_DirTo;


_posbarrier = [((_pos select 0) - (cos(_direction) * 8)), ((_pos select 1) + (sin(_direction) * 8)), 0];
_barrier1 = createVehicle ["Land_HBarrier_5_F", _posbarrier, [], 0, "NONE"];
_barrier1 setdir (_direction + 90);

_barrier2 = createVehicle ["Land_BarGate_F", _pos, [], 0, "NONE"];
_barrier2 setdir (_direction);

_posammo = [((_pos select 0) - (cos(_direction) * 10)), ((_pos select 1) + (sin(_direction) * 10)), 0];
_ammo1 = createVehicle ["Box_East_AmmoOrd_F", _posammo, [], 0, "NONE"];

_postower = [_pos, 15, 30, 4, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _postower, [], 0, "CAN_COLLIDE"];

_count = 0;
while {isonroad _tower && _count < 1000} do 
{
	_tower2 = _tower;
	_tower setPosATL [(getPosATL _tower2 select 0) + 10 - random 20, (getPosATL _tower2 select 1) + 10 - random 20, 0.01];
	_count = _count + 1;
};

_tower setvectorup [0,0,1];
_group_0 = createGroup east;
_ai = _group_0 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
_ai setpos (_tower buildingpos 1);
_ai setvariable ["raven_side_mission_group", 1];

_group_1 = createGroup east;
_ai = _group_1 createUnit ["O_Soldier_F", _postower, [], 0, "CAN_COLLIDE"];
_ai setpos (_tower buildingpos 0);
_ai setvariable ["raven_side_mission_group", 1];



cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
_mrk setMarkerAlphaLocal 0;
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [30, 30];
_type = [0] call cpg_fnc_chooseEnemy;
_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
cpg_v_enemynr = cpg_v_enemynr + (count units _grp) + 2;
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
nul = [leader _grp, _mrk, "nofollow", "spawned"] execVM "scripts\UPSMON.sqf";
{
	_x setvariable ["raven_side_mission_group", 1];
} forEach (units _grp);


_mrkroads = _pos nearRoads 100;
_pos4 = position (_mrkroads call BIS_fnc_selectRandom);

if (side_mission_show_markers == 1) then
{
	_mrk = createMarker [format["side_mission_%1",cpg_side_missions], _pos4];
	_mrk setMarkerType "mil_destroy";
	_mrk setMarkerAlpha 0.8;
	_mrk setMarkerColor "ColorRed";
	_mrk setMarkerText " Destroy Roadblock";
	_mrk setMarkerSize [1, 1];
	_mrk setMarkerPos _pos4;
};

[[[[["TaskDSM_1","Destroy Roadblock","Destroy Roadblock<br/><br/>Enemy forces have set up a roadblock aiming at controlling this island's roads and communications.<br/><br/>Destroy the roadblock and any fortification."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\roadblock.jpg' size='5' align='center'/><br/><br/>
<t align='center' size='2'>Objective</t><br/>
<t align='center' size='1.5'>Destroy Roadblock</t><br/><br/>
<t align='center' size='1.5' color='#08b000'>Assigned</t>
<br/><br/>
Enemy forces have set up a roadblock aiming at controlling this island's roads and communications.<br/><br/>
Destroy the roadblock and any fortification.<br/>   ";

[message,"hintThis"] spawn BIS_fnc_MP;

if ((persistent_module_on) == 1) then
{
	_string = format ["Side Mission Type %1", _mission_counter];
	["CPG_database", "Side Missions", _string, 1]  call iniDB_write;
	
	_string2 = format ["Side Mission Pos %1", _mission_counter];
	["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

	_string3 = format ["Side Mission Complete %1", _mission_counter];
	["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
};



waitUntil { sleep 5; !alive _barrier1; !alive _barrier2; ((damage _tower) > 0.9) };
		
campaign_balance = campaign_balance + 0.10;

_campaign_balance_judgement = "";

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
<t align='center' size='1.5'>Destroy Roadblock</t><br/><br/>
<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
The enemy roadblock has been destroyed: the enemy plan of territorial control has been halted.
<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

[message,"hintThis"] spawn BIS_fnc_MP;

if (side_mission_show_markers == 1) then
{
	_mrk setMarkerColor "ColorGreen";
	_mrk setMarkerText " Roadblock Destroyed";
};
		
_string3 = format ["Side Mission Complete %1", _mission_counter];
["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
	