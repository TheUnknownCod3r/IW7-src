/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\powers\coop_holywater.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 358 ms
 * Timestamp: 10/27/2023 12:08:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["holyWater_ring_idle"] = loadfx("vfx/iw7/levels/cp_disco/vfx_holywater_ring_idle");
	level._effect["holyWater_explode"] = loadfx("vfx/core/expl/grenade_flash");
	scripts\engine\utility::flag_init("power_holyWater_enabled");
	scripts\engine\utility::flag_init("flag_player_holding_holyWater");
	level.powers["power_holyWater"].var_AD4E = [];
}

//Function Number: 2
giveholywater()
{
	self.holywater = spawnstruct();
	self.holywater.hold_time = 0;
	thread holywater_projectile_watcher();
	scripts\engine\utility::flag_set("power_holyWater_enabled");
}

//Function Number: 3
takeholywater()
{
	level notify("cleanup_holyWater_weapon");
	scripts\engine\utility::flag_clear("power_holyWater_enabled");
	self.holywater = undefined;
}

//Function Number: 4
holywater_projectile_watcher()
{
	level endon("cleanup_holyWater_weapon");
	for(;;)
	{
		self waittill("grenade_fire",var_00);
		if(!isdefined(var_00.weapon_name))
		{
			continue;
		}

		if(var_00.weapon_name != "holywater_cp")
		{
			continue;
		}

		scripts\engine\utility::flag_clear("flag_player_holding_holyWater");
		level notify("holyWater_thrown");
		var_00.triggerportableradarping = self;
		var_00 thread holywater_projectile_instance();
	}
}

//Function Number: 5
holywater_projectile_instance()
{
	self endon("death");
	level.powers["power_holyWater"].var_AD4E = scripts\engine\utility::array_add(level.powers["power_holyWater"].var_AD4E,self);
	var_00 = gettime();
	level.zbg_active = 1;
	self waittill("missile_stuck");
	self hide();
	var_01 = 10 - gettime() - var_00 / 1000;
	var_02 = undefined;
	if(var_01 > 0)
	{
		level notify("holyWater_landed",self);
		var_02 = spawn("script_model",self.origin);
		var_02 setmodel("cp_holywater_trap");
		var_02 linkto(self);
		wait(1);
		var_02 setscriptablepartstate("fx","start");
		var_02 thread create_aod(var_00);
		wait(var_01);
	}

	self notify("aod_removed");
	level.powers["power_holyWater"].var_AD4E = scripts\engine\utility::array_remove(level.powers["power_holyWater"].var_AD4E,self);
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	level.zbg_active = undefined;
	self delete();
}

//Function Number: 6
create_aod(param_00)
{
	var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
	var_02 = scripts\engine\utility::get_array_of_closest(self.origin,var_01,undefined,undefined,64,0);
	foreach(var_04 in var_02)
	{
		var_04.dontmutilate = 1;
		var_04 dodamage(var_04.health + 100,self.origin,self,self,"MOD_UNKNOWN","iw7_electrictrap_zm");
	}

	var_06 = function_027A(self.origin,(72,72,12),(0,0,0),"axis");
	while(isdefined(self))
	{
		wait(0.05);
	}

	destroynavobstacle(var_06);
}