

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Combat Patrol Generator
//
//	Script created by BlackAlpha.
//	www.tier1ops.eu
//
//	This script will spawn enemies randomly on the map. First, the script randomly chooses a "patrol area". Then it spawns enemies around that patrol area.
//
//
//	Technical stuff:
//
//	Execute this script during map initialization and it will start the entire Combat Patrol Generator.
//	For example, inside "init.sqf" put the following line:
//	_handle = [] execVM "CombatPatrolGenerator\cpg_init.sqf";
//
//	This script requires the following line to be executed by onPlayerConnected:
//	[_id, _name, _uid] call cpg_fnc_updateJIPMarkers
//	For example, put the following line inside "init.sqf":
//	onPlayerConnected "[_id, _name, _uid] call cpg_fnc_updateJIPMarkers";
//
//
//	This script requires the following ingame markers to exist prior to starting CPG:
//	(Name of marker)	(Description what the marker is for)
//	cpg_m_center	- Marks the center of the map. A random position will be chosen in a certain radius (that covers the entire map) starting from this marker.
//	cpg_m_startloc	- Marks the player starting position. No enemies will spawn in 1 kilometer around that marker.
//	cpg_m_dposl		- Marks backup position to spawn land units in case no safe random position could be found due to collision isues.
//	cpg_m_dposw		- Marks backup position to spawn water units in case no safe random position could be found due to collision isues.
//	cpg_m_fort1		- Marks an area containing buildings that can be occupied by AI.
//	cpg_m_fort2		- Marks an area containing buildings that can be occupied by AI.
//	cpg_m_fort3		- Marks an area containing buildings that can be occupied by AI.
//	cpg_m_fort4		- Marks an area containing buildings that can be occupied by AI.
//	cpg_m_fort5		- Marks an area containing buildings that can be occupied by AI.
//	cpg_m_fort6		- Marks an area containing buildings that can be occupied by AI.
//	cpg_m_fortX		- Optional: More of such areas can be marked. Just make sure the number increments by 1 each time and you do not skip a number!
//
//
//	This script requires the following files that should already come with the Combat Patrol Generator:
//	- (mission root folder)\CombatPatrolGenerator\cpg_cleanup.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_fnc_chooseEnemy.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_fnc_chooseTactic.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_fnc_findClosestFort.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_fnc_spawnVehicles.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_fnc_updateJIPMarkers.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_init.sqf
//	- (mission root folder)\CombatPatrolGenerator\cpg_startPopulating.sqf
//
//
//	This script requires UPSMON. This script expects all UPSMON content to be located inside UPSMON's default folder:
//	- (mission root folder)\Scripts\
//	For example, "Init_UPSMON.sqf" should be located in:
//	- (mission root folder)\Scripts\Init_UPSMON.sqf
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



if (isserver) then {

	private ["_cpghandle"];
	
	//	Initialize functions and variables that are required to start CPG.
	cpg_fnc_chooseEnemy = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_chooseEnemy.sqf";
	cpg_fnc_findClosestFort = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_findClosestFort.sqf";
	cpg_fnc_chooseTactic = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_chooseTactic.sqf";
	cpg_fnc_chooseTactic_VehicleMadness = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_chooseTactic_VehicleMadness.sqf";
	cpg_fnc_createTactic_LoadedUnits = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_createTactic_LoadedUnits.sqf";
	cpg_fnc_loadObjectives = compile preprocessFile "CombatPatrolGenerator\dsm_p\loadObjectives.sqf";
	cpg_fnc_spawnVehicles = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_spawnVehicles.sqf";
	cpg_fnc_updateJIPMarkers = compile preprocessFile "CombatPatrolGenerator\cpg_fnc_updateJIPMarkers.sqf";
	cpg_finished = 0;
	cpg_v_tnr = 0;
	cpg_v_inr = 0;
	cpg_v_cpos_array = [];
	cpg_main_missions = 0;
	cpg_side_missions = 0;
	cpg_watchtower_counter = 0;
	cpg_intel_mrk_prob = (paramsarray select 2);
	cpg_show_patrol_mrk = (paramsarray select 8);
	cpg_mult = ((paramsarray select 9) / 10);
	cpg_side_missions_min = (paramsarray select 10);
	cpg_side_missions_max = (paramsarray select 11);
	cpg_side_adder = ((paramsarray select 12) / 10);
	cpg_side_mult = ((paramsarray select 13) / 10);
	cpg_vehicle_prob_mult = ((paramsarray select 14) / 10);
	cpg_enemy_mortars = (paramsarray select 15);
	cpg_air_ambushes = (paramsarray select 17);
	cpg_vehicle_madness = (paramsarray select 32);
	cpg_v_dpos = [getmarkerpos "cpg_m_dposl", getmarkerpos "cpg_m_dposw"];
	cpg_v_blacklist = [];
	cpg_v_nr = (paramsarray select 1) + (floor(random 25)) + 1;
	
	if (persistent_load == 0) then
	{
		cpg_v_zones = paramsarray select 0;
	} else
	{
		cpg_v_cpos_array = ["CPG_database", "Campaign_Enemy_Status", "Patrol Area Array", "ARRAY"]  call iniDB_read;
		cpg_v_zones = count cpg_v_cpos_array;
		enemy_starting_array = ["CPG_database", "Campaign_Enemy_Status", "Enemy Array", "ARRAY"]  call iniDB_read;
		enemy_starting_positions = ["CPG_database", "Campaign_Enemy_Status", "Enemy Position Array", "ARRAY"] call iniDB_read;
	};

	sleep (5 + (floor(random 5)));
	
	//	Start CPG.
	if (persistent_load == 0) then
	{
		_cpghandle = [] execVM "CombatPatrolGenerator\cpg_startPopulating.sqf";
	} else
	{
		_cpghandle = [] execVM "CombatPatrolGenerator\cpg_startPopulating_Load.sqf";
	};
	waitUntil {sleep 10; scriptDone _cpghandle;};
	
	// Create the Air Ambush Points
	_airhandle = [] execVM "CombatPatrolGenerator\cpg_airAmbushInit.sqf";
	waitUntil {sleep 10; scriptDone _airhandle};
	
	// Script to hide Opfor dead bodies, to improve performance
	[] execVM "Tier1\MiscScripts\hideBodies.sqf";
	
	// Side-mission system
	// It is triggered also in multi-session operations: it just brings the number of objectives
	// to the desired number, if they are already complete
	while { cpg_side_missions < cpg_side_missions_min } do
	{
		sleep 30;
		execVM "CombatPatrolGenerator\dsm\choose_dsm.sqf";
	};
	
	sleep 30;
	
	// Enemy Main HQ to be created or loaded!
	
	if (persistent_load == 0) then
	{
		execVM "CombatPatrolGenerator\dsm\mainBase.sqf";
	} else
	{
		_string3 = "Enemy Main HQ Destroyed";
		_completed = ["CPG_database", "Side Missions", _string3, "NUMBER"]  call iniDB_read;
		
		if (_completed == 0) then
		{
			_string2 = "Enemy Main HQ Pos";
			_pos = ["CPG_database", "Side Missions", _string2, "ARRAY"]  call iniDB_read;
			
			[_pos] execVM "CombatPatrolGenerator\dsm_p\mainBase.sqf";
		};
	};
	
	sleep 60;
	
	cpg_finished = 1;
	
	//	Cleanup after CPG has done its job.
	// _handle = [] execVM "CombatPatrolGenerator\cpg_cleanup.sqf";
	
	//  Never cleanup! Those values and functions are so useful!
	
};