
_guy = _this select 0;
_pos = getPos (_this select 0);
_given = false;
_prob = aid_request_prob_from_civ;

{ if (_x == _guy) then
	{
		_given = true;
	};
} foreach aidgiven;

// hint format ["pos is %1 and targets are %2", _pos, _targets];

if (alive _guy) then 
{

	if (!_given) then 
	{

		if ((random 100) < _prob) then 
		{
			_targetpos = getPos _guy;
			aidmarker = aidmarker + 1;
			publicvariable "aidmarker";
			
			switch (floor(random 3)) do 
			{
				case 0:
					{ 
						[[[_targetpos], "civ\aid\aidBricks.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
					};
				case 1:
					{ 
						[[[_targetpos], "civ\aid\aidWater.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
					};
				case 2:
					{ 
						[[[_targetpos], "civ\aid\aidFood.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
					};
				case 3:
					{ 
						[[[_targetpos], "civ\aid\aidFood.sqf"], "BIS_fnc_execVM", false, false] call BIS_fnc_MP;
					};
			};
			playSound "confirm1";
		} else
		{
		switch (floor(random 6)) do 
			{
				case 0:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No thanks</t><br/><br/><t align='center'>This civilian doesn't need anything.</t><br/>  "; playsound "warning1"; };
				case 1:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No thanks</t><br/><br/><t align='center'>This civilian says he's fine.</t><br/>  "; playsound "warning1"; };
				case 3:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No thanks</t><br/><br/><t align='center'>This civilian says all is fine.</t><br/>  "; playsound "warning1"; };
				case 4:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No thanks</t><br/><br/><t align='center'>This civilian doesn't understand your language.</t><br/>  "; playsound "warning1"; };
				case 5:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No thanks</t><br/><br/><t align='center'>This civilian doesn't want your help.</t><br/>  "; playsound "warning1"; };
				case 6:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No thanks</t><br/><br/><t align='center'>This civilian doesn't need anything.</t><br/>  "; playsound "warning1"; };
			};
		
		};
			
		aidgiven = aidgiven + [_guy];
		publicvariable "aidgiven";
		
	};

	if (_given) then 
	{
		hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>You again?</t><br/><br/><t align='center'>This civilian has already been asked if he needs help.</t><br/>  "; playsound "warning1";
	};
	
} else 
{
	hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>The dead<br/>can't talk</t><br/><br/><t align='center'>Are you seriously asking a dead body if it needs help?</t><br/>  "; playsound "warning1";
};

	// hint format ["%1", aidgiven];
	
	