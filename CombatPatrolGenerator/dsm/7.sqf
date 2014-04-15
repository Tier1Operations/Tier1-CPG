
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////	Enemy large FOB with special forces
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



private["_pos","_pos2","_pos3","_pos4","_barrier1","_barrier2","_barrier3","_barrier4","_barrel1","_mrk","_counter"];

// We want to find a good position to create the FOB, so we need the isFlatEmpty function to check if
// the position found by BIS_fnc_findSafePos is a good one. If not, retry.

_check = [];
_counter = 0;
_equal1 = true;
_equal2 = true;
while {(_equal1 || _equal2) && _counter < 10000} do 
{
	_pos = [cpg_v_cpos, cpg_side_adder, (2000*cpg_side_mult), 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	_check = _pos isflatempty [ 12, 1, 0.2, 15, 0, false, objNull]; 
	_counter = _counter + 1;
	_equal1 = [[], _check] call BIS_fnc_areEqual;	
	_normal = surfacenormal _pos;
	if ((_normal select 2) > 0.99) then
	{
		_equal2 = false;
		// hint format ["%1", _normal];
	} else
	{
		_equal2 = true;
	};
};

// This is a safety measure: if after 10000 iterations of the previous code you still haven't found
// a suitable place, don't execute the mission itself.

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

	_ifrit1 = createVehicle ["O_MRAP_02_hmg_F", _pos, [], 0, "NONE"];
	_ifrit1 setvariable ["raven_side_mission_group", 1];
	_helipad = createVehicle ["Land_HelipadSquare_F", _pos, [], 0, "CAN_COLLIDE"];

	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_Soldier_lite_F", _pos, [], 0, "NONE"];
	_ai moveindriver _ifrit1;
	_ai = _group_0 createUnit ["O_Soldier_lite_F", _pos, [], 0, "NONE"];
	_ai moveingunner _ifrit1;
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSizeLocal [200, 200];
	nul = [leader _group_0, _mrk, "ambush2", "spawned"] execVM "scripts\UPSMON.sqf";
	{
		_x setvariable ["raven_side_mission_group", 1];
	} forEach (units _group_0);

	_ifrit1 setvehiclelock "LOCKED";

	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 2, (_pos select 1) + 8.5], [], 0, "CAN_COLLIDE"];
	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 8.5, (_pos select 1) + 2], [], 0, "CAN_COLLIDE"];
	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 8.5, (_pos select 1) + 3], [], 0, "CAN_COLLIDE"];
	_barrel1 = createVehicle ["Land_MetalBarrel_F", [(_pos select 0) + 8.5, (_pos select 1) - 1], [], 0, "CAN_COLLIDE"];

	_ammo1 = createVehicle ["Box_East_AmmoOrd_F", [(_pos select 0) + 4, (_pos select 1) + 8.5], [], 0, "CAN_COLLIDE"];

	_pos2 = [_pos, 0, 50, 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
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
		_mrk setMarkerType "o_recon";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorRed";
		_mrk setMarkerText " Defeat Special Forces";
		_mrk setMarkerSize [1, 1];
		_mrk setMarkerPos _pos4;
	};


	[[[[["TaskDSM_7","Defeat Special Forces","Defeat Special Forces<br/><br/>Enemy forces have set up a recon FOB for Special Forces activity on the island. This is a threat we cannot tolerate and it must be eradicated at once.<br/><br/>Defeat the Special Forces squad."]]],"shk_taskmaster.sqf"],"BIS_fnc_execVM",false,true] spawn BIS_fnc_MP;

	message = parseText "<br/><img image='CombatPatrolGenerator\dsm\pix\specOpsFOB.jpg' size='5' align='center'/><br/><br/>
	<t align='center' size='2'>Objective</t><br/>
	<t align='center' size='1.5'>Defeat Special Forces</t><br/><br/>
	<t align='center' size='1.5' color='#08b000'>Assigned</t>
	<br/><br/>
	Enemy forces have set up a Recon FOB for Special Forces activity on the island. This is a threat we cannot tolerate and it must be eradicated at once.<br/><br/>
	Defeat the Special Forces squad.<br/>   ";

	[message,"hintThis"] spawn BIS_fnc_MP;
	
	if ((persistent_module_on) == 1) then
	{
		_string = format ["Side Mission Type %1", _mission_counter];
		["CPG_database", "Side Missions", _string, 7]  call iniDB_write;
		
		_string2 = format ["Side Mission Pos %1", _mission_counter];
		["CPG_database", "Side Missions", _string2, _pos]  call iniDB_write;

		_string3 = format ["Side Mission Complete %1", _mission_counter];
		["CPG_database", "Side Missions", _string3, 0]  call iniDB_write;
		
		["CPG_database", "Side Missions", "Side Missions Number", _mission_counter]  call iniDB_write;
	};
	
	

	waitUntil { sleep 5; !alive _ifrit1; !alive _leader1; !alive _leader2 };
			
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
	<t align='center' size='1.5'>Defeat Special Forces</t><br/><br/>
	<t align='center' size='1.5' color='#01df01'>Completed</t><br/><br/>
	The enemy Recon unit has been defeated: this deadly threat to our operation has finally been dismantled.
	<br/>Good job everyone.<br/><br/>Compared to the enemy, we are %1.<br/>   ", _campaign_balance_judgement];

	[message,"hintThis"] spawn BIS_fnc_MP;

	if (side_mission_show_markers == 1) then
	{
		_mrk setMarkerColor "ColorGreen";
		_mrk setMarkerText " Special Forces Defeated";
	};
	
	_string3 = format ["Side Mission Complete %1", _mission_counter];
	
	if ((persistent_module_on) == 1) then
	{
		["CPG_database", "Side Missions", _string3, 1]  call iniDB_write;
	};

};
