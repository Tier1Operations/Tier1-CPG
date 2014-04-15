


//	We want to make an "air ambush": the players will roam around the territory, and at a certain point
// they will get near an invisible helipad. This will spring the ambush, creating a helicopter with two
// enemy fireteams inside which will land in a suitable place, unload the infantrymen and attack the ambush position.

// First, we create the invisible helipad and use the waitUntil to detect when the players get near it.

_centerPos = _this select 0;
_dummypad = createVehicle ["Land_HelipadEmpty_F", _centerPos, [], 0, "CAN_COLLIDE"];

	
waitUntil { ([getPosATL (_dummypad), 8000, true, "count"] call custom_nearestPlayers) > 0 };

// hint format["%1", _centerPos];

sleep (_this select 1);
	
// Now we find a suitable position where our helicopter will land. We need to find a place which is in plain
// and large enough to let the chopper land without too many problems.
// So we use the BIS_fnc_findSafePos to find the position itself, which then will be checked by
// isFlatEmpty. If it's not big enough for a chopper, the code will run again for another try.
	
_landpos = [0,0,0];
_check = [];
_counter = 0;
_equal = [[], _check] call BIS_fnc_areEqual;

while { (_equal) and (_counter < 500) } do 
{
	_landpos = [_centerPos, 300, 800, 4, 0, 0, 0] call BIS_fnc_findSafePos;
	_check = _landpos isflatempty [ 10, 0, 0.3, 15, 0, false, _dummypad]; 
	_counter = _counter + 1;
	_equal = [[], _check] call BIS_fnc_areEqual;
};

// Safety measure to find a "not too bad" position if you really can't find a "good" one.
		
if (_counter > 499) then 
{
	_landpos = [_centerPos, 300, 1000, 4, 0, 0, 0] call BIS_fnc_findSafePos;
};
	
// hint format ["landpos is %1, equal is %2, check is %3", _landpos, _equal, _check];
	
