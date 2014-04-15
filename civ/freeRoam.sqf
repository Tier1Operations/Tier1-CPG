
_guy = _this select 0;
_townpos = _this select 1;
_rangex = _this select 2;
_rangey = _this select 3;
_group = group _guy;

_randompos = [((_townpos select 0) - (_rangex / 2) + (random _rangex)), ((_townpos select 1) - (_rangey / 2) + (random _rangey)), 0];

_guy setSpeedMode "LIMITED";
_guy setBehaviour "SAFE";
_guy domove _randompos;
_guy setSpeedMode "LIMITED";
_guy setBehaviour "SAFE";

while { !isnull _guy } do 

	{
		
		if (random 100 < 75) then 
			{
				_guy playMove "AmovPercMstpSnonWnonDnon";
				_randompos = [((_townpos select 0) - (_rangex / 2) + (random _rangex)), ((_townpos select 1) - (_rangey / 2) + (random _rangey)), 0];
				_guy setSpeedMode "LIMITED";
				_guy setBehaviour "SAFE";
				_guy domove _randompos;
				_guy setSpeedMode "LIMITED";
				_guy setBehaviour "SAFE";
			} else 
			{
				_guy setSpeedMode "LIMITED";
				_guy setBehaviour "SAFE";
				_guy domove (getpos _guy);
				_guy setSpeedMode "LIMITED";
				_guy setBehaviour "SAFE";
				sleep 0.1;
				_guy playMove "AmovPsitMstpSnonWnonDnon_ground";
				// _guy playMove "AmovPercMstpSnonWnonDnon_SaluteIn";
				// _guy playMove "AmovPercMstpSnonWnonDnon_SaluteOut";
			};
			
		sleep ((random 25) + 15);
		_guy setSpeedMode "LIMITED";
		_guy setBehaviour "SAFE";
		
	};
	



