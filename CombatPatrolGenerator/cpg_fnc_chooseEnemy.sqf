


//	This script chooses a random enemy group that is to be spawned. Group type depends on the parameter. It returns a group config.
//
//	Parameters:
//	_this select 0: Integer - Must be either 0 or 1. The number 0 will select infantry and 1 will select ground vehicles.
//
//	Returns: Group Config



_type = _this select 0;
_cfggrp = " ";



// Infantry
if (_type == 0) then 
{
	switch (floor(random 5)) do 
	{
		case 0:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry"); };
		case 1:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"); };
		case 2:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons"); };
		case 3:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"); };
		case 4:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_EOD"); };
		case 5:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"); };
	};
};



// Ground vehicles
if (_type == 1) then 
{
	switch (floor(random 2)) do 
	{
		case 0:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_AT"); };
		case 1:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInfTeam"); };
		case 2:
			{ _cfggrp = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInfTeam"); };
	};
};



_cfggrp