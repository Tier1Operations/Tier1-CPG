
_targettown = town_logics call BIS_fnc_selectRandom;
_targetpos1 = getposATL _targettown;

_targetpos = [(_targetpos1 select 0) - 100 + (random 200), (_targetpos1 select 1) - 100 + (random 200), _targetpos1 select 2];

switch (floor(random 3)) do 
{
	case 0:
		{ 
			// [_targetpos] execVM "civ\aid\aidBricks.sqf";
			[[[_targetpos], "civ\aid\aidBricks.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
		};
	case 1:
		{ 
			// [_targetpos] execVM "civ\aid\aidWater.sqf";
			[[[_targetpos], "civ\aid\aidWater.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
		};
	case 2:
		{ 
			// [_targetpos] execVM "civ\aid\aidFood.sqf";
			[[[_targetpos], "civ\aid\aidFood.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
		};
};
