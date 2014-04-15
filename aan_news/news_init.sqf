
disableserialization;

_header = _this select 0;
_line = _this select 1;

3000 cutrsc ["rscAAN","plain"];
_display = uinamespace getvariable "BIS_AAN";
_textHeader = _display displayctrl 3001;
_textHeader ctrlsetstructuredtext _header; // title
_textHeader ctrlcommit 0;

_textLine = _display displayctrl 3002;
_textLine ctrlsetstructuredtext _line; // stuff in reel
_textLine ctrlcommit 0;
_textLinePos = ctrlposition _textLine;
_textLinePos set [0,-100];
_textLine ctrlSetPosition _textLinePos;
_textLine ctrlcommit 1500;

_textClock = _display displayctrl 3003;
while {!isnull _display} do {

	_textClock ctrlsettext ([daytime,"HH:MM"] call bis_fnc_timetostring);
	_textClock ctrlcommit 0;
	sleep 60;
};
