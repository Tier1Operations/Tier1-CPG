


private ["_result","_pos","_range","_type","_alive","_units"];

_pos   = _this select 0;
_range = _this select 1;
_alive = _this select 2;
_type  = _this select 3;



if (_type == "count") then {
	_result = 0;
} else {
	_result = [];
};



if (count playableUnits <= 0) then {
	if (!isDedicated) then {
		// Singleplayer
		_units = [player];
	} else {
		// Multiplayer, no players online
		_units = [];
	};
} else {
	// Multiplayer, players are in mission
	_units = playableUnits;
};



{
	if (!isNil "_x") then {
		if (isPlayer _x) then {
			if (side _x == west) then {
				if (_x distance _pos <= _range && (alive _x || !_alive)) then { 
					if (_type == "count") then {
						_result = _result + 1;
					} else {
						_result = _result + [_x];
					};
				};
			};
		};
	};
} forEach _units;



_result