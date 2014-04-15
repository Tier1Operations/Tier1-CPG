
//	Check mission parameter settings and execute parameter code.
for [ { _i = 0 }, { _i < count(paramsArray) }, { _i = _i + 1 } ] do
{
	_paramName =(configName ((missionConfigFile >> "Params") select _i));
	_paramValue = (paramsArray select _i);
	_paramCode = ( getText (missionConfigFile >> "Params" >> _paramName >> "code"));
		
	diag_log format ["INIT Params: [%1] - [%2]", _paramName, _paramCode];
	
	if !( _paramCode == "" ) then 
	{
		_code = format[_paramCode, _paramValue];
		call compile _code;
	};
};


//	Initialize time of day, chosen in the mission parameters.
if (isserver) then {
	setDate [2035, 7, 6, T1_startingTimeHour, 0];
};

//	Anti hacker stuff. Experimental.
// "BIS_fnc_MP_packet" addPublicVariableEventHandler {};
// BIS_fnc_MP = {};


//	Initialize some misc stuff.
_side = createCenter east;
_side = createCenter west;


//	Initialize UPSMON.
if ((!isServer) && (player != player)) then
{
  waitUntil {player == player};
};
//	Init UPSMON script (must be run on all clients)
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";	
//	Process statements stored using setVehicleInit
// processInitCommands;
//	Finish world initialization before mission is launched. 


//	Define Aid Objects for everyone. These objects are used in the Humanitarian Missions
//  aid_objects = ["Land_Bricks_V1_F", "Land_Sacks_goods_F", "Land_WaterBarrel_F"];

//	The below list contains all unit types that are allowed to pilot aircraft vehicles.
//	This list is used by some Tier1 scripts.
playablePilotTypes = ["B_Helipilot_F", "O_helipilot_F", "B_Pilot_F", "I_helicrew_F", "I_helipilot_F", "T1_Pilot_Standard_F", "T1_Pilot_Black_F", "T1_Pilot_Blackcamo_F", "T1_Pilot_Camo_F", "T1_Pilot_Night_F"];

//	Define all town logics, to let all players know them
//	(used for example in Humanitarian Aid scripts)
//  town_logics = [agia_town_logic, base_1_town_logic, base_2_town_logic, cephas_town_logic, epodos_town_logic, girna_1_town_logic, girna_2_town_logic, girna_3_town_logic, ioannis_town_logic, jay_town_logic, kalitos_town_logic, kamino_town_logic, keiros_town_logic, kratos_town_logic, limeri_town_logic, mike_1_town_logic, mike_2_town_logic, nikos_town_logic, pardalos_town_logic, radio_1_town_logic, radio_2_town_logic, rogain_1_town_logic, tsoukalia_town_logic, tsekos_town_logic];


// This is a function used by side-missions to broadcast hints to everyone
// It's going to be called by bis_fnc_MP
hintThis = {hint _this;};


// Parameters for the UAV, IEDs, and others, should stay here so it's easy to update in case the description.ext file changes
// Hunting them in each and every script is time-consuming, so here they can be changed quickly and effectively
// These are parameters known by everyone. Other parameters that only the server should know (especially when players JIP)
// are in other scripts
// uav_available_in_mission = (paramsarray select 16);
// ied_present_in_mission = (paramsarray select 18);
// ieds_number_in_mission = (paramsarray select 19);
// civ_module_active_in_mission = (paramsarray select 20);
// civ_intel_prob_from_civ = (paramsarray select 21);
// aid_module_active_in_mission = (paramsarray select 22);
// aid_request_prob_from_civ = (paramsarray select 23);

// These parameters are needed here in order to be initialized for JIP players
// They weill be wrong for them, but at least they'll exist
// After the first synchronization, everything will be fine
// campaign_balance = (((paramsarray select 24) / 100) - 1);
// civ_reputation = (((paramsarray select 25) / 100) - 1);
// civ_happiness = (((paramsarray select 27) / 100) - 1);
// civ_reputation_lower_limit = (((paramsarray select 26) / 100) - 1);
// civ_happiness_lower_limit = (((paramsarray select 28) / 100) - 1);

persistent_module_on = (paramsarray select 29);
persistent_reset = (paramsarray select 30);
persistent_load = (paramsarray select 31);

// Do we want to show side mission markers on map?
side_mission_show_markers = (paramsarray select 33);


