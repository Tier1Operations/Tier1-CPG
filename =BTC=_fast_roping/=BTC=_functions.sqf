BTC_deploy_rope =
{
	hint "Rope deployed";
	_veh = vehicle player;
	_veh setVariable ["BTC_rope",1,true];
	if (BTC_AI_fast_rope_on_deploy == 1) then {_fast_rope = [_veh] spawn BTC_AI_fast_rope};
	WaitUntil {!Alive _veh || !Alive player || (((getPos player) select 2) > BTC_fast_rope_h) || format ["%1",_veh getVariable "BTC_rope"] != "1"};
	_veh setVariable ["BTC_rope",0,true];
};
BTC_cut_rope =
{
	hint "Rope cut";
	_veh = vehicle player;
	_veh setVariable ["BTC_rope",0,true];
};
BTC_fast_rope =
{
	hint "Fast roping!";
	_unit = _this select 1;
	hint format ["%1, %2", _unit, alive _unit];
	_veh = vehicle _unit;
	_unit action ["EJECT",_veh];
	_unit setPos (_veh modelToWorld [2,1,-2]);
	unassignVehicle _unit;
	_unit switchMove "LadderRifleStatic";
	_unit setDir (getDir _veh - 90);
	WaitUntil {!Alive _unit || (((getPos _unit) select 2) < 1.5)};
	// if (Alive _unit && (((getPos _veh) select 2) < (BTC_fast_rope_h + 5)) && speed _veh < 5) then
	// {
		_unit setVelocity [0,0,0];
		WaitUntil {!Alive _unit || (((getPos _unit) select 2) < 1)};
		_unit setVelocity [0,0,0];
		_unit playMove "LadderRifleDownOff";
		if !(isPlayer _unit) then {_unit move [((getPos _unit) select 0) + 3,((getPos _unit) select 1) + 3,0];};
	// };
	// if (((getPos _veh) select 2) > (BTC_fast_rope_h + 5)) then {hint "The chopper flied away! The rope has been cut!";};
};
BTC_AI_fast_rope = 
{
	_veh = _this select 0;
	_veh flyInHeight (BTC_fast_rope_h - 2);
	_time = time + 60;
	WaitUntil {!Alive _veh || !Alive driver _veh || (((getPos _veh) select 2) <= BTC_fast_rope_h) || _time < time};
	doStop _veh;
	if (Alive _veh && Alive driver _veh && (((getPos _veh) select 2) <= (BTC_fast_rope_h + 1))) then
	{
		{
			if !(isPlayer _x) then {_fast_rope = [_x] spawn BTC_fast_rope;sleep 3;};
		} foreach assignedCargo _veh;
	};
	sleep 3;
	_veh move position _veh;
};