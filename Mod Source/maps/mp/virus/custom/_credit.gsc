main()
{
	level.creditTime = 10;

	//ambientplay("endround1",1);
//level thread playSoundOnAllPlayers( "endround1");

	thread showCredit( "^0Thanks ^1For ^3Playing ^0In^1:", 2.4 );
	wait 0.5;
	thread showCredit( "^0Promod ^1By ^3>>^2VI[^3R^2]US^3<<", 2.4 );
	wait 1.2;
	thread showCredit( "^0Server ^1Owner^2:^3>>^2VI[^3R^2]US^3<<", 2.0 );
	wait 0.5;
	thread showCredit( "^1>^2>^3> "+getDvar("owner"), 2.4 );
	wait 1.2;
	thread showCredit( "^0Modded ^1By^2:^3>>^2VI[^3R^2]US^3<<", 2.0 );
	wait 0.5;
	thread showCredit( "^3>>^2VI[^3R^2]US^3<<", 2.4 );
	//thread showCredit( "^0Hackers ^1will ^3Be ^0Permanently ^1Ban^3!", 2.4 );
	/*wait 1.2;
	thread showCredit( "^0Thankx For Playing", 2.0 );
	wait 0.5;
	thread showCredit( "^1Want Mod Like This Contact ^3>>^2VI[^3R^2]US^3<<", 2.4 );*/
	wait 1.2;
//	thread showCredit( "^0HOSTED ^3By^2:", 2.0 );
	wait 0.5;
//	thread showCredit( "", 2.4 );
	wait 1.2;
	thread showCredit( "^0Thanks ^1For ^3Playing^2!", 2.4 );
	wait 0.5;
	thread showCredit( "^0Hope ^1you ^3found ^0your ^1stay ^3well ^0worth ^1your ^3time^2!", 1.8 );
	/*thread showCredit( "Hosted Through:", 1.8 );z
	wait 0.5;
	wait 0.5;*/
	//thread custom\_mapvote::Initialize();
}


showCredit( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 0;
	end_text.y = 540;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	end_text.glowColor = (.1,.4,0);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "^1", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 15 );
		neon.x = 800;
		wait 15;
		neon moveOverTime( 15 );
		neon.x = -800;
		wait 15;
	}
}

addNeon( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = -200;
	end_text.y = 8;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	//end_text.glowColor = (1,0,0.1);
	//end_text.glowAlpha = 1;
	end_text.foreground = true;
	return end_text;
}