// Pre-process useful scripts for the intel system
// raven_intelAction = compile preprocessFileLineNumbers "civ\intelActionGenerate.sqf";
// raven_freeRoam = compile preprocessFileLineNumbers "civ\freeRoam.sqf";
// raven_giveIntel = compile preprocessFileLineNumbers "civ\civIntel.sqf";
// raven_aidAction = compile preprocessFileLineNumbers "civ\aidActionGenerate.sqf";
// raven_needAid = compile preprocessFileLineNumbers "civ\needAid.sqf";
// raven_civKilled = compile preprocessFileLineNumbers "civ\civKilled.sqf";
// raven_civHealed = compile preprocessFileLineNumbers "civ\civHealed.sqf";
// raven_cargo_offroad_aid = compile preprocessFileLineNumbers "cargo\offroad\offroadAid.sqf";
// raven_cargo_offroad_load_aid = compile preprocessFileLineNumbers "cargo\offroad\offroadLoadAid.sqf";
// raven_cargo_offroad_unload_aid = compile preprocessFileLineNumbers "cargo\offroad\offroadUnloadAid.sqf";
persistent_bluforkilled = compile preprocessFileLineNumbers "persistent\bluforKilled.sqf";
persistent_opforkilled = compile preprocessFileLineNumbers "persistent\opforKilled.sqf";
//raven_news_init = compile preprocessFileLineNumbers "aan_news\news_init.sqf";
//raven_news_overlay = compile preprocessFileLineNumbers "aan_news\news_overlay.sqf";


// Run the briefing file.
execVM "Briefing.sqf";


["TaskAssigned",["","Patrol the Area"]] call bis_fnc_showNotification;

[[
	["Task1","Main Mission: Patrol Area","Patrol Area<br/><br/>Enemies have been spotted in the area. Your job is to patrol the marked areas and neutralize any hostiles you meet along the way.<br/><br/>Note: The mission is randomized each time you start it. Markers will show up shortly after the mission has started.<br/><br/>This mission does not end automatically, an admin will need to end the mission."]
]] execVM "shk_taskmaster.sqf";



finishMissionInit;



//	Initialize BTC Revive.
call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";



//	The following code is executed after the briefing screen.
sleep 0.5;



//	Server-side scripts.
if (isserver) then {
	
	//	Start custom functions used in a bunch of different scripts.
	[] execVM "CustomFunctions\custom_functions_init.sqf";
	
	CIVILIAN setFriend [WEST,1];
	CIVILIAN setFriend [EAST,1];
	
	// This is for the iniDB addon, to use a persistent database
	if (persistent_module_on == 1) then
	{
		call compile preProcessFile "\iniDB\init.sqf";
	};
	
	// Persistent database system: initialize or load parameters
	// Contains check for mission parameters to know if to actually load or not from the database
	// Must be run always, unregarding the mission parameters
	// Must also be run very early, or some scripts may not have some variables ready
	execVM "persistent\loadStartParameters.sqf";
	
	// Persistent database system: if on, save
	if (persistent_module_on == 1) then
	{
		execVM "persistent\saveParameters.sqf";
		execVM "persistent\saveEnemies.sqf";
		execVM "persistent\saveEnemyVehicles.sqf";
		execVM "persistent\saveMarkers.sqf";
		execVM "persistent\monitor\enemyReinforcementMonitor.sqf";
	};
	
	// The monitor that will adjust campaign parameters based on time
	// It's executed also if the persistent module is off, because it handles the civilian
	// happiness and blufor reputation among them
	execVM "persistent\monitor\campaignParametersMonitor.sqf";
	
	// The eventhandlers for the server to calculate the impact of Blufor and Opfor losses
	// on the campaign
	execVM "persistent\lossesHandlers.sqf";
	
	//	Begin script that protects pilot seats from non-pilot players.
	_handle = [] execVM "Tier1\ObjectSpawn\protectPilotSeats.sqf";
	
	//	Begin script that keeps the base clear of destroyed wrecks.
	_handle = [] execVM "Tier1\MiscScripts\clearVehicleWrecks.sqf";

	//	Start the side missions! (old obsolete method)
	// execVM "CombatPatrolGenerator\sm\startSM.sqf";
	
	//	Tweak AI accuracy and skill.
	[] execVM "Tier1\MiscScripts\set_skills.sqf";
	
	// Dynamic Weather
	// execVM "Tier1\MiscScripts\dynamicWeather.sqf";
	
	// WhiteRaven's simple civilian module
	// if (civ_module_active_in_mission == 1) then 
	{
		execVM "civ\civModuleInit.sqf";
	};
	
	// Create IEDs
	//if (ied_present_in_mission == 1) then 
	//{
	//	execVM "bon_ieds\init.sqf";
	//	};
	
	// Remove enemies from base
	execVM "Tier1\MiscScripts\safeZone.sqf";
	
	// Script to hide Opfor dead bodies, to improve performance 
	// (in CPG, it's executed in the appropriate script, after opfor generation)
	// [] execVM "Tier1\MiscScripts\hideBodies.sqf";
	
};


