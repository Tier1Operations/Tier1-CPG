
while {true} do 
{
	sleep 5;
	
	_forbidden = ["arifle_Katiba_ACO_F", "arifle_Katiba_ACO_pointer_F", "arifle_Katiba_ARCO_F", "arifle_Katiba_ARCO_pointer_F", "arifle_Katiba_C_ACO_F", "arifle_Katiba_C_ACO_pointer_F", "arifle_Katiba_C_F", "arifle_Katiba_F", "arifle_Katiba_GL_ACO_F", "arifle_Katiba_GL_ACO_pointer_F", "arifle_Katiba_GL_ARCO_pointer_F", "arifle_Katiba_GL_F", "LMG_Mk200_F", "LMG_Mk200_MRCO_F", "LMG_Mk200_pointer_F"];
	_weapon = primaryweapon player;
	
	{
		if (_x == _weapon) then
		{
			player removeweapon _weapon;
		};
	} forEach _forbidden;
	
};