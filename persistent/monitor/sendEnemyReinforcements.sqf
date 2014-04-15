


private ["_array", "_array2", "_landpos", "_marker_pos", "_marker_size"]

//	We want to make an "air ambush": the players will roam around the territory, and at a certain point
// they will get near an invisible helipad. This will spring the ambush, creating a helicopter with two
// enemy fireteams inside which will land in a suitable place, unload the infantrymen and attack the ambush position.

// First, we create the invisible helipad and use the waitUntil to detect when the players get near it.

_centerPos = getMarkerPos "cpg_m_center";
_triggerpos = [_centerPos, 0, 5000, 4, 0, 0, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
_dummypad = createVehicle ["Land_HelipadEmpty_F", _triggerpos, [], 0, "CAN_COLLIDE"];
	
waitUntil { ([getPosATL (_dummypad), 10000, true, "count"] call custom_nearestPlayers) > 0 };
	
// Now we find a suitable position where our helicopter will land. We need to find a place which is in plain
// and large enough to let the chopper land without too many problems.
// So we use the BIS_fnc_findSafePos to find the position itself, which then will be checked by
// isFlatEmpty. If it's not big enough for a chopper, the code will run again for another try.
	
_landpos = [0,0,0];
_check = [];
_counter = 0;
_equal = [[], _check] call BIS_fnc_areEqual;

while {_equal} do 
{
	_landpos = [_triggerpos, 0, 5000, 10, 0, 0, 0] call BIS_fnc_findSafePos;
	_check = _landpos isflatempty [ 10, 0, 0.3, 15, 0, false, _dummypad]; 
	_counter = _counter + 1;
	_equal = [[], _check] call BIS_fnc_areEqual;
};

// Safety measure to find a "not too bad" position if you really can't find a "good" one.
		
if (_counter > 498) then 
{
	_landpos = [_triggerpos, 0, 5000, 4, 0, 0, 0] call BIS_fnc_findSafePos;
};
	
/* hint format ["landpos is %1, equal is %2, check is %3", _landpos, _equal, _check];
	
_marker_0 = createMarker ["marker_00", _landpos];
_marker_0 setMarkerText " Land!";
_marker_0 setMarkerType "mil_destroy";
_marker_0 setMarkerColor "ColorRed";
_marker_0 setMarkerBrush "Solid";
_marker_0 setMarkerAlpha 0.8; */
	
// The helipad where the chopper will land
	
_helipad1 = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "CAN_COLLIDE"];
_helipad1 setVectorUp [0,0,1];
	
_chopper1 = createVehicle ["O_Heli_Light_02_unarmed_F", [0, 0], [], 0, "FLY"];
_chopper1 setDir 0;
_chopper1 setVehicleLock "LOCKED";

// Enemies and their waypoints, all commands to make them get out at the right moment and
// let the chopper fly away
	
