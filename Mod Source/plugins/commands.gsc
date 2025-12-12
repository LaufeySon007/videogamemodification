/*
	addScriptCommand( COMMAND_NAME, COMMAND_POWER )
	
	COMMAND_NAME = Command name, this is used to invoke the command ingame with $
	COMMAND_POWER = Power (integer) needed to invoke the command. Set to 1 if you want it to be usable by anyone. 0 will make it rcon only.

	--- commandHandler ---
	self = the player entity invoking the command
	cmd = command name from addScriptCommand
	arg = arguments supplied with command
*/
init()
{
	addscriptcommand( "fov", 1 );
	addscriptcommand( "fps", 1 );
	addscriptcommand( "music", 1 );
	
	thread plugins\plugins::eventHandler( ::commandHandler, "connect" );
}

commandHandler()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	
	for(;;)
	{
		self waittill( "cmd_executed", cmd, arg );
		
		waittillframeend;
		
		switch( cmd )
		{
			case "fps":
				if( self.pers["fullbright"] == 0 )
				{
					self iPrintlnBold( "Fullbright ^2ON ^7" );
					self setClientDvar( "r_fullbright", 1 );
					self setstat(3155,1);
					self.pers["fullbright"] = 1;
				}
				else
				{
					self iPrintlnBold( "Fullbright ^1OFF" );
					self setClientDvar( "r_fullbright", 0 );
					self setstat(3155,0);
					self.pers["fullbright"] = 0;
				}
				break;

			case "fov":
				if(self.pers["fov"] == 0 )
				{
					self iPrintlnBold( "*^0Field of View Scale^1[[^31.25^1]]" );
					self setClientDvar( "cg_fovscale", 1.25 );
					self setClientDvar( "cg_fov", 80 );
					self.pers["fov"] = 1;
				}
				else if(self.pers["fov"] == 1)
				{
					self iPrintlnBold( "*^0Field of View Scale^1[[^31.3^1]]" );
					self setClientDvar( "cg_fovscale", 1.3 );
					self setClientDvar( "cg_fov", 80 );
					self.pers["fov"] = 2;
				}
				else if(self.pers["fov"] == 2)
				{
					self iPrintlnBold( "*^0Field of View Scale^1[[^31.4^1]]" );
					self setClientDvar( "cg_fovscale", 1.4 );
					self setClientDvar( "cg_fov", 80 );
					self.pers["fov"] = 3;
				}
				else if(self.pers["fov"] == 3)
				{
					self iPrintlnBold( "*^0Field of View Scale^1[[^31.5^1]]" );
					self setClientDvar( "cg_fovscale", 1.5 );
					self setClientDvar( "cg_fov", 80 );
					self.pers["fov"] = 0;
				}
				break;
				
			case "music":
				if( !self.pers["disable_music"] )
				{
					self.pers["disable_music"] = 1;
					self iprintlnbold( "Killcam music ^1OFF" );
					self setStat(3157,1);
				}
				else
				{
					self.pers["disable_music"] = 0;
					self iprintlnbold( "Killcam music ^2ON" );
					self setStat(3157,0);
				}
				break;
				
			default:
				logPrint( "Unknown command invoked: " + cmd + " for player " + self.name + " with arguments: " + arg + "\n" );
				break;
		}
		
		waittillframeend;
	}
}