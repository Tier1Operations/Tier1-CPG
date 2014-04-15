
// This script is run ONLY by the server

// These are the global variables used for the intel system
// They are already loaded as a failsafe measure, to initialize already all useful variables
// so we'll never get 'undefined variable' errors
// We also publish the parameters people need to execute local scripts

campaign_balance = (((paramsarray select 24) / 100) - 1);
civ_reputation = (((paramsarray select 25) / 100) - 1);
civ_happiness = (((paramsarray select 27) / 100) - 1);
intelmarker = 0;
aidmarker = 0;
intelgiven = [];
aidgiven = [];
publicVariable "intelmarker";
publicVariable "intelgiven";
publicVariable "aidmarker";
publicVariable "aidgiven";

// If we want to use persistent module, we check if we want to load from database
// If so, load parameters. If the database still doesn't exist, use the mission parameters to start
if (persistent_module_on == 1) then
{
	if (persistent_reset == 0) then
	{
		if ("CPG_database" call iniDB_exists) then
		{
			campaign_balance = ["CPG_database", "Campaign_Parameters", "Campaign_Balance", "NUMBER"] call iniDB_read;
			civ_reputation = ["CPG_database", "Civilian_Parameters", "Blufor_Reputation", "NUMBER"] call iniDB_read;
			civ_happiness = ["CPG_database", "Civilian_Parameters", "Happiness", "NUMBER"] call iniDB_read;

		} else
		{
			campaign_balance = (((paramsarray select 24) / 100) - 1);
			civ_reputation = (((paramsarray select 25) / 100) - 1);
			civ_happiness = (((paramsarray select 27) / 100) - 1);
		};
	};
	
	// If the reset parameter is on, override everything and save new parameters in database
	if (persistent_reset == 1) then
	{
		campaign_balance = (((paramsarray select 24) / 100) - 1);
		civ_reputation = (((paramsarray select 25) / 100) - 1);
		civ_happiness = (((paramsarray select 27) / 100) - 1);
		["CPG_database", "Campaign_Parameters", "Campaign_Balance", campaign_balance]  call iniDB_write;
		["CPG_database", "Civilian_Parameters", "Happiness", civ_happiness]  call iniDB_write;
		["CPG_database", "Civilian_Parameters", "Blufor_Reputation", civ_reputation] call iniDB_write;
	};
};


publicvariable "civ_reputation";
sleep 1;
publicvariable "civ_happiness";
sleep 1;
publicvariable "campaign_balance";
sleep 1;

// hint format ["Reputation: %1\nHappiness: %2\nCampaign: %3", civ_reputation, civ_happiness, campaign_balance];

// Now we want to load any user-defined markers, but only in the case we're loading a previous session

if (persistent_module_on == 1) then
{
	if (persistent_load == 1) then
	{
		_number = ["CPG_database", "Player Markers", "Player Markers Number", "NUMBER"] call iniDB_read;
		for "_i" from 0 to (_number - 1) do
		{
			_string = format ["Player Marker %1", _i];
			_marker_name = ["CPG_database", "Player Markers", _string, "STRING"]  call iniDB_read;
			
			_string2 = format ["Player Marker Type %1", _i];
			_marker_type = ["CPG_database", "Player Markers", _string2, "STRING"]  call iniDB_read;
			
			_string3 = format ["Player Marker Text %1", _i];
			_marker_text = ["CPG_database", "Player Markers", _string3, "STRING"]  call iniDB_read;
			
			_string4 = format ["Player Marker Pos %1", _i];
			_marker_pos = ["CPG_database", "Player Markers", _string4, "ARRAY"]  call iniDB_read;
			
			_mrk = createMarker [_marker_name, _marker_pos];
			_mrk setMarkerType _marker_type;
			_mrk setMarkerText _marker_text;
			_mrk setMarkerPos _marker_pos;
		};
	};
};





