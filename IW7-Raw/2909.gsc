/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2909.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:24:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread pausemenu_think();
}

//Function Number: 2
pausemenu_think()
{
	for(;;)
	{
		level.player waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "restartMission")
		{
			func_E2B3();
		}
	}
}

//Function Number: 3
func_E2B3()
{
	var_00 = getdvar("version");
	if(var_00 != "" && issubstr(var_00,"IW7_PROFILE") || issubstr(var_00,"IW7_DEMO"))
	{
		map_restart();
		return;
	}

	level.player getrankinfoxpamt();
	var_01 = scripts\sp\_endmission::fireweapon(level.script);
	if(isdefined(var_01))
	{
		function_0039(var_01,0,0);
		return;
	}

	map_restart();
}