/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\areas.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 315 ms
 * Timestamp: 10/27/2023 12:14:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.softlandingtriggers = getentarray("trigger_multiple_softlanding","classname");
	var_00 = getentarray("destructible_vehicle","targetname");
	foreach(var_02 in level.softlandingtriggers)
	{
		if(var_02.script_type != "car")
		{
			continue;
		}

		foreach(var_04 in var_00)
		{
			if(distance(var_02.origin,var_04.origin) > 64)
			{
				continue;
			}

			var_02.destructible = var_04;
		}
	}

	thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.softlanding = undefined;
		var_00 thread softlandingwaiter();
	}
}

//Function Number: 3
playerentersoftlanding(param_00)
{
	self.softlanding = param_00;
}

//Function Number: 4
playerleavesoftlanding(param_00)
{
	self.softlanding = undefined;
}

//Function Number: 5
softlandingwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("soft_landing",var_00,var_01);
		if(!isdefined(var_00.destructible))
		{
			continue;
		}
	}
}