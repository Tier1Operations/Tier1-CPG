
_pos = _this select 0;
_ied = _this select 1;

// hint format ["pos is %1",_pos];

_target1 = objNull;

_targets = nearestObjects [[_pos select 0, _pos select 1, _pos select 2], ["MAN","CAR"], 20];

if (count _targets > 0) then {
   _target1 = _targets select 0;
};  



// hint format ["target is %1",_target];

[[[_ied],'bon_ieds\raven_iedAddAction.sqf'],'BIS_fnc_execVM', true, true] spawn BIS_fnc_MP;

_ied setVariable ["isIed", 1, true];

// _defuseAct = _ied addAction ["<t color='#0000ff'>Disarm and Clear IED</t>", "bon_ieds\raven_disarmIED.sqf", [], 7, false, true, "", "((getPosATL _target) distance (getPosATL _this) <= 5) && (_this isKindOf 'Man')"];

// hint "here";

while 
		{
		
		(speed _target1 < 4.5) || (side _target1 != west) || ((_pos distance (position _target1)) > 7)
		
		} do
			{ 
			
			sleep 0.5; 
			
			_targets = nearestObjects [[_pos select 0, _pos select 1, _pos select 2], ["MAN","CAR"], 20];
			
			if (count _targets > 0) then 
				{
				_target1 = _targets select 0;
				};

			};
	
// hint "boom";
	
// if (!isNull _ied) then 
if (_ied getVariable "isIed" == 1) then 
	{
	deletevehicle _ied;
	_bomb = createVehicle ['R_60mm_HE', _pos, [], 0, 'NONE'];
	_bomb setvectorup [0,0,-1];
	};

/*
if (!isNull _ied) then 
	{
	 switch (floor(random 4)) do 
		{
		case 0:
			{ _bomb = createVehicle ["Bo_Air_LGB_hidden", [_pos select 0, _pos select 1, 1], [], 0, 'NONE']; };
		case 1:
			{ _bomb = createVehicle ["", [_pos select 0, _pos select 1, 1], [], 0, 'NONE']; };
		case 2:
			{ _bomb = createVehicle ["", [_pos select 0, _pos select 1, 1], [], 0, 'NONE']; };
		case 3:
			{ _bomb = createVehicle ["SmokeShellArty", [_pos select 0, _pos select 1, 1], [], 0, 'NONE']; };
		case 4:
			{ _bomb = createVehicle ["", [_pos select 0, _pos select 1, 1], [], 0, 'NONE']; };
		};
	};
*/



