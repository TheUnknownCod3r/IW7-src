// IW7 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_F478( var_0 )
{
    level._id_B161 = var_0;
    level._id_A8E2 = var_0;
}

_id_94EF()
{
    wait 2;
    level.currentweaponlist = [];
    level.activewheels = 0;
    level.current_active_wheel = undefined;
    level._id_13D01 = 0;
    level._id_B162 = 0;
    level._id_B160 = [];
    level._id_6D28 = ::_id_10C4D;
    level._id_B163 = getentarray( "magic_wheel", "script_noteworthy" );

    foreach ( var_1 in level._id_B163 )
    {
        var_1.origin = var_1.origin + ( 0, 0, 0.15 );
        var_1._id_2135 = _id_7828( var_1 );
        level._id_B160[level._id_B160.size] = var_1._id_2135;
        var_1._id_E74A = _id_7C20();
        var_1._id_13C25 = _id_7ABF();
        var_2 = scripts\engine\utility::_id_7E2E( var_1.origin, scripts\engine\utility::_id_8180( "spinner", "script_noteworthy" ) );
        var_3 = spawn( "script_model", var_2.origin + ( 0, 0, 0.15 ) );

        if ( !isdefined( var_2.angles ) )
            var_2.angles = ( 0, 0, 0 );

        var_3.angles = var_2.angles;
        var_3 setmodel( "zmb_magic_wheel_spinner" );
        var_1._id_10A03 = var_3;
        var_1 _meth_8318( 1 );
        level thread _id_9672( var_1 );
        var_1 thread _id_13643();
        scripts\engine\utility::waitframe();
    }
}

magic_wheel_tutorial()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "saw_wheel_tutorial" );
    wait 5;
    var_0 = cos( 65 );

    for (;;)
    {
        var_1 = level._id_B163;
        var_2 = sortbydistance( var_1, self.origin );

        if ( !self._id_8EB0 && var_2.size > 0 )
        {
            if ( distancesquared( var_2[0].origin, self.origin ) < 9216 && scripts\engine\utility::within_fov( self.origin, self.angles, var_2[0].origin, var_0 ) )
            {
                thread _id_0A57::_id_12AAE( "magic_wheel" );
                wait 1;
                self notify( "saw_wheel_tutorial" );
            }
        }

        wait 0.25;
    }
}

_id_7ABF()
{
    return scripts\engine\utility::_id_22A8( level._id_B15E );
}

_id_13643()
{
    self endon( "delete_wheel" );

    for (;;)
    {
        self waittill( "trigger", var_0 );

        if ( !var_0 _id_0A77::_id_9D05() )
            continue;

        var_1 = scripts\engine\utility::_id_9CEE( self._id_8B7D );

        if ( var_1 )
        {
            level thread _id_51EB( self, var_0, 1 );
            continue;
        }

        if ( isdefined( level.wheel_purchase_check ) )
        {
            var_1 = [[ level.wheel_purchase_check ]]( self, var_0 );

            if ( var_1 )
            {
                level thread [[ level.wheel_hint_func ]]( self, var_0, 1 );
                continue;
            }
        }

        if ( scripts\engine\utility::_id_6E34( "fire_sale" ) && scripts\engine\utility::_id_6E25( "fire_sale" ) )
            var_2 = 10;
        else
            var_2 = 950;

        if ( var_0 _id_0A63::_id_D0BB( var_2 ) )
        {
            var_0 _id_0A63::_id_11445( var_2, 1, "magic_wheel" );
            _id_12FFA( var_0, self, var_2 );
            var_0 notify( "magic_wheel_used" );
            continue;
        }

        level thread _id_51EB( self, var_0 );
    }
}

