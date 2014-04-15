class Mode_SemiAuto {
aidispersioncoefx = 1.4;
aidispersioncoefy = 1.7;
airateoffire = 2;
airateoffiredistance = 500;
artillerycharge = 1;
artillerydispersion = 1;
autofire = 0;
burst = 1;
canshootinwater = 0;
dispersion = 0.0002;
displayname = "Semi";
ffcount = 1;
fffrequency = 11;
ffmagnitude = 0.5;
flash = "gunfire";
flashsize = 0.1;
maxrange = 600;
maxrangeprobab = 0.04;
midrange = 300;
midrangeprobab = 0.58;
minrange = 30;
minrangeprobab = 0.25;
multiplier = 1;
recoil = "recoil_single_primary_3outof10";
recoilprone = "recoil_single_primary_prone_3outof10";
reloadtime = 0.1;
requiredoptictype = -1;
showtoplayer = 1;
sound[] = {"", 10, 1};
soundbegin[] = {"sound", 1};
soundbeginwater[] = {"sound", 1};
soundburst = 0;
soundclosure[] = {"sound", 1};
soundcontinuous = 0;
soundend[] = {};
soundloop[] = {};
texturetype = "semi";
useaction = 0;
useactiontitle = "";
weaponsoundeffect = "";
};

class CfgWeapons {

class Default {
access = 0;
aidispersioncoefx = 1;
aidispersioncoefy = 1;
airateoffire = 5;
airateoffiredistance = 500;
ammo = "";
artillerycharge = 1;
artillerydispersion = 1;
autofire = 0;
autoreload = 1;
backgroundreload = 0;
ballisticscomputer = 0;
burst = 1;
candrop = 1;
canlock = 2;
canshootinwater = 0;
cartridgepos = "nabojnicestart";
cartridgevel = "nabojniceend";
cmimmunity = 1;
count = 0;
cursor = "";
cursoraim = "";
cursoraimon = "";
cursorsize = 1;
descriptionshort = "";
detectrange = 0;
dispersion = 0.002;
displayname = "";
disposableweapon = 0;
distancezoommax = 400;
distancezoommin = 400;
drysound[] = {"", 1, 1};
emptysound[] = {"", 1, 1};
enableattack = 1;
ffcount = 1;
fffrequency = 1;
ffmagnitude = 0;
fireanims[] = {};
firelightduration = 0.05;
firelightintensity = 0.012;
firespreadangle = "3.0f";
forceoptics = 0;
handanim[] = {};
hiddenselections[] = {};
hiddenselectionstextures[] = {};
hiddenunderwaterselections[] = {};
hiddenunderwaterselectionstextures[] = {};
initspeed = 0;
irdistance = 0;
irdotintensity = 0.001;
irlaserend = "laser dir";
irlaserpos = "laser pos";
laser = 0;
lockacquire = 1;
lockedtargetsound[] = {"\A3\sounds_f\dummysound", 0.000316228, 6};
lockingtargetsound[] = {"\A3\sounds_f\dummysound", 0.000316228, 2};
magazinereloadtime = 0;
magazines[] = {};
maxrange = 500;
maxrangeprobab = 0.04;
maxrecoilsway = 0.008;
memorypointcamera = "eye";
midrange = 150;
midrangeprobab = 0.58;
minrange = 1;
minrangeprobab = 0.3;
model = "";
modelmagazine = "";
modeloptics = "";
modelspecial = "";
modes[] = {"this"};
multiplier = 1;
muzzleend = "konec hlavne";
muzzlepos = "usti hlavne";
muzzles[] = {"this"};
namesound = "";
optics = 1;
opticsdisableperipherialvision = 0.67;
opticsflare = 1;
opticsid = 0;
opticsppeffects[] = {};
opticszoominit = 0.35;
opticszoommax = 0.35;
opticszoommin = 0.35;
picture = "";
primary = 10;
recoil = "empty";
recoilprone = "";
reloadaction = "";
reloadmagazinesound[] = {"", 1, 1};
reloadsound[] = {"", 1, 1};
reloadtime = 1;
scope = 0;
selectionfireanim = "zasleh";
showaimcursorinternal = 1;
showempty = 1;
shownunderwaterselections[] = {};
showswitchaction = 0;
showtoplayer = 1;
simulation = "Weapon";
sound[] = {"", 1, 1};
soundbegin[] = {"sound", 1};
soundbeginwater[] = {"sound", 1};
soundbullet[] = {"emptySound", 1};
soundburst = 1;
soundclosure[] = {"sound", 1};
soundcontinuous = 0;
soundend[] = {"sound", 1};
soundloop[] = {"sound", 1};
swaydecayspeed = 2;
texturetype = "default";
type = 65536;
uipicture = "";
useaction = 0;
useactiontitle = "";
useasbinocular = 0;
usemodeloptics = 1;
value = 2;
weaponlockdelay = 0;
weaponlocksystem = 0;
weaponsoundeffect = "";
weight = 0;
class Library {
libtextdesc = "";
};
class GunFire {
access = 0;
cloudletaccy = 0;
cloudletalpha = 1;
cloudletanimperiod = 1;
cloudletcolor[] = {1, 1, 1, 0};
cloudletdensitycoef = -1;
cloudletduration = 0.2;
cloudletfadein = 0.01;
cloudletfadeout = 0.5;
cloudletgrowup = 0.2;
cloudletmaxyspeed = 100;
cloudletminyspeed = -100;
cloudletshape = "cloudletFire";
cloudletsize = 1;
deltat = -3000;
initt = 4500;
interval = -0.01;
size = 3;
sourcesize = 0.5;
timetolive = 0;
class Table {
class T0 {
color[] = {0.82, 0.95, 0.93, 0};
maxt = 0;
};
class T1 {
color[] = {0.75, 0.77, 0.9, 0};
maxt = 200;
};
class T2 {
color[] = {0.56, 0.62, 0.67, 0};
maxt = 400;
};
class T3 {
color[] = {0.39, 0.46, 0.47, 0};
maxt = 600;
};
class T4 {
color[] = {0.24, 0.31, 0.31, 0};
maxt = 800;
};
class T5 {
color[] = {0.23, 0.31, 0.29, 0};
maxt = 1000;
};
class T6 {
color[] = {0.21, 0.29, 0.27, 0};
maxt = 1500;
};
class T7 {
color[] = {0.19, 0.23, 0.21, 0};
maxt = 2000;
};
class T8 {
color[] = {0.22, 0.19, 0.1, 0};
maxt = 2300;
};
class T9 {
color[] = {0.35, 0.2, 0.02, 0};
maxt = 2500;
};
class T10 {
color[] = {0.62, 0.29, 0.03, 0};
maxt = 2600;
};
class T11 {
color[] = {0.59, 0.35, 0.05, 0};
maxt = 2650;
};
class T12 {
color[] = {0.75, 0.37, 0.03, 0};
maxt = 2700;
};
class T13 {
color[] = {0.88, 0.34, 0.03, 0};
maxt = 2750;
};
class T14 {
color[] = {0.91, 0.5, 0.17, 0};
maxt = 2800;
};
class T15 {
color[] = {1, 0.6, 0.2, 0};
maxt = 2850;
};
class T16 {
color[] = {1, 0.71, 0.3, 0};
maxt = 2900;
};
class T17 {
color[] = {0.98, 0.83, 0.41, 0};
maxt = 2950;
};
class T18 {
color[] = {0.98, 0.91, 0.54, 0};
maxt = 3000;
};
class T19 {
color[] = {0.98, 0.99, 0.6, 0};
maxt = 3100;
};
class T20 {
color[] = {0.96, 0.99, 0.72, 0};
maxt = 3300;
};
class T21 {
color[] = {1, 0.98, 0.91, 0};
maxt = 3600;
};
class T22 {
color[] = {1, 1, 1, 0};
maxt = 4200;
};
};
};
class GunClouds {
access = 0;
cloudletaccy = 0;
cloudletalpha = 0.3;
cloudletanimperiod = 1;
cloudletcolor[] = {1, 1, 1, 0};
cloudletduration = 0.05;
cloudletfadein = 0;
cloudletfadeout = 0.1;
cloudletgrowup = 0.05;
cloudletmaxyspeed = 100;
cloudletminyspeed = -100;
cloudletshape = "cloudletClouds";
cloudletsize = 1;
deltat = 0;
initt = 0;
interval = -0.02;
size = 0.3;
sourcesize = 0.02;
timetolive = 0;
class Table {
class T0 {
color[] = {1, 1, 1, 0};
maxt = 0;
};
};
};
};

class CannonCore: Default {
type = 65536;
class GunClouds {
};
};

class mortar_82mm_new: CannonCore {
autoreload = 1;
ballisticscomputer = 2;
canlock = 0;
cursor = "mortar";
cursoraim = "EmptyCursor";
displayname = "Mortar 82mm";
magazinereloadtime = 5;
magazines[] = {"8Rnd_82mm_Mo_shells", "8Rnd_82mm_Mo_Flare_white", "8Rnd_82mm_Mo_Smoke_white", "8Rnd_82mm_Mo_guided", "8Rnd_82mm_Mo_LG", "8Rnd_82mm_Mo_Inc"};
maxleadspeed = 100;
maxrange = 4000;
maxrangeprobab = 0.1;
midrange = 2000;
midrangeprobab = 0.7;
minrange = 80;
minrangeprobab = 0.7;
modes[] = {"Single1"};
namesound = "CannonCore";
reloadsound[] = {"A3\sounds_f\dummysound", 1.12202, 1, 12};
reloadtime = 15;
scope = 1;
sound[] = {"A3\Sounds_F\weapons\Cannons\cannon82mm", 10, 1, 700};
soundservo[] = {"", 0.0001, 1};
class GunParticles {
class FirstEffect {
directionname = "Konec Hlavne";
effectname = "MortarFired";
positionname = "Usti Hlavne";
};
};
class Single1: Mode_SemiAuto {
artillerycharge = 0.35;
artillerydispersion = 0.7;
displayname = "Semi (close)";
maxrange = 0;
midrange = 0;
minrange = 0;
reloadsound[] = {"A3\sounds_f\dummysound", 1.12202, 1, 12};
reloadtime = 1.8;
sound[] = {"A3\Sounds_F\weapons\Cannons\cannon82mm.wav", 10, 1, 500};
soundservo[] = {"", 0.0001, 1};
};
};

};