// Spawn the vehicle if player is a crewman

_caller = _this select 1;
	
if (_caller isKindOf "B_engineer_F") then {

		if (sdelay > 60) then {
		
			hintSilent format["Please try again in about %1 seconds.", sdelay - 60];
			playsound "warning1";

		} else {

		// Spawn the vehicle
		_veh = "B_MBT_01_cannon_F" createVehicle (getPos spawnV1);
		_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 0.5];
		_veh setDir (getDir spawnV1);
		_veh addeventhandler ["killed", "[3] spawn persistent_bluforkilled"];
		sdelay = sdelay + 120;
		playSound "confirm1";
			

		};
		
	};
	
} else {

	hintSilent "You cannot spawn a Tank if you are not tank crew!";
	playSound "warning1";
	
};