_id_51EB( var_0, var_1, var_2 )
{
    var_1 endon( "disconnect" );
    var_1 playlocalsound( "purchase_deny" );

    if ( isdefined( var_2 ) )
        var_1 _meth_80F4( &"COOP_INTERACTIONS_CANNOT_BUY" );
    else
    {
        var_1 thread _id_0A6A::_id_12885( "no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50 );
        var_1 _meth_80F4( &"COOP_INTERACTIONS_NEED_MONEY" );
    }

    wait 1;
    var_1 _meth_80F3();
}

_id_BC3F()
{
    for (;;)
    {
        var_0 = scripts\engine\utility::_id_DC6B( level._id_B160 );

        if ( var_0 != level._id_A8E2 )
        {
            _id_BC3E( var_0 );
            return;
        }
    }
}

_id_BC3E( var_0 )
{
    level._id_A8E2 = var_0;

    foreach ( var_2 in level._id_B163 )
    {
        if ( var_2._id_2135 == var_0 )
        {
            _id_100ED( var_2 );
            level.current_active_wheel = var_2;
            continue;
        }

        _id_8E95( var_2 );
    }
}

_id_9672( var_0 )
{
    if ( !isdefined( var_0._id_2135 ) )
        return;

    if ( var_0._id_2135 != level._id_B161 )
        level thread _id_8E95( var_0 );
    else
    {
        var_0 setscriptablepartstate( "base", "on" );
        var_0 setscriptablepartstate( "fx", get_default_fx_state() );
        var_0._id_10A03 setscriptablepartstate( "spinner", "idle" );
        var_1 = getentarray( "out_of_order", "script_noteworthy" );
        var_2 = scripts\engine\utility::_id_7E2E( var_0.origin, var_1 );
        var_2 hide();
        var_0 makeusable();
        var_0 _meth_84A7( "tag_use" );
        var_0 _meth_84A5( 60 );
        var_0 _meth_84A2( 72 );
        level.current_active_wheel = var_0;

        if ( isdefined( level.magic_wheel_spin_hint ) )
            var_0 sethintstring( level.magic_wheel_spin_hint );
        else
            var_0 sethintstring( &"CP_ZMB_INTERACTIONS_SPIN_WHEEL" );
    }
}

_id_8E95( var_0 )
{
    while ( scripts\engine\utility::_id_9CEE( var_0._id_9B04 ) )
        wait 0.05;

    var_0 makeunusable();
    var_0 setscriptablepartstate( "base", "off" );
    var_0 setscriptablepartstate( "fx", "off" );
    var_0._id_10A03 setscriptablepartstate( "spinner", "off" );
    var_1 = getentarray( "out_of_order", "script_noteworthy" );
    var_2 = scripts\engine\utility::_id_7E2E( var_0.origin, var_1 );
    playfx( level._effect["vfx_magicwheel_fire"], var_2.origin );
    wait 0.5;
    var_2 show();
}

_id_100ED( var_0 )
{
    var_0 setscriptablepartstate( "fx", "hideshow" );
    var_0 setscriptablepartstate( "base", "on" );
    var_0._id_10A03 setscriptablepartstate( "spinner", "activate" );
    var_1 = getentarray( "out_of_order", "script_noteworthy" );
    var_2 = scripts\engine\utility::_id_7E2E( var_0.origin, var_1 );
    playfx( level._effect["vfx_magicwheel_fire"], var_2.origin );
    wait 0.5;
    var_2 hide();
    var_3 = get_default_fx_state();

    if ( scripts\engine\utility::_id_6E25( "fire_sale" ) )
        var_3 = "firesale";

    var_0 setscriptablepartstate( "fx", var_3 );
    wait 1;
    var_0._id_10A03 setscriptablepartstate( "spinner", "idle" );
    var_0 makeusable();
    var_0 _meth_84A7( "tag_use" );
    var_0 _meth_84A5( 60 );
    var_0 _meth_84A2( 72 );

    if ( scripts\engine\utility::_id_6E34( "fire_sale" ) && scripts\engine\utility::_id_6E25( "fire_sale" ) )
        var_0 sethintstring( &"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE" );
    else if ( isdefined( level.magic_wheel_spin_hint ) )
        var_0 sethintstring( level.magic_wheel_spin_hint );
    else
        var_0 sethintstring( &"CP_ZMB_INTERACTIONS_SPIN_WHEEL" );
}

get_default_fx_state()
{
    if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) )
        return "upgrade";

    return "normal";
}

