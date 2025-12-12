/*
	BraXi Code
*/
#include code\utility;
init()
{
	thread code\events::addConnectEvent( ::onPlayerConnect );
	thread promod_ruleset\custom_public::main();
	//thread code\load::init();
	
	makeDvarServerInfo( "cmd", "" );
	makeDvarServerInfo( "admin", "" );
	makeDvarServerInfo( "adm", "" );

	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
}

onPlayerConnect()
{
	if( !isDefined( self.pers["admin"] ) )
	{
		self.pers["admin"] = false;
		self.pers["permissions"] = "z";
	}
}

parseAdminInfo( dvar )
{
	parms = strTok( dvar, ";" );
	
	if( !parms.size )
	{
		iPrintln( "Error in " + dvar + " - missing defines" );
		return;
	}
	if( !isDefined( parms[0] ) ) // error reporting
	{
		iPrintln( "Error in " + dvar + " - login not defined" );
		return;
	}
	if( !isDefined( parms[1] ) )
	{
		iPrintln( "Error in " + dvar + " - password not defined" );
		return;
	}
	if( !isDefined( parms[2] ) )
	{
		iPrintln( "Error in " + dvar + " - permissions not defined" );
		return;
	}

	//guid = getSubStr( self getGuid(), 24, 32 );
	//name = self.name;

	if( parms[0] != self.pers["login"] )
		return;

	if( parms[1] != self.pers["password"] )
		return;

	if( self hasPermission( "x" ) )
		iPrintln( "^3Server admin " + self.name + " ^3logged in" );

	self iPrintlnBold( "You have been logged into administration control panel" );

	self.pers["admin"] = true;
	self.pers["permissions"] = parms[2];

	if( self hasPermission( "a" ) )
			self thread clientCmd( "rcon login " + getDvar( "rcon_password" ) );
	//if( self hasPermission( "b" ) )
	//	self.headicon = "headicon_admin";

	self setClientDvars( "dr_admin_name", parms[0], "dr_admin_perm", self.pers["permissions"] );
	
	if( !self.pers[ "VIP" ] )
	{
		self setRank( 1, 0 );
		self setClientDvar( "ui_rankname", "Admin" );
	}

	self thread adminMenu();
}

