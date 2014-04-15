fnc_channelStatus = {
	private["_index", "_enabledChannels", "_button"];
	_index = _this select 0;
	_enabledChannels = player getVariable "enabledChannels";
	_button = (findDisplay 2815) displayCtrl ((_index * 100 ) + 100);
	if( _enabledChannels select _index == 0 ) then 
	{
		_enabledChannels set [_index, 1];
		player setVariable ["enabledChannels", _enabledChannels];
		(radioChannels select _index) radioChannelAdd [player];
		_button ctrlSetTextColor [0, 1, 0, 1];
		_button ctrlSetText "ON";
		hintsilent format ["CH %1 Enabled", (_index+1)];
	} else 
	{
		_enabledChannels set [_index, 0];
		player setVariable ["enabledChannels", _enabledChannels];
		(radioChannels select _index) radioChannelRemove [player];
		_button ctrlSetTextColor [1, 0, 0, 1];
		_button ctrlSetText "OFF";
		hintsilent format ["CH %1 Disabled", (_index+1)];
	};
};