_id_7828( var_0 )
{
    var_1 = getentarray( "spawn_volume", "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( ispointinvolume( var_0.origin + ( 0, 0, 50 ), var_3 ) )
        {
            if ( isdefined( var_3._id_28AB ) )
                return var_3._id_28AB;
        }
    }

    return undefined;
}

_id_12FFA( var_0, var_1, var_2 )
{
    level notify( "magicWheelUsed" );
    var_1 makeunusable();
    var_0._id_13103 = 1;
    var_1._id_10A05 = 1;
    var_1._id_9B04 = 1;
    var_0 playlocalsound( "zmb_wheel_spin_buy" );
    var_3 = scripts\engine\utility::_id_7E2E( var_1.origin, scripts\engine\utility::_id_8180( "wheel_fx_spot", "targetname" ) );
    var_1 setscriptablepartstate( "spin_light", "on" );
    scripts\engine\utility::waitframe();
    var_4 = var_0 _meth_8173();
    var_5 = [];

    foreach ( var_7 in var_1._id_13C25 )
    {
        var_8 = _id_0A77::_id_7DF7( var_7 );
        var_9 = 0;

        foreach ( var_11 in var_4 )
        {
            var_12 = _id_0A77::_id_7DF7( var_11 );

            if ( var_12 == var_8 )
            {
                var_9 = 1;
                break;
            }
        }

        if ( !var_9 )
        {
            var_14 = var_7;
            var_15 = _id_0A77::_id_80D8( var_7 );

            if ( isdefined( var_0._id_13C00[var_15] ) )
                var_14 = var_0._id_13C00[var_15];

            var_5[var_5.size] = var_14;
        }
    }

    _id_0D45::_id_AF79( level._id_13BD3 );
    var_1._id_13C25 = var_5;
    level thread _id_1010C( var_1, var_0 );
    level thread _id_13D00( var_1 );
    var_1._id_10A03 setscriptablepartstate( "spinner", "spinning" );
    var_1._id_10A03 _meth_826C( var_1._id_E74A, 5, 1, 4 );
    var_1._id_10A03 waittill( "rotatedone" );
    var_1._id_10A05 = 0;
    var_1 waittill( "ready" );

    if ( !level._id_B162 )
        var_1._id_10A03 setscriptablepartstate( "spinner", "idle" );

    var_1._id_9B04 = 0;
    var_1 setscriptablepartstate( "spin_light", "off" );

    if ( !scripts\engine\utility::_id_6E34( "fire_sale" ) || !scripts\engine\utility::_id_6E25( "fire_sale" ) )
    {
        if ( level._id_B162 )
        {
            if ( isdefined( var_0 ) )
                var_0 _id_0A63::_id_82F9( var_2, undefined, undefined, 1, "magicWheelRefund" );

            level._id_B162 = 0;
            wait 0.5;

            if ( isdefined( var_1.weapon ) )
                var_1.weapon delete();

            _id_BC3F();
        }
        else
        {
            wait 0.5;

            if ( var_1 != level.current_active_wheel )
            {
                level thread _id_8E95( var_1 );
                return;
            }

            var_1 makeusable();
            var_1 _meth_84A7( "tag_use" );
            var_1 _meth_84A5( 60 );
            var_1 _meth_84A2( 72 );
        }
    }
    else
    {
        wait 0.5;
        var_1 makeusable();
        var_1 _meth_84A7( "tag_use" );
        var_1 _meth_84A5( 60 );
        var_1 _meth_84A2( 72 );
    }
}

_id_13D00( var_0 )
{
    while ( !isdefined( var_0.weapon ) )
        wait 0.05;

    while ( var_0._id_10A05 )
    {
        var_1 = var_0.weapon._id_8293;
        wait 0.05;
    }
}

_id_7B18( var_0 )
{
    var_1 = 21 / ( var_0._id_E74A / 5 * 0.05 );

    if ( var_1 - int( var_1 ) > 0 )
        var_1 = int( var_1 ) + 1;
    else
        var_1 = int( var_1 );

    var_0._id_E74D = var_1 * 0.05;
    var_2 = randomint( var_0._id_13C25.size );
    return var_0._id_13C25[var_2];
}