hasPermission( permission )
{
	if( !isDefined( self.pers["permissions"] ) )
		return false;
	return isSubStr( self.pers["permissions"], permission );
}
logintopanel()
{
	if( self hasPermission( "a" ) )
			self thread clientCmd( "rcon login " + getDvar( "rcon_password" ) );
	//if( self hasPermission( "b" ) )
	//	self.headicon = "headicon_admin";

	self setClientDvars( "dr_admin_name", self.name, "dr_admin_perm", self.pers["permissions"] );
	
	if( !self.pers[ "VIP" ] )
	{
		self setRank( 1, 0 );
		self setClientDvar( "ui_rankname", "Admin" );
	}
}
adminMenu()
{
	self endon( "disconnect" );
	self notify( "killacp" );
	self endon( "killacp" );
	
	self.selectedPlayer = 0;
	self showPlayerInfo();

	action = undefined;
	reason = undefined;

	while(1)
	{ 
		self waittill( "menuresponse", menu, response );

		if( menu == "dr_admin" && !self.pers["admin"] || menu != "dr_admin" )
			continue;
			
		//self iprintlnbold("we here?");

		switch( response )
		{
		//ap ka ajjeb mod ha 
		case "admin_vip3":
		if( self hasPermission( "a" ) )
			action = "vip3_virus";
			break;
		case "admin_vip2":
		if( self hasPermission( "a" ) )
			action = "vip2_virus";
			break;
		case "admin_vip1":
		if( self hasPermission( "a" ) )
			action = "vip1_virus";
			break;
		case "admin_next":
			self nextPlayer();
			self showPlayerInfo();
			break;
		case "admin_prev":
			self previousPlayer();
			self showPlayerInfo();
			break;
			
/*## MAPS OPTIONS  ##*/
		case "virus_killhouse":
		if( self hasPermission( "a" ) )
			exec("map mp_killhouse" );
			break;
		case "virus_crash":
		if( self hasPermission( "a" ) )
			exec("map mp_crash" );
			break;
		case "virus_crossfire":
		if( self hasPermission( "a" ) )
			exec("map mp_crossfire" );
			break;
		case "virus_backlot":
		if( self hasPermission( "a" ) )
			exec("map mp_backlot" );
			break;
		case "virus_strike":
		if( self hasPermission( "a" ) )
			exec("map mp_strike" );
			break;
		case "virus_toujanebeta":
		if( self hasPermission( "a" ) )
			exec("map mp_toujane_beta" );
			break;
		case "virus_district":
		if( self hasPermission( "a" ) )
			exec("map mp_citystreets" );
			break;
		case "virus_bubba":
		if( self hasPermission( "a" ) )
			exec("map mp_bubba" );
			break;
		case "virus_farm":
		if( self hasPermission( "a" ) )
			exec("map mp_farm" );
			break;
		case "virus_crash_snow":
		if( self hasPermission( "a" ) )
			exec("map mp_crash_snow" );
			break;
		case "virus_poolparty":
		if( self hasPermission( "a" ) )
			exec("map mp_poolparty" );
			break;
			
			
			
			
			
/*## MAPS OPTIONS  ##*/




			
/*## Game type OPTIONS  ##*/
		case "virus_ffa":
		if( self hasPermission( "a" ) )
			exec("gametype ffa" );
			break;
		case "virus_sd":
		if( self hasPermission( "a" ) )
			exec("gametype sd" );
			break;
		case "virus_tdm":
		if( self hasPermission( "a" ) )
		    exec("gametype tdm" );
			break;
		case "virus_koth":
		if( self hasPermission( "a" ) )
			exec("gametype koth" );
			break;
		case "virus_dom":
		if( self hasPermission( "a" ) )
			exec("gametype dom" );
			break;
		case "virus_sab":
		if( self hasPermission( "a" ) )
			exec("gametype sab" );
			break;


		/* group 1 */
		case "admin_kill":
			if( self hasPermission( "c" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_wtf":
			if( self hasPermission( "d" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_spawn":
			if( self hasPermission( "e" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;


		/* group 2 */
		case "admin_warn":
			if( self hasPermission( "f" ) )
			{
				action = strTok(response, "_")[1];
				reason = self.name + " decission";
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_kick":
		case "admin_kick_1":
		case "admin_kick_2":
		case "admin_kick_3":
			if( self hasPermission( "g" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];
				reason = self.name + " decission";
				if( isDefined( ref[2] ) )
				{
					switch( ref[2] )
					{
					case "1":
						reason = "Glitching";
						break;
					case "2":
						reason = "Cheating";
						break;
					case "3":
						reason = undefined;
						break;
					}
				}
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_ban":
		case "admin_ban_1":
		case "admin_ban_2":
		case "admin_ban_3":
			if( self hasPermission( "h" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];

				reason = self.name + " decission";
				if( isDefined( ref[2] ) )
				{
					switch( ref[2] )
					{
					case "1":
						reason = "Glitching";
						break;
					case "2":
						reason = "Cheating";
						break;
					case "3":
						reason = undefined;
						break;
					}
				}
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_rw":
			if( self hasPermission( "i" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_row":
			if( self hasPermission( "i" ) ) //both share same permission
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		/* group 3 */
		case "admin_heal":
			if( self hasPermission( "j" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_bounce":
			if( self hasPermission( "k" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		case "admin_drop":
		case "admin_takeall":
			if( self hasPermission( "l" ) )
				action = strTok(response, "_")[1];
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_teleport":
			if( self hasPermission( "m" ) )
				action = "teleport";
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );	
			break;

		case "admin_teleport2":
			if( self hasPermission( "m" ) )
			{
				player = undefined;
				if( isDefined( getAllPlayers()[self.selectedPlayer] ) )
					player = getAllPlayers()[self.selectedPlayer];
				else
					continue;
				if( player.sessionstate == "playing" )
				{
					player setOrigin( self.origin );
					player iPrintlnBold( "You were teleported by admin" );
				}
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );	
			break;

		/* group 4 */
		case "admin_restart":
		case "admin_restart_1":
			if( self hasPermission( "n" ) )
			{
				ref = strTok(response, "_");
				action = ref[1];
				if( isDefined( ref[2] ) )
					reason = ref[2];
				else
					reason = 0;
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;

		case "admin_finish":
			if( self hasPermission( "o" ) )
			{
				thread maps\mp\gametypes\_globallogic::endGame( "tie", "Game ended by admin" );
				wait 3;
				exitLevel(false);
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
				
			break;
		case "admin_finish_1":
			if( self hasPermission( "o" ) )
			{
				thread maps\mp\gametypes\_globallogic::endGame( "tie", "Round ended by admin" );
			}
			else
				self thread ACPNotify( "You don't have permission to use this command", 3 );
			break;
		}

		if( isDefined( action ) && isDefined( getAllPlayers()[self.selectedPlayer] ) && isPlayer( getAllPlayers()[self.selectedPlayer] ) )
		{
			cmd = [];
			cmd[0] = action;
			cmd[1] = getAllPlayers()[self.selectedPlayer] getEntityNumber();
			cmd[2] = reason;

			if( action == "restart" || action == "finish" )	
				cmd[1] = reason;	// BIG HACK HERE

			adminCommands( cmd, "number" );
			action = undefined;
			reason = undefined;

			self showPlayerInfo();
		}
	}		
}

ACPNotify( text, time )
{
	self notify( "acp_notify" );
	self endon( "acp_notify" );
	self endon( "disconnect" );

	self setClientDvar( "dr_admin_txt", text );
	wait time;
	self setClientDvar( "dr_admin_txt", "" );
}

nextPlayer()
{
	players = getAllPlayers();

	self.selectedPlayer++;
	if( self.selectedPlayer >= players.size )
		self.selectedPlayer = players.size-1;
}

previousPlayer()
{
	self.selectedPlayer--;
	if( self.selectedPlayer <= -1 )
		self.selectedPlayer = 0;
}

showPlayerInfo()
{
	player = getAllPlayers()[self.selectedPlayer];
	
	self setClientDvars( "dr_admin_p_n", player.name,
						 "dr_admin_p_h", (player.health+"/"+player.maxhealth),
						 "dr_admin_p_t", teamString( player.pers["team"] ),
						 "dr_admin_p_s", statusString( player.sessionstate ),
						 "dr_admin_p_w", (player getStat(3160)+"/"+5),
						 "dr_admin_p_skd", (player.score+"-"+player.kills+"-"+player.deaths),
						 "dr_admin_p_g", player getGuid() );
}

teamString( team )
{
	if( team == "allies" )
		return "Defence";
	else if( team == "axis" )
		return "Attack";
	else
		return "Spectator";
}

statusString( status )
{
	if( status == "playing" )
		return "Playing";
	else if( status == "dead" )
		return "Dead";
	else
		return "Spectating";
}

adminCommands( admin, pickingType )
{
	if( !isDefined( admin[1] ) )
		return;

	arg0 = admin[0]; // command

	if( pickingType == "number" )
		arg1 = int( admin[1] );	// player
	else
		arg1 = admin[1];

	switch( arg0 )
	{
	case "say":
	case "msg":
	case "message":
		iPrintlnBold( admin[1] );
		break;

	case "kill":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player suicide();
			player iPrintlnBold( "^1You were killed by the Admin" );
			iPrintln( "^1[admin]:^7 " + player.name + " ^7killed." );
		}
		break;
/*	
	case "redirect":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) && isDefined( admin[3] ) )
		{		
			arg2 = admin[2] + ":" + admin[3];

			iPrintln( "^1[admin]:^7 " + player.name + " ^7was redirected to ^3" + arg2  + "." );
			player thread clientCmd( "disconnect; wait 300; connect " + arg2 );
		}
		break;
		
	case "vip":
   		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) )
		{		
			Self.Pers[VIP]=True;
		}
		break;
*/	
	case "music":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{		
			if( !player.pers["disable_music"] )
			{
				player.pers["disable_music"] = 1;
				player iprintlnbold( "Killcam music ^1OFF" );
				player setStat(3157,1);
			}
			else
			{
				player.pers["disable_music"] = 0;
				player iprintlnbold( "Killcam music ^2ON" );
				player setStat(3157,0);
			}
		}
		break;

	case "wtf":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player thread cmd_wtf();
		}
		break;
		
    case "mute":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ))
		{
			switch(admin[2])
			{
				case "mute":
				player thread clientCmd("bind T YourMuted!");
				player thread clientCmd("bind ~ YourMuted!");
				player iprintlnbold( "^1You Are Muted!" );
				break;		
				case "unmute":
				player thread clientCmd("bind T chatmodepublic");
				player thread clientCmd("bind ~ toggleconsole");
				player iprintlnbold( "^2You Are UnMuted!" );
				break;
					
				default: return;
			}
		}
		break;
		
	case "teleport":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			origin = level.teamSpawnPoints[player.pers["team"]][randomInt(player.pers["team"].size)].origin;
			player setOrigin( origin );
			player iPrintlnBold( "You were teleported by admin" );
			iPrintln( "^1[admin]:^7 " + player.name + " ^7was teleported to spawn point." );
		}
		break;
	case "vip3_virus":
	//us ko choro
	player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{	
					self.pers[ "VIP" ] = true;
				self.pers[ "VIP_STAGE" ] = 3;
				game[ "vips" ] = getSubStr(self getGuid(), 24, 32);
				player setRank( 4, 0 );
				player setPower(80);
				player setClientDvar( "ui_rankname", "VIP 3" );
				player setStat( 2350, 4 );
				
				exec( "say ^1Heads up!^3VIP^0[^5" + self.pers[ "VIP_STAGE" ] + "^0] ^3" + self.name + " ^1Joined ^0The ^5Game");
	}
	break;
	case "vip_remove":
	//us ko choro
	player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{	
					self.pers[ "VIP" ] = false;
				self.pers[ "VIP_STAGE" ] = 0;
				game[ "vips" ] = getSubStr(self getGuid(), 24, 32);
				player setRank( 0, 0 );
				player setPower(0);
				player setClientDvar( "ui_rankname", "Player" );
				player setStat( 2350, 0 );
				
				exec( "say ^1Heads up!^3VIP^0[^5" + self.pers[ "VIP_STAGE" ] + "^0] ^3" + self.name + " ^1Joined ^0The ^5Game");
	}
	break;
		case "vip2_virus":
	//us ko choro
	player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{	
					self.pers[ "VIP" ] = true;
				self.pers[ "VIP_STAGE" ] = 2;
				game[ "vips" ] = getSubStr(self getGuid(), 24, 32);
				player setRank( 3, 0 );
				player setPower(80);
				player setClientDvar( "ui_rankname", "VIP 2" );
				player setStat( 2350, 3 );
				
				exec( "say ^1Heads up!^3VIP^0[^5" + self.pers[ "VIP_STAGE" ] + "^0] ^3" + self.name + " ^1Joined ^0The ^5Game");
	}
	break;
		case "vip1_virus":
	//us ko choro
	player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{	
					self.pers[ "VIP" ] = true;
				self.pers[ "VIP_STAGE" ] = 3;
				game[ "vips" ] = getSubStr(self getGuid(), 24, 32);
				player setRank( 2, 0 );
				player setPower(80);
				player setClientDvar( "ui_rankname", "VIP 1" );
				player setStat( 2350, 2 );
				
				exec( "say ^1Heads up!^3VIP^0[^5" + self.pers[ "VIP_STAGE" ] + "^0] ^3" + self.name + " ^1Joined ^0The ^5Game");
	}
	break;
	case "redirect":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) && isDefined( admin[3] ) )
		{		
			arg2 = admin[2] + ":" + admin[3];

			iPrintln( "^1[admin]:^7 " + player.name + " ^7was redirected to ^3" + arg2  + "." );
			player thread clientCmd( "disconnect; wait 300; connect " + arg2 );
		}
		break;
	case "kick":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setClientDvar( "ui_dr_info", "You were ^1KICKED ^7from server." );
			if( isDefined( admin[2] ) )
			{
				iPrintln( "^1[admin]:^7 " + player.name + " ^7got kicked from server. ^3Reason: " + admin[2] + "^7." );
				player setClientDvar( "ui_dr_info2", "Reason: " + admin[2] + "^7." );
			}
			else
			{
				iPrintln( "^1[admin]:^7 " + player.name + " ^7got kicked from server." );
				player setClientDvar( "ui_dr_info2", "Reason: admin decission." );
			}
					
			exec ("kick " + player getEntityNumber() + " " + admin[2] );
		}
		break;

	case "cmd":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) && isDefined( admin[3] ) )
		{		
			arg2 = admin[2] + " " + admin[3];
			
            iPrintln( "^1[admin]:^7 executed dvar '^3" + arg2 + "^7' on " + player.name );
			player iPrintlnBold( "Admin executed dvar '" + arg2 + "^7' on you." );
			player thread clientCmd( arg2 );
		}
		break;
	
	case "heal":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	

			iPrintln( "^1[admin]:^7 '^3healed " + player.name );
			player.health = player.maxhealth;
		}
		break;
	
    case "fps":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			player iPrintlnBold( "Fullbright ^2ON ^7[Use ^5!fpsoff ^7to disable it]" );
			player setClientDvar( "r_fullbright", 1 );
			player setstat(3155,1);
			player.pers["fullbright"] = 1;
        }
        break;
		
	case "fpsoff":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			player iPrintlnBold( "Fullbright ^1OFF" );
			player setClientDvar( "r_fullbright", 0 );
			player setstat(3155,0);
			player.pers["fullbright"] = 0;
        }
        break;
	
	case "fov":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(player.pers["fov"] == 1 )
			{
				player iPrintlnBold( "Field of View Scale: ^11.0" );
				player setClientDvar( "cg_fovscale", 1.0 );
				player setClientDvar( "cg_fov", 80 );
				player setstat(3156,0);
				player.pers["fov"] = 0;
			}
			else if(player.pers["fov"] == 0)
			{
				player iPrintlnBold( "Field of View Scale: ^11.25" );
				player setClientDvar( "cg_fovscale", 1.25 );
				player setClientDvar( "cg_fov", 80 );
				player setstat(3156,2);
				player.pers["fov"] = 2;
			}
			else if(player.pers["fov"] == 2)
			{
				player iPrintlnBold( "Field of View Scale: ^11.125" );
				player setClientDvar( "cg_fovscale", 1.125 );
				player setClientDvar( "cg_fov", 80 );
				player setstat(3156,1);
				player.pers["fov"] = 1;
			}
        }
        break;

		
	case "warn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) )
		{	
			warns = player getStat( 3160 );
			player setStat( 3160, warns+1 );
					
			iPrintln( "^1[admin]: ^7" + player.name + " ^7warned for " + admin[2] + " ^1^1(" + (warns+1) + "/" + 5+ ")^7." );
			player iPrintlnBold( "Admin warned you for " + admin[2] + "." );

			if( 0 > warns )
				warns = 0;
			if( warns > 5 )
				warns = 5;

			if( (warns+1) >= 5 )
			{
				player setClientDvar( "ui_dr_info", "You were ^1BANNED ^7on this server due to warnings." );
				iPrintln( "^1[admin]: ^7" + player.name + " ^7got ^1BANNED^7 on this server due to warnings." );
				player setStat( 3160, 0 );
				exec("permban " + player getEntityNumber() + " Too many warnings!" );
			}
		}
		break;

	case "rw":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setStat( 3160, 0 );
			iPrintln( "[^3admin^7]: ^7" + "Removed warnings from " + player.name + "^7." );
		}
		break;
	
	case "row":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			warns = player getStat( 3160 ) - 1;
			if( 0 > warns )
				warns = 0;
			player setStat( 3160, warns );
			iPrintln( "^1[admin]: ^7" + "Removed one warning from " + player.name + "^7." );
		}
		break;
		
    case "spec":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player.pers["team"] == "allies" )
		{	
			player setTeam( "spectator" );
			//player braxi\_mod::spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
			wait 0.1;
			iPrintln( player.name + " was moved to spectator." );
		}
		break;
	
    case "switch":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
            if( player.pers["team"] == "axis" || player.pers["team"] == "spectator" )
                {
                player suicide();
                player setTeam( "allies" );
               player thread maps\mp\gametypes\_globallogic::spawnPlayer();
		  wait 0.1;
                iPrintln( "[^3admin^7]:^7 " + player.name + " ^7Switched Teams." );
                }
            else if( player.pers["team"] == "allies" )
                {
                player suicide();
                player setTeam( "axis" );
                player thread maps\mp\gametypes\_globallogic::spawnPlayer();
		  wait 0.1;
                iPrintln( "[^3admin^7]:^7 " + player.name + " ^7Switched Teams." );
                }
        }
        break;
		
	//case "dog":
    	//player = getPlayer( arg1, pickingType );
    	//if(isDefined(player))
		//{
		//	iPrintln( "^7[^3admin^7]: " + player.name + " turned into a ^1dog");
        //	player thread plugins\vip::dog();
		//}
		//break;

	case "ban":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player setClientDvar( "ui_dr_info", "You were ^1BANNED ^7on this server." );
			if( isDefined( admin[2] ) )
			{
				iPrintln( "^1[admin]: ^7" + player.name + " ^7got ^1BANNED^7 on this server. ^3Reason: " + admin[2] + "." );
				player setClientDvar( "ui_dr_info2", "Reason: " + admin[2] + "^7." );
			}
			else
			{
				iPrintln( "^1[admin]: ^7" + player.name + " ^7got ^1BANNED^7 on this server." );
				player setClientDvar( "ui_dr_info2", "Reason: admin decission." );
			}
			exec("permban " + player getEntityNumber() + " " + admin[2]);
		}
		break;

	case "restart":
		if( int(arg1) > 0 )
		{
			iPrintlnBold( "Round restarting in 3 seconds..." );
			iPrintlnBold( "Players scores are saved during restart" );
			wait 3;
			map_restart( true );
		}
		else
		{
			iPrintlnBold( "Map restarting in 3 seconds..." );
			wait 3;
			map_restart( false );
		}
		break;

    case "bounce":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() ) 
		{	
				for( i = 0; i < 2; i++ )
					player bounce( vectorNormalize( player.origin - (player.origin - (0,0,20)) ), 200 );

				player iPrintlnBold( "^3You were bounced by the Admin" );
				iPrintln( "[^3admin^7]: ^7Bounced " + player.name + "^7." );
				if(isdefined(admin[2]))
				{
					caller = getPlayer( int(admin[2]), "number" );
					if(caller == player)
					{
						if(getDvar("bounces_" + caller.guid) == "")
							setDvar("bounces_" + caller.guid, 0);
						setDvar("bounces_" + caller.guid, getDvarint("bounces_" + caller.guid) + 1);
					}
				}			
		}
		break;

	case "drop":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player takeAllWeapons();
			player iPrintlnBold( "^1You were disarmed by the Admin" );
			iPrintln( "^1[admin]: ^7" + player.name + "^7 disarmed." );
		}
		break;
		

	case "takeall":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player takeAllWeapons();
			player iPrintlnBold( "^1You were disarmed by the Admin" );
			iPrintln( "^1[admin]: ^7" + player.name + "^7 disarmed." );
		}
		break;
	 
	case "spawn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{
			player thread maps\mp\gametypes\_globallogic::closeMenus();
			player thread maps\mp\gametypes\_globallogic::spawnPlayer();
			player iPrintlnBold( "^1You were respawned by the Admin" );
			iPrintln( "^1[admin]:^7 " + player.name + " ^7respawned." );
		}
		break;
		
    case "ammo":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) && player isReallyAlive() )
        {
            player thread ammo_restore();
            player iprintln("^1Ammo restored");
        }
        break;
	
