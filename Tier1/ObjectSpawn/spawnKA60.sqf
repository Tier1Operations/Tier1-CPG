// Spawn the vehicle if player is a pilot

_caller = _this select 1;
	
if (_caller isKindOf "B_Helipilot_F") then {

	// Check if player is allowed to spawn another vehicle.
	if (local (_this select 1)) then {
		if (sdelay > 60) then {
			
			hintSilent format["Please try again in about %1 seconds.", sdelay - 60];
			playsound "warning1";

		} else {

			_pos = [(getPos spawnA2), 0, 30, 13, 0, 1000, 0, [], [(getPos spawnA2),(getPos spawnA2)]] call BIS_fnc_findSafePos;
			_veh = "O_Heli_Light_02_unarmed_F" createVehicle _pos;
			_veh setDir (getDir spawnA2);
			sdelay = sdelay + 120;
			playSound "confirm1";
			[[_veh], 'raven_fast_roping', true, true] spawn BIS_fnc_MP;
			
			// Send vehicle to server, so that the server can protect the pilot seat.
			protair = _veh;
			publicvariableserver "protair";
		};
	};
	
} else {

	hintSilent "You cannot spawn a helicopter if you are not a pilot!";
	playSound "warning1";
		
};

