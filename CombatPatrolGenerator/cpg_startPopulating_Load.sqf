
private ["_k"];

//	Create blacklist zone around player starting position.
_campaign_blacklist_mult = campaign_balance;
if (campaign_balance > 0) then
{
	_campaign_blacklist_mult = _campaign_blacklist_mult * 4;
};
_blc1 = [((getmarkerpos "cpg_m_startloc") select 0) - 1000 - (_campaign_blacklist_mult * 500), ((getmarkerpos "cpg_m_startloc") select 1) + 1000 + (_campaign_blacklist_mult * 1000), 0];
_blc2 = [((getmarkerpos "cpg_m_startloc") select 0) + 1000 + (_campaign_blacklist_mult * 500), ((getmarkerpos "cpg_m_startloc") select 1) - 1000 - (_campaign_blacklist_mult * 1000), 0];
cpg_v_blacklist set [count cpg_v_blacklist, [_blc1,_blc2]];


for [{_k = 1}, {_k <= cpg_v_zones}, {_k = _k + 1}] do 
{

	// Counter of the number of enemies created so far
	cpg_v_enemynr = 0;

	//	Create a marker on the patrol area center position
	//	if the corresponging mission parameter is set to on
	
	cpg_v_cpos = cpg_v_cpos_array select (_k - 1);
	
	if (cpg_show_patrol_mrk == 1) then
	{
		cpg_v_inr = cpg_v_inr + 1;
		_mrk = createMarker [format["cpg_m_inr%1",cpg_v_inr], cpg_v_cpos];
		_mrk setMarkerType "mil_objective";
		_mrk setMarkerAlpha 0.8;
		_mrk setMarkerColor "ColorBlue";
		_mrk setMarkerText " Patrol the area";
		_mrk setMarkerPos cpg_v_cpos;
	};

};

// And now we spawn all the units from the previous session.
// We don't need to know where the "Patrol the Area" markers are, because we already have
// the positions of the groups, so just spawn them there!
// In this way we lose a bit of information and the groups won't be patrolling *exactly* the
// same area as the previous sessions, but oh well :)

_handle = [] call cpg_fnc_createTactic_LoadedUnits;
sleep 1;
[] spawn cpg_fnc_loadObjectives;