/* _marker_0 = createMarker ["marker_00", _landpos];
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
			_ai setUnitAbility 0.7;
			_ai setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai setskill ["aimingShake",0.6 + random 0.20];
			_ai setskill ["aimingSpeed",0.3 + random 0.10];
			_ai setskill ["Endurance",0.5 + random 0.20];
			_ai setskill ["spotDistance",0.80 + random 0.15];
			_ai setskill ["spotTime",0.65 + random 0.10];
			_ai setskill ["courage",0.7 + random 0.25];
			_ai setskill ["reloadSpeed",0.35 + random 0.20];
			_ai setskill ["general",0.7 + random 0.20];
			_ai setskill ["commanding",0.8 + random 0.15];
  if (true) then {_group_0 selectLeader _ai;};
  _ai setBehaviour "CARELESS";
  _ai moveindriver _chopper1;
  _ai allowFleeing 0;
  
  
  _group_2 = createGroup east;

  _ai1 = _group_2 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai1 setUnitAbility 0.7;
			_ai1 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai1 setskill ["aimingShake",0.6 + random 0.20];
			_ai1 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai1 setskill ["Endurance",0.5 + random 0.20];
			_ai1 setskill ["spotDistance",0.80 + random 0.15];
			_ai1 setskill ["spotTime",0.65 + random 0.10];
			_ai1 setskill ["courage",0.7 + random 0.25];
			_ai1 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai1 setskill ["general",0.7 + random 0.20];
			_ai1 setskill ["commanding",0.8 + random 0.15];
  _ai1 moveincargo _chopper1;

  _ai2 = _group_2 createUnit ["O_Soldier_AR_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai2 setUnitAbility 0.7;
			_ai2 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai2 setskill ["aimingShake",0.6 + random 0.20];
			_ai2 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai2 setskill ["Endurance",0.5 + random 0.20];
			_ai2 setskill ["spotDistance",0.80 + random 0.15];
			_ai2 setskill ["spotTime",0.65 + random 0.10];
			_ai2 setskill ["courage",0.7 + random 0.25];
			_ai2 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai2 setskill ["general",0.7 + random 0.20];
			_ai2 setskill ["commanding",0.8 + random 0.15];
  _ai2 moveincargo _chopper1;

  _ai3 = _group_2 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai3 setUnitAbility 0.7;
			_ai3 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai3 setskill ["aimingShake",0.6 + random 0.20];
			_ai3 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai3 setskill ["Endurance",0.5 + random 0.20];
			_ai3 setskill ["spotDistance",0.80 + random 0.15];
			_ai3 setskill ["spotTime",0.65 + random 0.10];
			_ai3 setskill ["courage",0.7 + random 0.25];
			_ai3 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai3 setskill ["general",0.7 + random 0.20];
			_ai3 setskill ["commanding",0.8 + random 0.15];
  _ai3 moveincargo _chopper1;
  
  _ai8 = _group_2 createUnit ["O_Soldier_GL_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai8 setUnitAbility 0.7;
			_ai8 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai8 setskill ["aimingShake",0.6 + random 0.20];
			_ai8 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai8 setskill ["Endurance",0.5 + random 0.20];
			_ai8 setskill ["spotDistance",0.80 + random 0.15];
			_ai8 setskill ["spotTime",0.65 + random 0.10];
			_ai8 setskill ["courage",0.7 + random 0.25];
			_ai8 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai8 setskill ["general",0.7 + random 0.20];
			_ai8 setskill ["commanding",0.8 + random 0.15];
  _ai8 moveincargo _chopper1;

  
_group_3 = createGroup east;

  _ai4 = _group_3 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai4 setUnitAbility 0.7;
			_ai4 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai4 setskill ["aimingShake",0.6 + random 0.20];
			_ai4 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai4 setskill ["Endurance",0.5 + random 0.20];
			_ai4 setskill ["spotDistance",0.80 + random 0.15];
			_ai4 setskill ["spotTime",0.65 + random 0.10];
			_ai4 setskill ["courage",0.7 + random 0.25];
			_ai4 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai4 setskill ["general",0.7 + random 0.20];
			_ai4 setskill ["commanding",0.8 + random 0.15];
  _ai4 moveincargo _chopper1;

  _ai5 = _group_3 createUnit ["O_Soldier_AR_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai5 setUnitAbility 0.7;
			_ai5 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai5 setskill ["aimingShake",0.6 + random 0.20];
			_ai5 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai5 setskill ["Endurance",0.5 + random 0.20];
			_ai5 setskill ["spotDistance",0.80 + random 0.15];
			_ai5 setskill ["spotTime",0.65 + random 0.10];
			_ai5 setskill ["courage",0.7 + random 0.25];
			_ai5 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai5 setskill ["general",0.7 + random 0.20];
			_ai5 setskill ["commanding",0.8 + random 0.15];
  _ai5 moveincargo _chopper1;

  _ai6 = _group_3 createUnit ["O_Soldier_GL_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai6 setUnitAbility 0.7;
			_ai6 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai6 setskill ["aimingShake",0.6 + random 0.20];
			_ai6 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai6 setskill ["Endurance",0.5 + random 0.20];
			_ai6 setskill ["spotDistance",0.80 + random 0.15];
			_ai6 setskill ["spotTime",0.65 + random 0.10];
			_ai6 setskill ["courage",0.7 + random 0.25];
			_ai6 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai6 setskill ["general",0.7 + random 0.20];
			_ai6 setskill ["commanding",0.8 + random 0.15];
  _ai6 moveincargo _chopper1;

  _ai7 = _group_3 createUnit ["O_Soldier_F", [10, 10, 0], [], 0, "CAN_COLLIDE"];
			_ai7 setUnitAbility 0.7;
			_ai7 setskill ["aimingAccuracy",0.25 + random 0.10];
			_ai7 setskill ["aimingShake",0.6 + random 0.20];
			_ai7 setskill ["aimingSpeed",0.3 + random 0.10];
			_ai7 setskill ["Endurance",0.5 + random 0.20];
			_ai7 setskill ["spotDistance",0.80 + random 0.15];
			_ai7 setskill ["spotTime",0.65 + random 0.10];
			_ai7 setskill ["courage",0.7 + random 0.25];
			_ai7 setskill ["reloadSpeed",0.35 + random 0.20];
			_ai7 setskill ["general",0.7 + random 0.20];
			_ai7 setskill ["commanding",0.8 + random 0.15];
  _ai7 moveincargo _chopper1;
 

  _wp1 = _group_0 addWaypoint [[_landpos select 0, _landpos select 1, 0], 0];
  _wp1 setWaypointType "TR UNLOAD";
  _wp1 setWaypointBehaviour "CARELESS";
  _wp1 setWaypointCombatMode "BLUE";
  _wp1 setWaypointStatements ["true", "_chopper1 flyinheight 0; _chopper1 land 'LAND'"];
  
  _wp2 = _group_2 addWaypoint [[_landpos select 0, _landpos select 1, 0], 0];
  _wp2 setWaypointType "GETOUT";
  // [_group_0, 1] synchronizeWaypoint [[_group_2, 1]];

  _wp3 = _group_3 addWaypoint [[_landpos select 0, _landpos select 1, 0], 0];
  _wp3 setWaypointType "GETOUT";
  // [_group_0, 1] synchronizeWaypoint [[_group_3, 1]];
  
  _chopper1 allowFleeing 0;
  _chopper1 flyInHeight 20;
  sleep 15;
  _chopper1 domove [_landpos select 0, _landpos select 1, 0];

while { (_chopper1 distance _helipad1) > 400 } do {sleep 1;};  
  
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
  
_ai = _group_2 addWaypoint [[_centerpos select 0, _centerpos select 1, 0], 0];
_ai setWaypointType "MOVE";

_ai = _group_3 addWaypoint [[_centerpos select 0, _centerpos select 1, 0], 0];
_ai setWaypointType "MOVE";
  
sleep 1;

_chopper1 flyinheight 30;

_ai = _group_0 addWaypoint [[0, 0, 0], 0];
_ai setWaypointType "MOVE";
_ai setWaypointStatements ["true", "deletevehicle _chopper1"];
	
	
	
	
	
	