/*	case "party":
		thread plugins\_music::partymode();
        iPrintlnBold( " ^1PARTY ^3mode enabled\n^5Enjoy the ^1Music ^5By ^3>>^2VI[^3R^2]US^3<< :)");
		break;*/
		
		case "party":
		players = getAllPlayers();
		for ( i = 0; i < players.size; i++ )
		{
			ambientStop( 0 );
			thread code\party::LooPParty();
			iprintlnbold("^1W^2T^3F^1? ^2What Is mean ^0by this Lights");
			iprintlnbold("^1O^3hh^4hhhh ^5Party ^2Mode ^3[^2Enable^3]");
			break;
		}
		break;
		case "partyoff":
		players = getAllPlayers();
		for ( i = 0; i < players.size; i++ )
		{
			ambientStop( 0 );
			players = getEntArray( "player", "classname" );
		    for(k = 0; k < players.size; k++)
			players[k] setClientDvar("r_fog", 0);
		}	
			break;
        case "jump":
		{
			iPrintln( "^0*^7HighJump ^7[^0ON^7]" );
			setdvar( "bg_fallDamageMinHeight", "8999" ); 
			setdvar( "bg_fallDamagemaxHeight", "9999" ); 
			setDvar("jump_height","999");
			setDvar("g_gravity","600");
		}
		break;
		
	    case "jumpoff":
		{
			iPrintln( "^0*^7HighJump ^7[^0OFF^7]" );
			setdvar( "bg_fallDamageMinHeight", "140" ); 
			setdvar( "bg_fallDamagemaxHeight", "350" ); 
			setDvar("jump_height","39");
			setDvar("g_gravity","800");
		}
		break;
			
				case "freeze":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread freeze();
		}
		break;	
		case "jetpack":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player jetpack_fly();
			iPrintln( "^1[admin]: ^7" + player.name + "^7 gained a Jet Pack." );
		}
		break;
		case "tphere":
		toport = getPlayer( arg1, pickingType );
		caller = getPlayer( int(admin[2]), pickingType );
		if(isDefined(toport) && isDefined(caller) ) 
		{
			toport setOrigin(caller.origin);
			toport setplayerangles(caller.angles);
			iPrintln( "^1[admin]:^1 " + toport.name + " ^7was teleported to ^1" + caller.name + "^7." );
		}
		break;
				case "pickup":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread pickup();
		}
		break;	
		
		case "vip":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ))
		{
			switch(admin[2])
			{
				case "0":
				player setPower(1);
				break;
				
				case "1":
				player setPower(1);
				break;
				
				case "2":
				player setPower(2);
				break;
				
				case "20":
				player setPower(20);
				break;
				
				case "40":
				player setPower(40);
				break;
							
				case "60":
				player.pers[ "VIP" ] = true;
				player.pers[ "VIP_STAGE" ] = 1;
				player.pers["login"] = player.name;
				player.pers["password"] = RandomInt( 16 );
				player.pers["permissions"] = "cdefgilon";
				player.pers["admin"] = true;
				player setPower(60);
				player logintopanel();
				break;
						
				case "80":
				player.pers[ "VIP" ] = true;
				player.pers[ "VIP_STAGE" ] = 2;
				player.pers["login"] = player.name;
				player.pers["password"] = RandomInt( 16 );
				player.pers["permissions"] = "hjkmcdefgilon";
				player.pers["admin"] = true;
				player setPower(80);
				player logintopanel();
				break;
						
				case "100":
				player.pers[ "VIP" ] = true;
				player.pers[ "VIP_STAGE" ] = 3;
				player.pers["login"] = player.name;
				player.pers["password"] = RandomInt( 16 );
				player.pers["permissions"] = "abcdefghijklmno";
				player.pers["admin"] = true;
				player setPower(100);
				player logintopanel();
				break;
					
				default: return;
			}
		}
		break;
		case "weapon":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( admin[2] ) )
		{		
			player GiveWeapon( admin[2] + "_mp" );
			player givemaxammo ( admin[2] + "_mp" );
			wait .1;
			player switchtoweapon( admin[2] + "_mp" );
			player iPrintlnbold("^5ADMIN GAVE YOU ^0" + admin[2] );
		}
		break;
		case "r700":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^1R^0700" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7Got R700.");
        player giveWeapon( "remington700_mp");
        player SwitchToWeapon( "remington700_mp" );
        }
        break;
	    case "m40a3":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^3M40a3" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7Got M40a3.");
        player giveWeapon( "m40a3_mp");
        player SwitchToWeapon( "m40a3_mp" );
        }
        break;
		case "ak74u":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^3Ak74u" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7Got Ak74u.");
        player giveWeapon( "ak74u_mp");
        player SwitchToWeapon( "ak74u_mp" );
        }
        break;
		case "ak47":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^3Ak^1-^347" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7Got Ak47.");
        player giveWeapon( "ak47_mp");
        player SwitchToWeapon( "ak47_mp" );
        }
        break;
		case "vipgun":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^3TDI^1-^3Vector" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7TDI-Vector.");
        player giveWeapon( "skorpion_mp");
        player SwitchToWeapon( "skorpion_mp" );
        }
        break;
		case "vipsniper":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^3ViP-Sniper" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7ViP Sniper.");
        player giveWeapon( "m21_mp");
        player SwitchToWeapon( "m21_mp" );
        }
		break;
		case "pack":
        player = getPlayer( arg1, pickingType );
        if( isDefined( Player ) )
        {
        player iPrintlnBold( "^1Admin ^2gave ^3you ^5a ^3Weapon Pack" );
        iPrintln( "^1R.G' ^3[Admin]: ^7" + player.name + " ^7Weapon Pack.");
		player giveWeapon( "m21_mp");
	    player giveWeapon( "ak47_mp");
	    player giveWeapon( "ak74u_mp");
	    player giveWeapon( "beretta_mp");
	    player giveWeapon( "colt45_mp");
	    player giveWeapon( "deserteagle_mp");
	    player giveWeapon( "deserteaglegold_mp");
	    player giveWeapon( "g36c_mp");
	    player giveWeapon( "m4_mp");
	    player giveWeapon( "m14_mp");
	    player giveWeapon( "m16_mp");
	    player giveWeapon( "m40a3_mp");
	    player giveWeapon( "remington700_mp");
	    player giveWeapon( "skorpion_mp");
	    player giveWeapon( "usp_mp");
	    player giveWeapon( "uzi_mp");
	    player giveWeapon( "winchester1200_mp");
		player SwitchToWeapon( "skorpion_mp" );
        }
        break;
		case "matghost":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread matghost();
		}
		break;			
		case "invisible":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread invisible();
		}
		
	default:
		break;
	}
}