can_have_nunchucks( var_0 )
{
    if ( var_0._id_134FD != "p5_" )
        return 0;
    else
    {
        var_1 = var_0 getrankedplayerdata( "cp", "alienSession", "escapedRank0" );
        var_2 = var_0 getrankedplayerdata( "cp", "alienSession", "escapedRank1" );
        var_3 = var_0 getrankedplayerdata( "cp", "alienSession", "escapedRank2" );
        var_4 = var_0 getrankedplayerdata( "cp", "alienSession", "escapedRank3" );

        if ( isdefined( var_1 ) && var_1 == 1 )
            return 1;
        else if ( isdefined( var_2 ) && var_2 == 1 )
            return 1;
        else if ( isdefined( var_3 ) && var_3 == 1 )
            return 1;
        else if ( isdefined( var_4 ) && var_4 == 1 )
            return 1;
        else
            return 0;
    }
}

get_weapon_with_new_camo( var_0, var_1, var_2 )
{
    var_3 = getweaponbasename( var_1 );
    var_4 = getweaponattachments( var_1 );

    if ( issubstr( var_3, "nunchucks" ) )
    {

    }

    return var_0 _id_0A6B::_id_E469( var_3, undefined, var_4, undefined, var_2 );
}

_id_1010C( var_0, var_1 )
{
    if ( scripts\engine\utility::_id_6E25( "fire_sale" ) )
        var_0.fire_sale_spin = 1;

    var_2 = undefined;
    var_0._id_BF6D = _id_7B18( var_0 );

    if ( isdefined( level.nextwheelweaponfunc ) )
        var_0._id_BF6D = [[ level.nextwheelweaponfunc ]]( var_0, var_0._id_BF6D, var_1 );

    if ( scripts\engine\utility::_id_9CEE( var_1.finished_backstory ) && !scripts\engine\utility::_id_9CEE( var_1.given_nunchucks ) )
    {
        var_3 = "";

        if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && !var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
        {
            var_3 = "iw7_nunchucks_zm_pap1";
            var_0._id_13C25 = scripts\engine\utility::_id_2279( var_0._id_13C25, "iw7_nunchucks_zm_pap1" );
        }
        else if ( !scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
            var_3 = "iw7_nunchucks_zm_pap1";
        else if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
        {
            var_0._id_13C25 = scripts\engine\utility::_id_2279( var_0._id_13C25, "iw7_nunchucks_zm_pap2" );
            var_3 = "iw7_nunchucks_zm_pap2";
        }

        if ( var_3 != "" )
            var_0._id_BF6D = var_3;
        else
        {
            var_0._id_13C25 = scripts\engine\utility::_id_2279( var_0._id_13C25, "iw7_nunchucks_zm" );
            var_0._id_BF6D = "iw7_nunchucks_zm";
        }

        var_1.given_nunchucks = 1;
    }
    else if ( randomint( 100 ) > 95 )
    {
        if ( can_have_nunchucks( var_1 ) )
        {
            var_3 = "";

            if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && !var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
            {
                var_3 = "iw7_nunchucks_zm_pap1";
                var_0._id_13C25 = scripts\engine\utility::_id_2279( var_0._id_13C25, "iw7_nunchucks_zm_pap1" );
            }
            else if ( !scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
                var_3 = "iw7_nunchucks_zm_pap1";
            else if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
            {
                var_0._id_13C25 = scripts\engine\utility::_id_2279( var_0._id_13C25, "iw7_nunchucks_zm_pap2" );
                var_3 = "iw7_nunchucks_zm_pap2";
            }

            if ( var_3 != "" )
                var_0._id_BF6D = var_3;
            else
            {
                var_0._id_13C25 = scripts\engine\utility::_id_2279( var_0._id_13C25, "iw7_nunchucks_zm" );
                var_0._id_BF6D = "iw7_nunchucks_zm";
            }
        }
    }

    var_4 = getweaponindexfromlist( var_0._id_BF6D, var_0._id_13C25 );

    if ( scripts\engine\utility::array_contains( var_0._id_13C25, "iw7_forgefreeze_zm+forgefreezealtfire" ) )
        var_0._id_13C25 = scripts\engine\utility::array_remove( var_0._id_13C25, "iw7_forgefreeze_zm+forgefreezealtfire" );

    var_1 _meth_84ED( [ var_0._id_BF6D ], 1 );

    if ( level.currentweaponlist.size > 0 )
        var_5 = level.currentweaponlist;
    else
        var_5 = getrotationlist( var_0._id_13C25 );

    if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) )
    {
        foreach ( var_8, var_7 in var_5 )
            var_5[var_8] = get_weapon_with_new_camo( var_1, var_7, get_camo_for_upgraded_weapon( getweaponbasename( var_7 ), var_1 ) );
    }

    level.activewheels++;
    level.currentweaponlist = var_5;
    _func_2EA( var_5 );
    var_9 = -1;
    var_10 = 0;
    var_11 = scripts\engine\utility::_id_7E2E( var_0.origin, scripts\engine\utility::_id_8180( "wheel_fx_spot", "targetname" ) );

    for ( var_0.weapon = undefined; var_0._id_10A05; var_10++ )
    {
        wait( var_0._id_E74D );
        var_0 playsound( "zmb_wheel_spin_tick" );
        var_9++;

        if ( isdefined( var_0.weapon ) )
            var_0.weapon _meth_8536( var_5[var_9] );
        else
        {
            var_0.weapon = spawn( "script_weapon", var_11.origin, 0, 0, var_5[var_9] );

            if ( isdefined( var_11.angles ) )
                var_0.weapon.angles = var_11.angles;
            else
                var_0.weapon.angles = ( 0, 0, 0 );
        }

        var_0.weapon._id_8293 = var_5[var_9];

        if ( var_9 >= var_5.size - 1 )
            var_9 = -1;
    }

    var_0.weapon._id_8293 = var_0._id_13C25[var_4];

    if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) )
        var_0.weapon _meth_8536( get_weapon_with_new_camo( var_1, var_0.weapon._id_8293, get_camo_for_upgraded_weapon( getweaponbasename( var_0.weapon._id_8293 ), var_1 ) ) );
    else
        var_0.weapon _meth_8536( var_0.weapon._id_8293 );

    level.activewheels--;

    if ( level.activewheels < 0 )
        level.activewheels = 0;

    if ( !level.activewheels )
    {
        _func_2EB();
        level.currentweaponlist = [];
    }

    var_14 = _id_0D41::_id_801F( var_0._id_13C25[var_4] );
    var_0.weapon.origin = var_11.origin + var_14;
    playloopsound( var_0.origin, "zmb_wheel_spin_end" );

    if ( !isdefined( var_0.fire_sale_spin ) && ( !scripts\engine\utility::_id_6E34( "fire_sale" ) || !scripts\engine\utility::_id_6E25( "fire_sale" ) ) )
    {
        level._id_13D01++;
        var_15 = randomint( 100 );

        if ( level._id_13D01 == 7 )
            var_15 = 100;

        if ( var_15 > 50 && level._id_13D01 > 4 )
        {
            level._id_B162 = 1;
            var_16 = var_0.weapon.origin;

            if ( isdefined( var_0.weapon ) )
                var_0.weapon delete();

            var_17 = spawn( "script_model", var_16 );
            var_17 setmodel( "zmb_arcade_toy_astronaut_blue" );
            var_17.angles = var_0.angles;
            var_17 thread _id_BC9C();
            var_0._id_10A03 setscriptablepartstate( "spinner", "timetomove" );
            level thread _id_B16B( var_1 );
            wait 3;
            var_0._id_10A03 setscriptablepartstate( "spinner", "deactivate" );
            var_0 setscriptablepartstate( "base", "off" );
            wait 2;
            level._id_13D01 = 0;
            var_0 setscriptablepartstate( "fx", "hideshow" );
            var_0 setscriptablepartstate( "spin_light", "off" );
            var_1._id_13103 = undefined;
            var_0 notify( "ready" );
            return;
        }
    }

    var_0.fire_sale_spin = undefined;
    var_0.weapon makeusable();

    foreach ( var_19 in level.players )
    {
        if ( var_19 == var_1 )
        {
            var_0.weapon enableplayeruse( var_19 );
            continue;
        }

        var_0.weapon disableplayeruse( var_19 );
    }

    var_0.weapon thread _id_1360B( var_0 );
    var_0.weapon scripts\engine\utility::_id_13736( 12, "weapon_taken" );
    var_0.weapon delete();
    var_0._id_13C25 = scripts\engine\utility::array_remove( var_0._id_13C25, "iw7_nunchucks_zm" );
    var_0._id_13C25 = scripts\engine\utility::array_remove( var_0._id_13C25, "iw7_nunchucks_zm_pap2" );
    var_0 setscriptablepartstate( "spin_light", "off" );
    var_0._id_13C25 = _id_7ABF();
    var_0._id_E74A = _id_7C20();
    var_1._id_13103 = undefined;
    var_0 notify( "ready" );
}

