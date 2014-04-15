

//	Wait until a player spawns a vehicle and sends the vehicle object to the server.
//	Then add an eventhandler to that vehicle to only let pilots get in the driver seat.
//	Run this script on the server.

[] spawn {
	while {true} do {
		waituntil{sleep 0.1; !isnil "protair"};
		
		_veh = protair;
		protair = nil;
		
		_veh addEventHandler ["GetIn", {
			_unit = _this select 2;
			
			if ((!((typeOf _unit) in playablePilotTypes)) && (_unit == (driver (vehicle _unit)))) then {
				
				_unit action ["GetOut", vehicle _unit];
				
			};
		}];
	};
};