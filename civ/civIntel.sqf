

_guy = _this select 0;
_pos = getPos (_this select 0);
_targets = nearestObjects [[_pos select 0, _pos select 1, _pos select 2], ["MAN","CAR"], 2000];
_nearestenemies = [];
_given = false;
_prob = civ_intel_prob_from_civ;

{ if (_x == _guy) then
	{
		_given = true;
	};
} foreach intelgiven;

// hint format ["pos is %1 and targets are %2", _pos, _targets];

if (alive _guy) then {

if (!_given) then 
	{

		if ((random 100) < (_prob + (civ_reputation * 50))) then 
		{

			if(east countSide _targets > 0) then
			{
	
				{
					_unit = _x;
					if(side _unit == east) then{_nearestenemies = _nearestenemies + [_unit]};
				} foreach _targets;

				_intel = (_nearestenemies select (floor (random (count _nearestenemies))));

				_targetpos = getPos _intel;
				_targetpos1 = [(_targetpos select 0) - 100 + (random 200), (_targetpos select 1) - 100 + (random 200), 0];

				_intelmrk = createMarker [format["intelmrk_%1",intelmarker], _targetpos1];
				_intelmrk setMarkerType 'mil_warning';
				_intelmrk setMarkerAlpha 0.5;
				_intelmrk setMarkerColor 'ColorRed';
				_intelmrk setMarkerBrush 'Solid';
				_intelmrk setMarkerSize [0.8, 0.8];
					
				intelmarker = intelmarker + 1;
				publicvariable "intelmarker";
		
				hint parsetext "<br/><img image='civ\pix\opfor.jpg' size='5' align='center'/><br/><br/><t align='center' size='1.5' color='#08b000'>Intel Obtained</t><br/><br/><t align='center'>This civilian says he saw some enemies nearby.<br/>He marked some approximate positions your map.</t><br/>  ";
				playSound "confirm1";

			} else
			{
				hint parsetext "<br/><img image='civ\pix\landscape.jpg' size='5' align='center'/><br/><br/><t align='center' size='1.5' color='#ffff00'>Change Area!</t><br/><br/><t align='center'>This civilian says there are no enemies around here.</t><br/>  "; 
				playsound "confirm1";
			};

		} else
		{
			switch (floor(random 6)) do 
			{
				case 0:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian doesn't want to talk to you.</t><br/>  "; playsound "warning1"; };
				case 1:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian doesn't know anything useful.</t><br/>  "; playsound "warning1"; };
				case 2:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian is too afraid to talk.</t><br/>  "; playsound "warning1"; };				
				case 3:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian is not cooperative.</t><br/>  "; playsound "warning1"; };
				case 4:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian doesn't understand your language.</t><br/>  "; playsound "warning1"; };
				case 5:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian is just looking for food.</t><br/>  "; playsound "warning1"; };
				case 6:
					{ hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>No Intel</t><br/><br/><t align='center'>This civilian doesn't want to talk to you.</t><br/>  "; playsound "warning1"; };
			};
		};
		
		intelgiven = intelgiven + [_guy];
		publicvariable "intelgiven";
	
	};

if (_given) then 
	{
		hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>You again?</t><br/><br/><t align='center'>This civilian has already been questioned.</t><br/>  "; playsound "warning1";
	};
	
} else {
	hint parsetext "<br/><t align='center' size='1.5' color='#ff0000'>The dead<br/>can't talk</t><br/><br/><t align='center'>Are you seriously questioning a dead body?</t><br/>  "; playsound "warning1";
	};

	// hint format ["%1", intelgiven];
	
	