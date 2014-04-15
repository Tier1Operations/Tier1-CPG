// Spawn the vehicle if player is eliglible

_caller = _this select 1;
	
if ((typeOf _caller) in ["B_engineer_F","B_Soldier_TL_F","B_Soldier_SL_F"]) then {

	if (sdelay > 60) then {
	
		hintSilent format["Please try again in about %1 seconds.", sdelay - 60];
		playsound "warning1";

	} else {

		// Spawn the vehicle
		_veh = "C_Offroad_01_F" createVehicle (getPos spawnV1);
		_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 0.5];
		_veh setDir (getDir spawnV1);
		_veh setVariable ["cargoFull", 0, true];
		publicvariable "_veh";
		[[_veh], 'raven_cargo_offroad_aid', true, true] spawn BIS_fnc_MP;
		sdelay = sdelay + 120;
		playSound "confirm1";

	};
};

} else {

	hintSilent "You cannot spawn a vehicles since you are not FTL or SL!";
	playSound "warning1";
	
};