//	Start the Combat Patrol Generator.
_handle = [] execVM "CombatPatrolGenerator\cpg_init.sqf";
//	Combat Patrol Generator requirement. Initialize onPlayerConnected to start a script that will update/create CPG markers for JIPs.
onPlayerConnected "[_id, _name, _uid] call cpg_fnc_updateJIPMarkers";



//	Client-side scripts.
if (!isdedicated) then {

	//	Add map markers to all player groups.
	[] execVM "Tier1\UnitMarkers\setgroupmarkers.sqf";
	
	//	Disable AI radio chatter.
	player setVariable ["BIS_noCoreConversations", true];
	
	//	Vehicle anti spawn-spam protection.
	_handle = [] execVM "Tier1\ObjectSpawn\spawnDelay.sqf";
	
	//	Firing in base protection.
	_handle = [] execVM "Tier1\MiscScripts\noFireZone.sqf";
	
	//	Aircraft resupply zones.
	_handle = [] execVM "Tier1\MiscScripts\aircraftResupplyZone.sqf";
	
	//	Enable ghost mode and teleport for server admin.
	[player] call compile preprocessFileLineNumbers "Tier1\AdminActions\main.sqf";
	
	//	Initialize ammo drop script.
	[] execVM "Tier1\EjectScript\EP_init_eject.sqf";
	
	// Vehicle Crew Hud and Platoon List
	hud_teamlist = compile preprocessFileLineNumbers ("Tier1\VehicleHud\hud_teamlist.sqf");
	[] spawn hud_teamlist;	
	platoon_teamlist = compile preprocessFileLineNumbers ("Tier1\VehicleHud\hud_platoonlist.sqf");
	[] spawn platoon_teamlist;
	
	// Remove enemy weapons from Blufor players!
	execVM "Tier1\MiscScripts\removeEnemyWeapons.sqf";
	
	//	TAW view distance stuff.
	[] execVM "taw_vd\init.sqf";
	
};


// Scripts for all machines!

// Fast roping system (experimental!)
raven_fast_roping = compile preprocessFileLineNumbers "=BTC=_fast_roping\=BTC=_fast_roping_init.sqf";
[] spawn raven_fast_roping;

//  Instantly removes any kind of bullet/grenade/satchel/mine fired or placed by a player 
//  around 150m from the respawn_west marker
execVM "Tier1\MiscScripts\grenadeStop.sqf";

// Radio channels: must stay here, outside of all conditions
_null = [] execVM "radio\radioChannels.sqf";

//	Initialize ammo drop script.
[] execVM "Tier1\Ammodrop\AD_initAmmoDrop.sqf";
	
// Civilian Intel and Humanitarian Aid actions are added through these scripts
// if (civ_module_active_in_mission == 1) then 
{
	execVM "civ\intelActionGenerate.sqf";
	if (aid_module_active_in_mission == 1) then
	{
		execVM "civ\aidActionGenerate.sqf";
	};
};
	

//	Start TPWCAS.
if !(isNil "tpwcas_enable") then 
{
	if ( tpwcas_enable == 1 ) then
	{
		tpwcas_mode = tpwcas_mode + 2;
		diag_log format ["%1 - starting TPWCAS_A3 with tpwcas_mode [%2]", time, (tpwcas_mode)];
		[tpwcas_mode] execVM "tpwcas\tpwcas_script_init.sqf";
	};

	// enable AI Supression statistics logging (once every 60 seconds)
	if ( (tpwcas_enable == 1) && ( tpwcas_mode == 2 || isServer ) ) then
	{
		waitUntil { !(isNil "bdetect_init_done") };
	
		[] spawn tpwcas_fnc_log_benchmark;
	};
};

//	The hint window, appearing when a player joins the game
//	Better to place it here, so it doesn't stop other scripts (eventually).
//	This is a window that will appear right in front of every player, stopping him
//	from doing anything, forcing him to (hopefully) read these basic rules

if (!isServer) then {
"Welcome to Tier 1 CPG" hintC parseText "Eliminate all enemies on the map and complete side missions.<br/><br/>
Coordinate with the other players and <t color='#0000ff'>teamplay</t>.<br/>
Check which team you are in by pressing J.<br/>
Alone in your team? Maybe there are <t color='#0000ff'>free slots in other teams</t>.<br/><br/>
This is a <t color='#0000ff'>teamplay only</t> server. No playing alone.<br/><br/>
There is <t color='#ff0000'>no 3rd person view</t>.<br/>
There are <t color='#ff0000'>no ammo boxes</t> or custom gear.<br/>
You <t color='#ff2200'>must be on teamspeak to fly helicopters</t>.<br/><br/>
If you press <t color='#ff0000'>G</t> you will throw a <t color='#ff0000'>Grenade</t>.<br/>
Press <t color='#00ff33'>I</t> to check your <t color='#00ff33'>Inventory</t>.<br/><br/>
Open the map and read the markers for help.<br/>";
			};
