
private ["_aU", "_dU"];
_aU = allUnits;

raven_hideBody = compile preprocessFileLineNumbers "Tier1\MiscScripts\hideBody.sqf";

{if(side _x == east) then {_x addEventHandler ["killed", raven_hideBody]}} forEach allUnits; 

/* while {true} do 
{
	sleep 1;
	if (count _aU != count allUnits) then 
		{
			_dU = _aU - allUnits;
			{
				if ( (side _x) == east ) then { hidebody _x; };
			} foreach _dU;
		};
	_aU = allUnits;
}; */
