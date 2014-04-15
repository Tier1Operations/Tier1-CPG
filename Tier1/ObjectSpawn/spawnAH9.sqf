// Spawn the vehicle if player is a pilot

_caller = _this select 1;
	
if (_caller isKindOf "B_Helipilot_F") then {

	// Check if player is allowed to spawn another vehicle.
	if (local (_this select 1)) then {
		if (sdelay > 60) then {
		
			hintSilent format["Please try again in about %1 seconds.", sdelay - 60];
			playsound "warning1";

		} else {

			_pos = [(getPos spawnA1), 0, 30, 13, 0, 1000, 0, [], [(getPos spawnA1),(getPos spawnA1)]] call BIS_fnc_findSafePos;
			_veh = "B_Heli_Light_01_armed_F" createVehicle _pos;
			_veh setDir (getDir spawnA1);
			_veh addeventhandler ["killed", "[3] spawn persistent_bluforkilled"];
			sdelay = sdelay + 120;
			playSound "confirm1";
			
			// Send vehicle to server, so that the server can protect the pilot seat.
			protair = _veh;
			publicvariableserver "protair";
		};
		
	};
	
} else {

	hintSilent "You cannot spawn a helicopter if you are not a pilot!";
	playSound "warning1";
	
};

