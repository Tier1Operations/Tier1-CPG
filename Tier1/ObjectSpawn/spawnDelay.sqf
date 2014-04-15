
//	This script reduces the timer for spawning vehicles. It does so roughly every 10 seconds.
//	Run this script on the clients.

sdelay = 0;

[] Spawn {
	while {true} do {
		
		sleep 10;
		
		if (sdelay > 0) then {
			sdelay = sdelay - 10;
		
		};
	};
};