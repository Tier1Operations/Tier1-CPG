
//	Already declare variables, so we won't have trouble with their scope :)
private ["_pos", "_pos2", "_pos3", "_pos4", "_array", "_array2", "_marker_size"];

_vehicles = ["O_MRAP_02_F", "O_MRAP_02_F", "O_MRAP_02_F", "O_Truck_02_transport_F", "O_Truck_02_covered_F", "O_MRAP_02_hmg_F", "O_MRAP_02_hmg_F", "O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"];

//	Chance to mark an enemy position on the map. Chosen in mission parameters.
_mark = cpg_intel_mrk_prob;

//	Pick randomly one of the following enemy types.
_chance = floor(random 11);
_vehicle_prob = cpg_vehicle_prob_mult;

_array2 = [];

switch (_chance) do 
{

	case 0:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Enemy foot patrol
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_pos = [cpg_v_cpos, 0, (1200*cpg_mult), 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], cpg_v_cpos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		if ((random 100) < 75) then
		{
			_marker_size = [100, 100];
			_mrk setMarkerSizeLocal _marker_size;
		} else
		{
			_marker_size = [200, 200];
			_mrk setMarkerSizeLocal _marker_size;
		};
		_type = [0] call cpg_fnc_chooseEnemy;
		_grp = [cpg_v_cpos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
		cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
		
		if ((random 100) < 50) then
		{
			if ((random 100) < 75) then 
			{
				_array = [leader _grp, _mrk, "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			} else 
			{
				_array = [leader _grp, _mrk, "reinforcement", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			};
		} else
		{
			if ((random 100) < 75) then 
			{
				_array = [leader _grp, _mrk, "onroad", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			} else 
			{
				_array = [leader _grp, _mrk, "onroad", "reinforcement", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			};
		};

		_array2 = + _array;
		
		
		// We need to save these variables for the persistent system
		// They will be retrieved by the persistent scripts and saved in the database
		{
			_array2 set [0, ""];
			_x setVariable ["pers_UPSMON_Mrk_Pos", cpg_v_cpos];
			_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
			_x setVariable ["pers_UPSMON_Array", _array2];
		} forEach (units _grp);
		
	
		if (_mark != 0) then
		{
			if (floor(random 100) < _mark) then 
			{
				if ((random 100) < 50) then 
				{
					_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_inr = cpg_v_inr + 1;
					_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
					_mrk setMarkerType "o_inf";
					_mrk setMarkerAlpha 0.8;
					_mrk setMarkerColor "ColorRed";
					_mrk setMarkerSize [1, 1];
					_mrk setMarkerPos _pos2;
				} else 
				{
					_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_inr = cpg_v_inr + 1;
					_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
					_mrk setMarkerType "o_unknown";
					_mrk setMarkerAlpha 0.8;
					_mrk setMarkerColor "ColorRed";
					_mrk setMarkerSize [1, 1];
					_mrk setMarkerPos _pos2;
				};
			};
		};
	};
	
	case 1:
	{
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Enemy motorized patrol
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if ((random 100) < (100 * _vehicle_prob)) then
		{
			_pos = [cpg_v_cpos, 0, (1000*cpg_mult), 3, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
			cpg_v_tnr = cpg_v_tnr + 1;
			_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
			_mrk setMarkerAlphaLocal 0;
			_mrk setMarkerShapeLocal "RECTANGLE";
			if ((random 100) < 50) then
			{
				_marker_size = [200, 200];
				_mrk setMarkerSizeLocal _marker_size;
			} else
			{
				_marker_size = [700, 700];
				_mrk setMarkerSizeLocal _marker_size;
			};
			_type = [0] call cpg_fnc_chooseEnemy;
			_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [6,0.5], (random 360)] call BIS_fnc_spawnGroup;
			cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
			
			nul = [_pos, 100, _grp, 0] call cpg_fnc_spawnVehicles;
			
			if ((random 100) < 50) then
			{
				if ((random 100) < 25) then 
				{
					_array = [leader _grp, _mrk, "spawned"];
					_array execVM "scripts\UPSMON.sqf";
				} else 
				{
					_array = [leader _grp, _mrk, "reinforcement", "spawned"];
					_array execVM "scripts\UPSMON.sqf";
				};
			} else
			{
				if ((random 100) < 25) then 
				{
					_array = [leader _grp, _mrk, "onroad", "spawned"];
					_array execVM "scripts\UPSMON.sqf";
				} else 
				{
					_array = [leader _grp, _mrk, "onroad", "reinforcement", "spawned"];
					_array execVM "scripts\UPSMON.sqf";
				};
			};
			
			_array2 = + _array;
			
			{
				_array2 set [0, ""];
				_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
				_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
				_x setVariable ["pers_UPSMON_Array", _array2];
			} forEach (units _grp);
			
			if (_mark != 0) then 
			{
				if (floor(random 100) < _mark) then 
				{
					if ((random 100) < 50) then 
					{
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_motor_inf";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					} else 
					{
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_unknown";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					};
				};
			};
		};
	};
	
	case 2:
	{
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Fortified enemies.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_pos = [cpg_v_cpos, 100, (1200*cpg_mult), 3, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		if ((random 100) < 50) then
		{
			_marker_size = [50, 50];
			_mrk setMarkerSizeLocal _marker_size;
		} else
		{
			_marker_size = [100, 100];
			_mrk setMarkerSizeLocal _marker_size;
		};
		_type = [0] call cpg_fnc_chooseEnemy;
		_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
		cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
		
		if ((random 100) < 50) then 
		{
			nul = [_pos, 100, _grp, 0] call cpg_fnc_spawnVehicles;
		};
		
		_array = [leader _grp, _mrk, "nofollow", "fortify", "noveh", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
		
		_array2 = + _array;
		
		{
			_array2 set [0, ""];
			_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
			_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
			_x setVariable ["pers_UPSMON_Array", _array2];
		} forEach (units _grp);
		
		if (_mark != 0) then 
		{
			if (floor(random 100) < _mark) then 
			{
				if ((random 100) < 50) then 
				{
					_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_inr = cpg_v_inr + 1;
					_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
					_mrk setMarkerType "o_inf";
					_mrk setMarkerAlpha 0.8;
					_mrk setMarkerColor "ColorRed";
					_mrk setMarkerSize [1, 1];
					_mrk setMarkerPos _pos2;
				} else 
				{
					_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_inr = cpg_v_inr + 1;
					_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
					_mrk setMarkerType "o_unknown";
					_mrk setMarkerAlpha 0.8;
					_mrk setMarkerColor "ColorRed";
					_mrk setMarkerSize [1, 1];
					_mrk setMarkerPos _pos2;
				};
			};
		};
	};
	
	case 3:
	{
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Fortified enemies inside nearby buildings.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//	Find the 3 closest areas with buildings that can be garrisoned by enemies. Later in this script, those areas will be fortified by enemies.
		_forts = [] call cpg_fnc_findClosestFort;
		
		{
			// If the area has many buildings, spawn a bit more enemies.
			if ((_x == "cpg_m_fort1") or (_x == "cpg_m_fort8") or (_x == "cpg_m_fort9") or (_x == "cpg_m_fort10") 
					or (_x == "cpg_m_fort19") or (_x == "cpg_m_fort21") or (_x == "cpg_m_fort23") or (_x == "cpg_m_fort26")) then 
			{
			
				for [{_y = 1}, {(_y <= 2) and (cpg_v_enemynr <= cpg_v_nr)}, {_y = _y + 1}] do 
				{
					_pos = [(getMarkerPos _x), 25, 150, 3, 0, 1000, 0, [], cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_tnr = cpg_v_tnr + 1;
					_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
					_mrk setMarkerAlphaLocal 0;
					_mrk setMarkerShapeLocal "RECTANGLE";
					if ((random 100) < 50) then
					{
						_marker_size = [50, 50];
						_mrk setMarkerSizeLocal _marker_size;
					} else
					{
						_marker_size = [100, 100];
						_mrk setMarkerSizeLocal _marker_size;
					};
					_type = [0] call cpg_fnc_chooseEnemy;
					_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.3], (random 360)] call BIS_fnc_spawnGroup;
					if ((random 100) < 50) then
					{
						nul = [_pos, 100, _grp, 0] call cpg_fnc_spawnVehicles;
					};
					cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
					_array = [leader _grp, _mrk, "nofollow", "fortify", "noveh", "spawned"];
					_array execVM "scripts\UPSMON.sqf";
					
					_array2 = + _array;
					
					{
						_array2 set [0, ""];
						_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
						_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
						_x setVariable ["pers_UPSMON_Array", _array2];
					} forEach (units _grp);
				};
				
			} else 
			{
				_pos = [(getMarkerPos _x), 10, 75, 3, 0, 1000, 0, [], cpg_v_dpos] call BIS_fnc_findSafePos;
				cpg_v_tnr = cpg_v_tnr + 1;
				_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
				_mrk setMarkerAlphaLocal 0;
				_mrk setMarkerShapeLocal "RECTANGLE";
				if ((random 100) < 50) then
				{
					_marker_size = [50, 50];
					_mrk setMarkerSizeLocal _marker_size;
				} else
				{
					_marker_size = [100, 100];
					_mrk setMarkerSizeLocal _marker_size;
				};
				_type = [0] call cpg_fnc_chooseEnemy;
				_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
				if ((random 100) < 50) then
				{
					nul = [_pos, 100, _grp, 0] call cpg_fnc_spawnVehicles;
				};
				cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
				
				_array = [leader _grp, _mrk, "nofollow", "fortify", "noveh", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
				
				_array2 = + _array;
				
				{
					_array2 set [0, ""];
					_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
					_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
					_x setVariable ["pers_UPSMON_Array", _array2];
				} forEach (units _grp);
			};
			
			if (_mark != 0) then 
			{
				if (floor(random 100) < _mark) then 
				{
					if ((random 100) < 50) then 
					{
						_pos2 = [_pos, 10, 150, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_inf";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					} else 
					{
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_unknown";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					};
				};
			};
			
		} foreach _forts;
		
	};
	
	case 4:
	{
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Uncommon) Enemy ATV patrols.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if (floor(random 100) < 50) then 
		{
			_pos = [cpg_v_cpos, 0, (1200*cpg_mult), 7, 0, 0.5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
			cpg_v_tnr = cpg_v_tnr + 1;
			_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
			_mrk setMarkerAlphaLocal 0;
			_mrk setMarkerShapeLocal "RECTANGLE";
			if ((random 100) < 50) then
			{
				_marker_size = [500, 500];
				_mrk setMarkerSizeLocal _marker_size;
			} else
			{
				_marker_size = [1000, 1000];
				_mrk setMarkerSizeLocal _marker_size;
			};
			_type = [0] call cpg_fnc_chooseEnemy;
			_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.5,0.8], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
			cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
			nul = [_pos, 100, _grp, 1] call cpg_fnc_spawnVehicles;
			
			if ((random 100) < 25) then 
			{
				_array = [leader _grp, _mrk, "spawned"];
				_array execVM "scripts\UPSMON.sqf"; 
			} else 
			{
				_array = [leader _grp, _mrk, "reinforcement", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			};
			
			_array2 = + _array;
			
			{
				_array2 set [0, ""];
				_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
				_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
				_x setVariable ["pers_UPSMON_Array", _array2];
			} forEach (units _grp);
				
			if (_mark != 0) then 
			{
				if (floor(random 100) < _mark) then {
					if ((random 100) < 50) then {
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_inf";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
						} else {
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_unknown";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					};
				};
			};
		};
	};
	
	case 5:
	{
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Special) Mines / ambush point
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Chance to spawn a minefield on a road further away from the patrol marker. This minefield marks the ambush point.
		if (floor(random 100) < 20) then {
			
			_ambush = [];
			_roads = [];
			_tmpnr = 0;
			
			while {((count _roads) < 1) and (_tmpnr < 100)} do {
				_ambush = [cpg_v_cpos, 800, 1500, 5, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_roads = _ambush nearRoads 300;
				_tmpnr = _tmpnr + 1;
			};
			
			_pos = position (_roads call BIS_fnc_selectRandom);
			
			for "_x" from 1 to 10 do {
				_pos2 = [_pos, 0, 5, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_mine = createMine ["APERSBoundingMine", _pos2, [], 0];
			};

			
			// Chance to spawn a second minefield on the road closeby.
			if (floor(random 100) < 50) then {
			
				_roads = [];
				_tmpnr = 0;
				
				while {((count _roads) < 1) and (_tmpnr < 50)} do {
					_pos = [_ambush, 75, 125, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					_roads = _pos nearRoads 110;
					_tmpnr = _tmpnr + 1;
				};
				
				_pos = position (_roads call BIS_fnc_selectRandom);
				
				for "_x" from 1 to 10 do {
					_pos2 = [_pos, 0, 5, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					_mine = createMine ["APERSBoundingMine", _pos2, [], 0];
				};
			};
			
			
			// Chance to spawn a third minefield on the road closeby.
			if (floor(random 100) < 50) then {
			
				_roads = [];
				_tmpnr = 0;
				
				while {((count _roads) < 1) and (_tmpnr < 50)} do {
					_pos = [_ambush, 75, 125, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					_roads = _pos nearRoads 110;
					_tmpnr = _tmpnr + 1;
				};
				
				_pos = position (_roads call BIS_fnc_selectRandom);
				
				for "_x" from 1 to 10 do {
					_pos2 = [_pos, 0, 5, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					_mine = createMine ["APERSBoundingMine", _pos2, [], 0];
				};
			};
			
			
			// Chance to spawn an ambush squad nearby.
			if (floor(random 100) < 90) then 
			{
				_pos = [_ambush, 250, 25, 20] call BIS_fnc_findOverwatch;
				
				_pos2 = [_pos, 0, 15, 2, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				cpg_v_tnr = cpg_v_tnr + 1;
				_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos2];
				_mrk setMarkerAlphaLocal 0;
				_mrk setMarkerShapeLocal "RECTANGLE";
				if ((random 100) < 50) then
				{
					_marker_size = [50, 50];
					_mrk setMarkerSizeLocal _marker_size;
				} else
				{
					_marker_size = [100, 100];
					_mrk setMarkerSizeLocal _marker_size;
				};
				_type = [0] call cpg_fnc_chooseEnemy;
				_dir = [_pos2, _ambush] call BIS_fnc_dirTo;
				_grp = [_pos2, east, _type, [], [], [0.45,0.9], [0.4,1], [4,0.5], _dir] call BIS_fnc_spawnGroup;
				cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
				
				_array = [leader _grp, _mrk, "ambush2", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
		
				_array2 = + _array;
		
				{
					_array2 set [0, ""];
					_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
					_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
					_x setVariable ["pers_UPSMON_Array", _array2];
				} forEach (units _grp);
			};
		};
	};

	case 6:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Enemy patrol and watchtower
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_pos = [cpg_v_cpos, 0, (1200*cpg_mult), 4, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		_tower = createVehicle ["Land_Cargo_Patrol_V1_F", _pos, [], 0, "CAN_COLLIDE"];
		_tower setvectorup [0,0,1];
		_group_0 = createGroup east;
		_ai = _group_0 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
		_ai setpos (_tower buildingpos 1);
		_ai setVariable ["raven_side_mission_group", 1];
		_group_1 = createGroup east;
		_ai = _group_1 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
		_ai setpos (_tower buildingpos 0);
		_ai setVariable ["raven_side_mission_group", 1];
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		if ((random 100) < 50) then
		{
			_marker_size = [50, 50];
			_mrk setMarkerSizeLocal _marker_size;
		} else
		{
			_marker_size = [100, 100];
			_mrk setMarkerSizeLocal _marker_size;
		};
		_type = [0] call cpg_fnc_chooseEnemy;
		_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
		cpg_v_enemynr = cpg_v_enemynr + (count units _grp) + 2;
		
		_array = [leader _grp, _mrk, "spawned"];
		_array execVM "scripts\UPSMON.sqf";
		
		_array2 = + _array;
		
		{
			_array2 set [0, ""];
			_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
			_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
			_x setVariable ["pers_UPSMON_Array", _array2];
		} forEach (units _grp);
		
		if (persistent_module_on == 1) then
		{
			_string = format ["Enemy Watchtower Pos %1", cpg_watchtower_counter];
			["CPG_database", "Campaign_Enemy_Status", _string, _pos]  call iniDB_write;
			cpg_watchtower_counter = cpg_watchtower_counter + 1;
		};
		
		if (_mark != 0) then {
			if (floor(random 100) < _mark) then {
				if ((random 100) < 50) then {
					_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_inr = cpg_v_inr + 1;
					_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
					_mrk setMarkerType "o_inf";
					_mrk setMarkerAlpha 0.8;
					_mrk setMarkerColor "ColorRed";
					_mrk setMarkerSize [1, 1];
					_mrk setMarkerPos _pos2;
					} else {
					_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
					cpg_v_inr = cpg_v_inr + 1;
					_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
					_mrk setMarkerType "o_unknown";
					_mrk setMarkerAlpha 0.8;
					_mrk setMarkerColor "ColorRed";
					_mrk setMarkerSize [1, 1];
					_mrk setMarkerPos _pos2;
				};
			};
		};
	};
	
	case 7:
	{

			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			////
			////	(Special) Enemy sniper-spotter team
			////
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		if ((random 100) < 10) then 
		{
			_pos = [cpg_v_cpos, 0, (1400*cpg_mult), 4, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
			_grp = createGroup east;
			_ai = _grp createUnit ["O_sniper_F", _pos, [], 0, "CAN_COLLIDE"];
			_ai = _grp createUnit ["O_spotter_F", _pos, [], 0, "CAN_COLLIDE"];
			cpg_v_tnr = cpg_v_tnr + 1;
			_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
			_mrk setMarkerAlphaLocal 0;
			_mrk setMarkerShapeLocal "RECTANGLE";
			if ((random 100) < 50) then
			{
				_marker_size = [100, 100];
				_mrk setMarkerSizeLocal _marker_size;
			} else
			{
				_marker_size = [600, 600];
				_mrk setMarkerSizeLocal _marker_size;
			};
			cpg_v_enemynr = cpg_v_enemynr + 2;
			
			if ((random 100) < 50) then 
			{
				_array = [leader _grp, _mrk, "ambush2", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			} else 
			{
				_array = [leader _grp, _mrk, "ambush2", "reinforcement", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			};
			
			_array2 = + _array;
			
			{
				_array2 set [0, ""];
				_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
				_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
				_x setVariable ["pers_UPSMON_Array", _array2];
			} forEach (units _grp);
			
			if (_mark != 0) then 
			{
				if (floor(random 100) < _mark) then 
				{
					if ((random 100) < 50) then 
					{
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_recon";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					} else 
					{
						_pos2 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_unknown";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					};
				};
			};
			
		};
	};
	
	case 8:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Special) Side Mission
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if (cpg_side_missions < cpg_side_missions_max) then
		{
			if ((random 100) < 100) then
			{
				execVM "CombatPatrolGenerator\dsm\choose_dsm.sqf";
			};
		};

	};
	
	case 9:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Special) Enemy mortar team
		////	Mortars are bound to specific scripts that make them less powerful
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if (cpg_enemy_mortars == 1) then
		{
			if ((random 100) < 10) then 
			{
				_pos = [cpg_v_cpos, 0, (1000*cpg_mult), 4, 0, 5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_group_0 = createGroup east;
				_mortar = createVehicle ["O_Mortar_01_F", _pos, [], 0, "CAN_COLLIDE"];
				_gunner = _group_0 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
				_gunner moveInGunner _mortar;
				_mortar setVehicleLock "LOCKED";
				_mortar execVM "mortar\mortar.sqf"; // mortar script to make it less powerful
				_ai = _group_0 createUnit ["O_Soldier_TL_F", _pos, [], 0, "CAN_COLLIDE"];
				_ai = _group_0 createUnit ["O_Soldier_F", _pos, [], 0, "CAN_COLLIDE"];
				_ai = _group_0 createUnit ["O_Soldier_GL_F", _pos, [], 0, "CAN_COLLIDE"];
				cpg_v_tnr = cpg_v_tnr + 1;
				_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
				_mrk setMarkerAlphaLocal 0;
				_mrk setMarkerShapeLocal "RECTANGLE";
				if ((random 100) < 50) then
				{
					_marker_size = [25, 25];
					_mrk setMarkerSizeLocal _marker_size;
				} else
				{
					_marker_size = [50, 50];
					_mrk setMarkerSizeLocal _marker_size;
				};
				cpg_v_enemynr = cpg_v_enemynr + 5;
				if ((random 100) < 50) then
				{
					_array = [leader _group_0, _mrk, "nomove", "spawned"];
					_array execVM "scripts\UPSMON.sqf";
				} else
				{
					_array = [leader _group_0, _mrk, "spawned"];
					_array execVM "scripts\UPSMON.sqf";
				};
				
				_array2 = + _array;
				
				{
					_array2 set [0, ""];
					_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
					_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
					_x setVariable ["pers_UPSMON_Array", _array2];
				} forEach (units _grp);
				
				if (_mark != 0) then 
				{
					if (floor(random 100) < _mark) then 
					{
						_pos2 = [_pos, 10, 200, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos2];
						_mrk setMarkerType "o_mortar";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos2;
					};
				};	
			};
		};
	};
	
	case 10:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Rare) Enemy mechanized section.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if ((random 100) < (35 * _vehicle_prob)) then
		{
			_pos = [cpg_v_cpos, 0, (1200*cpg_mult), 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
			_type = [0] call cpg_fnc_chooseEnemy;
			_grp = [cpg_v_cpos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
			
			_lav1 = createVehicle ["O_APC_Wheeled_02_rcws_F", _pos, [], 0, "CAN_COLLIDE"];
			_ai = _grp createUnit ["O_Soldier_lite_F", _pos, [], 0, "CAN_COLLIDE"];
			_ai assignAsGunner _lav1;
			_ai moveInGunner _lav1;
			_ai = _grp createUnit ["O_Soldier_lite_F", _pos, [], 0, "CAN_COLLIDE"];
			_ai assignAsDriver _lav1;
			_ai moveInDriver _lav1;
			
			if ((random 100) < 30) then
			{
				_pos2 = [_pos, 0, 100, 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
				_ifrit1 = createVehicle ["O_MRAP_02_hmg_F", _pos2, [], 0, "CAN_COLLIDE"];
				_ai = _grp createUnit ["O_Soldier_lite_F", _pos2, [], 0, "CAN_COLLIDE"];
				_ai assignAsGunner _ifrit1;
				_ai moveInGunner _ifrit1;
				_ai = _grp createUnit ["O_Soldier_lite_F", _pos2, [], 0, "CAN_COLLIDE"];
				_ai assignAsDriver _ifrit1;
				_ai moveInDriver _ifrit1;
			};
			
			cpg_v_tnr = cpg_v_tnr + 1;
			_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], cpg_v_cpos];
			_mrk setMarkerAlphaLocal 0;
			_mrk setMarkerShapeLocal "RECTANGLE";
			if ((random 100) < 50) then
			{
				_marker_size = [100, 100];
				_mrk setMarkerSizeLocal _marker_size;
			} else
			{
				_marker_size = [500, 500];
				_mrk setMarkerSizeLocal _marker_size;
			};

			cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
			
			if ((random 100) < 50) then 
			{
				_array = [leader _grp, _mrk, "spawned"];
				_array execVM "scripts\UPSMON.sqf"; 
			} else 
			{
				_array = [leader _grp, _mrk, "reinforcement", "spawned"];
				_array execVM "scripts\UPSMON.sqf";
			};
			
			_array2 = + _array;
			
			{
				_array2 set [0, ""];
				_x setVariable ["pers_UPSMON_Mrk_Pos", _pos];
				_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
				_x setVariable ["pers_UPSMON_Array", _array2];
			} forEach (units _grp);
		
			if (_mark != 0) then 
			{
				if (floor(random 100) < _mark) then 
				{
					if ((random 100) < 75) then 
					{
						_pos3 = [_pos, 10, 20, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos3];
						_mrk setMarkerType "o_mech_inf";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos3;
					} else 
					{
						_pos3 = [_pos, 20, 300, 0, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
						cpg_v_inr = cpg_v_inr + 1;
						_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], _pos3];
						_mrk setMarkerType "o_unknown";
						_mrk setMarkerAlpha 0.8;
						_mrk setMarkerColor "ColorRed";
						_mrk setMarkerSize [1, 1];
						_mrk setMarkerPos _pos3;
					};
				};
			};
		};
	};
	
};
