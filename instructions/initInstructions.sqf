
_board = (_this select 0);

_action = _board addAction ["<t color='#ff0000'>General Instructions</t>", "instructions\text\general.sqf", [], 10, true, true];
_action = _board addAction ["<t color='#3300ff'>How to Teamplay</t>", "instructions\text\teamplay.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#3399ff'>Comm Channels</t>", "instructions\text\commsChannels.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#00ff33'>Side Missions</t>", "instructions\text\sideMissions.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#0000ff'>Intel Gathering</t>", "instructions\text\intelGathering.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#00ff88'>Humanitarian Aid</t>", "instructions\text\humanitarianAid.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#ff0000'>About Roadside IEDs</t>", "instructions\text\IED.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#0033ff'>Want to fly a helicopter?</t>", "instructions\text\choppers.sqf", [], 10, false, true];
_action = _board addAction ["<t color='#00ff33'>Join Tier 1!</t>", "instructions\text\joinTier1.sqf", [], 10, false, true];

_boardpos = getPos _board;
while { true } do { sleep 60; _board setpos _boardpos; _board setvectorup [0,0,1]; _board setdir 15; };

