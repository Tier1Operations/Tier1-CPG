
private ["_i", "_type", "_pos"];

cpg_finished = 0;

// _enemy_vehicles = [];

waitUntil {sleep 5; cpg_finished == 1; };

while { true } do
{
	_vehicles = vehicles;
	_i = 0;
	{
		_type = typeof _x;
		if ((_type == "O_MRAP_02_F" ) || (_type == "O_MRAP_02_hmg_F" ) || (_type == "O_MRAP_02_gmg_F" ) 
		|| (_type == "O_Truck_02_transport_F" ) || (_type == "O_Truck_02_covered_F" ) || (_type == "O_APC_Wheeled_02_rcws_F" )) then
		{
			if (_x getvariable ["raven_side_mission_group", 0] != 1) then
			{
				_pos = getposATL _x;
				
				_string = format ["Enemy Vehicle %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string, _type] call iniDB_write;
				_string2 = format ["Enemy Vehicle Pos %1", _i];
				["CPG_database", "Campaign_Enemy_Status", _string2, _pos] call iniDB_write;
				
				_i = _i + 1;
			};			
		};
	} forEach _vehicles;
	
	["CPG_database", "Campaign_Enemy_Status", "Enemy Vehicle Number", _i]  call iniDB_write;

	sleep 300;
};
