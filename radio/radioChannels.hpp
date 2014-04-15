class RadioChannels_Button {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.049216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	soundEnter[] = {"\A3\ui_f\data\sound\onover", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\new1", 0.0, 0};
	soundClick[] = {"\A3\ui_f\data\sound\onclick", 0.07, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\onescape", 0.09, 1};
	colorBackground[] = {0, 0, 0, 0.8};
	colorBackground2[] = {1, 1, 1, 0.5};
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class TextPos {
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	
	class Attributes {
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "center";
		shadow = "false";
	};
	
	class ShortcutPos {
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};

class RadioChannels_Button2 : RadioChannels_Button {
	animTextureNormal = "";
	animTextureDisabled = "";
	animTextureOver = "";
	animTextureFocused = "";
	animTexturePressed = "";
	animTextureDefault = "";
	textureNoShortcut = "";
	colorFocused[] = {0, 0, 0, 0};
	colorBackgroundActive[] = {0, 0, 0, 0};
	color[] = {0, 0, 0, 0};
	colorBackground[] = {0, 0, 0, 0};
	colorDisabled[] = {0, 0, 0, 0};
};

class RadioChannels_Text {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 0;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	colorText[] = {1, 1, 1, 1.0};
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
};

class RadioChannels
{
	name = "RadioChannels";
	idd = 2815;
	movingEnable = true;
	enableSimulation = true;

	class controlsBackground {
	
		class RadioChannels_TitleBackground : RadioChannels_Text {
			colorBackground[] = {
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", 
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", 
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 
				"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"
			};
			idc = -1;
			x = 0.25;
			y = 0.2;
			w = 0.5;
			h = (1 / 25);
		};

		class MainBackground : RadioChannels_Text {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.25;
			y = 0.2 + (11 / 250);
			w = 0.5;
			h = 0.4 - (22 / 250);
		};
		
		class PlatoonChannel : RadioChannels_Text
		{
			idc = -1;
			text = "Platoon Channel";
			x = 0.28;
			y = 0.285;
			w = 0.275;
			h = 0.04;
			colorText[] = {1.0, 0.3, 0, 1};
		};
		
		class AlphaSquadChannel : RadioChannels_Text
		{
			idc = -1;
			text = "Alpha Squad Channel";
			x = 0.28;
			y = 0.345;
			w = 0.275;
			h = 0.04;
			colorText[] = {1.0, 0, 0, 1};
		};
		
		class BravoSquadChannel : RadioChannels_Text
		{
			idc = -1;
			text = "Bravo Squad Channel";
			x = 0.28;
			y = 0.405;
			w = 0.275;
			h = 0.04;
			colorText[] = {0, 0.4, 0.93, 1};
		};
		class CharlieSquadChannel : RadioChannels_Text
		{
			idc = -1;
			text = "Charlie Squad Channel";
			x = 0.28;
			y = 0.465;
			w = 0.275;
			h = 0.04;
			colorText[] = {1, 0.5, 0, 1};
		};
		
	};

	class controls 
	{
			class Title : RadioChannels_Text {
				colorBackground[] = {0, 0, 0, 0};
				idc = -1;
				text = "Radio Channels";
				x = 0.25;
				y = 0.2;
				w = 0.8;
				h = (1 / 25);
				shadow = 0;
				colorText[] = {0.95, 0.95, 0.95, 1};
			};
			
			class PlatoonButton : RadioChannels_Button2 {
				idc = 100;
				text = "";
				action = "[0] call fnc_channelStatus;";
				x = 0.58;
				y = 0.285;
				w = (6.25 / 40);
				h = 0.04;
			};

			class AlphaSquadButton : RadioChannels_Button2 {
				idc = 200;
				text = "";
				action = "[1] call fnc_channelStatus;";
				x = 0.58;
				y = 0.345;
				w = (6.25 / 40);
				h = 0.04;
			};

			class BravoSquadButton : RadioChannels_Button2 {
				idc = 300;
				text = "";
				action = "[2] call fnc_channelStatus;";
				x = 0.58;
				y = 0.405;
				w = (6.25 / 40);
				h = 0.04;
			};
			class CharlieSquadButton : RadioChannels_Button2 {
				idc = 400;
				text = "";
				action = "[3] call fnc_channelStatus;";
				x = 0.58;
				y = 0.465;
				w = (6.25 / 40);
				h = 0.04;
			};
			
			class CloseButton : RadioChannels_Button {
				idc = -1;
				text = "Close";
				onButtonClick = "closeDialog 0;";
				default = true;
				x = 0.420;
				y = 0.7 - (1 / 25);
				w = (6.25 / 40);
				h = (1 / 25);
			};
	};
};
