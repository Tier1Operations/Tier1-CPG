


private ["_civvies","_dimensx","_dimensy","_dimensx","_dimensy","_logicpos","_guy","_pos"];

_civvies = [];
_town_logic = _this select 0;
_dimensx = _this select 1;
_dimensy = _this select 2;
_inhab = _this select 3;
_dogs = _this select 4;
_sheep = _this select 5;
_hens = _this select 6;
_cocks = _this select 7;
_logicpos = getPos _town_logic;
_pos = _logicpos;
_group_0 = createGroup civilian;

while {true} do {

waitUntil { sleep 5; ([getPosATL (_town_logic), 400, true, "count"] call custom_nearestPlayers) > 0 };

for "_i" from 0 to _inhab do	
{
	_group_0 = createGroup civilian;
	_pos = [((_logicpos select 0) - (_dimensx / 2) + (random _dimensx)),((_logicpos select 1) - (_dimensy / 2) + (random _dimensy)),0];
								
	switch (floor (random 7)) do
	{
		case 0:
			{ _guy = _group_0 createUnit ["C_man_1", _pos, [], 0, "CAN_COLLIDE"]; };
		case 1:
			{ _guy = _group_0 createUnit ["C_man_polo_1_F", _pos, [], 0, "CAN_COLLIDE"]; };
		case 2:
			{ _guy = _group_0 createUnit ["C_man_polo_2_F", _pos, [], 0, "CAN_COLLIDE"]; };
		case 3:
			{ _guy = _group_0 createUnit ["C_man_polo_3_F", _pos, [], 0, "CAN_COLLIDE"]; };
		case 4:
			{ _guy = _group_0 createUnit ["C_man_polo_4_F", _pos, [], 0, "CAN_COLLIDE"]; };
		case 5:
			{ _guy = _group_0 createUnit ["C_man_polo_5_F", _pos, [], 0, "CAN_COLLIDE"]; };
		case 6:
			{ _guy = _group_0 createUnit ["C_man_polo_6_F", _pos, [], 0, "CAN_COLLIDE"]; };
		case 7:
			{ _guy = _group_0 createUnit ["C_man_polo_6_F", _pos, [], 0, "CAN_COLLIDE"]; };
	};

	_guy setskill ["courage",0.3 + random 0.4];
							
	waitUntil { !isNull _guy };	
	
	// hint format ["%1",_guy];
	
	// _guy setpos (getpos player);
	
	// _civvies = _civvies + [_guy];
	_civvies set [count _civvies, _guy];
	
	_guy addeventhandler ["killed", "_this spawn raven_civKilled"];
	_guy addeventhandler ["handleHeal", "_this spawn raven_civHealed"];
	
	if ((random 100) < 10) then
	{
		_guy setdamage 0.5;
	};
							
	[_guy, _logicpos, _dimensx, _dimensy] spawn raven_freeRoam;
};

	// [[_civvies], 'raven_intelAction', true, true] spawn BIS_fnc_MP;
	
	/* if (paramsarray select 16 == 1) then
	{
		sleep 0.1;
		[[_civvies], 'raven_aidAction', true, true] spawn BIS_fnc_MP;
	}; */
	
	// test_civvies = _civvies;
	// publicvariable "test_civvies";
	
	// hint format["%1",_civvies];
	
sleep 0.5;
	
for "_i" from 0 to _dogs do
{
	_pos = [((_logicpos select 0) - (_dimensx / 2) + (random _dimensx)),((_logicpos select 1) - (_dimensy / 2) + (random _dimensy)),0];
	if ((random 100) < 50) then
	{
		_guy = createAgent ["Alsatian_random_F", _pos, [], 0, "CAN_COLLIDE"];
	} else
	{
		_guy = createAgent ["Fin_random_F", _pos, [], 0, "CAN_COLLIDE"];
	};
	_civvies set [count _civvies, _guy];
};

for "_i" from 0 to _sheep do
{
	_pos = [((_logicpos select 0) - (_dimensx / 2) + (random _dimensx)),((_logicpos select 1) - (_dimensy / 2) + (random _dimensy)),0];
	_guy = createAgent ["Sheep_random_F", _pos, [], 0, "CAN_COLLIDE"];
	_civvies set [count _civvies, _guy];
};

for "_i" from 0 to _hens do
{
	_pos = [((_logicpos select 0) - (_dimensx / 2) + (random _dimensx)),((_logicpos select 1) - (_dimensy / 2) + (random _dimensy)),0];
	_guy = createAgent ["Hen_random_F", _pos, [], 0, "CAN_COLLIDE"];
	_civvies set [count _civvies, _guy];
};
	
for "_i" from 0 to _cocks do
{
	_pos = [((_logicpos select 0) - (_dimensx / 2) + (random _dimensx)),((_logicpos select 1) - (_dimensy / 2) + (random _dimensy)),0];
	_guy = createAgent ["Cock_random_F", _pos, [], 0, "CAN_COLLIDE"];
	_civvies set [count _civvies, _guy];
};
	

waitUntil { sleep 5; ([getPosATL (_town_logic), 500, true, "count"] call custom_nearestPlayers) < 1 };
	
	{ deletevehicle _x; } forEach _civvies;
	
	sleep 2;
	
	_civvies = [];
	
	// hint format["%1",_civvies];
	
	// _targets = nearestObjects [_logicpos, ["MAN"], 500];
	
	// hint format["%1 - %2",(count _targets),_targets];
 
 };


