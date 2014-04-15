
_board = (_this select 0);

_action = _board addAction ["<t color='#00ff33'>Join Tier 1!</t>", "instructions\text\joinTier1.sqf", [], 10, true, true];
_action = _board addAction ["<t color='#3300ff'>How to Teamplay</t>", "instructions\text\teamplay.sqf", [], 10, false, true];

_boardpos = getPos _board;
while { true } do { sleep 60; _board setpos _boardpos; _board setvectorup [0,0,1]; _board setdir 0; };

