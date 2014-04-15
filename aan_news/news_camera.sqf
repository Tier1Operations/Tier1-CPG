
disableserialization;

titleCut ["", "BLACK OUT", 1];
sleep 1;

_camera = "camera" camcreate [0,0,0];
_camera cameraeffect ["internal", "back"];

// AAN overlay already has cinemaborder
// showcinemaborder true;

// It has been precompiled in init.sqf
[] spawn raven_news_overlay;

sleep 0.5;
titleCut ["", "BLACK IN", 1];

if ((random 100) < 50) then
{
	playmusic ["Track01_Proteus", 53];
} else
{
	playmusic ["Track05_Underwater2", 0];
};

0 fademusic 1;

_camerashots_1 = [
[[2126, 2125, 2]
];

_camerashots_2 = [
[[2126, 2125, 2]
];

_shot_1 = _camerashots_1 call BIS_fnc_selectRandom;
_shot_2 = _camerashots_2 call BIS_fnc_selectRandom;
// _shot_1 = _camerashots_1 select 3;
// _shot_2 = _camerashots_2 select 7;

_pos_1 = _shot_1 select 0;
_target_1_1 = _shot_1 select 1;
_target_1_2 = _shot_1 select 2;

_pos_2 = _shot_2 select 0;
_target_2_1 = _shot_2 select 1;
_target_2_2 = _shot_2 select 2;

_camera camPreparePos _pos_1;
_camera camPrepareTarget _target_1_1;
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
sleep 2;
_camera camPrepareTarget _target_1_2;
_camera camCommitPrepared 10;

sleep 12;

_camera camPreparePos _pos_2;
_camera camPrepareTarget _target_2_1;
_camera camCommitPrepared 0;
sleep 2;
_camera camPrepareTarget _target_2_2;
_camera camCommitPrepared 10;

sleep 12;

4 fademusic 0;
// FADE OUT TO ACTUAL GAME
titleCut ["", "BLACK OUT", 1];
sleep 1;
3000 cuttext ["", "PLAIN", 1];
sleep 1;

player cameraEffect ["terminate","back"];
camDestroy _camera;

titleCut ["", "BLACK IN", 1];

sleep 2;

playmusic "";