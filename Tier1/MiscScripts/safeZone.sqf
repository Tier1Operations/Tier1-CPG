
_position = [2000, 5600, 0];

sleep 30;

while { true } do
{
	_people = nearestObjects [_position, ["MAN", "CAR"], 400];
	
	{
		if (side _x == east) then
		{
			deletevehicle _x;
		};
	} forEach _people;
	
	sleep 30;
};
	
	
	