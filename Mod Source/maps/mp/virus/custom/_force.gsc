#include maps\mp\gametypes\_globallogic;
#include maps\mp\virus\_common;
forcend()
{
players = getAllPlayers();
		for ( i = 0; i < players.size; i++ )
		{
players setspec( "spectator" );
}
maps\mp\virus\custom\_credits::main();
	wait 3;
	for(i=0;
	i<level.players.size;
	i++)
	{
		player=level.players[i];
		player closeMenu();
		player closeInGameMenu();
		player notify("reset_outcome");
		player thread spawnIntermission();
		player setClientDvar("ui_hud_hardcore",0);
	}
	wait 4;
	if(isDefined(game["PROMOD_MATCH_MODE"])&&game["PROMOD_MATCH_MODE"]=="match")
	{
		map_restart(false);
		return;
	}
	exitLevel(false);
}