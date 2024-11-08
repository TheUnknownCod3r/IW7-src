/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3607.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:53 AM
*******************************************************************/

//Function Number: 1
func_DD9E()
{
	level._effect["reaper_kill"] = loadfx("vfx/iw7/_requests/mp/vfx_meatbag_large.vfx");
	level._effect["reaper_kill_robot"] = loadfx("vfx/iw7/core/impact/robot/vfx_mp_c6_melee.vfx");
	level._effect["screen_blood"] = loadfx("vfx/iw7/core/zombie/weapon/axe/vfx_zmb_axe_screen_blood.vfx");
}

//Function Number: 2
func_DD9D()
{
	self _meth_845E(1);
	self give_crafted_sentry(1);
	self setclientomnvar("ui_odin",5);
	self give_explosive_touch_on_revived("c6reaperservo");
	thread func_13B7A();
	self playsoundonmovingent("reaper_startup");
	self.health = self.maxhealth;
	self setsuit("reaper_mp");
	func_DD94();
	func_DD99();
	func_DD9B();
	self.var_B62A = spawn("script_model",self.origin);
	self.var_B62A setmodel("tag_origin");
	thread func_13ACC();
	thread func_13A9F();
	thread scripts\mp\_supers::watchobjuse(125);
	return 1;
}

//Function Number: 3
func_DD97()
{
	self endon("death");
	self endon("disconnect");
	self notify("reaper_removed");
	self notify("obj_drain_end");
	self _meth_845E(0);
	self give_crafted_sentry(0);
	self setclientomnvar("ui_odin",-1);
	self thermalvisionoff();
	self give_explosive_touch_on_revived(self.var_42B0);
	self playlocalsound("reaper_shutdown");
	if(scripts\mp\_utility::istrue(level.tactical))
	{
		self setsuit("scout_mp_tactical");
	}
	else
	{
		self setsuit("scout_mp");
	}

	func_DD98();
	reaper_restorerigperks();
	func_DD9A();
	self.var_B62A delete();
}

//Function Number: 4
func_13A9F()
{
	self endon("death");
	self endon("disconnect");
	self endon("reaper_removed");
	level endon("game_ended");
	for(;;)
	{
		self waittill("got_a_kill");
		self.health = self.maxhealth;
		var_00 = self getvieworigin();
		playfx(level._effect["screen_blood"],var_00);
	}
}

//Function Number: 5
func_13B7A()
{
	self endon("death");
	self endon("disconnect");
	self endon("reaper_removed");
	level endon("game_ended");
	var_00 = 0;
	self thermalvisionoff();
	self notifyonplayercommand("switch_reaper_thermal","+usereload");
	self notifyonplayercommand("switch_reaper_thermal","+activate");
	for(;;)
	{
		self waittill("switch_reaper_thermal");
		if(!var_00)
		{
			self thermalvisionon();
		}
		else
		{
			self thermalvisionoff();
		}

		self playlocalsound("reaper_thermal_toggle");
		var_00 = !var_00;
	}
}

//Function Number: 6
func_13ACC()
{
	self endon("death");
	self endon("disconnect");
	self endon("reaper_removed");
	level endon("game_ended");
	var_00 = (0,0,32);
	for(;;)
	{
		self waittill("melee_fired");
		self setscriptablepartstate("reaper_claws","claws_on_fire",0);
	}
}

//Function Number: 7
func_DD99()
{
	if(scripts\mp\_utility::_hasperk("specialty_dodge"))
	{
		self.restoredodge = "specialty_dodge";
		self setclientomnvar("ui_dodge_charges",0);
		self notify("setDodge");
		scripts\mp\_utility::removeperk("specialty_dodge");
	}

	if(scripts\mp\_utility::_hasperk("specialty_afterburner"))
	{
		self.restoreafterburner = "specialty_afterburner";
		scripts\mp\_utility::removeperk("specialty_afterburner");
	}

	if(scripts\mp\_utility::_hasperk("specialty_rush"))
	{
		self.restorerush = "specialty_rush";
		scripts\mp\_utility::removeperk("specialty_rush");
	}

	self goal_radius(0,400);
}

//Function Number: 8
reaper_restorerigperks()
{
	if(isdefined(self.restoredodge))
	{
		scripts\mp\_utility::giveperk(self.restoredodge);
		self.restoredodge = undefined;
	}

	if(isdefined(self.restoreafterburner))
	{
		scripts\mp\_utility::giveperk(self.restoreafterburner);
		self.restoreafterburner = undefined;
	}

	if(isdefined(self.restorerush))
	{
		scripts\mp\_utility::giveperk(self.restorerush);
		self.restorerush = undefined;
	}

	self goal_radius(0,50);
}

//Function Number: 9
func_DD94()
{
	scripts\mp\_utility::giveperk("specialty_extendedmelee");
	scripts\mp\_utility::giveperk("specialty_fastermelee");
	scripts\mp\_utility::giveperk("specialty_sprintmelee");
	scripts\mp\_utility::giveperk("specialty_commando");
	scripts\mp\_utility::giveperk("specialty_selectivehearing");
	scripts\mp\_utility::giveperk("specialty_heartbreaker");
	scripts\mp\_utility::giveperk("specialty_stun_resistance");
	scripts\mp\_utility::giveperk("specialty_ghost");
}

//Function Number: 10
func_DD98()
{
	scripts\mp\_utility::removeperk("specialty_extendedmelee");
	scripts\mp\_utility::removeperk("specialty_fastermelee");
	scripts\mp\_utility::removeperk("specialty_sprintmelee");
	scripts\mp\_utility::removeperk("specialty_commando");
	scripts\mp\_utility::removeperk("specialty_selectivehearing");
	scripts\mp\_utility::removeperk("specialty_heartbreaker");
	scripts\mp\_utility::removeperk("specialty_stun_resistance");
	scripts\mp\_utility::removeperk("specialty_ghost");
}

//Function Number: 11
func_DD9B()
{
	self disableweaponpickup();
	scripts\engine\utility::allow_slide(0);
	scripts\engine\utility::allow_prone(0);
	scripts\engine\utility::allow_usability(0);
	scripts\mp\_utility::func_1C47(0);
	scripts\mp\_powers::func_D729();
}

//Function Number: 12
func_DD9A()
{
	self enableweaponpickup();
	scripts\engine\utility::allow_slide(1);
	scripts\engine\utility::allow_prone(1);
	scripts\engine\utility::allow_usability(1);
	scripts\mp\_utility::func_1C47(1);
	scripts\mp\_powers::func_D72F();
}

//Function Number: 13
func_93D9()
{
	return scripts\engine\utility::ter_op(scripts\mp\_utility::istrue(level.hardcoremode),19,50);
}

//Function Number: 14
func_A668()
{
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	var_00 = self _meth_8113();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = var_00.origin;
	if(self.loadoutarchetype == "archetype_scout")
	{
		playfx(level._effect["reaper_kill_robot"],var_01 + (0,0,12));
	}
	else
	{
		playfx(level._effect["reaper_kill"],var_01 + (0,0,12));
	}

	if(isdefined(var_00))
	{
		var_00 hide(1);
		var_00.permanentcustommovetransition = 1;
	}
}

//Function Number: 15
isusingreaper()
{
	if(!isplayer(self))
	{
		return 0;
	}

	if(!scripts\mp\_utility::isreallyalive(self))
	{
		return 0;
	}

	var_00 = scripts\mp\_supers::getcurrentsuperref();
	if(!isdefined(var_00) || var_00 != "super_reaper")
	{
		return 0;
	}

	return scripts\mp\_supers::issuperinuse();
}