// Script by Zonekiller  -- http://zonekiller.ath.cx --    -- zonekiller@live.com.au --


_veh = _this select 0;

// if !(local _veh) exitwith {};

	sleep 2;

		while { (count (crew _veh)) > 0 } do
		{

		waituntil {sleep 1; ((!isnull assignedTarget (gunner _veh)) && !(isplayer gunner _veh))};


		_target = assignedTarget (gunner _veh);


//hint typeof _target;


		// if ((alive _target) && (_target iskindof "LAND")) then {_fire = _veh fireAtTarget [_target]; sleep 30;};
		// if ((alive _target) && (_target iskindof "LAND")) then {(gunner _veh) action ["useWeapon", _veh , gunner _veh, 0]; sleep 30;};
		// if ((alive _target) && (_target iskindof "LAND")) then {_veh doFire _target; sleep 30;};
		// if ((alive _target) && (_target iskindof "LAND")) then {(gunner _veh) fire mortar_82mm; sleep 30;};
		/* _firetarget = [((getpos _target) select 0) - 200 + (random 400), ((getpos _target) select 1) - 200 + (random 400), ((getpos _target) select 2)];
		if ((alive _target) && (_target iskindof "LAND")) then 
		{
			_veh doArtilleryFire [_firetarget, "8Rnd_82mm_Mo_shells", 1]; 
			for "_i" from 1 to 30 do 
			{
				setweaponrealoadingtime [gunner _veh, currentmuzzle (gunner _veh), 0]; sleep 0.5;
			};
		}; */
		
		// if ((alive _target) && (_target iskindof "LAND")) then {_veh forceWeaponFire ["mortar_82mm", "Single"]; sleep 15;};
		
		// _veh setVehicleAmmo 1;

		};