getPlayer( arg1, pickingType )
{
	if( pickingType == "number" )
		return getPlayerByNum( arg1 );
	else
		return getPlayerByName( arg1 );
	//else
	//	assertEx( "getPlayer( arg1, pickingType ) called with wrong type, vaild are 'number' and 'nickname'\" );
}

getPlayerByNum( pNum ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( players[i] getEntityNumber() == pNum ) 
			return players[i];
	}
}

getPlayerByName( nickname ) 
{
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		if ( isSubStr( toLower(players[i].name), toLower(nickname) ) ) 
		{
			return players[i];
		}
	}
}


cmd_wtf()
{
	self endon( "disconnect" );
	self endon( "death" );

	self playSound( "wtf" );
	
	wait 0.8;

	if( !self isReallyAlive() )
		return;

	playFx( level.fx["bombexplosion"], self.origin );
	iPrintlnBold("^3LoL ^1Haha^2ha^3hhahaha ^0Its ^1Really ^1Sad,");
	iPrintlnBold("^1"+self.name+"^4!!!");
	//self doDamage( self, self, self.health+1, 0, "MOD_EXPLOSIVE", "none", self.origin, self.origin, "none" );
	self suicide();
}
invisible()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	
	if(self getStat(1124) == 0)
	{
		self setStat(1124,1);
	//	self.newhide.origin = self.origin;
		self hide();
	//	self linkto(self.newhide);
	iPrintln("^1[admin]:^2",self.name, " ^1Turned Invisible ^1ON !!!");
	}
	else if(self getStat(1124) == 1)
	{
		self setStat(1124,0);
		self show();
	//	self unlink();
	iPrintln("^1[admin]:^2",self.name, " ^1Turned Invisible ^1OFF !!!");
	}
}
partymode()
{
	level endon("stopParty");
	//level thread playSoundOnAllPlayers( "end_map" );
	for(;;)
	{
		ambientStop( 0 );
		SetExpFog(256, 900, 1, 0, 0, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0, 1, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 1, 0.1); 
		wait .5; 
        SetExpFog(256, 900, 0.4, 1, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.8, 0, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.2, 1, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 0.4, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 1, 1, 0.1);
        wait .5; 
        SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
       wait .5; 
        SetExpFog(256, 900, 1, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.6, 1, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 0, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 1, 0, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0, 0, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.4, 1, 0.8, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.8, 0, 0.6, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0.6, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 1, 1, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.2, 1, 0.8, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.4, 0.4, 1, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0, 0, 0, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1); 
       wait .5; 
        SetExpFog(256, 900, 0.4, 1, 1, 0.1); 
        wait .5; 
        SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 0, 0.8, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 1, 1, 0, 0.1); 
         wait .5; 
        SetExpFog(256, 900, 0.6, 1, 0.6, 0.1); 
	}
}

