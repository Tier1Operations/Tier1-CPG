
private ["_k"];

//	This loop allows the script to run multiple times to create multiple patrol areas.
//	Amount of patrol areas depends on what is set in the mission parameters.
//	Note that the variable _k keeps count of how many patrol areas have been created.
for [{_k = 1}, {_k <= cpg_v_zones}, {_k = _k + 1}] do {


	// Counter of the number of enemies created so far
	cpg_v_enemynr = 0;

	_campaign_blacklist_mult = campaign_balance;
	if (campaign_balance > 0) then
	{
		_campaign_blacklist_mult = _campaign_blacklist_mult * 4;
	};

	//	Create blacklist zone around player starting position.
	if (_k < 2) then {
		_blc1 = [((getmarkerpos "cpg_m_startloc") select 0) - 1000 - (_campaign_blacklist_mult * 500), ((getmarkerpos "cpg_m_startloc") select 1) + 1000 + (_campaign_blacklist_mult * 1000), 0];
		_blc2 = [((getmarkerpos "cpg_m_startloc") select 0) + 1000 + (_campaign_blacklist_mult * 500), ((getmarkerpos "cpg_m_startloc") select 1) - 1000 - (_campaign_blacklist_mult * 1000), 0];
		cpg_v_blacklist set [count cpg_v_blacklist, [_blc1,_blc2]];
	};

	_campaign_blacklist_mult = campaign_balance;
	if (campaign_balance > 0) then
	{
		_campaign_blacklist_mult = 0;
	};


	//	The following finds a random position on the island that isn't inside the blacklisted zones.
	
	_campaign_blacklist_mult = campaign_balance;
	
	sleep (2 + (floor(random 5)));
	cpg_v_cpos = [(getMarkerPos "cpg_m_center"), 10, 20000 , 3, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	cpg_v_cpos_array set [count cpg_v_cpos_array, cpg_v_cpos];



	//	Create a marker on the patrol area center position
	//	if the corresponging mission parameter is set to on
	
	if (cpg_show_patrol_mrk == 1) then
	{
		cpg_v_inr = cpg_v_inr + 1;
		_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], cpg_v_cpos];
		_mrk setMarkerType "mil_objective";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorBlue";
		_mrk setMarkerText " Patrol the area";
		_mrk setMarkerPos cpg_v_cpos;
	};
	
	

	sleep 1;


	while {cpg_v_enemynr <= cpg_v_nr} do 
	{
		if (cpg_vehicle_madness == 0) then
		{
			nul = [] call cpg_fnc_chooseTactic;
		} else
		{
			nul = [] call cpg_fnc_chooseTactic_VehicleMadness;
		};
		sleep 2;
	};
	
	

}; //	End of patrol area creation loop. It will now go back to the start of the loop, near the top of the file.


