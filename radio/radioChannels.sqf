_enabledChannels = [0, 0, 0, 0];
_channelsCount = count _enabledChannels;
player setVariable ["enabledChannels", _enabledChannels];

if (isServer) then {

	_platoonIndex = radioChannelCreate [
		[1, 0.3, 0, 1],
		"Platoon Channel",
		"%UNIT_GRP_NAME %UNIT_NAME",
		[]
	];

	_alphaIndex = radioChannelCreate [
		[1, 0, 0, 1],
		"Alpha Squad Channel",
		"%UNIT_GRP_NAME %UNIT_NAME",
		[]
	];

	_bravoIndex = radioChannelCreate [
		[0, 0.4, 0.93, 1],
		"Bravo Squad Channel",
		"%UNIT_GRP_NAME %UNIT_NAME",
		[]
	];
_charlieIndex = radioChannelCreate [
		[1, 0.5, 0, 1],
		"Charlie Squad Channel",
		"%UNIT_GRP_NAME %UNIT_NAME",
		[]
	];

	
	radioChannels = [_platoonIndex, _alphaIndex, _bravoIndex, _charlieIndex];
	publicVariable "radioChannels";
	
	SUB_RADIO_INIT = true;
	publicvariable "SUB_RADIO_INIT";

};
	
waituntil {SUB_RADIO_INIT};

/* if I put this inside !isServer the action is not added */
if(!isDedicated) then
{
		waitUntil {!isNull player && player == player};
		[] execVM "radio\radioChannels_functions.sqf";
		_radioAction = player addaction ["<t color='#ff3300'>Open Radio Menu</t>", "radio\radioChannels_menu.sqf", [], 9, false];
		player addEventHandler ["killed", "_unit = (_this select 0); [_unit] execVM 'radio\radioChannels_removeFromCh.sqf';"];
		player addEventHandler ["respawn", "_unit = (_this select 0); [_unit] execVM 'radio\radioChannels_addAction.sqf';"];
};