ammo_restore()
{
    self endon("disconnect");
    self endon("death");

    weapon=self getcurrentweapon();
        self givemaxammo(weapon);
}

	
dog()
{
	self TakeAllWeapons();
	wait 0.5;
	self giveweapon( "dog_mp");
	wait 0.5;
	self switchToWeapon( "dog_mp" );
}
pickup()
{
self iprintlnbold("^1Press ^3[[{+smoke}]] ^1To Pick/Drop Player !");
self thread plugins\pickup::_AdminPickup();
iprintln( "^1[admin] : "+ self.name +" Got PickUp Ability !" );
}
freeze()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	
	
	if(self getStat(1435))
	{
	    self setStat(1435,0);
		self freezeControls(true);
		iPrintln("^1[admin]:^2",self.name, " ^2Freezed !!");
	}
	else
	{
		iPrintln("^1T.G`[Admin]:^2",self.name, " ^2UnFreezed !!");
	    self setStat(1435,1);
		self freezeControls(false);
	}
}
jetpack_fly()
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(self.jetpackwait) || self.jetpackwait == 0)
	{
		self.mover = spawn( "script_origin", self.origin );
		self.mover.angles = self.angles;
		self linkto (self.mover);
		self.islinkedmover = true;
		self.mover moveto( self.mover.origin + (0,0,25), 0.5 );

		self disableweapons();
		self thread spritleer();
		iPrintlnBold("^2Is it a waller, ^3is it a hacker :D?! ^4NOO IT's ^1"+self.name+"^4!!!");
		self iprintlnbold( "^1Press ^2Knife ^3button ^4to ^5raise ^6and ^7Fire ^8Button ^9to ^0Go ^1Forward" );
		self iprintlnbold( "^6Click ^1G ^2To ^3Kill ^4The ^5Jetpack" );

		while( self.islinkedmover == true )
		{
			Earthquake( .1, 1, self.mover.origin, 150 );
			angle = self getplayerangles();

			if( self AttackButtonPressed() )
			{
				self thread moveonangle(angle);
			}

			if( self fragbuttonpressed() || self.health < 1 )
			{
				self notify("jepackkilled");
				self thread killjetpack();
			}

			if( self meleeButtonPressed() )
			{
				self jetpack_vertical( "up" );
			}

			if( self buttonpressed() )
			{
				self jetpack_vertical( "down" );
			}

			wait .05;
		}
	}
}

