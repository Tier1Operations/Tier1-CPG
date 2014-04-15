

for [{_i = 1}, { _i <= cpg_air_ambushes}, {_i = _i+1}] do 	
{

	execVM "CombatPatrolGenerator\cpg_createAirAmbushPoint.sqf";
	
};

