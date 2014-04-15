
private["_group_pos"];

// This cpg_variable is defined also here, to avoid "undefined variable" problems at the immediate beginning of the game
cpg_v_cpos_array = [];

// The arrays that contain type and position for ALL enemies on map
_persistent_enemy_array = [];
_persistent_enemy_pos_array = [];

// The arrays that contain type and position for ONE single group at a time
// which will be then inserted into the "enemy" arrays
_persistent_group_array = [];

waitUntil {sleep 5; cpg_finished == 1; };

while { true } do
{
	_persistent_enemy_array = [];
	_persistent_enemy_pos_array = [];
	{
		_persistent_group_array = [];
		
		if ((side _x == east) && (alive (leader _x))) then
		{
			if ((count (units _x)) > 0) then
			{
				{
					// get type of unit
					_unit_type = typeOf _x;
					
					// put unit type in group array
					_persistent_group_array set [count _persistent_group_array, _unit_type];
				} forEach (units _x);
				
				_group_pos = getposATL (leader _x);
			};
		};
		
		if ((count _persistent_group_array) > 0) then
		{
			_persistent_enemy_array set [count _persistent_enemy_array, _persistent_group_array];
			_persistent_enemy_pos_array set [count _persistent_enemy_pos_array, _group_pos];
		};
		
	} forEach allGroups;
	
	["CPG_database", "Campaign_Enemy_Status", "Enemy Array", _persistent_enemy_array]  call iniDB_write;
	["CPG_database", "Campaign_Enemy_Status", "Enemy Position Array", _persistent_enemy_pos_array]  call iniDB_write;
	["CPG_database", "Campaign_Enemy_Status", "Patrol Area Array", cpg_v_cpos_array]  call iniDB_write;
	
	sleep 10;
};