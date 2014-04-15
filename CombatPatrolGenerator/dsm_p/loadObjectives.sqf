
private ["_counter", "_side_mission_number"];

_side_mission_number = ["CPG_database", "Side Missions", "Side Missions Number", "NUMBER"]  call iniDB_read;

// hint format ["_side_mission_number: %1", _side_mission_number];

_counter = 0;

for "_i" from 1 to (_side_mission_number) do
{
	sleep 10;
	
	_string = format ["Side Mission Complete %1", _i];
	_complete = ["CPG_database", "Side Missions", _string, "NUMBER"]  call iniDB_read;
	
	// hint format ["_i: %1", _i];
	
	sleep 2;
	
	if (_complete == 0) then
	{
		_string2 = format ["Side Mission Pos %1", _i];
		_pos = ["CPG_database", "Side Missions", _string2, "ARRAY"]  call iniDB_read;
	
		_string3 = format ["Side Mission Type %1", _i];
		_type = ["CPG_database", "Side Missions", _string3, "NUMBER"]  call iniDB_read;
		
		[_pos] execVM format["CombatPatrolGenerator\dsm_p\%1.sqf", _type];
		
		_counter = _counter + 1;
	};
};

cpg_side_missions = _counter;
