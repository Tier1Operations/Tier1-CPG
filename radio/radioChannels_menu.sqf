_ok = createDialog "RadioChannels";
disableSerialization;
_display = findDisplay 2815;
_enabledChannels = player getVariable "enabledChannels";
_channelsCount = count _enabledChannels;
for "_i" from 0 to _channelsCount do
{
	_button = _display displayCtrl ((_i * 100) + 100);
	if( (_enabledChannels select _i) == 0 ) then
	{	
		_button ctrlSetTextColor [1, 0, 0, 1];
		_button ctrlSetText "OFF";
	} else {
		_button ctrlSetTextColor [0, 1, 0, 1];
		_button ctrlSetText "ON";
	};
};

