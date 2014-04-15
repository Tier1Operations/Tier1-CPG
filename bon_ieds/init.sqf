//by Bon_Inf*
// very simple IED script :-P


BON_IED_PATH = "bon_ieds\";


bon_number_ieds = ieds_number_in_mission;
bon_number_fake_ieds = ieds_number_in_mission;
bon_number_fake_ieds2 = 1;

bon_ied_container = [
	"Land_GarbageBags_F","Land_GarbageWashingMachine_F","Land_GarbagePallet_F","Land_JunkPile_F","Land_Tyre_F","Land_Tyres_F",
	"Land_WheelCart_F","Land_WoodenBox_F","Land_WoodenCart_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Car_F","Land_Wreck_Car2_F",
	"Land_Wreck_Car3_F","Land_Wreck_BRDM2_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Truck_F"
];

bon_fake_ied_container = [
	"Land_GarbageBags_F","Land_GarbageWashingMachine_F","Land_GarbagePallet_F","Land_JunkPile_F","Land_Tyre_F","Land_Tyres_F",
	"Land_WheelCart_F","Land_WoodenBox_F","Land_WoodenCart_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Car_F","Land_Wreck_Car2_F",
	"Land_Wreck_Car3_F","Land_Wreck_BRDM2_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Truck_F"
];

bon_fake_ied_container2 = [
	"Land_GarbageBags_F","Land_GarbageWashingMachine_F","Land_GarbagePallet_F","Land_JunkPile_F","Land_Tyre_F","Land_Tyres_F",
	"Land_WheelCart_F","Land_WoodenBox_F","Land_WoodenCart_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Car_F","Land_Wreck_Car2_F",
	"Land_Wreck_Car3_F","Land_Wreck_BRDM2_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Truck_F"
];

// bon_ied_boomlist = ["ARTY_Sh_81_HE","ARTY_Sh_105_HE","ARTY_R_227mm_HE","ARTY_Sh_122_HE","ARTY_Sh_105_WP","ARTY_Sh_122_WP"];


bon_ied_boomlist = ["R_60mm_HE"];

[] execVM (BON_IED_PATH+"ied_creation.sqf");

