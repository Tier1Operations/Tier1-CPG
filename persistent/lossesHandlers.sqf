

while { true } do
{
	{
		if (_x getvariable ["persist_haseventkilled", 0] != 1) then
		{
			if ((side _x == east) && (alive _x)) then
			{
				_x addeventhandler ["killed", "[] spawn persistent_opforkilled"];
				_x setvariable ["persist_haseventkilled", 1];
				_x addeventhandler ["respawn", "(_this select 0) setvariable ['persist_haseventkilled', 1];"];
			};
			if ((side _x == west) && (alive _x)) then
			{
				_x addeventhandler ["killed", "[0] spawn persistent_bluforkilled"];
				_x setvariable ["persist_haseventkilled", 1];
			};
		};
	} forEach allUnits;
	sleep 300;
};

