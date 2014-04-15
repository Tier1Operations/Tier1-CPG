
_board = (_this select 0);

_action = _board addAction ["<t color='#00ff88'>Campaign Status</t>", "instructions\campaign\general.sqf", [], 10, true, true];

_boardpos = getPos _board;
while { true } do { sleep 60; _board setpos _boardpos; _board setvectorup [0,0,1]; _board setdir 15; };

