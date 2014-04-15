
_ied = _this select 0;

_defuseAct = _ied addAction ["<t color='#0000ff'>Disarm and Clear IED</t>", "bon_ieds\raven_disarmIED.sqf", [], 10, false, true, "", "((getPosATL _target) distance (getPosATL _this) <= 5) && (_this isKindOf 'Man')"];
