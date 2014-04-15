
disableserialization;

_enabledChannels = player getVariable "enabledChannels";

_i = 0;

{
	if( _x == 1 ) then 
	{
		_enabledChannels set [_i, 0];
		player setVariable ["enabledChannels", _enabledChannels];
		(radioChannels select _i) radioChannelRemove [player];
		_button = (findDisplay 2815) displayCtrl ((_i * 100 ) + 100);
		_button ctrlSetTextColor [1, 0, 0, 1];
		_button ctrlSetText "OFF";
		_i = _i + 1;
		// hint "hello";
	};
} forEach _enabledChannels;

