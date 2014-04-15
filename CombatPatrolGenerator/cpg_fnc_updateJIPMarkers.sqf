


//	Update markers after a player connects. This should send the markers to all clients and hence said markers should show up for JIPs.



//	Dynamically create code that checks if a marker exists and if so, set the marker's position.
//	This code checks marker names starting with "cpg_m_inrX", where X is a number.

for [{_i=1}, {(getMarkerType (format["cpg_m_inr%1",_i])) != ""}, {_i=_i+1}] do {

	(format["cpg_m_inr%1",_i]) setMarkerPos (getMarkerPos (format["cpg_m_inr%1",_i]));
	
};



//	This is for the side missions!


for [{_i=1}, {(getMarkerType (format["side_mission_%1",_i])) != ""}, {_i=_i+1}] do {

	(format["side_mission_%1",_i]) setMarkerPos (getMarkerPos (format["side_mission_%1",_i]));
	
};

for [{_i=1}, {(getMarkerType (format["main_mission_%1",_i])) != ""}, {_i=_i+1}] do {

	(format["main_mission_%1",_i]) setMarkerPos (getMarkerPos (format["main_mission_%1",_i]));
	
};

 for [{_i=0}, {(getMarkerType (format["intelmrk_%1",_i])) != ""}, {_i=_i+1}] do {

	(format["intelmrk%1",_i]) setMarkerPos (getMarkerPos (format["intelmrk%1",_i]));
	
}; 



