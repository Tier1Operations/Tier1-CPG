

//	Delete unused functions, vars, and markers.

cpg_fnc_chooseEnemy = nil;
cpg_fnc_findClosestFort = nil;
cpg_fnc_chooseTactic = nil;
cpg_fnc_spawnEmptyVehicles = nil;
cpg_v_enemynr = nil;
cpg_v_tnr = nil;
cpg_v_inr = nil;
cpg_v_dpos = nil;
cpg_v_cpos = nil;
cpg_v_blacklist = nil;
cpg_v_zones = nil;
cpg_v_nr = nil;

deletemarker "cpg_m_center";
deletemarker "cpg_m_dposl";
deletemarker "cpg_m_dposw";

for [{_i=1}, {(getMarkerType (format["cpg_m_fort%1",_i])) != ""}, {_i=_i+1}] do {

	deletemarker format["cpg_m_fort%1",_i];

};
