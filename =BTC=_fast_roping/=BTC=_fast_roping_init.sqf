#include "=BTC=_functions.sqf"
BTC_fast_rope_h = 25;
BTC_AI_fast_rope_on_deploy = 1;
BTC_roping_chopper = ["B_Heli_Transport_01_F"];

	_veh = _this select 0;

	if (!(isNil "_veh")) then
	{
	
		_rope = _veh addaction [
			("<t color=""#ED2744"">") + ("Deploy rope") + "</t>",
			BTC_deploy_rope,
			[],
			7,
			true,
			false,
			"",
			"player == driver _target && format [""%1"",_target getVariable ""BTC_rope""] != ""1"" && ((getPos _target) select 2) < BTC_fast_rope_h && speed _target < 15"
		];
		
		_rope = _veh addaction [
			("<t color=""#ED2744"">") + ("Cut rope") + "</t>",
			BTC_cut_rope,
			[],
			7,
			true,
			false,
			"",
			"player == driver _target && format [""%1"",_target getVariable ""BTC_rope""] == ""1"""
		];
		
		_out  = _veh addaction [
			("<t color=""#ED2744"">") + ("Fast rope") + "</t>",
			BTC_fast_rope,
			[],
			7,
			true,
			false,
			"",
			"player in (assignedCargo _target) && format [""%1"",_target getVariable ""BTC_rope""] == ""1"""
		];
	
	};
