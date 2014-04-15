
private["_group_pos", "_i", "_array"];

// This cpg_variable is defined also here, to avoid "undefined variable" problems at the immediate beginning of the game
cpg_v_cpos_array = [];

cpg_finished = 0;

// The arrays that contain type and position for ONE single group at a time
// which will be then inserted into the "enemy" arrays
_persistent_group_array = [];

waitUntil {sleep 5; cpg_finished == 1; };

while { true } do
{
	_persistent_enemy_array = [];
	_persistent_enemy_pos_array = [];
	_i = -1;
	{
		_persistent_group_array = [];
		
		if ((side _x == east) && (alive (leader _x)) && ((leader _x) getvariable ["raven_side_mission_group", 0] != 1) ) then
		{
			if ((count (units _x)) > 0) then
			{
				// Loop for every group
				
				{
					// Loop for every unit
					
					// get type of unit
					_unit_type = typeOf _x;
					
					// put unit type in group array
					_persistent_group_array set [count _persistent_group_array, _unit_type];
				} forEach (units _x);
				
				_group_pos = getposATL (leader _x);
				
				_i = _i + 1;
				
				_string = format ["Enemy Group %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string, _persistent_group_array]  call iniDB_write;
				_string2 = format ["Enemy Position %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string2, _group_pos]  call iniDB_write;
				
				_array = (leader _x) getVariable "pers_UPSMON_Array";
				_string3 = format ["Enemy UPSMON Array %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string3, _array]  call iniDB_write;
				
				_array2 = (leader _x) getVariable "pers_UPSMON_Mrk_Pos";
				_string4 = format ["Enemy UPSMON Marker Pos %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string4, _array2]  call iniDB_write;
				
				_array3 = (leader _x) getVariable "pers_UPSMON_Mrk_Size";
				_string5 = format ["Enemy UPSMON Marker Size %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string5, _array3]  call iniDB_write;
			};
		};	
	} forEach allGroups;
	
	["CPG_database", "Campaign_Enemy_Status", "Enemy Group Number", _i]  call iniDB_write;
	["CPG_database", "Campaign_Enemy_Status", "Patrol Area Array", cpg_v_cpos_array]  call iniDB_write;
	["CPG_database", "Campaign_Enemy_Status", "Enemy Watchtowers Number", cpg_watchtower_counter]  call iniDB_write;
	
	sleep 300;
	
};