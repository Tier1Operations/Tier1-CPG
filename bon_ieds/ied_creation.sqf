//by Bon_Inf*

// if(!isServer) exitWith {};


private ["_iedpos","_offset","_ied","_trg"];


_roads = spawnA2 nearRoads 20000;
// _roads = Server nearRoads 20000;
_iedpositions = [];
_fakeiedpositions = [];
_fakeiedpositions2 = [];

// hint format["You have %1 roads",count _roads];

for "_i" from 1 to bon_number_ieds do {

	for "_searchcount" from 1 to 10000 do {

		_j = (count _roads - 1) min (round random (count _roads));
		_iedpos = _roads select _j;

		if(
			// {_iedpos distance _x < 500} count _iedpositions == 0 &&
			_iedpos distance (getMarkerPos format["m_base"]) > 1000
		) exitWith{};

		_iedpos = nil;

	};
	

	if(not isNil "_iedpos") then {
		_roads = _roads - [_iedpos];
		_iedpositions = _iedpositions + [_iedpos];

		_j = (count bon_ied_container - 1) min (round random (count bon_ied_container));
		_ied = (bon_ied_container select _j) createVehicle position _iedpos;
		
		_count = 0;
		while {isonroad _ied && _count < 1000} do 
		{
			_ied2 = _ied;
			// _offset = [10 - random 20, 10 - random 20, 0];
			// _ied setPosATL (_iedpos modelToWorld _offset);
			_ied setPosATL [(getPosATL _ied2 select 0) + 10 - random 20, (getPosATL _ied2 select 1) + 10 - random 20, 0.01];
			_count = _count + 1;
		};

		// _ied setVehicleInit format["
		// det1 = this addAction ['<t color=""#FFCC00"">Detonate IED - delayed</t>','%1blow.sqf',[],1,false,true,'','_this distance _target < 7'];
		// ",BON_IED_PATH]; 
		// processInitCommands;
		// _ied execFSM (BON_IED_PATH+"mine_sensor.fsm");
		
		
		[[(getPosATL _ied select 0), (getPosATL _ied select 1), 0], _ied] execVM "bon_ieds\raven_createIED.sqf";
		
		// sleep 0.1;

		_iedpos = nil;
		_ied = nil;
		// _trg = nil;

	};
};

//{
//	(createMarker [str round random 999999,position _x]) setMarkerType "mil_warning";
//} foreach _iedpositions;


for "_i" from 1 to bon_number_fake_ieds do {

	for "_searchcount" from 1 to 10000 do {

		_j = (count _roads - 1) min (round random (count _roads));
		_iedpos = _roads select _j;

		if(
			// {_iedpos distance _x < 500} count _fakeiedpositions == 0 &&
			_iedpos distance (getMarkerPos format["m_base"]) > 1000
		) exitWith{};

		_iedpos = nil;

	};

	if(not isNil "_iedpos") then {
		_roads = _roads - [_iedpos];
		_fakeiedpositions = _fakeiedpositions + [_iedpos];

		_j = (count bon_fake_ied_container - 1) min (round random (count bon_fake_ied_container));
		_ied = (bon_fake_ied_container select _j) createVehicle position _iedpos;
		
		_count = 0;
		while {isonroad _ied && _count < 1000} do 
		{
			_ied2 = _ied;
			//_offset = [10 - random 20, 10 - random 20, 0];
			//_ied setPosATL (_iedpos modelToWorld _offset);
			_ied setPosATL [(getPosATL _ied2 select 0) + 10 - random 20, (getPosATL _ied2 select 1) + 10 - random 20, 0.01];
			_count = _count + 1;
		};

		_iedpos = nil;
		_ied = nil;
	};
};


//{
//	(createMarker [str round random 999999,position _x]) setMarkerType "mil_dot";
//} foreach _fakeiedpositions;


for "_i" from 1 to bon_number_fake_ieds2 do {

	for "_searchcount" from 1 to 10000 do {

		_j = (count _roads - 1) min (round random (count _roads));
		_iedpos = _roads select _j;

		if(
			// {_iedpos distance _x < 500} count _fakeiedpositions2 == 0 &&
			_iedpos distance (getMarkerPos format["m_base"]) > 1000
		) exitWith{};

		_iedpos = nil;

	};

	if(not isNil "_iedpos") then {
		_roads = _roads - [_iedpos];
		_fakeiedpositions2 = _fakeiedpositions2 + [_iedpos];

		_j = (count bon_fake_ied_container2 - 1) min (round random (count bon_fake_ied_container2));
		_ied = (bon_fake_ied_container2 select _j) createVehicle position _iedpos;
		_ied setFuel 0.05;
		_ied setDamage 0.4;
		
		_count = 0;
		while {isonroad _ied && _count < 1000} do 
		{
			_ied2 = _ied;
			// _offset = [10 - random 20, 10 - random 20, 0];
			// _ied setPosATL (_iedpos modelToWorld _offset);
			_ied setPosATL [(getPosATL _ied2 select 0) + 10 - random 20, (getPosATL _ied2 select 1) + 10 - random 20, 0.01];
			_count = _count + 1;
		};

		_iedpos = nil;
		_ied = nil;
	};
};


//{
//	(createMarker [str round random 999999,position _x]) setMarkerType "mil_pickup";
//} foreach _fakeiedpositions2;