_group_0 = createGroup east;

  _ai = _group_0 createUnit ["O_helipilot_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
  if (true) then {_group_0 selectLeader _ai;};
  _ai setBehaviour "CARELESS";
  _ai moveindriver _chopper1;
  _ai allowFleeing 0;
  _ai setVariable ["raven_side_mission_group", 1];
  
  
  _group_2 = createGroup east;

  _ai1 = _group_2 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai1 moveincargo _chopper1;

  _ai2 = _group_2 createUnit ["O_Soldier_AR_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai2 moveincargo _chopper1;

  _ai3 = _group_2 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai3 moveincargo _chopper1;
  
  _ai8 = _group_2 createUnit ["O_Soldier_GL_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai8 moveincargo _chopper1;

  
_group_3 = createGroup east;

  _ai4 = _group_3 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai4 moveincargo _chopper1;

  _ai5 = _group_3 createUnit ["O_Soldier_AR_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai5 moveincargo _chopper1;

  _ai6 = _group_3 createUnit ["O_Soldier_GL_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai6 moveincargo _chopper1;

  _ai7 = _group_3 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
  _ai7 moveincargo _chopper1;
 

  _wp1 = _group_0 addWaypoint [[_landpos select 0, _landpos select 1, 0], 0];
  _wp1 setWaypointType "TR UNLOAD";
  _wp1 setWaypointBehaviour "CARELESS";
  _wp1 setWaypointCombatMode "BLUE";
  _wp1 setWaypointStatements ["true", "_chopper1 flyinheight 0; _chopper1 land 'LAND'"];
  
  _wp2 = _group_2 addWaypoint [[_landpos select 0, _landpos select 1, 0], 0];
  _wp2 setWaypointType "GETOUT";

  _wp3 = _group_3 addWaypoint [[_landpos select 0, _landpos select 1, 0], 0];
  _wp3 setWaypointType "GETOUT";
  
  _chopper1 allowFleeing 0;
  _chopper1 flyInHeight 20;
  sleep 15;
  _chopper1 domove [_landpos select 0, _landpos select 1, 0];

while { (_chopper1 distance _helipad1) > 500 } do {sleep 1;};  
  
  _chopper1 flyInHeight 15;
  _chopper1 land "LAND";
  _chopper1 domove [_landpos select 0, _landpos select 1, 0];
  _chopper1 land "LAND";
  
  
while { (getpos _chopper1 select 2) > 1 } do {sleep 1;};  

_ai1 action ["getOut", _chopper1];
unassignVehicle _ai1;
_ai2 action ["getOut", _chopper1];
unassignVehicle _ai2;
_ai3 action ["getOut", _chopper1];
unassignVehicle _ai3;
_ai4 action ["getOut", _chopper1];
unassignVehicle _ai4;
_ai5 action ["getOut", _chopper1];
unassignVehicle _ai5;
_ai6 action ["getOut", _chopper1];
unassignVehicle _ai6;
_ai7 action ["getOut", _chopper1];
unassignVehicle _ai7;
_ai8 action ["getOut", _chopper1];
unassignVehicle _ai8;

sleep 1;

// As soon as the troops get down of the chopper, they get added to UPSMON and start their tasks

_marker_pos = [_landpos, 0, 200, 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _marker_pos];
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

_chance = -1;

while { ((_chance < 0) && (_chance > 4)) } do
{
	_chance = floor(random 5);
};

switch (_chance) do
{
	case 0:
	{
		_array = [leader _group_2, _mrk, "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 1:
	{
		_array = [leader _group_2, _mrk, "reinforcement", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 2:
	{
		_array = [leader _group_2, _mrk, "onroad", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 3:
	{
		_array = [leader _group_2, _mrk, "onroad", "reinforcement", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 4:
	{
		_array = [leader _group_2, _mrk, "fortify", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
};

_array2 = + _array;

// We need to save these variables for the persistent system
// They will be retrieved by the persistent scripts and saved in the database
{
	_array2 set [0, ""];
	_x setVariable ["pers_UPSMON_Mrk_Pos", _marker_pos];
	_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
	_x setVariable ["pers_UPSMON_Array", _array2];
} forEach (units _group_2);


_marker_pos = [_landpos, 0, 200, 4, 0, 1000, 0, cpg_v_blacklist, cpg_v_dpos] call BIS_fnc_findSafePos;
cpg_v_tnr = cpg_v_tnr + 1;
_mrk = createMarkerLocal [format["upsmon_m_tnr%1",cpg_v_tnr], _marker_pos];
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

_chance = -1;

while { ((_chance < 0) && (_chance > 4)) } do
{
	_chance = floor(random 5);
};

switch (_chance) do
{
	case 0:
	{
		_array = [leader _group_3, _mrk, "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 1:
	{
		_array = [leader _group_3, _mrk, "reinforcement", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 2:
	{
		_array = [leader _group_3, _mrk, "onroad", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 3:
	{
		_array = [leader _group_3, _mrk, "onroad", "reinforcement", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
	
	case 4:
	{
		_array = [leader _group_3, _mrk, "fortify", "spawned"];
		_array execVM "scripts\UPSMON.sqf";
	};
};

_array2 = + _array;

// We need to save these variables for the persistent system
// They will be retrieved by the persistent scripts and saved in the database
{
	_array2 set [0, ""];
	_x setVariable ["pers_UPSMON_Mrk_Pos", _marker_pos];
	_x setVariable ["pers_UPSMON_Mrk_Size", _marker_size];
	_x setVariable ["pers_UPSMON_Array", _array2];
} forEach (units _group_2);




if ((random 100) < 20) then
{
	nul = [_landpos, 100, _group_2, 0] call cpg_fnc_spawnVehicles;
};



  
sleep 1;

_chopper1 flyinheight 30;

_ai = _group_0 addWaypoint [[0, 0, 0], 0];
_ai setWaypointType "MOVE";
_ai setWaypointStatements ["true", "deletevehicle _chopper1"];
	
	
	
	
	
	