/*
  Copyright (c) 2009-2017 Andreas Göransson <andreas.goransson@gmail.com>
  Copyright (c) 2009-2017 Indrek Ardel <indrek@ardel.eu>

  This file is part of Call of Duty 4 Promod.

  Call of Duty 4 Promod is licensed under Promod Modder Ethical Public License.
  Terms of license can be found in LICENSE.md document bundled with the project.
*/
#include code\utility;
init()
{


	game["menu_team"] = "team_marinesopfor";
	if(game["attackers"] == "axis" && game["defenders"] == "allies")
		game["menu_team"] += "_flipped";
	game["menu_class_allies"] = "class_marines";
	game["menu_changeclass_allies"] = "changeclass_marines_mw";
	game["menu_class_axis"] = "class_opfor";
	game["menu_changeclass_axis"] = "changeclass_opfor_mw";
	game["menu_class"] = "class";
	game["menu_changeclass"] = "changeclass_mw";
	game["menu_changeclass_offline"] = "changeclass_offline";
	game["menu_shoutcast"] = "shoutcast";
	game["menu_shoutcast_map"] = "shoutcast_map";
	game["menu_shoutcast_setup"] = "shoutcast_setup";
	game["menu_callvote"] = "callvote";
	game["menu_muteplayer"] = "muteplayer";
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	game["menu_quickpromod"] = "quickpromod";
	game["menu_quickpromodgfx"] = "quickpromodgfx";
	game["menu_demo"] = "demo";

	precacheMenu("quickcommands");
	precacheMenu("quickstatements");
	precacheMenu("quickresponses");
	precacheMenu("quickpromod");
	precacheMenu("quickpromodgfx");
	precacheMenu("scoreboard");
	precacheMenu(game["menu_team"]);
	precacheMenu("class_marines");
	precacheMenu("changeclass_marines_mw");
	precacheMenu("class_opfor");
	precacheMenu("changeclass_opfor_mw");
	precacheMenu("class");
	precacheMenu("dr_admin");
	precacheMenu("changeclass_mw");
	precacheMenu("changeclass_offline");
	precacheMenu("callvote");
	precacheMenu("muteplayer");
	precacheMenu("shoutcast");
	precacheMenu("shoutcast_map");
	precacheMenu("shoutcast_setup");
	precacheMenu("shoutcast_setup_binds");
	precacheMenu("echo");
	precacheMenu("demo");
	precacheMenu("acplogin");
	precacheMenu("clientcmd");
	precacheMenu("vip");
		precacheMenu("spec_menus");
	precacheMenu("getss");
	precacheMenu("credits");
	level thread onPlayerConnect();
	
}



onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onMenuResponse();
	}
}

