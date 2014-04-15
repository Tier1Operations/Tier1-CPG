//	EXECUTE MARKER SCRIPT FOR EACH GROUP AND PASS VARIABLES
//	Run on the clients.


["Grp_PL", 10, "PL", "ColorBrown"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_ASL", 1, "ASL", "ColorRed"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_A1", 2, "A1", "ColorRed"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_A2", 2, "A2", "ColorRed"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_A3", 2, "A3", "ColorRed"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_BSL", 1, "BSL", "ColorBlue"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_B1", 2, "B1", "ColorBlue"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_B2", 2, "B2", "ColorBlue"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_B3", 2, "B3", "ColorBlue"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
//["Grp_Fox1", 8, "Fox1", "ColorRed"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
//["Grp_Fox2", 8, "Fox2", "ColorBlue"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
//["Grp_Hammer1", 8, "H1", "ColorBrown"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_CSL", 1, "CSL", "ColorOrange"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_C1", 2, "C1", "ColorOrange"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_C2", 2, "C2", "ColorOrange"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_C3", 2, "C3", "ColorOrange"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
["Grp_Shadow1", 6, "S1", "ColorBlack"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
//["Grp_Shadow2", 6, "S2", "ColorBlack"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
//["Grp_Reaper1", 9, "R1", "ColorGreen"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";
//["Grp_Reaper2", 9, "R2", "ColorGreen"] execVM "Tier1\UnitMarkers\groupmarkers.sqf";

if (!(isNil "reaper11")) then
{
	[Reaper11, 9, "R1", "ColorGreen"] execVM "Tier1\UnitMarkers\unitmarker.sqf";
	Reaper11 addEventHandler ["Respawn","[Reaper11, 9, 'R1', 'ColorGreen'] execVM 'Tier1\UnitMarkers\unitmarker.sqf';"];
};

if (!(isNil "reaper12")) then
{
	[Reaper12, 9, "R2", "ColorGreen"] execVM "Tier1\UnitMarkers\unitmarker.sqf";
	Reaper12 addEventHandler ["Respawn","[Reaper12, 9, 'R2', 'ColorGreen'] execVM 'Tier1\UnitMarkers\unitmarker.sqf';"];
};

if (!(isNil "reaper13")) then
{
	[Reaper13, 9, "R3", "ColorGreen"] execVM "Tier1\UnitMarkers\unitmarker.sqf";
	Reaper13 addEventHandler ["Respawn","[Reaper13, 9, 'R3', 'ColorGreen'] execVM 'Tier1\UnitMarkers\unitmarker.sqf';"];
};

if (!(isNil "Raptor1")) then
{
	[Raptor1, 9, "RA1", "ColorBrown"] execVM "Tier1\UnitMarkers\unitmarker.sqf";
	Raptor1 addEventHandler ["Respawn","[Raptor1, 9, 'RA1', 'ColorBrown'] execVM 'Tier1\UnitMarkers\unitmarker.sqf';"];
};

if (true) exitWith {};