
private ["_counter", "_marker", "_to_save", "_markers_to_save"];

cpg_finished = 0;

waitUntil {sleep 5; cpg_finished == 1; };

_markers_to_save = 
[
	"b_empty",
	"b_unknown",
	"o_hq",
	"o_empty",
	"o_unknown",
	"o_inf",
	"o_motor_inf",
	"o_mech_inf",
	"o_armor",
	"o_recon",
	"o_air",
	"o_plane",
	"o_uav",
	"o_med",
	"o_art",
	"o_mortar",
	"o_support"
];

_markers_not_to_save =
[
	"m_base",
	"m_vehicles",
	"m_boats",
	"m_aid",
	"m_service",
	"unknown_example",
	"hq_example",
	"recon_example",
	"inf_example",
	"motor_inf_example",
	"mech_inf_example",
	"armor_example",
	"heli_example",
	"plane_example",
	"mortar_example",
	"arty_example",
	"support_example",
	"installation_example"
];

while { true } do
{
	sleep 60;
	
	_counter = 0;
	
	{
		_to_save = 0;
		_marker = _x;
		{
			if (getMarkerType _marker == _x) then
			{
				_to_save = 1;
			};
			
		} forEach _markers_to_save;
		
		{
			if (_marker == _x) then
			{
				_to_save = 0;
			};
		} forEach _markers_not_to_save;
			
		if (_to_save == 1) then
		{
			
			_string = format ["Player Marker %1", _counter];
			["CPG_database", "Player Markers", _string, _marker]  call iniDB_write;
			
			_marker_type = getMarkerType _marker;
			_string2 = format ["Player Marker Type %1", _counter];
			["CPG_database", "Player Markers", _string2, _marker_type]  call iniDB_write;
			
			_marker_text = markerText _marker;
			_string3 = format ["Player Marker Text %1", _counter];
			["CPG_database", "Player Markers", _string3, _marker_text]  call iniDB_write;
			
			_marker_pos = getMarkerPos _marker;
			_string4 = format ["Player Marker Pos %1", _counter];
			["CPG_database", "Player Markers", _string4, _marker_pos]  call iniDB_write;
			
			_counter = _counter + 1;
			
		};
		
	} forEach allMapMarkers;
	
	["CPG_database", "Player Markers", "Player Markers Number", _counter]  call iniDB_write;
};

