


// Check if player is allowed to spawn another vehicle.
if (local (_this select 1)) then {
	if (sdelay > 60) then {
	
		hintSilent format["Please try again in about %1 seconds.", sdelay - 60];
		playsound "warning1";

	} else {

		// Spawn the vehicle
		_veh = "B_Quadbike_01_F" createVehicle (getPos spawnV2);
		_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 0.5];
		_veh setDir (getDir spawnV2);
		sdelay = sdelay + 120;
		playSound "confirm1";

	};
};