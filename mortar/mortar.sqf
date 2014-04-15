// Script by Zonekiller  -- http://zonekiller.ath.cx --    -- zonekiller@live.com.au --

sleep 3;

// _nil = [_this] execVM "mortar\Global_Launch_Code.sqf";
_this addEventHandler ["Fired", {_missile = nearestObject [_this select 0, _this select 4]; [_this select 0,_missile] execVM  "mortar\Global_Guided_Code.sqf"; [_this select 0] execVM  "mortar\Delay_Fire.sqf";}];

(gunner _this) setCombatMode "RED";
(gunner _this) setBehaviour "COMBAT";