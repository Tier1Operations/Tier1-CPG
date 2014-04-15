
_vehicle = _this select 0;

if (!isNull _vehicle) then 
{
	_loadaction = _vehicle addAction 
	[
		"<t color='#00ff33'>Load Aid</t>",
		raven_cargo_offroad_load_aid,
		[],
		10,
		false,
		true,
		"",
		"((getPosATL _target) distance (getPosATL _this) <= 5) && ((speed _target) <= 5) && ((speed _target) >= -5) && (count (nearestObjects [_target, aid_objects, 10]) > 0) && ((driver _target) == _this)"
	];
	
	_unloadaction = _vehicle addAction 
	[
		"<t color='#00ff88'>Unload Aid</t>",
		raven_cargo_offroad_unload_aid,
		[],
		10,
		false,
		true,
		"",
		"((getPosATL _target) distance (getPosATL _this) <= 5) && ((speed _target) <= 5) && ((speed _target) >= -5) && (count (nearestObjects [_target, aid_objects, 10]) > 0) && ((driver _target) == _this)"
	];
};