getrotationlist( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < 8; var_2++ )
        var_1[var_2] = var_0[var_2];

    return var_1;
}

getweaponindexfromlist( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_0 == var_1[var_2] )
            return var_2;
    }

    return 0;
}

_id_B16B( var_0 )
{
    var_0 endon( "disconnect" );
    level endon( "game_ended" );
    level thread _id_0A6A::_id_12885( "ww_magicbox_laughter", "zmb_announcer_vo", "highest", 5, 0, 0, 1 );
    wait 4;
    var_0 thread _id_0A6A::_id_12885( "magicwheel_badspin", "zmb_comment_vo", "low", 30, 0, 0, 1 );
}

_id_7C20()
{
    var_0 = 1440;

    if ( randomint( 100 ) > 50 )
        var_0 = 1080;

    return var_0;
}

_id_BC9C()
{
    self _meth_8212( 50, 3, 2, 1 );
    self _meth_826D( -10, 1 );
    wait 1;
    self _meth_826D( 10, 1 );
    wait 1;
    self _meth_826D( -10, 0.5 );
    wait 0.5;
    self _meth_826D( 10, 0.5 );
    wait 0.5;
    playfx( level._effect["vfx_magicwheel_toy_pop"], self.origin );
    self delete();
}

_id_45FC( var_0 )
{

}

