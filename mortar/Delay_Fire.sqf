
_veh = _this select 0;

/* for "_i" from 1 to 30 do 
{
	sleep 1;
	mortar1 setweaponreloadingtime [gunner _veh, currentweapon (gunner _veh), 1];
}; */

// _mags = magazines _veh;

_veh removemagazines "8Rnd_82mm_Mo_shells";

sleep 60;

_veh addmagazine ["8Rnd_82mm_Mo_shells", 1];
