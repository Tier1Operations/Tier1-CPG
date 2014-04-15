// Script by Zonekiller  -- http://zonekiller.ath.cx --    -- zonekiller@live.com.au --

_veh = _this select 0;
_missile = _this select 1;

if (!(local _veh) or (isplayer gunner _veh)) exitwith {};

_target = assignedTarget gunner _veh;

if ((isNull _target) or !(alive _target) or (isNull _missile) or (typeName _target != "OBJECT")) exitWith {};

waituntil {((((getposATL _missile) select 2) > 90) or !(alive _missile))};


	_homeMissile = {
	private ["_velocityX", "_velocityY", "_velocityZ", "_target", "_missile", "_missileSpeed", "_travelTime"];
	
	_missile = _this select 0;
	_target = _this select 1;
	_targetasl = _this select 2;
	_missileSpeed = _this select 3;



		if (_missile distance _target > (_missileSpeed / 20)) then 
		{
		_travelTime = (_target distance _missile) / _missileSpeed;
		_relDirHor = [_missile, _target] call BIS_fnc_DirTo;
		_missile setDir _relDirHor;
		_relDirVer = asin ((((getPosASL _missile) select 2) - (_targetasl select 2)) / (_target distance _missile));
		_relDirVer = (_relDirVer * -1);
		[_missile, _relDirVer, 0] call BIS_fnc_setPitchBank;

		_velocityX = ((_targetasl select 0) - ((getPosASL _missile) select 0)) / _travelTime;
		_velocityY = ((_targetasl select 1) - ((getPosASL _missile) select 1)) / _travelTime;
		_velocityZ = ((_targetasl select 2) - ((getPosASL _missile) select 2)) / _travelTime;
		};

	[_velocityX, _velocityY, _velocityZ]
	};


_posasl = ((getposASL _target) select 2); 
_target1 = (gunner _veh) getHideFrom _target;
_targetasl = [(_target1 select 0) - 250 + (random 500), (_target1 select 1) - 250 + (random 500), _posasl];

_spd = 180;
_hgt = 50;

while {((alive _missile) && (_hgt > 5) && (alive _target))} do 
{
_pos = position _missile;
_hgt = _pos select 2;

	if ((alive _target) && (_hgt > 5) && (alive _missile)) then 
	{
	_velocityForCheck = [_missile,_target1,_targetasl,_spd] call _homeMissile;
	if ({(typeName _x) == (typeName 0)} count _velocityForCheck == 3) then {_missile setVelocity _velocityForCheck;};
	};

sleep 1;
};


