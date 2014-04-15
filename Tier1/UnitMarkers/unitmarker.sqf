
//	This script is run by another one. It should only be run on the clients.

// DECLARE PRIVATE VARIABLES

private ["_unit","_mkrType","_mkrText","_mkrColor","_mkrName","_mkr","_unitName"];

// ====================================================================================

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local variables:

call compile format ["
	_unit = %1;
",_this select 0];

_unitName = _this select 0;
_mkrType = _this select 1;
_mkrText = _this select 2;
_mkrColor = _this select 3;
_mkrName = format ["mkr_%1",_unit];
_first = true;

if (markertype _mkrName != "") then { _first = false; };

while {true} do {

// ====================================================================================

// WAIT FOR GROUP TO EXIST IN-MISSION
// We wait for the group to have members before creating the marker.

if (isNil "_unit") then 
{
	call compile format ["
		waitUntil {sleep 3; count units %1 > 0}; 
		_unit = %1;
		
	",_unitName,_unit];
	_mkrName = format ["mkr_%1",_unit];
};

// ====================================================================================

// EXIT FOR EMPTY GROUPS (PART I)
// If the group is empty, this script exits.

if ((count (units _unit)) == 0) then
	{
	// if (true) exitWith {};
	}
	else
	{

// ====================================================================================

// CREATE MARKER
// Depending on the value of _mkrType a different type of marker is created.

		switch (_mkrType) do
		{
		
		// Add cases for mmg team gunner, mmat team gunner
		
// Platoon HQ
			case 0:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos _unit select 0),(getPos _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_HQ";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Squad  
			case 1:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_HQ";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Fireteam
			case 2:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_INF";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Medium MG
			case 3:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_INF";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Medium AT
			case 4:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_EMPTY";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Heavy AT
			case 5:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_EMPTY";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Sniper Team
			case 6:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_RECON";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Heavy MG
			case 7:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_EMPTY";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
// Armor			
			case 8:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_ARMOR";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};			

		
// Air
			case 9:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_AIR";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};			
			
			case 10:
			{
				if (_first) then {
				_mkr = createMarkerLocal [_mkrName,[(getPos   _unit select 0),(getPos   _unit select 1)]]; };
				_mkr setMarkerShapeLocal "ICON";
				_mkrName setMarkerTypeLocal "B_HQ";
				_mkrName setMarkerColorLocal _mkrColor;
				_mkrName setMarkerSizeLocal [0.8, 0.8];
				_mkrName setMarkerTextLocal _mkrText;
			};
		};		
		
	_first = false;

// ====================================================================================

// UPDATE MARKER POSITION
// As long as certain conditions are met (the unit is alive) the marker 
// position is updated periodically. This only happens locally - so as not to burden 
// the server.

		for [{_i=0}, {_i<=10000}, {_i=_i}] do
		{
			if (!isnull _unit) then 
			{
				_mkrName setMarkerPosLocal [(getPos _unit select 0),(getPos _unit select 1)];
				_mkr setMarkerAlphaLocal 1;
			} else {
				deletemarker _mkr;
				// _mkr setMarkerAlphaLocal 0;
			};
			sleep 6;
		};

// ====================================================================================

// EXIT FOR EMPTY GROUPS (PART II)
// If the group is empty, this script exits.

	};
	
	sleep 10;
	
};

// ====================================================================================

// if (true) exitWith {};

		
