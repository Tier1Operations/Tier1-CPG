
while { true } do 	
	{	
	switch (floor (random 6)) do		
		{
			case 0:
				{
				1800 setOvercast 0;
				};
				
			case 1:
				{
				1800 setOvercast 0.2;
				};
				
			case 2:
				{
				1800 setOvercast 0.4;
				};
				
			case 3:
				{
				1800 setOvercast 0.6;
				1800 setLightnings 0.1;
				};
				
			case 4:
				{
				1800 setOvercast 0.8;
				1800 setLightnings 0.4;
				};
				
			case 5:
				{
				1800 setOvercast 1.0;
				1800 setLightnings 0.7;
				};
				
			case 6:
				{
				1800 setOvercast 0.5;
				};
		};
	
	switch (floor (random 5)) do		
		{
			case 0:
				{
				1800 setWaves 0.2;
				};
				
			case 1:
				{
				1800 setWaves 0.4;
				};
				
			case 2:
				{
				1800 setWaves 0.6;
				};
				
			case 3:
				{
				1800 setWaves 0.8;
				};
				
			case 4:
				{
				1800 setWaves 1.0;
				};
				
			case 5:
				{
				1800 setWaves 0.5;
				};
		};
	
	sleep 1800;
	
	};
				
				