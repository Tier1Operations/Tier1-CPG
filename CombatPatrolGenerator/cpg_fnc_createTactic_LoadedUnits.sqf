
//	Already declare variables, so we won't have trouble with their scope :)
private ["_i", "_grp", "_group_0", "_pos", "_pos2", "_pos3", "_pos4", "_type", "_mrk", "_array", "_marker_pos", "_marker_size", "_target"];

//	Chance to mark an enemy position on the map. Chosen in mission parameters.
_mark = paramsarray select 2;

//	Pick randomly one of the following enemy types.
_chance = floor(random 13);

// This retrieves the maximum counter of Enemy Groups (don't need to subtract 1 in the "for" cycle)
enemy_group_number = ["CPG_database", "Campaign_Enemy_Status", "Enemy Group Number", "NUMBER"] call iniDB_read;

for "_i" from 0 to enemy_group_number do
{	

	sleep 1;
	
	_grp = creategroup east;
	
	// Old way of doing things, but then found out that iniDB read function only handles small array
	// God knows why...
	/* _pos = enemy_starting_positions select _i;
	_group_array = (enemy_starting_array select _i)
	_count_units = (count _group_array); */

	_string = format ["Enemy Group %1", _i];
	_group_array = ["CPG_database", "Campaign_Enemy_Status", _string, "ARRAY"]  call iniDB_read;
	_count_units = (count _group_array);
	
	_string2 = format ["Enemy Position %1", _i];
	_pos = ["CPG_database", "Campaign_Enemy_Status", _string2, "ARRAY"]  call iniDB_read;
	
	_string3 = format ["Enemy UPSMON Array %1", _i];
	_array = ["CPG_database", "Campaign_Enemy_Status", _string3, "ARRAY"]  call iniDB_read;
	
	_string4 = format ["Enemy UPSMON Marker Pos %1", _i];
	_marker_pos = ["CPG_database", "Campaign_Enemy_Status", _string4, "ARRAY"]  call iniDB_read;
	
	_string5 = format ["Enemy UPSMON Marker Size %1", _i];
	_marker_size = ["CPG_database", "Campaign_Enemy_Status", _string5, "ARRAY"]  call iniDB_read;
	

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////
	////	(Common) Enemy patrol around their old position.
	////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _marker_pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	_mrk setMarkerSize _marker_size;

	for "_k" from 0 to (_count_units - 1) do
	{
		_pos2 = [_pos, 0, 10, 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		_type = _group_array select _k;
		_ai = _grp createUnit [_type, _pos2, [], 0, "NONE"];
	};
	
	cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
	
	_array set [0, leader _grp];
	_array set [1, _mrk];
	
	_array execVM "scripts\UPSMON.sqf";
	
	_array2 = + _array;
			
	{
		_array2 set [0, ""];
		_x setVariable ["pers_UPSMON_Mrk_Pos", _marker_pos];
		_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
		_x setVariable ["pers_UPSMON_Array", _array2];
	} forEach (units _grp);


	if (_mark != 0) then 
	{
		if (floor(random 100) < _mark) then 
		{
			if ((random 100) < 50) then 
			{
				_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				cpg_v_inr = cpg_v_inr + 1;
				_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
				_mrk setMarkerType "o_inf";
				_mrk setMarkerAlpha 0.8;
				_mrk setMarkerColor "ColorRed";
				_mrk setMarkerSize [1, 1];
				_mrk setMarkerPos _pos2;
			} else 
			{
				_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				cpg_v_inr = cpg_v_inr + 1;
				_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
				_mrk setMarkerType "o_unknown";
				_mrk setMarkerAlpha 0.8;
				_mrk setMarkerColor "ColorRed";
				_mrk setMarkerSize [1, 1];
				_mrk setMarkerPos _pos2;
			};
		};
	};
};
		


// And now we load the vehicles, also giving them a crew

// This retrieves the number of Enemy Vehicles
enemy_vehicle_number = ["CPG_database", "Campaign_Enemy_Status", "Enemy Vehicle Number", "NUMBER"] call iniDB_read;

for "_i" from 0 to (enemy_vehicle_number - 1) do
{	
	sleep 1;
	_string = format ["Enemy Vehicle %1", _i];
	_type = ["CPG_database", "Campaign_Enemy_Status", _string, "STRING"] call iniDB_read;
	_string2 = format ["Enemy Vehicle Pos %1", _i];
	_pos = ["CPG_database", "Campaign_Enemy_Status", _string2, "ARRAY"] call iniDB_read;
	
	cpg_v_tnr = cpg_v_tnr + 1;
	_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
	_mrk setMarkerAlphaLocal 0;
	_mrk setMarkerShapeLocal "RECTANGLE";
	if ((random 100) < 75) then
	{
		_mrk setMarkerSizeLocal [100, 100];
	} else
	{
		_mrk setMarkerSizeLocal [500, 500];
	};

	_vehicle = createVehicle [_type, _pos, [], 0, "NONE"];
	_pos2 = [_pos, 4, 30, 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
	
	_targets = nearestObjects [_pos, ["MAN"], 400];
	_found = 0;
	_counter = 0;
	
	if ((count _targets) > 0) then
	{
		while { ((_found == 0) && (_counter < (count _targets))) } do
		{
			_target = _targets select _counter;
			if ((side _target) == east) then
			{
				_found = 1;
			} else
			{
				_counter = _counter + 1;
			};
		};
		_group_0 = group _target;
	} else
	{
		_group_0 = creategroup east;
	};
	
	_ai = _group_0 createUnit ["O_Soldier_lite_F", _pos2, [], 0, "NONE"];
	_ai moveindriver _vehicle;
	_ai assignasdriver _vehicle;
	_ai setVariable ["raven_side_mission_group", 1];
	_ai = _group_0 createUnit ["O_Soldier_lite_F", _pos2, [], 0, "NONE"];
	_ai moveingunner _vehicle;
	_ai assignasgunner _vehicle;
	_ai setVariable ["raven_side_mission_group", 1];

	
	if ((random 100) < 50) then 
	{
		if ((random 100) < 50) then 
		{
			nul = [leader _group_0, _mrk, "spawned"] execVM "scripts\UPSMON.sqf"; 
		} else 
		{
			nul = [leader _group_0, _mrk, "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
		};
	} else
	{
		if ((random 100) < 50) then 
		{
			nul = [leader _group_0, _mrk, "onroad", "spawned"] execVM "scripts\UPSMON.sqf"; 
		} else 
		{
			nul = [leader _group_0, _mrk, "onroad", "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
		};
	};
	
	if (_mark != 0) then 
	{
		if (floor(random 100) < _mark) then 
		{
			if ((random 100) < 50) then 
			{
				_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				cpg_v_inr = cpg_v_inr + 1;
				_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
				
				if (_type == "O_APC_Wheeled_02_rcws_F") then
				{
					_mrk setMarkerType "o_mech_inf";
				} else
				{
					_mrk setMarkerType "o_motor_inf";
				};
				_mrk setMarkerAlpha 0.8;
				_mrk setMarkerColor "ColorRed";
				_mrk setMarkerSize [1, 1];
				_mrk setMarkerPos _pos2;
			} else {
				_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				cpg_v_inr = cpg_v_inr + 1;
				_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
				_mrk setMarkerType "o_unknown";
				_mrk setMarkerAlpha 0.8;
				_mrk setMarkerColor "ColorRed";
				_mrk setMarkerSize [1, 1];
				_mrk setMarkerPos _pos2;
			};
		};
	};
	
};


// Now we load watchtowers, manning them with two enemy soldiers

// The actual number of enemy watchtowers, will need to subtract 1 in the "for" cycle
cpg_watchtower_counter = ["CPG_database", "Campaign_Enemy_Status", "Enemy Watchtowers Number", "NUMBER"] call iniDB_read;

for "_i" from 0 to (cpg_watchtower_counter - 1) do
{	
	
	_string = format ["Enemy Watchtower Pos %1", _i];
	_pos = ["CPG_database", "Campaign_Enemy_Status", _string, "ARRAY"] call iniDB_read;
	
	_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _pos, [], 0, "CAN_COLLIDE"];
	_tower setvectorup [0,0,1];
	_group_0 = createGroup east;
	_ai = _group_0 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 1);
	_ai setVariable ["raven_side_mission_group", 1];
	_group_1 = createGroup east;
	_ai = _group_1 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
	_ai setpos (_tower buildingpos 0);
	_ai setVariable ["raven_side_mission_group", 1];
	
};