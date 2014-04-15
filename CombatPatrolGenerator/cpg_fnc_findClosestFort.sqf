


//	Set scope of vars.
_forts = [];
_dist = [];
_list = [];



//	Check which "m_fortXX" markers exist and add them to the array called _forts.
//	This is done by:
//	1. Make the variable _i into number 1 to start with. At the end of each loop, increment _i by 1.
//	2. Use _i and the format function to dynamically create the code that will check if the marker exists.
//	3. Check if (getMarkerType "cpg_m_fortX") returns true. X equals _i. While that check returns true, it means the marker exists.
//	4. If the check returned true, then the marker exists and so we will add the marker name to an array called _forts that we will use to list all "cpg_m_fortXX" markers.
//	5. Keep looping this code until _i reaches a number of which there is no actual "cpg_m_fortXX" marker.
//	At that point we have created a list of all the "cpg_m_fortXX" markers, assuming the markers have been named properly.
for [{_i=1}, {(getMarkerType (format["cpg_m_fort%1",_i])) != ""}, {_i=_i+1}] do {

	_forts set [count _forts, format["cpg_m_fort%1",_i]];

};



//	Check the distances between the target area and all fort markers. Put all distances into the array called _dist.
{
	_dist set [count _dist, cpg_v_cpos distance (getmarkerpos _x)];
} foreach _forts;



//	The following will create a list of the few closest markers to the target area. The amount of closest markers stored depends on how many times the loop runs.
//	Note that _forts contains a list of all "cpg_m_fortXX" markers and _dist contains a list of distance values of the said markers (distance between marker position and target area).
//	Both arrays are sorted in the same order, the indexes correspond to each other.
for "_i" from 1 to 6 do {
	
	//	Find lowest number inside _dist. This lowest number is put into _extr.
	//	Now we know that the marker name with the same index value must be the marker that is the closest to the target area.
	_extr = [_dist, 0] call BIS_fnc_findExtreme;
	
	//	Find index value of the lowest number inside _dist.
	//	Now we can use the index value to identify which marker name corresponds with the lowest number found earlier.
	_index = ([_dist, _extr] call BIS_fnc_arrayFindDeep) select 0;
	
	//	Use the previously found index number to look inside _forts for the marker name with the same index value. Then add that marker name to _list.
	//	Now we have added the marker with the lowest distance value (which means it's the closest marker from the list to the target area) to an array called _list.
	//	We will use that array (_list) to store the markers who are the closest to the target area.
	_list set [count _list, _forts select _index];
	
	//	Use the previously found index number to remove the lowest number from _dist.
	//	We want to delete the distance number which corresponds with the marker name we have already put inside _list,
	//	so that next time we run this script, the script can look for the next closest marker.
	_dist = [_dist, _index] call BIS_fnc_removeIndex;
	
	//	Use the previously found index number to remove the marker name inside _forts that corresponds with the lowest number.
	//	We want to delete the marker name which we have already put inside _list, so that next time we run this script, the script can look for the next closest marker.
	_forts = [_forts, _index] call BIS_fnc_removeIndex;
	
	//	Now we are going to loop this a few times to create a list of the closest markers to the target area.
	//	This list of closest markers can be found inside the array called _list.
	//	How many markers are put inside _list is determined by the amount of times this code is looped.
};



//	Empty the array _forts so that we can use it to store new info. Then randomly choose 3 markers from _list. Put them inside _forts.
//	We have then chosen the three closest markers to the target area. Job done.
_forts = [];
for "_i" from 1 to 3 do {
	
	_forts set [count _forts, _list call BIS_fnc_selectRandom];
};



//	Return _forts, so that another script can use these results.
_forts