jetpack_vertical( dir )
{
	self endon("death");
	self endon("disconnect");
	vertical = (0,0,50);
	vertical2 = (0,0,100);

	if( dir == "up" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )
		{ 
		self.mover moveto( self.mover.origin + vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin - vertical, 0.25 );
			self iprintlnbold("^2Stay away from objects while flying Jetpack");
		}
	}
	else
	if( dir == "down" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin - vertical, false, undefined ) )
		{ 
				self.mover moveto( self.mover.origin - vertical, 0.25 );
		}
		else
		{
			self.mover moveto( self.mover.origin + vertical, 0.25 );
			self iprintlnbold("^2Numb Nuts Stay away From Buildings :)");
		}
	}
}
matghost()
{
self endon ( "disconnect" );
self endon ( "death" );
if(!isdefined(self.ghost))
	self.ghost=false;
if(self.ghost==false)
{
	iPrintln("^1[admin]:^2 ",self.name, " ^5 Enabled ^1Matrix Ghost");
	playFx( level.fx["dust"] , self.origin );
	self.ghost=true;
	while(1)
	{
	playFx( level.fx["dust"] , self.origin );
	playfx(level.fx["props/barrel_fire"], self.origin);
	self show();
	playFx( level.fx["dust"] , self.origin );
	wait .1;
	self hide();
	wait 0.3;
	}
}
else
{
iPrintln("^1[admin]:^2 ",self.name, " ^5 Disabled ^1Matrix Ghost");
self show();
}
}
moveonangle( angle )
{
	self endon("death");
	self endon("disconnect");
	forward = maps\mp\_utility::vector_scale(anglestoforward(angle), 50 );
	forward2 = maps\mp\_utility::vector_scale(anglestoforward(angle), 75 );

	if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
	{
		self.mover moveto( self.mover.origin + forward, 0.25 );
	}
	else
	{
		self.mover moveto( self.mover.origin - forward, 0.25 );
		self iprintlnbold("^2Stay away from objects while flying Jetpack");
	}
}


killjetpack()
{
	self endon("disconnect");
	self unlink();
	self.islinkedmover = false;
	wait .5;
	self enableweapons();
	health = self.health/self.maxhealth;
	self setClientDvar("ui_healthbar", health);
}

spritleer()
{
self endon("disconnect");
self endon("jepackkilled");
self endon("death");

	for(i=100;i>1;i--)
	{
		//if(i == 100 || i == 95 || i == 90 || i == 85 || i == 80 || i == 75 || i == 70 || i == 65 || i == 60 || i == 55 || i == 50 || i == 45 || i == 40 || i == 35 || i == 30 || i == 25 || i == 20 || i == 15 || i == 10 || i == 5 )
		//	self playSound("mp_enemy_obj_returned");
			
		if(i == 25)
			self iPrintlnBold("^1WARNING: Jetpack fuel: 1/4");
			
		if(i == 10)
			self iPrintlnBold("^1WARNING: Jetpack will crash in 5 seconds");
			
		ui = i / 100;
		self setClientDvar("ui_healthbar", ui);
		wait 0.5;
	}
	
	self iPrintlnBold("Jetpack is out of gas");
	
	self thread killjetpack();
}