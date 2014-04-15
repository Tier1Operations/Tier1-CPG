

// Number of side missions (number of latest file - 1)
_number = 12;
_chosen = -1;

while { (_chosen < 0) || (_chosen >= _number) } do
{
	_chosen = floor (random _number);
};

// _chosen = 10;

execVM format["CombatPatrolGenerator\dsm\%1.sqf", _chosen];