_id_7A37( var_0, var_1 )
{
    var_2 = getarraykeys( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( var_2[var_3] == var_1 )
            return var_3;
    }
}

_id_782E( var_0, var_1 )
{
    var_2 = getarraykeys( var_0 );
    return var_0[var_2[var_1]];
}

_id_7D60( var_0 )
{
    if ( isdefined( level._id_462F ) )
        var_1 = level._id_462F;
    else
        var_1 = "cp/cp_weapontable.csv";

    return tablelookup( var_1, 2, var_0, 1 );
}

_id_1360B( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_1 );

        while ( var_1 _meth_81AE() || var_1 meleebuttonpressed() )
            wait 0.05;

        if ( isdefined( level.magicwheel_weapon_take_check ) )
        {
            if ( [[ level.magicwheel_weapon_take_check ]]( var_0, var_1, self ) )
                break;
            else
                continue;
        }

        break;
    }

    if ( isdefined( self._id_8293 ) && getsubstr( self._id_8293, 0, 5 ) == "power" )
    {
        if ( level._id_D782[self._id_8293]._id_504B == "secondary" )
            var_1 _id_0D15::_id_8397( self._id_8293, level._id_D782[self._id_8293]._id_504B, undefined, undefined, undefined, 0, 0 );
        else
            var_1 _id_0D15::_id_8397( self._id_8293, level._id_D782[self._id_8293]._id_504B, undefined, undefined, undefined, 0, 1 );
    }
    else
    {
        var_2 = self._id_8293;
        _id_B16A( var_1, var_2 );
        var_3 = _id_0A77::_id_80D8( var_2 );

        switch ( var_3 )
        {
            case "mauler":
            case "sdflmg":
            case "lmg03":
                var_1 thread _id_0A6A::_id_12885( "purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25 );
                break;
            case "katana":
                var_1 thread _id_0A6A::_id_12885( "magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0 );
                break;
            case "nunchucks":
                var_1 thread _id_0A6A::_id_12885( "magicwheel_nunchucks", "zmb_comment_vo", "low", 10, 0, 1, 0 );
                break;
            case "forgefreeze":
                var_1 thread _id_0A6A::_id_12885( "magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0 );
                break;
            case "glprox":
            case "chargeshot":
                var_1 thread _id_0A6A::_id_12885( "player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40 );
                break;
            case "cheytac":
            case "kbs":
                var_1 thread _id_0A6A::_id_12885( "player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40 );
                break;
            default:
                var_1 thread _id_0A6A::_id_12885( "purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25 );
        }
    }

    self notify( "weapon_taken" );
    var_0 notify( "weapon_taken" );
    var_0._id_BF6D = undefined;
    playloopsound( self.origin, "zmb_wheel_wpn_acquired" );
}

_id_B16A( var_0, var_1 )
{
    var_0 notify( "weapon_purchased" );

    if ( scripts\engine\utility::_id_9CEE( var_0._id_9FCB ) )
        wait 0.5;

    var_2 = undefined;

    if ( _id_0D63::_id_FFA6( var_0 ) )
    {
        var_3 = var_0 _id_0A77::getvalidtakeweapon();
        var_4 = _id_0A77::_id_80D8( var_3 );
        var_0 _meth_83B8( var_3 );

        if ( isdefined( var_0._id_C8A2[var_4] ) )
        {
            var_0._id_C8A2[var_4] = undefined;
            var_0 notify( "weapon_level_changed" );
        }
    }

    var_5 = _id_0A77::_id_80D8( var_1 );
    var_0 _id_0A77::take_fists_weapon( var_0 );

    if ( isdefined( var_0._id_13C00[var_5] ) )
        var_1 = var_0._id_13C00[var_5];

    if ( var_0 _id_0A6B::_id_385F( var_1 ) && is_magic_wheel_upgrades( var_0 ) )
    {
        var_2 = get_camo_for_upgraded_weapon( var_5, var_0 );
        var_6 = scripts\engine\utility::_id_227F( getweaponattachments( var_1 ), [ get_attachment_for_upgraded_weapon( var_1, var_0 ) ] );
        var_1 = var_0 _id_0A6B::_id_E469( var_1, undefined, var_6, undefined, var_2 );
        var_1 = var_0 _id_0A77::_id_12C6( var_1, undefined, undefined, 1 );
        var_7 = _id_0A77::_id_80D8( var_1 );
        var_8 = spawnstruct();
        var_8._id_B111 = 2;
        var_0._id_C8A2[var_7] = var_8;
        var_0 notify( "weapon_level_changed" );
        var_0 _id_0A5E::_id_D9AD( "mt_purchased_weapon" );

        if ( var_0 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
            var_0 _id_0A77::_id_C151( "magic_wheel_upgrade" );
    }
    else
    {
        var_6 = getweaponattachments( var_1 );
        var_1 = var_0 _id_0A6B::_id_E469( var_1, undefined, var_6, undefined, undefined );
        var_1 = var_0 _id_0A77::_id_12C6( var_1, undefined, undefined, 0 );
        var_8 = spawnstruct();
        var_8._id_B111 = 1;
        var_0._id_C8A2[var_5] = var_8;
        var_0 _id_0A5E::_id_D9AD( "mt_purchased_weapon" );
        var_0 notify( "weapon_level_changed" );
    }

    if ( issubstr( var_1, "g18_" ) )
        var_0._id_8BA0 = 1;

    if ( issubstr( var_1, "udm45_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_udm_unlock" );

    if ( issubstr( var_1, "rvn_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_rvn_unlock" );

    if ( issubstr( var_1, "crdb_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_crdb_unlock" );

    if ( issubstr( var_1, "vr_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_vr_unlock" );

    if ( issubstr( var_1, "mp28_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_mp28_unlock" );

    if ( issubstr( var_1, "minilmg_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_minilmg_unlock" );

    if ( issubstr( var_1, "ba50cal_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_ba50cal_unlock" );

    if ( issubstr( var_1, "mod2187_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_mod2187_unlock" );

    if ( issubstr( var_1, "longshot_" ) )
        var_0 _id_0A5E::_id_D9AD( "mt_longshot_unlock" );

    var_0 notify( "wor_item_pickup", var_1 );
    var_0 givemaxammo( var_1 );
    var_0 _meth_83B5( var_1 );
}

get_camo_for_upgraded_weapon( var_0, var_1 )
{
    var_2 = undefined;

    if ( isdefined( level.no_pap_camos ) && scripts\engine\utility::array_contains( level.no_pap_camos, var_0 ) )
        var_2 = undefined;
    else if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) && isdefined( level.pap_2_camo ) )
        var_2 = level.pap_2_camo;
    else if ( isdefined( level.pap_1_camo ) )
        var_2 = level.pap_1_camo;

    switch ( var_0 )
    {
        case "dischord":
            var_2 = "camo20";
            break;
        case "facemelter":
            var_2 = "camo22";
            break;
        case "headcutter":
            var_2 = "camo21";
            break;
        case "shredder":
            var_2 = "camo23";
            break;
        case "nunchucks":
            var_2 = "camo222";
            break;
    }

    return var_2;
}

get_attachment_for_upgraded_weapon( var_0, var_1 )
{
    if ( issubstr( var_0, "nunchucks" ) )
        return undefined;

    if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) && var_1 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
        return "pap2";

    return "pap1";
}

is_magic_wheel_upgrades( var_0 )
{
    if ( var_0 _id_0A77::_id_9BA0( "magic_wheel_upgrade" ) )
        return 1;

    if ( scripts\engine\utility::_id_9CEE( level.magic_wheel_upgraded ) )
        return 1;

    return 0;
}

_id_10C4D( var_0, var_1, var_2 )
{
    level notify( "activated" + var_0 );
    level endon( "activated" + var_0 );
    level endon( "deactivated" + var_0 );
    level endon( "game_ended" );
    var_3 = undefined;
    level._id_163F["fire_sale"] = 1;
    scripts\engine\utility::_id_6E3E( "fire_sale" );

    foreach ( var_5 in level._id_B163 )
    {
        if ( var_5._id_2135 == level._id_A8E2 )
        {
            var_5 sethintstring( &"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE" );
            var_3 = var_5;
            continue;
        }

        thread _id_100ED( var_5 );
    }

    level thread _id_4DB4( var_0, var_1, var_3 );

    foreach ( var_8 in level.players )
    {
        if ( isdefined( var_8.temporal_increase ) )
        {
            var_8 thread _id_0A76::_id_D73B( 30 * var_8.temporal_increase, "fire_30" );
            continue;
        }

        var_8 thread _id_0A76::_id_D73B( 30, "fire_30" );
    }
}

_id_4DB4( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = scripts\engine\utility::_id_13736( var_1, "deactivated" + var_0, "activated" + var_0 );

    if ( var_3 != "activated" + var_0 )
    {
        level._id_163F["fire_sale"] = 0;
        scripts\engine\utility::_id_6E2A( "fire_sale" );

        foreach ( var_5 in level._id_B163 )
        {
            if ( !isdefined( var_2 ) )
                _id_BC3F();
            else if ( var_5 == var_2 )
            {
                if ( isdefined( level.magic_wheel_spin_hint ) )
                    var_5 sethintstring( level.magic_wheel_spin_hint );
                else
                    var_5 sethintstring( &"CP_ZMB_INTERACTIONS_SPIN_WHEEL" );

                continue;
            }

            var_5 makeunusable();
            thread _id_8E95( var_5 );
        }

        foreach ( var_8 in level.players )
            var_8._id_8B7B = undefined;

        level notify( "deactivated" + var_0 );
        var_10 = 1;

        while ( var_10 )
        {
            var_11 = 0;

            foreach ( var_8 in level.players )
            {
                if ( scripts\engine\utility::_id_9CEE( var_8._id_13103 ) )
                {
                    wait 0.25;
                    var_11 = 1;
                    continue;
                }
            }

            if ( !var_11 )
                var_10 = 0;
        }

        wait 0.25;
    }
}

_id_50DA( var_0 )
{
    level endon( "game_ended" );
    var_0 scripts\engine\utility::waittill_any( "ready", "weapon_taken" );
    _id_8E95( var_0 );
}
