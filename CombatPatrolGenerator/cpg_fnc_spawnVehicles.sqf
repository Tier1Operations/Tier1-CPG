


//	This script spawns empty Opfor vehicles, depending on how big the group next to it is.
//	The group size, position and chance to spawn is determined by the parameters.
//
//	Parameters:
//	_this select 0: Coordinates - Random position will be chosen nearby the coordinates given.
//	_this select 1: Integer - From 0 to 100. Determines chance to spawn the vehicles. An integer higher than 99 will always result in vehicles getting spawned.
//	_this select 2: group - The script counts how large the group is and spawns enough vehicles for the entire group. The vehicles are assigned to the group.
//	_this select 3: Integer - Vehicle type to spawn. 0 is Ifrit, 1 is ATV.
//
//	Returns: Nothing



_pos = [(_this select 0), 25, 100, 7, 0, 0.4, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_chance = _this select 1;
_grp = _this select 2;
_type = _this select 3;
_size = count units _grp;
_class = " ";


if ((floor(random 100)) < _chance) then {

	switch (_type) do {
		case 0:
		{
			for [{_i = _size}, {_i > 0}, {_i = _i - 4}] do {
				switch (floor(random 10)) do {
					case 0:
						{ _class = "O_MRAP_02_F"; };
					case 1:
						{ _class = "O_MRAP_02_F"; };
					case 2:
						{ _class = "O_MRAP_02_F"; };
					case 3:
						{ _class = "O_Truck_02_transport_F"; };
					case 4:
						{ _class = "O_Truck_02_covered_F"; };
					case 5:
						{ _class = "O_MRAP_02_hmg_F"; };
					case 6:
						{ _class = "O_MRAP_02_hmg_F"; };
					case 7:
						{ _class = "O_MRAP_02_hmg_F"; };
					case 8:
						{ _class = "O_MRAP_02_gmg_F"; };
					case 9:
						{ _class = "O_MRAP_02_hmg_F"; };
					case 10:
						{ _class = "O_MRAP_02_hmg_F"; };
				};
				_pos2 = [_pos, 12, 60, 8, 0, 0.5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_veh = createVehicle [_class, _pos2, [], 0, "NONE"];
				_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 1.5];
				_veh setdir (random 360);
				_grp addVehicle _veh;
				_pos_crew = [_pos2, 4, 20, 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_ai = _grp createUnit ["O_Soldier_lite_F", _pos_crew, [], 0, "NONE"];
				_ai moveindriver _veh;
				_ai assignasdriver _veh;
				_ai setVariable ["raven_side_mission_group", 1];
				_ai = _grp createUnit ["O_Soldier_lite_F", _pos_crew, [], 0, "NONE"];
				_ai moveingunner _veh;
				_ai assignasgunner _veh;
				_ai setVariable ["raven_side_mission_group", 1];
			};
		};
		
		case 1:
		{
			for [{_i = _size}, {_i > 0}, {_i = _i - 2}] do {
				_class = "B_Quadbike_01_F";
				_pos2 = [_pos, 12, 60, 8, 0, 0.5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_veh = createVehicle [_class, _pos2, [], 0, "NONE"];
				_veh setpos [(getpos _veh) select 0, (getpos _veh) select 1, ((getpos _veh) select 2) + 1.5];
				_veh setdir (random 360);
				_grp addVehicle _veh;
			};
		};
	};
};