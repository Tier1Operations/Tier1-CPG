
_vehicle = _this select 0;

// player globalchat format["offroadUnloadAid.sqf ---- %1 ---- %2", _vehicle, (_vehicle getVariable "cargoFull")];

if ((_vehicle getVariable "cargoFull") == 1) then
{
	_targets = nearestObjects [_vehicle, aid_objects, 4];
	_target = _targets select 0;
	detach _target;
	_vehiclepos = getpos _vehicle;
	_target setpos [(_vehiclepos select 0) - 5, _vehiclepos select 1, 0];
	_vehicle setVariable ["cargoFull", 0, true];
	publicvariable "_vehicle";
} else
{
	hint "No cargo to unload";
};


