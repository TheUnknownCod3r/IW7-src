/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3081.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:07 AM
*******************************************************************/

//Function Number: 1
func_97F9()
{
	self.var_71A1 = ::func_5673;
	self.var_719D = ::func_4D6D;
	lib_0A15::setupdestructibledoors();
}

//Function Number: 2
func_4D6D(param_00)
{
	var_01 = 0;
	switch(param_00.updategamerprofileall)
	{
		case "hip_pack_left":
		case "hip_pack_right":
		case "torso":
		case "head":
			break;

		case "right_arm":
		case "left_arm":
			var_01 = 1;
			break;
	}

	lib_0A0B::func_98C9(param_00.updategamerprofileall);
	if(self._blackboard.scriptableparts[param_00.updategamerprofileall].state == "dismember")
	{
		return;
	}

	var_02 = "dmg_" + param_00.spawnscriptitem;
	var_03 = 0;
	if(var_01)
	{
		if(self._blackboard.scriptableparts[param_00.updategamerprofileall].state == "dmg_upper" || self._blackboard.scriptableparts[param_00.updategamerprofileall].state == "dmg_lower")
		{
			var_03 = 1;
		}
	}

	if(var_03)
	{
		self _meth_847D(param_00.updategamerprofileall);
		return;
	}

	lib_0A0B::func_F592(param_00.updategamerprofileall,var_02);
	if(var_01 && param_00.spawnscriptitem == "upper" && self.var_13CC3[strtok(param_00.updategamerprofileall,"_")[0]] == "rocket")
	{
		lib_0C47::func_10907();
	}
}

//Function Number: 3
func_5673(param_00)
{
	var_01 = 1;
	switch(param_00.updategamerprofileall)
	{
		case "left_arm":
			func_5668();
			break;

		case "right_arm":
			func_5675();
			break;

		case "left_leg":
			func_566A();
			break;

		case "right_leg":
			func_5677();
			break;

		case "hip_pack_left":
			func_5669();
			var_01 = 0;
			break;

		case "hip_pack_right":
			func_5676();
			var_01 = 0;
			break;

		case "head":
			func_5666();
			break;

		case "torso":
			break;

		default:
			break;
	}

	if(isdefined(self.var_C925) && isdefined(self.var_C925[param_00.updategamerprofileall]))
	{
		self.var_C925[param_00.updategamerprofileall] delete();
		self.var_C925 = scripts\sp\_utility::func_22B2(self.var_C925,param_00.updategamerprofileall);
	}

	self notify(param_00.updategamerprofileall + "_dismembered");
	if(self getthreatbiasgroup() != "c12" && issubstr(param_00.updategamerprofileall,"arm") || issubstr(param_00.updategamerprofileall,"leg"))
	{
		thread func_6620();
	}

	func_5674(param_00.updategamerprofileall,var_01);
}

//Function Number: 4
func_5674(param_00,param_01)
{
	lib_0A0B::func_98C9(param_00);
	if(lib_0A0B::func_7C35(param_00) == "dismember")
	{
		return;
	}

	if(isdefined(self.bt.var_55CF))
	{
		return;
	}

	var_02 = 0.25;
	if(param_00 == "head")
	{
		var_02 = 0;
	}

	thread lib_0A0B::func_F592(param_00,"dismember",var_02);
	lib_0A0B::func_F6C9(param_00);
	thread func_3544(param_00);
	if(isdefined(self.bt.var_55CE))
	{
		return;
	}

	if(param_01)
	{
		scripts/asm/asm::asm_setstate("dismember");
	}
}

//Function Number: 5
func_5666()
{
	scripts/asm/asm_bb::bb_setselfdestruct(1);
	playrumbleonposition("light_1s",self gettagorigin("j_neck"));
}

//Function Number: 6
func_5668()
{
	var_00 = "left";
	if(self.var_13CC3[var_00] == "rocket" && isdefined(self.var_E601))
	{
		self.var_E601 delete();
	}

	lib_0A05::func_3555(var_00,0);
	scripts/asm/asm_bb::bb_setcanrodeo(var_00);
	if(getdvarint("c12_slowturn"))
	{
		lib_0A05::func_3609(0.05);
	}

	if(func_9D45("left_arm"))
	{
		func_5678();
	}

	playrumbleonposition("light_1s",self gettagorigin("j_clavicle_le"));
}

//Function Number: 7
func_5675()
{
	var_00 = "right";
	if(self.var_13CC3[var_00] == "rocket" && isdefined(self.var_E601))
	{
		self.var_E601 delete();
	}

	lib_0A05::func_3555(var_00,0);
	scripts/asm/asm_bb::bb_setcanrodeo(var_00);
	if(getdvarint("c12_slowturn"))
	{
		lib_0A05::func_3609(0.05);
	}

	if(func_9D45("right_arm"))
	{
		func_5678();
	}

	playrumbleonposition("light_1s",self gettagorigin("j_clavicle_ri"));
}

//Function Number: 8
func_566A()
{
	if(func_9D45("left_leg"))
	{
		func_5678();
	}

	playrumbleonposition("light_1s",self gettagorigin("j_mainroot2"));
}

//Function Number: 9
func_5677()
{
	if(func_9D45("right_leg"))
	{
		func_5678();
	}

	playrumbleonposition("light_1s",self gettagorigin("j_mainroot2"));
}

//Function Number: 10
func_5669()
{
}

//Function Number: 11
func_5676()
{
}

//Function Number: 12
func_9E23(param_00)
{
	return 0;
}

//Function Number: 13
func_9D45(param_00)
{
	var_01 = ["left_arm","right_arm","left_leg","right_leg"];
	var_01 = scripts\engine\utility::array_remove(var_01,param_00);
	foreach(var_03 in var_01)
	{
		if(scripts/asm/asm_bb::ispartdismembered(var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
func_5678()
{
	scripts/asm/asm_bb::bb_setselfdestruct(1);
	if(!isdefined(self.script_noteworthy) || self.script_noteworthy != "enemy_hill_intro_c12")
	{
		lib_0A05::func_3634("c12AchievementSelfdestruct");
	}
}

//Function Number: 15
func_6620()
{
	var_00 = level.player getthreatbiasgroup();
	if(!function_0218("c12"))
	{
		function_004E("c12");
	}

	if(!function_0218("player"))
	{
		function_004E("player");
	}

	self give_zombies_perk("c12");
	level.player give_zombies_perk("player");
	function_01D1("player","c12",99999);
	self waittill("death");
	if(var_00 != "")
	{
		level.player give_zombies_perk(var_00);
		return;
	}

	level.player give_zombies_perk();
}

//Function Number: 16
func_3544(param_00)
{
	if(param_00 == "right_arm" || param_00 == "left_arm")
	{
		self playsound("c12_dismember_arm");
	}

	if(param_00 == "right_leg" || param_00 == "left_leg")
	{
		self playsound("c12_dismember_leg");
	}
}