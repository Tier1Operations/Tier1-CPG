
//	Initialize briefing.
[
	[
		"Mission",
		[
			"Enemies have been spotted in the area. Your job is to patrol the marked areas and neutralize any hostiles you meet along the way.<br/><br/>Note: The mission is randomized each time you start it. Markers will show up shortly after the mission has started. This mission does not end automatically, an admin will need to end the mission."
		]
	],
	[
		"Rules",
		[
			"1. Please do not pick the pilot slot without permission and keep in mind you have to be on the Tier1 Ops Teamspeak server if you want to fly. First ask if a pilot is needed and if there's an admin online he will give you an answer.<br/><br/>2. Do not fire in the spawn area / friendly base. Especially, do not fire at the transport helicopters that are being piloted by players, they are friendly!<br/><br/>Note: There are often pilots transporting people from the spawn to the frontline. You should ask if there's a pilot doing transport runs, and if there is one, then you can wait at base for pickup."
		]
	],
	[
		"Info",
		[
			"Keep in mind that medics can revive people.<br/><br/>This mission was created by Tier 1 Operations. We are an Arma community who prefer to play tactical coop missions.<br/><br/>We are always recruiting, so check us out at:<br/><br/>http://www.tier1ops.eu<br/><br/>Also, feel free to join us on our TeamSpeak server:<br/><br/>Server: ts.tier1ops.eu<br/>Password: welcome"
		]
	],
	[
		"Credits",
		[
			"Mission created by BlackAlpha @ Tier 1 Operations.<br/>http://www.tier1ops.eu<br/>This mission utilizes UPSMON created by various different people. You may find more info on UPSMON at the official Arma 3 Scripting forum.<br/>This mission utilizes BTC Revive created by the Black Templars Clan, modified by BlackAlpha.<br/>This mission utilizes TPWCAS AI suppression script created by TPW, Coulum, fabrizio_T and Ollem (Tier1ops).<br/>This mission utilizes Admin Actions created by [KH]Jman, modified by BlackAlpha.<br/>This mission utilizes Vehice Service script, created by (unknown), modified by BlackAlpha.<br/>This mission utilizes Folk Group Marker script from the F2 Framework, created by Folk.<br/>This mission utilizes Setskill Script, created by Ollem (Tier1ops) and Sonsalt (Tier1ops).<br/>This mission utilizes UAV script from Ahoy World, edited by WhiteRaven.<br/>Special thanks to Tweet (Tier1ops) and FreeFire (Tier1ops) for helping create the concept of the vehicle spawning facilities."
		]
	]
]
call {
	if (not isdedicated) then {
		private "_briefing";
		_briefing = _this;
		waituntil {not isnull player};
		for "_i" from ((count _briefing) - 1) to 0 step -1 do {
			for [{_k = (count (_briefing select _i select 1)) - 1},{_k >= 0},{_k = _k - 1}] do {
				player createDiaryRecord ["Diary", [_briefing select _i select 0,_briefing select _i select 1 select _k]];
			};
		};
	};
};