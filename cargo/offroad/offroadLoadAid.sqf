
_vehicle = _this select 0;

// player globalchat format["offroadLoadAid.sqf ---- %1 ---- %2", _vehicle, (_vehicle getVariable "cargoFull")];

if ((_vehicle getVariable "cargoFull") == 0) then
{
	_targets = nearestObjects [_vehicle, aid_objects, 8];
	
	if ((count _targets) > 0) then
	{
		_target = _targets select 0;
		
		if (typeof _target == "Land_Bricks_V1_F") then
		{
			_target attachTo [_vehicle,[0,-1.5,-0.5]];
		};
		
		if (typeof _target == "Land_Sacks_goods_F") then
		{
			_target attachTo [_vehicle,[0,-1.5,0]];
		};
		
		if (typeof _target == "Land_WaterBarrel_F") then
		{
			_target attachTo [_vehicle,[0,-1.5,-0.2]];
		};
		
		_vehicle setVariable ["cargoFull", 1, true];
		publicvariable "_vehicle";
		
	} else
	{
		hint "No Aid to load here";
	};
	
} else
{
	hint "Cargo is already full";
};


