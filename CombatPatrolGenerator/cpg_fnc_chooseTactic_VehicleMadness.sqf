
//	Already declare variables, so we won't have trouble with their scope :)
private ["_pos", "_pos2", "_pos3", "_pos4"];

//	Chance to mark an enemy position on the map. Chosen in mission parameters.
_mark = paramsarray select 2;

//	Pick randomly one of the following enemy types.
_chance = floor(random 6);
_vehicle_prob = ((paramsarray select 27) / 10);


switch (_chance) do 
{

	case 0:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Enemy patrol around the patrol marker.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_pos = [cpg_v_cpos, 0, (1200*cpg_mult), 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], cpg_v_cpos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		_mrk setMarkerSizeLocal [600, 600];
		_type = [0] call cpg_fnc_chooseEnemy;
		_grp = [cpg_v_cpos, east, _type, [], [], [0.45,0.9], [0.4,1], [2,0.5], (random 360)] call BIS_fnc_spawnGroup;
		cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
		nul = [_pos, 10, _grp, 0] call cpg_fnc_spawnEmptyVehicles;
		
		if ((random 100) < 75) then 
		{
			nul = [leader _grp, _mrk, "spawned"] execVM "scripts\UPSMON.sqf"; 
		} else 
		{
			nul = [leader _grp, _mrk, "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
		};
	
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
		////	(Common) Enemy motorized patrols on surrounding roads.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_pos = [cpg_v_cpos, 0, (1000*cpg_mult), 3, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		_mrk setMarkerSizeLocal [1500, 1500];
		_type = [0] call cpg_fnc_chooseEnemy;
		_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.4,1], [6,0.5], (random 360)] call BIS_fnc_spawnGroup;
		cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
		nul = [_pos, 100, _grp, 0] call cpg_fnc_spawnEmptyVehicles;
		
		if ((random 100) < 25) then 
		{
			nul = [leader _grp, _mrk, "onroad", "spawned"] execVM "scripts\UPSMON.sqf"; 
		} else 
		{
			nul = [leader _grp, _mrk, "onroad", "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
		};
		
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
	
	case 2:
	{
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Common) Enemy combat vehicle patrols
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_pos = [cpg_v_cpos, 0, (600*cpg_mult), 7, 0, 0.5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
		cpg_v_tnr = cpg_v_tnr + 1;
		_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
		_mrk setMarkerAlphaLocal 0;
		_mrk setMarkerShapeLocal "RECTANGLE";
		_mrk setMarkerSizeLocal [1000, 1000];
		_type = [1] call cpg_fnc_chooseEnemy;
		_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.5,0.8], [2,0.7], (random 360)] call BIS_fnc_spawnGroup;
		cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
		
		if ((random 100) < 25) then 
		{
			nul = [leader _grp, _mrk, "spawned"] execVM "scripts\UPSMON.sqf"; 
		} else 
		{
			nul = [leader _grp, _mrk, "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
		};
			
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
		////	(Uncommon) Enemy ATV patrols.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		if (floor(random 100) < 10) then 
		{
			_pos = [cpg_v_cpos, 0, (1200*cpg_mult), 7, 0, 0.5, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
			cpg_v_tnr = cpg_v_tnr + 1;
			_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _pos];
			_mrk setMarkerAlphaLocal 0;
			_mrk setMarkerShapeLocal "RECTANGLE";
			_mrk setMarkerSizeLocal [1500, 1500];
			_type = [0] call cpg_fnc_chooseEnemy;
			_grp = [_pos, east, _type, [], [], [0.45,0.9], [0.5,0.8], [4,0.5], (random 360)] call BIS_fnc_spawnGroup;
			cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
			nul = [_pos, 100, _grp, 1] call cpg_fnc_spawnEmptyVehicles;
			
			if ((random 100) < 25) then 
			{
				nul = [leader _grp, _mrk, "spawned"] execVM "scripts\UPSMON.sqf"; 
			} else 
			{
				nul = [leader _grp, _mrk, "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
			};
				
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
	
	case 4:
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
	
	case 5:
	{

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////
		////	(Rare) Enemy mechanized section.
		////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
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
		_mrk setMarkerSizeLocal [600, 600];

		cpg_v_enemynr = cpg_v_enemynr + (count units _grp);
		
		nul = [leader _grp, _mrk, "spawned"] execVM "scripts\UPSMON.sqf";
		
		if ((random 100) < 50) then 
		{
			nul = [leader _grp, _mrk, "spawned"] execVM "scripts\UPSMON.sqf"; 
		} else 
		{
			nul = [leader _grp, _mrk, "reinforcement", "spawned"] execVM "scripts\UPSMON.sqf";
		};
	
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