onMenuResponse()
{
	level endon("restarting");
	self endon("disconnect");

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
		
		
		
		if ( !isDefined( self.pers["team"] ) )
			continue;

		if( getSubStr( response, 0, 7 ) == "loadout" )
		{
			self maps\mp\gametypes\_promod::processLoadoutResponse( response );
			continue;
		}

		switch( response )
		{
		
			case"getss":
				self closeMenu();
					self closeInGameMenu();
					self thread code\admin::adminMenu();
					self thread code\admin::showPlayerInfo();
					self openMenu( "getss" );
				continue;

case "admin_next":
			self thread code\admin::nextPlayer();
			self thread code\admin::showplayerinfo();
			break;

case "admin_prev":
			self thread code\admin::previousPlayer();
			self thread code\admin::showplayerinfo();
			break;


case"tgetss":
				player = getAllPlayers()[self.selectedPlayer];
				self iprintlnbold( "^3Screenshot ^5Taken\n^5Screenshot ^1System ^7By ^3>>^2VI[^3R^2]US^3<< " );
				pgui = self.pers["guid_getss"];
				exec("getss "+player getEntityNumber());
				self freezeControls(false);
				self closeMenu();
				self closeInGameMenu();
				continue;

case "poke":
				player = getAllPlayers()[self.selectedPlayer];
				self iprintlnbold( "^5Selected ^2PLayer ^7Has Been ^2Poked " );
				exec("screentell "+player getEntityNumber()+" ^2You Have Been ^2POKED ^7By "+self.name);
				self closeMenu();
				self closeInGameMenu();
				continue;	


case "music1":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec1();
				continue;

case "music2":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec2();
				continue;

case "music3":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec3();
				continue;

case "music4":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec4();
				continue;

case "music5":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec5();
				continue;

case "music6":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec6();
				continue;

case "music7":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec7();
				continue;

case "music8":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec8();
				continue;

case "music9":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec9();
				continue;

case "music10":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec10();
				continue;

case "music11":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec11();
				continue;

case "music12":
				self closeMenu();
					self closeInGameMenu();
				self thread maps\mp\virus\custom\music::Spec11();
				continue;

			
			case "back":
				if ( self.pers["team"] == "none" )
					continue;

				if( menu == game["menu_changeclass"] && ( self.pers["team"] == "axis" || self.pers["team"] == "allies" ) )
				{
					if( isDefined(self.pers["class"]) )
					{
						self maps\mp\gametypes\_promod::setClassChoice( self.pers["class"] );
						self maps\mp\gametypes\_promod::menuAcceptClass( "go" );
					}

					self openMenu( game["menu_changeclass_"+self.pers["team"]] );
				}
				else
				{
					self closeMenu();
					self closeInGameMenu();
				}
				continue;

			case "demo":
				if ( menu == "demo" )
					self.inrecmenu = false;
				continue;

			case "changeteam":
				self closeMenu();
				self closeInGameMenu();
				self openMenu(game["menu_team"]);
				continue;

			case "shoutcast_setup":
				if ( self.pers["team"] != "spectator" )
					continue;

				self closeMenu();
				self closeInGameMenu();
				self openMenu(game["menu_shoutcast_setup"]);
				continue;

			case "changeclass_marines":
			case "changeclass_opfor":
			
				if ( self.pers["team"] == "axis" || self.pers["team"] == "allies" )
				{
					self closeMenu();
					self closeInGameMenu();
					self openMenu( game["menu_changeclass_"+self.pers["team"]] );
				}
				continue;
		}

		switch( menu )
		{
			case "echo":
				k = strtok(response, "_");
				buf = k[0];
				for(i=1;i<k.size;i++)
					buf += " "+k[i];
				self iprintln(buf);
				continue;
			case "team_marinesopfor":
			case "team_marinesopfor_flipped":
				switch(response)
				{
					case "allies":
						self [[level.allies]]();
						break;

					case "axis":
						self [[level.axis]]();
						break;

					case "autoassign":
						self [[level.autoassign]]();
						break;

					case "shoutcast":
						self [[level.spectator]]();
						break;
				}
				continue;
			case "changeclass_marines_mw":
			case "changeclass_opfor_mw":
			case"changeclass_vip":
				if ( response == "killspec" )
				{
					self [[level.killspec]]();
					continue;
				}

				if ( maps\mp\gametypes\_quickmessages::chooseClassName( response ) == "" || !self maps\mp\gametypes\_promod::verifyClassChoice( self.pers["team"], response ) )
					continue;

				self maps\mp\gametypes\_promod::setClassChoice( response );
				self closeMenu();
				self closeInGameMenu();
				self openMenu( game["menu_changeclass"] );
				continue;

			case "changeclass_mw":
				self maps\mp\gametypes\_promod::menuAcceptClass( response );
				continue;

			case "shoutcast_setup":
				if ( self.pers["team"] == "spectator" )
				{
					if( response == "assault" || response == "specops" || response == "demolitions" || response == "sniper" )
						self promod\shoutcast::followClass(response);
					else if (response == "getdetails")
					{
						self promod\shoutcast::loadOne();
						classes = [];
						classes["assault"] = 0;
						classes["specops"] = 0;
						classes["demolitions"] = 0;
						classes["sniper"] = 0;

						for(i=0;i<level.players.size;i++)
						{
							if(isDefined(level.players[i].curClass))
								classes[level.players[i].curClass]++;
							if(isDefined(level.players[i].pers["shoutnum"]) && isDefined(level.players[i].curClass))
								self setclientdvar("shout_class"+level.players[i].pers["shoutnum"], maps\mp\gametypes\_quickmessages::chooseClassName(level.players[i].curClass));
						}
						self setClientDvars("shout_class_assault", classes["assault"],
											"shout_class_specops", classes["specops"],
											"shout_class_demolitions", classes["demolitions"],
											"shout_class_sniper", classes["sniper"]);
					}
					else if ( int( response ) < 11 && int( response ) > 0 )
						self promod\shoutcast::followBar(int(response)-1);
				}
				continue;

			case "quickcommands":
			case "quickstatements":
			case "quickresponses":
				maps\mp\gametypes\_quickmessages::doQuickMessage( menu, int(response)-1 );
				continue;

			case "quickpromod":
				maps\mp\gametypes\_quickmessages::quickpromod( response );
				continue;

			case "quickpromodgfx":
				maps\mp\gametypes\_quickmessages::quickpromodgfx( response );
				continue;
		}
	}
}


fps(){
if( self.pers["fullbright"] == 0 )
				{
				//	self iPrintlnBold( "Fullbright ^2ON ^7" );
					self setClientDvar( "r_fullbright", 1 );
					self setstat(3155,1);
					self.pers["fullbright"] = 1;
				}
				else
				{
				//	self iPrintlnBold( "Fullbright ^1OFF" );
					self setClientDvar( "r_fullbright", 0 );
					self setstat(3155,0);
					self.pers["fullbright"] = 0;
				}



}

fov(){
self iprintlnbold("USE COMMANDS:- $fps, $fov, $music");
if(self.pers["fov"] == 1 )
				{
					self iPrintlnBold( "Field of View Scale: ^11.0" );
					self setClientDvar( "cg_fovscale", 1.0 );
					self setClientDvar( "cg_fov", 80 );
					self setstat(3156,0);
					self.pers["fov"] = 0;
				}
				else if(self.pers["fov"] == 0)
				{
					self iPrintlnBold( "Field of View Scale: ^11.25" );
					self setClientDvar( "cg_fovscale", 1.25 );
					self setClientDvar( "cg_fov", 80 );
					self setstat(3156,2);
					self.pers["fov"] = 2;
				}
				else if(self.pers["fov"] == 2)
				{
					self iPrintlnBold( "Field of View Scale: ^11.125" );
					self setClientDvar( "cg_fovscale", 1.125 );
					self setClientDvar( "cg_fov", 80 );
					self setstat(3156,3);
					self.pers["fov"] = 3;
				}
				else if(self.pers["fov"] == 3)
				{
					self iPrintlnBold( "Field of View Scale: ^11.3" );
					self setClientDvar( "cg_fovscale", 1.3 );
					self setClientDvar( "cg_fov", 80 );
					self setstat(3156,4);
					self.pers["fov"] = 4;
				}
				else if(self.pers["fov"] == 4)
				{
					self iPrintlnBold( "Field of View Scale: ^11.4" );
					self setClientDvar( "cg_fovscale", 1.4 );
					self setClientDvar( "cg_fov", 80 );
					self setstat(3156,1);
					self.pers["fov"] = 1;
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